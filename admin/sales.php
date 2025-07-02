<?php
require_once '../includes/auth.php';
redirectIfNotLoggedIn();

// Handle date filtering
$start_date = isset($_GET['start_date']) ? $_GET['start_date'] : date('Y-m-01');
$end_date = isset($_GET['end_date']) ? $_GET['end_date'] : date('Y-m-d');

$query = "
    SELECT 
        s.sale_id,
        s.transaction_date,
        s.total_amount,
        s.status,
        COUNT(si.item_id) as item_count,
        GROUP_CONCAT(CONCAT(p.name, ' (', si.quantity, 'x)') SEPARATOR ', ') as items
    FROM sales s
    LEFT JOIN sale_items si ON s.sale_id = si.sale_id
    LEFT JOIN products p ON si.product_id = p.id
    WHERE DATE(s.transaction_date) BETWEEN :start_date AND :end_date
    GROUP BY s.sale_id, s.transaction_date, s.total_amount, s.status
    ORDER BY s.transaction_date DESC
";

// Prepare and execute the query
$stmt = $pdo->prepare($query);
$stmt->execute([
    ':start_date' => $start_date,
    ':end_date' => $end_date
]);
$sales = $stmt->fetchAll();

// Get sales summary for the period
$summary_query = "
    SELECT 
        COUNT(*) as total_sales,
        SUM(total_amount) as total_revenue,
        AVG(total_amount) as avg_sale
    FROM sales
    WHERE DATE(transaction_date) BETWEEN :start_date AND :end_date
";
$summary_stmt = $pdo->prepare($summary_query);
$summary_stmt->execute([
    ':start_date' => $start_date,
    ':end_date' => $end_date
]);
$summary = $summary_stmt->fetch();

// Get top selling products
$top_products_query = "
    SELECT 
        p.name,
        SUM(si.quantity) as total_quantity,
        SUM(si.subtotal) as total_revenue
    FROM sale_items si
    JOIN products p ON si.product_id = p.id
    JOIN sales s ON si.sale_id = s.sale_id
    WHERE DATE(s.transaction_date) BETWEEN :start_date AND :end_date
    GROUP BY p.name
    ORDER BY total_quantity DESC
    LIMIT 5
";
$top_products_stmt = $pdo->prepare($top_products_query);
$top_products_stmt->execute([
    ':start_date' => $start_date,
    ':end_date' => $end_date
]);
$top_products = $top_products_stmt->fetchAll();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sales | POS System</title>
    
    <link rel="stylesheet" href="../assets/css/sidebar.css">
    <link rel="stylesheet" href="../assets/css/admin.css">
    <link rel="stylesheet" href="../assets/css/sales.css">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Datepicker CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
</head>
<body>
    <div class="admin-container">
        <?php include '../includes/sidebar.php'; ?>

        <div class="main-content">
            <div class="content-container">
                <div class="page-header">
                    <h1>Sales Management</h1>
                    <div class="date-range-display">
                        <?php echo date('M d, Y', strtotime($start_date)); ?> to <?php echo date('M d, Y', strtotime($end_date)); ?>
                    </div>
                </div>
                
                <!-- Date Filter -->
                <div class="filter-card card mb-4">
                    <div class="card-header">
                        <h4>Filter Sales</h4>
                    </div>
                    <div class="card-body">
                        <form method="get" class="filter-form">
                            <div class="form-group">
                                <label for="start_date">Start Date</label>
                                <input type="date" class="form-control" id="start_date" name="start_date" value="<?php echo $start_date; ?>">
                            </div>
                            <div class="form-group">
                                <label for="end_date">End Date</label>
                                <input type="date" class="form-control" id="end_date" name="end_date" value="<?php echo $end_date; ?>">
                            </div>
                            <button type="submit" class="btn btn-primary">Apply Filter</button>
                        </form>
                    </div>
                </div>
                
                <!-- Sales Summary -->
                <div class="stats-grid mb-4">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="bi bi-receipt"></i>
                        </div>
                        <div class="stat-content">
                            <h3>Total Sales</h3>
                            <h2><?php echo $summary['total_sales'] ?? 0; ?></h2>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="bi bi-currency-dollar"></i>
                        </div>
                        <div class="stat-content">
                            <h3>Total Revenue</h3>
                            <h2>₱<?php echo number_format($summary['total_revenue'] ?? 0, 2); ?></h2>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="bi bi-graph-up"></i>
                        </div>
                        <div class="stat-content">
                            <h3>Average Sale</h3>
                            <h2>₱<?php echo number_format($summary['avg_sale'] ?? 0, 2); ?></h2>
                        </div>
                    </div>
                </div>
                
                <!-- Two-column layout for tables -->
                <div class="two-column-layout">
                    <!-- Top Selling Products -->
                    <div class="column">
                        <div class="card">
                            <div class="card-header">
                                <h4>Top Selling Products</h4>
                            </div>
                            <div class="card-body">
                                <div class="table-container">
                                    <table class="data-table">
                                        <thead>
                                            <tr>
                                                <th>Product</th>
                                                <th>Quantity</th>
                                                <th>Revenue</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php foreach ($top_products as $product): ?>
                                                <tr>
                                                    <td><?php echo htmlspecialchars($product['name']); ?></td>
                                                    <td class="text-center"><?php echo $product['total_quantity']; ?></td>
                                                    <td class="text-right">₱<?php echo number_format($product['total_revenue'], 2); ?></td>
                                                </tr>
                                            <?php endforeach; ?>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Sales Transactions -->
                    <div class="column">
                        <div class="card">
                            <div class="card-header">
                                <h4>Sales Transactions</h4>
                            </div>
                            <div class="card-body">
                                <div class="table-container">
                                    <table class="data-table">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Date & Time</th>
                                                <th>Items</th>
                                                <th>Amount</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php foreach ($sales as $sale): ?>
                                                <tr>
                                                    <td><?php echo $sale['sale_id']; ?></td>
                                                    <td><?php echo date('M d, Y h:i A', strtotime($sale['transaction_date'])); ?></td>
                                                    <td class="text-center"><?php echo $sale['item_count']; ?></td>
                                                    <td class="text-right">₱<?php echo number_format($sale['total_amount'], 2); ?></td>
                                                </tr>
                                            <?php endforeach; ?>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="../assets/js/sales.js"></script>
</body>
</html>