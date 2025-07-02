<?php
require_once '../includes/auth.php';
require_once '../includes/db.php';

header('Content-Type: application/json');

if (!isset($_GET['sale_id'])) {
    echo json_encode(['success' => false, 'message' => 'Sale ID not provided']);
    exit;
}

$sale_id = $_GET['sale_id'];

try {
    // Get sale info
    $stmt = $pdo->prepare("SELECT * FROM sales WHERE sale_id = ?");
    $stmt->execute([$sale_id]);
    $sale = $stmt->fetch();
    
    if (!$sale) {
        echo json_encode(['success' => false, 'message' => 'Sale not found']);
        exit;
    }
    
    // Get sale items
    $stmt = $pdo->prepare("
        SELECT si.*, p.name 
        FROM sale_items si
        JOIN products p ON si.product_id = p.id
        WHERE si.sale_id = ?
    ");
    $stmt->execute([$sale_id]);
    $items = $stmt->fetchAll();
    
    echo json_encode([
        'success' => true,
        'sale' => $sale,
        'items' => $items
    ]);
    
} catch (PDOException $e) {
    echo json_encode(['success' => false, 'message' => 'Database error: ' . $e->getMessage()]);
}