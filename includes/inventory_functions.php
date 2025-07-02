<?php
require_once 'db.php';

function logAuditTrail($actionType, $details, $table = null, $recordId = null) {
    global $conn;
    
    $stmt = $conn->prepare("
        INSERT INTO audit_trail 
        (user_id, action_type, action_details, ip_address, user_agent, affected_table, record_id)
        VALUES 
        (:user_id, :action_type, :action_details, :ip_address, :user_agent, :affected_table, :record_id)
    ");
    
    $stmt->execute([
        ':user_id' => $_SESSION['user_id'] ?? null,
        ':action_type' => $actionType,
        ':action_details' => is_array($details) ? json_encode($details) : $details,
        ':ip_address' => $_SERVER['REMOTE_ADDR'] ?? 'unknown',
        ':user_agent' => $_SERVER['HTTP_USER_AGENT'] ?? 'unknown',
        ':affected_table' => $table,
        ':record_id' => $recordId
    ]);
}

function handleImageUpload($file, $targetDir, $currentImage = '') {
    if ($file['error'] === UPLOAD_ERR_OK) {
        if (!file_exists($targetDir)) {
            mkdir($targetDir, 0777, true);
        }
        
        $fileExtension = pathinfo($file['name'], PATHINFO_EXTENSION);
        $filename = uniqid() . '.' . $fileExtension;
        $targetFile = $targetDir . $filename;
        
        if (move_uploaded_file($file['tmp_name'], $targetFile)) {
            // Delete old image if exists
            if (!empty($currentImage) && file_exists($currentImage)) {
                unlink($currentImage);
            }
            return $targetFile;
        }
    }
    return $currentImage;
}

function addProduct($data, $imageFile) {
    global $conn;
    
    $imagePath = handleImageUpload($imageFile, '../uploads/products/');
    
    $stmt = $conn->prepare("INSERT INTO products (name, description, category_id, price, stock, image_path) 
                           VALUES (:name, :description, :category_id, :price, :stock, :image_path)");
    
    $success = $stmt->execute([
        ':name' => $data['name'],
        ':description' => $data['description'],
        ':category_id' => $data['category_id'] ?: null,
        ':price' => $data['price'],
        ':stock' => $data['stock'],
        ':image_path' => $imagePath
    ]);
    
    if ($success) {
        $productId = $conn->lastInsertId();
        logAuditTrail('create', [
            'name' => $data['name'],
            'description' => $data['description'],
            'category_id' => $data['category_id'],
            'price' => $data['price'],
            'stock' => $data['stock'],
            'image_path' => $imagePath
        ], 'products', $productId);
    }
    
    return $success;
}

function updateProduct($id, $data, $imageFile) {
    global $conn;
    
    // Get current product data
    $stmt = $conn->prepare("SELECT * FROM products WHERE id = :id");
    $stmt->execute([':id' => $id]);
    $currentData = $stmt->fetch(PDO::FETCH_ASSOC);
    
    // Get current image path
    $currentImage = $currentData['image_path'] ?? '';
    $imagePath = handleImageUpload($imageFile, '../uploads/products/', $currentImage);
    
    $stmt = $conn->prepare("UPDATE products SET 
                          name = :name, 
                          description = :description, 
                          category_id = :category_id, 
                          price = :price, 
                          stock = :stock, 
                          image_path = :image_path 
                          WHERE id = :id");
    
    $success = $stmt->execute([
        ':id' => $id,
        ':name' => $data['name'],
        ':description' => $data['description'],
        ':category_id' => $data['category_id'] ?: null,
        ':price' => $data['price'],
        ':stock' => $data['stock'],
        ':image_path' => $imagePath
    ]);
    
    if ($success) {
        // Find what changed
        $changes = [];
        foreach ($data as $key => $value) {
            if ($key === 'action' || $key === 'id') continue;
            
            $oldValue = $currentData[$key] ?? null;
            $newValue = $value;
            
            if ($oldValue != $newValue) {
                $changes[$key] = [
                    'old' => $oldValue,
                    'new' => $newValue
                ];
            }
        }
        
        // Check if image changed
        if ($imagePath != $currentImage) {
            $changes['image_path'] = [
                'old' => $currentImage,
                'new' => $imagePath
            ];
        }
        
        if (!empty($changes)) {
            logAuditTrail('update', $changes, 'products', $id);
        }
    }
    
    return $success;
}

function deleteProduct($id) {
    global $conn;
    
    // Get product data before deletion
    $stmt = $conn->prepare("SELECT * FROM products WHERE id = :id");
    $stmt->execute([':id' => $id]);
    $product = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$product) return false;
    
    // Delete image file if exists
    $imagePath = $product['image_path'] ?? '';
    if ($imagePath && file_exists($imagePath)) {
        unlink($imagePath);
    }
    
    $stmt = $conn->prepare("DELETE FROM products WHERE id = :id");
    $success = $stmt->execute([':id' => $id]);
    
    if ($success) {
        logAuditTrail('delete', [
            'name' => $product['name'],
            'description' => $product['description'],
            'category_id' => $product['category_id'],
            'price' => $product['price'],
            'stock' => $product['stock'],
            'image_path' => $product['image_path']
        ], 'products', $id);
    }
    
    return $success;
}

function addCategory($data) {  // Removed $imageFile parameter
    global $conn;
    
    $stmt = $conn->prepare("INSERT INTO categories (name, description) 
                           VALUES (:name, :description)");
    
    $success = $stmt->execute([
        ':name' => $data['name'],
        ':description' => $data['description']
    ]);
    
    if ($success) {
        $categoryId = $conn->lastInsertId();
        logAuditTrail('create', [
            'name' => $data['name'],
            'description' => $data['description']
        ], 'categories', $categoryId);
    }
    
    return $success;
}

function updateCategory($id, $data) {  // Removed $imageFile parameter
    global $conn;
    
    // Get current category data
    $stmt = $conn->prepare("SELECT * FROM categories WHERE id = :id");
    $stmt->execute([':id' => $id]);
    $currentData = $stmt->fetch(PDO::FETCH_ASSOC);
    
    $stmt = $conn->prepare("UPDATE categories SET 
                          name = :name, 
                          description = :description
                          WHERE id = :id");
    
    $success = $stmt->execute([
        ':id' => $id,
        ':name' => $data['name'],
        ':description' => $data['description']
    ]);
    
    if ($success) {
        // Find what changed
        $changes = [];
        foreach ($data as $key => $value) {
            if ($key === 'action' || $key === 'id') continue;
            
            $oldValue = $currentData[$key] ?? null;
            $newValue = $value;
            
            if ($oldValue != $newValue) {
                $changes[$key] = [
                    'old' => $oldValue,
                    'new' => $newValue
                ];
            }
        }
        
        if (!empty($changes)) {
            logAuditTrail('update', $changes, 'categories', $id);
        }
    }
    
    return $success;
}

function deleteCategory($id) {
    global $conn;
    
    // Get category data before deletion
    $stmt = $conn->prepare("SELECT * FROM categories WHERE id = :id");
    $stmt->execute([':id' => $id]);
    $category = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if (!$category) return false;
    
    // First set products' category_id to NULL
    $stmt = $conn->prepare("UPDATE products SET category_id = NULL WHERE category_id = :id");
    $stmt->execute([':id' => $id]);
    
    // Then delete the category
    $stmt = $conn->prepare("DELETE FROM categories WHERE id = :id");
    $success = $stmt->execute([':id' => $id]);
    
    if ($success) {
        logAuditTrail('delete', [
            'name' => $category['name'],
            'description' => $category['description']
        ], 'categories', $id);
    }
    
    return $success;
}
function getAllProducts() {
    global $conn;
    $stmt = $conn->query("SELECT p.*, c.name as category_name FROM products p LEFT JOIN categories c ON p.category_id = c.id");
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function getAllCategories() {
    global $conn;
    $stmt = $conn->query("SELECT * FROM categories");
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

function getProductById($id) {
    global $conn;
    $stmt = $conn->prepare("SELECT * FROM products WHERE id = :id");
    $stmt->execute([':id' => $id]);
    return $stmt->fetch(PDO::FETCH_ASSOC);
}

function getCategoryById($id) {
    global $conn;
    $stmt = $conn->prepare("SELECT * FROM categories WHERE id = :id");
    $stmt->execute([':id' => $id]);
    return $stmt->fetch(PDO::FETCH_ASSOC);
}
?>