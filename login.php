<?php
require 'includes/config.php';
require 'includes/auth.php';
require 'includes/db.php';
require 'includes/inventory_functions.php';

// If already logged in, redirect to dashboard
if (isAdminLoggedIn()) {
    header("Location: admin/dashboard.php");
    exit();
}

$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = trim($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';
    
    // Basic input validation
    if (empty($username) || empty($password)) {
        $error = "Username and password are required";
    } else {
        $stmt = $pdo->prepare("SELECT * FROM admins WHERE username = ?");
        $stmt->execute([$username]);
        $admin = $stmt->fetch();

        if ($admin) {
            // Verify password
            if (verifyPassword($password, $admin['password'])) {
                
                // Successful login
                $stmt = $pdo->prepare("UPDATE admins SET last_login = NOW() WHERE id = ?");
                $stmt->execute([$admin['id']]);
                
                // Set session variables
                $_SESSION['admin_logged_in'] = true;
                $_SESSION['admin_username'] = $admin['username'];
                $_SESSION['user_id'] = $admin['id'];
                $_SESSION['user_agent'] = md5($_SERVER['HTTP_USER_AGENT']);
                $_SESSION['ip_address'] = $_SERVER['REMOTE_ADDR'];
                
                // Log successful login to audit trail
                logAuditTrail('login', 'User logged in successfully', 'admins', $admin['id']);
                
                header("Location: admin/dashboard.php");
                exit();
            } else {
                // Failed login
                $error = "Invalid username or password";
                logAuditTrail('login_failed', 'Failed login attempt for user: ' . $username, 'admins', $admin['id']);
                
                // Delay response to prevent timing attacks
                sleep(1);
            }
        } else {
            // User doesn't exist
            $error = "Invalid username or password";
            logAuditTrail('login_failed', 'Failed login attempt for non-existent user: ' . $username);
            
            // Delay response to prevent timing attacks
            sleep(1);
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>
    <link rel="stylesheet" href="assets/css/admin.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="login-container">
    <div class="login-box">
        <h2>Admin Login</h2>
        <?php if (!empty($error)): ?>
            <div class="alert alert-danger"><?php echo htmlspecialchars($error); ?></div>
        <?php endif; ?>
        <form method="POST">
            <div class="mb-3">
                <label for="username" class="form-label">Username</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <div class="forgot-password">
                <a href="#" id="forgot-password-link">Forgot Password?</a>
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
        </form>
        
        <div class="contact-info" id="contact-info">
            <h5>Forgot Password?</h5>
            <p>Please contact IT support for assistance:</p>
            <ul>
                <li>Email: it-support@yourcompany.com</li>
                <li>Phone: (123) 456-7890</li>
                <li>Extension: 1234</li>
            </ul>
        </div>
    </div>
</div>

    <script src="assets/js/admin.js"></script>
</body>
</html>