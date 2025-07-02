<?php
function logAuditTrail($action, $description, $table = null, $record_id = null) {
    global $pdo;
    
    try {
        $stmt = $pdo->prepare("INSERT INTO audit_trail 
                             (user_id, action_type, action_details, affected_table, record_id, ip_address, user_agent) 
                             VALUES (?, ?, ?, ?, ?, ?, ?)");
        
        $stmt->execute([
            $_SESSION['user_id'] ?? null,
            $action,
            $description,
            $table,
            $record_id,
            $_SERVER['REMOTE_ADDR'],
            $_SERVER['HTTP_USER_AGENT']
        ]);
        
        return true;
    } catch (PDOException $e) {
        error_log("Audit trail error: " . $e->getMessage());
        return false;
    }
}
?>