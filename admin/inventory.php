<?php
require_once '../includes/auth.php';
require_once '../includes/inventory_functions.php';
redirectIfNotLoggedIn();

// Handle form submissions
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $action = $_POST['action'] ?? '';
    $id = $_POST['id'] ?? 0;
    
    try {
        switch ($action) {
            case 'add_product':
                addProduct($_POST, $_FILES['image'] ?? null);
                break;
            case 'update_product':
                updateProduct($id, $_POST, $_FILES['image'] ?? null);
                break;
            case 'delete_product':
                deleteProduct($id);
                break;
            case 'add_category':
                addCategory($_POST);
                break;
            case 'update_category':
                updateCategory($id, $_POST);
                break;
            case 'delete_category':
                deleteCategory($id);
                break;
        }
        header("Location: inventory.php");
        exit();
    } catch (Exception $e) {
        die("Error: " . $e->getMessage());
    }
}

$products = getAllProducts();
$categories = getAllCategories();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Inventory</title>
    <link rel="stylesheet" href="../assets/css/sidebar.css">
    <link rel="stylesheet" href="../assets/css/inventory.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <div class="inventory-container" style="font-size: 1rem;"> 
        <?php include '../includes/sidebar.php'; ?>

        <!-- Main Content -->
        <div class="main-content">
            <div class="content-container">
                <h1>Inventory</h1>
                <div class="search-bar">
                    <input type="text" id="global-search" placeholder="Search products...">
                    <button id="search-btn">Search</button>
                </div>

                <div class="inventory-tabs">
                    <button class="tab-btn active" data-tab="products">Products</button>
                    <button class="tab-btn" data-tab="categories">Categories</button>
                </div>

                <!-- Products Tab -->
                <div class="tab-content active" id="products-tab">
                    <div class="action-bar">
                        <button id="add-product-btn" class="btn-primary">Add New Product</button>
                    </div>
                    <div class="table-container">
                        <table id="products-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Image</th>
                                    <th>Name</th>
                                    <th>Category</th>
                                    <th>Price</th>
                                    <th>Stock</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody id="products-list">
                                <?php foreach ($products as $product): ?>
                                <tr>
                                    <td><?= htmlspecialchars($product['id']) ?></td>
                                    <td>
                                        <?php if (!empty($product['image_path'])): ?>
                                            <img src="<?= htmlspecialchars($product['image_path']) ?>" alt="<?= htmlspecialchars($product['name']) ?>" style="width: 50px; height: 50px; object-fit: cover;">
                                        <?php else: ?>
                                            <span>No image</span>
                                        <?php endif; ?>
                                    </td>
                                    <td><?= htmlspecialchars($product['name']) ?></td>
                                    <td><?= htmlspecialchars($product['category_name'] ?? 'Uncategorized') ?></td>
                                    <td><?= number_format($product['price'], 2) ?></td>
                                    <td><?= $product['stock'] ?></td>
                                    <td>
                                        <button class="btn-primary edit-product" data-id="<?= $product['id'] ?>">Edit</button>
                                        <button class="btn-danger delete-product" data-id="<?= $product['id'] ?>">Delete</button>
                                    </td>
                                </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Categories Tab -->
                <div class="tab-content" id="categories-tab">
                    <div class="action-bar">
                        <button id="add-category-btn" class="btn-primary">Add New Category</button>
                    </div>
                    <div class="table-container">
                        <table id="categories-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Description</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody id="categories-list">
                                <?php foreach ($categories as $category): ?>
                                <tr>
                                    <td><?= htmlspecialchars($category['id']) ?></td>
                                    <td><?= htmlspecialchars($category['name']) ?></td>
                                    <td><?= htmlspecialchars($category['description']) ?></td>
                                    <td>
                                        <button class="btn-primary edit-category" data-id="<?= $category['id'] ?>">Edit</button>
                                        <button class="btn-danger delete-category" data-id="<?= $category['id'] ?>">Delete</button>
                                    </td>
                                </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Product Modal -->
    <div id="product-modal" class="modal">
        <div class="modal-content">
            <span class="close-btn">&times;</span>
            <h2 id="product-modal-title">Add New Product</h2>
            <form id="product-form" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="action" id="product-action" value="add_product">
                <input type="hidden" name="id" id="product-id" value="">
                <input type="hidden" name="current_image" id="current-image" value="">
                
                <div class="form-group">
                    <label for="product-name">Name</label>
                    <input type="text" id="product-name" name="name" required>
                </div>
                
                <div class="form-group">
                    <label for="product-description">Description</label>
                    <textarea id="product-description" name="description"></textarea>
                </div>
                
                <div class="form-group">
                    <label for="product-category">Category</label>
                    <select id="product-category" name="category_id">
                        <option value="">Select Category</option>
                        <?php foreach ($categories as $category): ?>
                            <option value="<?= $category['id'] ?>"><?= htmlspecialchars($category['name']) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="product-price">Price</label>
                    <input type="number" id="product-price" name="price" step="0.01" min="0" required>
                </div>
                
                <div class="form-group">
                    <label for="product-stock">Stock</label>
                    <input type="number" id="product-stock" name="stock" min="0" required>
                </div>
                
                <div class="form-group">
                    <label for="product-image">Image</label>
                    <input type="file" id="product-image" name="image" accept="image/*">
                    <div id="image-preview-container">
                        <img id="image-preview" style="display: none;">
                    </div>
                </div>
                
                <div class="form-actions">
                    <button type="button" class="btn-secondary" id="cancel-product-btn">Cancel</button>
                    <button type="submit" class="btn-primary">Save</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Category Modal -->
    <div id="category-modal" class="modal">
        <div class="modal-content">
            <span class="close-btn">&times;</span>
            <h2 id="category-modal-title">Add New Category</h2>
            <form id="category-form" method="POST">
                <input type="hidden" name="action" id="category-action" value="add_category">
                <input type="hidden" name="id" id="category-id" value="">
                
                <div class="form-group">
                    <label for="category-name">Name</label>
                    <input type="text" id="category-name" name="name" required>
                </div>
                
                <div class="form-group">
                    <label for="category-description">Description</label>
                    <textarea id="category-description" name="description"></textarea>
                </div>
                
                <div class="form-actions">
                    <button type="button" class="btn-secondary" id="cancel-category-btn">Cancel</button>
                    <button type="submit" class="btn-primary">Save</button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="../assets/js/inventory.js"></script>
</body>
</html>