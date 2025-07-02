<?php
require_once '../includes/auth.php';
redirectIfNotLoggedIn();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    
    <link rel="stylesheet" href="../assets/css/sidebar.css">
    <link rel="stylesheet" href="../assets/css/admin.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <div class="admin-container">
        <?php include '../includes/sidebar.php'; ?>

        <div class="main-content">
            <div class="content-container">
                <h1>Dashboard</h1>
                
                <!-- Stats Cards -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="card-body">
                            <h5 class="card-title">Today's Sales</h5>
                            <h2 class="card-text">₱<?php 
                                $stmt = $pdo->query("SELECT SUM(total_amount) as total FROM sales WHERE DATE(transaction_date) = CURDATE()");
                                $result = $stmt->fetch();
                                echo number_format($result['total'] ?? 0, 2);
                            ?></h2>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="card-body">
                            <h5 class="card-title">Monthly Sales</h5>
                            <h2 class="card-text">₱<?php 
                                $stmt = $pdo->query("SELECT SUM(total_amount) as total FROM sales WHERE MONTH(transaction_date) = MONTH(CURDATE()) AND YEAR(transaction_date) = YEAR(CURDATE())");  
                                $result = $stmt->fetch();
                                echo number_format($result['total'] ?? 0, 2);
                            ?></h2>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="card-body">
                            <h5 class="card-title">Low Stock Items</h5>
                            <h2 class="card-text"><?php 
                                $stmt = $pdo->query("SELECT COUNT(*) as count FROM products WHERE stock < 10");
                                $result = $stmt->fetch();
                                echo $result['count'] ?? 0;
                            ?></h2>
                        </div>
                    </div>
                </div>
                
                <!-- Recent Sales -->
                <div class="card">
                    <div class="card-header">
                        <h4>Recent Sales</h4>
                    </div>
                    <div class="card-body">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Date</th>
                                    <th>Items</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php
                                $stmt = $pdo->query("
                                    SELECT 
                                        s.sale_id, 
                                        s.transaction_date, 
                                        s.total_amount,
                                        (
                                            SELECT GROUP_CONCAT(CONCAT(p.name, ' (x', si.quantity, ')') SEPARATOR ', ')
                                            FROM sale_items si
                                            JOIN products p ON si.product_id = p.id
                                            WHERE si.sale_id = s.sale_id
                                        ) as items
                                    FROM sales s
                                    ORDER BY s.transaction_date DESC 
                                    LIMIT 5
                                ");
                                while ($sale = $stmt->fetch()):
                                ?>
                                <tr>
                                    <td><?php echo $sale['sale_id']; ?></td>
                                    <td><?php echo date('M d, Y h:i A', strtotime($sale['transaction_date'])); ?></td>
                                    <td><?php echo $sale['items'] ?? 'No items'; ?></td>
                                    <td>₱<?php echo number_format($sale['total_amount'], 2); ?></td>
                                </tr>
                                <?php endwhile; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="../assets/js/admin.js"></script>
</body>
</html>