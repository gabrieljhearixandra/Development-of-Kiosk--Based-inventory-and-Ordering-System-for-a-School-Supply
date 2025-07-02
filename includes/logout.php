<?php
require __DIR__ . '/../includes/config.php';  
require __DIR__ . '/../includes/auth.php';  
require __DIR__ . '/../includes/audit_functions.php';  

// Log logout event
if (isset($_SESSION['user_id'])) {
    logAuditTrail('logout', 'User logged out', 'admins', $_SESSION['user_id']);
}

// Clear all session data
$_SESSION = array();

// Delete session cookie
if (ini_get("session.use_cookies")) {
    $params = session_get_cookie_params();
    setcookie(session_name(), '', time() - 42000,
        $params["path"], $params["domain"],
        $params["secure"], $params["httponly"]
    );
}

// Destroy session
session_destroy();

// Redirect to login page
header("Location: " . dirname($_SERVER['PHP_SELF']) . "/../login.php");
exit();
?>