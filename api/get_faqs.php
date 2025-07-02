<?php
require_once __DIR__ . '/../includes/config.php';
require_once __DIR__ . '/../includes/auth.php';

header('Content-Type: application/json');

$response = [];

try {
    // Check database connection
    if (!$pdo) {
        throw new Exception('Could not connect to database');
    }

    // Fetch FAQs
    $stmt = $pdo->query("SELECT * FROM faqs ORDER BY id");
    $response = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    $response = ['error' => true, 'message' => 'Database error: ' . $e->getMessage()];
} catch (Exception $e) {
    $response = ['error' => true, 'message' => $e->getMessage()];
}

echo json_encode($response);
?>