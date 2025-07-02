<?php
require_once __DIR__ . '/../includes/config.php';
require_once __DIR__ . '/../includes/auth.php';

header('Content-Type: application/json');

try {
    // Check if requesting a single product
    if (isset($_GET['id'])) {
        $stmt = $pdo->prepare("
            SELECT p.*, c.name as category_name, s.quantity as current_stock
            FROM products p 
            LEFT JOIN categories c ON p.category_id = c.id
            LEFT JOIN stock s ON p.id = s.product_id
            WHERE p.id = ?
        ");
        $stmt->execute([$_GET['id']]);
        $product = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$product) {
            throw new Exception('Product not found');
        }
        
        echo json_encode($product);
    } else {
        // Get all products (including out of stock)
        $stmt = $pdo->query("
            SELECT p.*, c.name as category_name, s.quantity as current_stock
            FROM products p 
            LEFT JOIN categories c ON p.category_id = c.id
            LEFT JOIN stock s ON p.id = s.product_id
            ORDER BY p.name
        ");
        $products = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        echo json_encode($products);
    }
} catch (PDOException $e) {
    echo json_encode(['error' => 'Database error: ' . $e->getMessage()]);
} catch (Exception $e) {
    echo json_encode(['error' => $e->getMessage()]);
}