<?php
require_once __DIR__ . '/includes/config.php';
require_once __DIR__ . '/includes/functions.php';
require_once __DIR__ . '/includes/receipt_functions.php';

header('Content-Type: application/json');

// Enable error reporting for debugging
error_reporting(E_ALL);
ini_set('display_errors', 1);

try {
    // Verify database connection
    if (!isset($pdo)) {
        throw new Exception('Database connection not established');
    }

    // Get raw POST data
    $rawData = file_get_contents('php://input');
    if (empty($rawData)) {
        throw new Exception('No data received');
    }
    
    $data = json_decode($rawData, true);
    if ($data === null && json_last_error() !== JSON_ERROR_NONE) {
        throw new Exception('Invalid JSON data: ' . json_last_error_msg());
    }
    
    if (!isset($data['order'])) {
        throw new Exception('Invalid order data: order field missing');
    }
    
    // Decode the order data
    $order = json_decode($data['order'], true);
    if ($order === null && json_last_error() !== JSON_ERROR_NONE) {
        throw new Exception('Invalid order JSON: ' . json_last_error_msg());
    }
    
    if (!isset($order['items']) || !is_array($order['items']) || !isset($order['total'])) {
        throw new Exception('Invalid order structure');
    }
    
    // Start transaction
    $pdo->beginTransaction();
    
    // Insert sale
    $stmt = $pdo->prepare("INSERT INTO sales (total_amount, transaction_date) VALUES (:total, NOW())");
    $stmt->execute([':total' => $order['total']]);
    $saleId = $pdo->lastInsertId();
    
    // Insert sale items
    foreach ($order['items'] as $item) {
        if (!isset($item['id'], $item['quantity'], $item['price'])) {
            throw new Exception('Invalid item data');
        }
        
        // Insert sale item
        $stmt = $pdo->prepare("INSERT INTO sale_items (sale_id, product_id, quantity, unit_price, subtotal) 
                              VALUES (:sale_id, :product_id, :quantity, :price, :subtotal)");
        $subtotal = $item['price'] * $item['quantity'];
        
        $stmt->execute([
            ':sale_id' => $saleId,
            ':product_id' => $item['id'],
            ':quantity' => $item['quantity'],
            ':price' => $item['price'],
            ':subtotal' => $subtotal
        ]);
        
        // Update product stock
        $stmt = $pdo->prepare("UPDATE products SET stock = stock - :quantity WHERE id = :id");
        $stmt->execute([
            ':id' => $item['id'],
            ':quantity' => $item['quantity']
        ]);
    }
    
    // Generate receipt HTML
    $receiptSettings = getReceiptSettings();
    $receiptContent = generateReceiptHTML($saleId, $order['items'], $order['total'], $receiptSettings);

    // Commit transaction
    $pdo->commit();

    echo json_encode([
        'success' => true, 
        'order_id' => $saleId,
        'receipt_html' => $receiptContent,
        'message' => 'Order processed successfully'
    ]);
    
} catch (PDOException $e) {
    if (isset($pdo) && $pdo->inTransaction()) {
        $pdo->rollBack();
    }
    http_response_code(500);
    echo json_encode([
        'error' => true,
        'message' => 'Database error: ' . $e->getMessage()
    ]);
} catch (Exception $e) {
    if (isset($pdo) && $pdo->inTransaction()) {
        $pdo->rollBack();
    }
    http_response_code(400);
    echo json_encode([
        'error' => true,
        'message' => $e->getMessage()
    ]);
}
?>