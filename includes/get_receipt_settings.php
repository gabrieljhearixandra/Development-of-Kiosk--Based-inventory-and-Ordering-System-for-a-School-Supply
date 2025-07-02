<?php
require_once __DIR__ . '/../includes/db.php';
require_once __DIR__ . '/../includes/receipt_functions.php';

header('Content-Type: application/json');

try {
    $settings = getReceiptSettings();
    echo json_encode($settings);
} catch (Exception $e) {
    http_response_code(500);
    echo json_encode(['error' => $e->getMessage()]);
}
?>