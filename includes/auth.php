<?php
require_once 'config.php';
require_once 'password_functions.php';

function isAdminLoggedIn() {
    if (!isset($_SESSION['admin_logged_in']) || $_SESSION['admin_logged_in'] !== true) {
        return false;
    }
    
    // Additional session validation
    if (!isset($_SESSION['user_agent']) || $_SESSION['user_agent'] !== md5($_SERVER['HTTP_USER_AGENT'])) {
        session_destroy();
        return false;
    }
    
    if (!isset($_SESSION['ip_address']) || $_SESSION['ip_address'] !== $_SERVER['REMOTE_ADDR']) {
        session_destroy();
        return false;
    }
    
    return true;
}

function redirectIfNotLoggedIn() {
    if (!isAdminLoggedIn()) {
        header("Location: ../login.php");
        exit();
    }
}

// Start session 
if (session_status() === PHP_SESSION_NONE) {
    session_start();
    
    // Regenerate session ID periodically for security
    if (!isset($_SESSION['created'])) {
        $_SESSION['created'] = time();
    } else if (time() - $_SESSION['created'] > 1800) {
        session_regenerate_id(true);
        $_SESSION['created'] = time();
    }
}

function verifyAdminPassword($password) {
    global $pdo;
    
    if (!isset($_SESSION['user_id'])) {
        return false;
    }
    
    $stmt = $pdo->prepare("SELECT password FROM admins WHERE id = ?");
    $stmt->execute([$_SESSION['user_id']]);
    $admin = $stmt->fetch();
    
    if (!$admin) {
        return false;
    }
    
    return verifyPassword($password, $admin['password']);
}

?>