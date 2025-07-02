<?php
require_once __DIR__ . '/db.php';

function getReceiptSettings() {
    global $pdo;
    
    try {
        // Check if table exists
        $tableExists = $pdo->query("SHOW TABLES LIKE 'receipt_settings'")->rowCount() > 0;
        
        if (!$tableExists) {
            // Create the table if it doesn't exist
            $pdo->exec("
                CREATE TABLE IF NOT EXISTS receipt_settings (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    store_name VARCHAR(255) NOT NULL DEFAULT 'MY STORE',
                    store_address VARCHAR(255) NOT NULL DEFAULT '123 Main Street, City',
                    store_phone VARCHAR(50) NOT NULL DEFAULT 'Tel: (123) 456-7890',
                    thank_you_message VARCHAR(255) NOT NULL DEFAULT 'Thank you for your purchase!',
                    receipt_number INT NOT NULL DEFAULT 1,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
                )
            ");
            
            // Insert default record
            $pdo->exec("
                INSERT INTO receipt_settings 
                (store_name, store_address, store_phone, thank_you_message, receipt_number)
                VALUES 
                ('MY STORE', '123 Main Street, City', 'Tel: (123) 456-7890', 'Thank you for your purchase!', 1)
            ");
        }
        
        $stmt = $pdo->query("SELECT * FROM receipt_settings LIMIT 1");
        $settings = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$settings) {
            return [
                'store_name' => 'MY STORE',
                'store_address' => '123 Main Street, City',
                'store_phone' => 'Tel: (123) 456-7890',
                'thank_you_message' => 'Thank you for your purchase!'
            ];
        }
        
        return $settings;
    } catch (PDOException $e) {
        error_log("Error getting receipt settings: " . $e->getMessage());
        return [
            'store_name' => 'MY STORE',
            'store_address' => '123 Main Street, City',
            'store_phone' => 'Tel: (123) 456-7890',
            'thank_you_message' => 'Thank you for your purchase!'
        ];
    }
}

function updateReceiptSettings($data) {
    global $pdo;
    
    try {
        $pdo->beginTransaction();
        
        // Check if settings exist
        $stmt = $pdo->query("SELECT COUNT(*) FROM receipt_settings");
        $count = $stmt->fetchColumn();
        
        if ($count == 0) {
            // Insert new settings
            $stmt = $pdo->prepare("
                INSERT INTO receipt_settings 
                (store_name, store_address, store_phone, thank_you_message)
                VALUES (?, ?, ?, ?)
            ");
            $stmt->execute([
                $data['store_name'],
                $data['store_address'],
                $data['store_phone'],
                $data['thank_you_message']
            ]);
        } else {
            // Update existing settings
            $stmt = $pdo->prepare("
                UPDATE receipt_settings SET
                    store_name = ?,
                    store_address = ?,
                    store_phone = ?,
                    thank_you_message = ?
                WHERE id = 1
            ");
            
            $stmt->execute([
                $data['store_name'],
                $data['store_address'],
                $data['store_phone'],
                $data['thank_you_message']
            ]);
        }
        
        $pdo->commit();
        return true;
    } catch (PDOException $e) {
        $pdo->rollBack();
        error_log("Error updating receipt settings: " . $e->getMessage());
        return false;
    }
}

function getNextReceiptNumber() {
    global $pdo;
    
    try {
        $pdo->beginTransaction();
        
        // Get current number
        $stmt = $pdo->query("SELECT receipt_number FROM receipt_settings LIMIT 1");
        $settings = $stmt->fetch(PDO::FETCH_ASSOC);
        
        if (!$settings) {
            throw new Exception("Receipt settings not found");
        }
        
        // Increment the number
        $newNumber = $settings['receipt_number'] + 1;
        $stmt = $pdo->prepare("UPDATE receipt_settings SET receipt_number = ? WHERE id = 1");
        $stmt->execute([$newNumber]);
        
        $pdo->commit();
        
        return str_pad($settings['receipt_number'], 6, '0', STR_PAD_LEFT);
    } catch (Exception $e) {
        $pdo->rollBack();
        error_log("Error getting next receipt number: " . $e->getMessage());
        return str_pad(rand(1, 999999), 6, '0', STR_PAD_LEFT); // Fallback
    }
}

function generateReceiptHTML($orderId, $items, $total, $settings) {
    $date = date('m/d/Y h:i A');
  
    
    $itemsHTML = '';
    foreach ($items as $item) {
        $itemsHTML .= '
        <div class="receipt-item">
            <div class="item-name">' . htmlspecialchars($item['name']) . '</div>
            <div class="item-details">
                <span>' . $item['quantity'] . ' x ₱' . number_format($item['price'], 2) . '</span>
                <span>₱' . number_format($item['price'] * $item['quantity'], 2) . '</span>
            </div>
        </div>';
    }
    
    return '
    <div class="receipt">
        <div class="receipt-header">
            <h2>' . htmlspecialchars($settings['store_name']) . '</h2>
            <p>' . htmlspecialchars($settings['store_address']) . '</p>
            <p>' . htmlspecialchars($settings['store_phone']) . '</p>
        </div>
        
        <div class="receipt-info">
            <p>Order No: ' . $orderId . '</p>
            <p>Date: ' . $date . '</p>
        </div>
        
        <div class="receipt-items">
            ' . $itemsHTML . '
        </div>
        
        <div class="receipt-total">
            <div class="total-line">
                <span>Total:</span>
                <span>₱' . number_format($total, 2) . '</span>
            </div>
        </div>
        
        <div class="receipt-footer">
            <p>' . htmlspecialchars($settings['thank_you_message']) . '</p>
        </div>
    </div>';
}