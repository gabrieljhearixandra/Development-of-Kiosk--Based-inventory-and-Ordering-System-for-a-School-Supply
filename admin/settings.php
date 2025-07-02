<?php
require_once '../includes/auth.php';
require_once '../includes/audit_functions.php'; 
require_once '../includes/db.php';
require_once '../includes/receipt_functions.php';
redirectIfNotLoggedIn();

// Initialize variables
$error = '';
$success = '';
$isAdmin = isAdminLoggedIn();

// Get current receipt settings
$receiptSettings = getReceiptSettings();

// Process form submissions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Reset Sales
    if (isset($_POST['reset_sales'])) {
        $resetPeriod = $_POST['reset_period'] ?? 'month';
        $customDate = $_POST['custom_date'] ?? '';
        $adminPassword = $_POST['admin_password'] ?? '';
        
        // Verify admin password
        if (!verifyAdminPassword($adminPassword)) {
            $error = "Invalid admin password";
        } else {
            try {
                $pdo->beginTransaction();
                
                // Determine date range based on period
                $startDate = '';
                $endDate = '';
                
                switch ($resetPeriod) {
                    case 'day':
                        $date = $customDate ?: date('Y-m-d');
                        $startDate = $date;
                        $endDate = $date;
                        break;
                    case 'week':
                        $date = $customDate ?: date('Y-m-d');
                        $week = date('W', strtotime($date));
                        $year = date('Y', strtotime($date));
                        $startDate = date('Y-m-d', strtotime($year . 'W' . $week));
                        $endDate = date('Y-m-d', strtotime($year . 'W' . $week . '7'));
                        break;
                    case 'month':
                        $date = $customDate ? $customDate . '-01' : date('Y-m-01');
                        $startDate = date('Y-m-01', strtotime($date));
                        $endDate = date('Y-m-t', strtotime($date));
                        break;
                    case 'year':
                        $date = $customDate ? $customDate . '-01-01' : date('Y-01-01');
                        $startDate = date('Y-01-01', strtotime($date));
                        $endDate = date('Y-12-31', strtotime($date));
                        break;
                }
                
                // Reset sales data
                // First delete sale_items to maintain referential integrity
                $stmt = $pdo->prepare("DELETE FROM sale_items WHERE sale_id IN (
                    SELECT id FROM sales WHERE DATE(transaction_date) BETWEEN ? AND ?
                )");
                $stmt->execute([$startDate, $endDate]);

                // Then delete the sales
                $stmt = $pdo->prepare("DELETE FROM sales WHERE DATE(transaction_date) BETWEEN ? AND ?");
                $stmt->execute([$startDate, $endDate]);

                // Log the reset action
                $actionDetails = [
                    'period' => $resetPeriod,
                    'start_date' => $startDate,
                    'end_date' => $endDate,
                    'custom_date' => $customDate,
                    'records_deleted' => $stmt->rowCount()
                ];
                
                logAuditTrail('reset_sales', 'Reset sales data', 'sales', null, json_encode($actionDetails));

                $pdo->commit();
                $success = "Sales data for selected period has been reset successfully";
            } catch (PDOException $e) {
                $pdo->rollBack();
                $error = "Error resetting sales: " . $e->getMessage();
            }
        }
    }
    
    // Update Receipt Settings
    if (isset($_POST['update_receipt_settings'])) {
        $adminPassword = $_POST['admin_password'] ?? '';
        
        // Verify admin password
        if (!verifyAdminPassword($adminPassword)) {
            $error = "Invalid admin password";
        } else {
            try {
                $settingsData = [
                    'store_name' => $_POST['store_name'],
                    'store_address' => $_POST['store_address'],
                    'store_phone' => $_POST['store_phone'],
                    'thank_you_message' => $_POST['thank_you_message']
                ];
                
                if (updateReceiptSettings($settingsData)) {
                    $success = "Receipt settings updated successfully";
                    $receiptSettings = getReceiptSettings(); // Refresh settings
                    
                    // Log the action
                    logAuditTrail(
                        'update_receipt_settings', 
                        'Updated receipt settings', 
                        'receipt_settings', 
                        null,
                        json_encode($settingsData)
                    );
                } else {
                    $error = "Failed to update receipt settings";
                }
            } catch (Exception $e) {
                $error = "Error updating receipt settings: " . $e->getMessage();
            }
        }
    }
    
    // Reset Password
    if (isset($_POST['reset_password'])) {
        $currentPassword = $_POST['current_password'] ?? '';
        $newPassword = $_POST['new_password'] ?? '';
        $confirmPassword = $_POST['confirm_password'] ?? '';
        
        // Verify current password
        if (!verifyAdminPassword($currentPassword)) {
            $error = "Current password is incorrect";
        } elseif ($newPassword !== $confirmPassword) {
            $error = "New passwords do not match";
        } elseif (strlen($newPassword) < 8) {
            $error = "Password must be at least 8 characters long";
        } else {
            try {
                $hashedPassword = hashPassword($newPassword);
                $stmt = $pdo->prepare("UPDATE admins SET password = ? WHERE id = ?");
                $stmt->execute([$hashedPassword, $_SESSION['user_id']]);
                
                $success = "Password changed successfully";
                logAuditTrail('password_change', 'Password updated', 'admins', $_SESSION['user_id']);
            } catch (PDOException $e) {
                $error = "Error changing password: " . $e->getMessage();
            }
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Settings | POS System</title>
    <link rel="stylesheet" href="../assets/css/sidebar.css">
    <link rel="stylesheet" href="../assets/css/settings.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <div class="admin-container">
        <?php include '../includes/sidebar.php'; ?>

        <div class="main-content">
            <div class="content-container">
                <h1>System Settings</h1>
                
                <?php if ($error): ?>
                    <div class="alert alert-danger"><?php echo $error; ?></div>
                <?php endif; ?>
                
                <?php if ($success): ?>
                    <div class="alert alert-success"><?php echo $success; ?></div>
                <?php endif; ?>
                
                <?php if ($isAdmin): ?>
                <div class="settings-container">
                    <!-- Password Reset Section -->
                    <div class="settings-section">
                        <div class="card">
                            <div class="card-header clickable" data-target="passwordModal">
                                <h2><i class="bi bi-shield-lock"></i> Change Password</h2>
                                <i class="bi bi-chevron-down"></i>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Sales Reset Section -->
                    <div class="settings-section">
                        <div class="card">
                            <div class="card-header clickable" data-target="resetSalesModal">
                                <h2><i class="bi bi-arrow-repeat"></i> Sales Reset</h2>
                                <i class="bi bi-chevron-down"></i>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Receipt Settings Section -->
                    <div class="settings-section">
                        <div class="card">
                            <div class="card-header clickable" data-target="receiptSettingsModal">
                                <h2><i class="bi bi-receipt"></i> Receipt Settings</h2>
                                <i class="bi bi-chevron-down"></i>
                            </div>
                        </div>
                    </div>
                </div>
                <?php else: ?>
                    <div class="alert alert-warning">You don't have administrator privileges to access these settings.</div>
                <?php endif; ?>
            </div>
        </div>
    </div>

    <!-- Password Change Modal -->
    <div id="passwordModal" class="modal">
        <div class="modal-content">
            <span class="close-modal">&times;</span>
            <h2><i class="bi bi-shield-lock"></i> Change Password</h2>
            <form method="POST" class="form-grid">
                <div class="form-group">
                    <label for="current_password">Current Password</label>
                    <input type="password" id="current_password" name="current_password" required>
                </div>
                
                <div class="form-group">
                    <label for="new_password">New Password</label>
                    <input type="password" id="new_password" name="new_password" required>
                </div>
                
                <div class="form-group">
                    <label for="confirm_password">Confirm New Password</label>
                    <input type="password" id="confirm_password" name="confirm_password" required>
                </div>
                
                <div class="form-group full-width">
                    <button type="submit" name="reset_password" class="btn btn-primary">
                        <i class="bi bi-key"></i> Change Password
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Reset Sales Modal -->
    <div id="resetSalesModal" class="modal">
        <div class="modal-content">
            <span class="close-modal">&times;</span>
            <h2><i class="bi bi-arrow-repeat"></i> Sales Reset</h2>
            <form method="POST" id="resetSalesForm" class="form-grid">
                <div class="form-group">
                    <label for="reset_period">Reset Period</label>
                    <select id="reset_period" name="reset_period" required>
                        <option value="day">Day</option>
                        <option value="week">Weekly</option>
                        <option value="month" selected>Monthly</option>
                        <option value="year">Yearly</option>
                    </select>
                </div>
                
                <div class="form-group" id="customDateContainer" style="display:none;">
                    <label for="custom_date">Select Date</label>
                    <input type="text" class="datepicker" id="custom_date" name="custom_date">
                </div>
                
                <div class="form-group">
                    <label for="admin_password">Admin Password</label>
                    <input type="password" id="admin_password" name="admin_password" required>
                    <div id="passwordError" class="error-message" style="display:none;"></div>
                </div>
                
                <div class="form-group full-width">
                    <button type="submit" name="reset_sales" class="btn btn-danger">
                        <i class="bi bi-exclamation-triangle"></i> Reset Sales
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Receipt Settings Modal -->
    <div id="receiptSettingsModal" class="modal">
        <div class="modal-content">
            <span class="close-modal">&times;</span>
            <h2><i class="bi bi-receipt"></i> Receipt Settings</h2>
            <form method="POST" class="form-grid">
                <div class="form-group">
                    <label for="store_name">Store Name</label>
                    <input type="text" id="store_name" name="store_name" 
                           value="<?= htmlspecialchars($receiptSettings['store_name'] ?? 'MY STORE') ?>" required>
                </div>
                
                <div class="form-group">
                    <label for="store_address">Store Address</label>
                    <input type="text" id="store_address" name="store_address" 
                           value="<?= htmlspecialchars($receiptSettings['store_address'] ?? '123 Main Street, City') ?>" required>
                </div>
                
                <div class="form-group">
                    <label for="store_phone">Store Phone</label>
                    <input type="text" id="store_phone" name="store_phone" 
                           value="<?= htmlspecialchars($receiptSettings['store_phone'] ?? 'Tel: (123) 456-7890') ?>" required>
                </div>
                
                <div class="form-group">
                    <label for="thank_you_message">Thank You Message</label>
                    <input type="text" id="thank_you_message" name="thank_you_message" 
                           value="<?= htmlspecialchars($receiptSettings['thank_you_message'] ?? 'Thank you for your purchase!') ?>" required>
                </div>
                
                <div class="form-group full-width">
                    <label for="admin_password_receipt">Admin Password</label>
                    <input type="password" id="admin_password_receipt" name="admin_password" required>
                </div>
                
                <div class="form-group full-width">
                    <button type="submit" name="update_receipt_settings" class="btn btn-primary">
                        <i class="bi bi-save"></i> Save Settings
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="../assets/js/settings.js"></script>
</body>
</html>