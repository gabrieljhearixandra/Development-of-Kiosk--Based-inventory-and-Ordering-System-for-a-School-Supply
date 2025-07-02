<?php
require_once '../includes/auth.php';
require_once '../includes/db.php';
require_once '../includes/inventory_functions.php';
redirectIfNotLoggedIn();

// Handle support item CRUD operations
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    if (isset($_POST['add_support'])) {
        $question = trim($_POST['new_question']);
        $answer = trim($_POST['new_answer']);
        
        $stmt = $pdo->prepare("INSERT INTO faqs (question, answer) VALUES (?, ?)");
        if ($stmt->execute([$question, $answer])) {
            $newId = $pdo->lastInsertId();
            
            $actionDetails = json_encode([
                'type' => 'FAQ',
                'question' => $question,
                'answer' => $answer,
                'affected_table' => 'faqs',
                'record_id' => $newId
            ]);
            
            $auditStmt = $pdo->prepare("INSERT INTO audit_trail (user_id, action_type, action_details, affected_table, record_id) VALUES (?, 'CREATE', ?, 'faqs', ?)");
            $auditStmt->execute([$_SESSION['user_id'], $actionDetails, $newId]);
            
            $success = "Support item added successfully!";
        } else {
            $error = "Failed to add support item.";
        }
    } elseif (isset($_POST['update_support'])) {
        $id = $_POST['support_id'];
        $question = trim($_POST['question']);
        $answer = trim($_POST['answer']);
        
        // Get the old values first for audit trail
        $oldItem = $pdo->prepare("SELECT question, answer FROM faqs WHERE id = ?");
        $oldItem->execute([$id]);
        $oldData = $oldItem->fetch(PDO::FETCH_ASSOC);
        
        $stmt = $pdo->prepare("UPDATE faqs SET question = ?, answer = ? WHERE id = ?");
        if ($stmt->execute([$question, $answer, $id])) {
            // Prepare changes for audit trail
            $changes = [
                'type' => 'FAQ',
                'id' => $id,
                'affected_table' => 'faqs',
                'record_id' => $id
            ];
            if ($oldData['question'] !== $question) {
                $changes['question'] = [
                    'old' => $oldData['question'],
                    'new' => $question
                ];
            }
            if ($oldData['answer'] !== $answer) {
                $changes['answer'] = [
                    'old' => $oldData['answer'],
                    'new' => $answer
                ];
            }
            
            if (!empty($changes)) {
                $auditStmt = $pdo->prepare("INSERT INTO audit_trail (user_id, action_type, action_details, affected_table, record_id) VALUES (?, 'UPDATE', ?, 'faqs', ?)");
                $auditStmt->execute([$_SESSION['user_id'], json_encode($changes), $id]);
            }
            
            $success = "Support item updated successfully!";
        } else {
            $error = "Failed to update support item.";
        }
    } elseif (isset($_POST['delete_support'])) {
        $id = $_POST['support_id'];
        
        // Get the item data first for audit trail
        $item = $pdo->prepare("SELECT question, answer FROM faqs WHERE id = ?");
        $item->execute([$id]);
        $itemData = $item->fetch(PDO::FETCH_ASSOC);
        
        $stmt = $pdo->prepare("DELETE FROM faqs WHERE id = ?");
        if ($stmt->execute([$id])) {
            $actionDetails = json_encode([
                'type' => 'FAQ',
                'question' => $itemData['question'],
                'answer' => $itemData['answer'],
                'affected_table' => 'faqs',
                'record_id' => $id
            ]);
            
            $auditStmt = $pdo->prepare("INSERT INTO audit_trail (user_id, action_type, action_details, affected_table, record_id) VALUES (?, 'DELETE', ?, 'faqs', ?)");
            $auditStmt->execute([$_SESSION['user_id'], $actionDetails, $id]);
            
            $success = "Support item deleted successfully!";
        } else {
            $error = "Failed to delete support item.";
        }
    }
}

// Get all support items
$supportItems = $pdo->query("SELECT * FROM faqs ORDER BY id DESC")->fetchAll(PDO::FETCH_ASSOC);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Support Items</title>
    <link rel="stylesheet" href="../assets/css/sidebar.css">
    <link rel="stylesheet" href="../assets/css/admin.css">
    <link rel="stylesheet" href="../assets/css/support.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <div class="admin-container">
        <?php include '../includes/sidebar.php'; ?>

        <div class="main-content">
            <div class="content-container">
                <h1>Manage Support Items</h1>
                
                <?php if (isset($success)): ?>
                    <div class="success-message"><?php echo htmlspecialchars($success); ?></div>
                <?php endif; ?>
                
                <?php if (isset($error)): ?>
                    <div class="error-message"><?php echo htmlspecialchars($error); ?></div>
                <?php endif; ?>
                
                <div class="support-section">
                    <h2><i class="bi bi-question-circle"></i> Support Items</h2>
                    
                    <?php foreach ($supportItems as $item): ?>
                    <div class="support-item">
                        <div class="support-actions">
                            <button type="button" onclick="showEditModal(<?php echo $item['id']; ?>, '<?php echo htmlspecialchars(addslashes($item['question']), ENT_QUOTES); ?>', '<?php echo htmlspecialchars(addslashes($item['answer']), ENT_QUOTES); ?>')">
                                <i class="bi bi-pencil"></i>
                            </button>
                            <form method="POST" style="display:inline;">
                                <input type="hidden" name="support_id" value="<?php echo $item['id']; ?>">
                                <button type="submit" name="delete_support" onclick="return confirm('Are you sure you want to delete this support item?')">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </form>
                        </div>
                        <div class="support-question"><?php echo htmlspecialchars($item['question']); ?></div>
                        <div class="support-answer"><?php echo nl2br(htmlspecialchars($item['answer'])); ?></div>
                    </div>
                    <?php endforeach; ?>
                    
                    <div class="add-support-form">
                        <h3>Add New Support Item</h3>
                        <form method="POST">
                            <div class="form-group">
                                <label for="new_question">Question</label>
                                <input type="text" id="new_question" name="new_question" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="new_answer">Answer</label>
                                <textarea id="new_answer" name="new_answer" required></textarea>
                            </div>
                            
                            <button type="submit" name="add_support" class="btn-submit">
                                <i class="bi bi-plus-circle"></i> Add Item
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Support Modal -->
    <div id="editSupportModal" class="modal hidden">
        <div class="modal-content" onclick="event.stopPropagation()">
            <div class="modal-header">
                <h2>Edit Support Item</h2>
                <button class="btn-close" onclick="hideEditModal()">&times;</button>
            </div>
            <div class="modal-body">
                <form id="editSupportForm" method="POST">
                    <input type="hidden" name="support_id" id="edit_support_id">
                    <div class="form-group">
                        <label for="edit_question">Question</label>
                        <input type="text" id="edit_question" name="question" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="edit_answer">Answer</label>
                        <textarea id="edit_answer" name="answer" required></textarea>
                    </div>
                    
                    <button type="submit" name="update_support" class="btn-submit">
                        <i class="bi bi-save"></i> Save Changes
                    </button>
                </form>
            </div>
        </div>
    </div>

    <script src="../assets/js/support.js"></script>
</body>
</html>