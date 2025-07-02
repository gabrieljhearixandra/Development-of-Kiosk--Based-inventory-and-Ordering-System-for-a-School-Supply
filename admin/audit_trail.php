<?php
require_once __DIR__ . '/../includes/auth.php';
require_once __DIR__ . '/../includes/db.php';
require_once __DIR__ . '/../includes/inventory_functions.php';
redirectIfNotLoggedIn();

// Date filtering
$start_date = $_GET['start_date'] ?? date('Y-m-d', strtotime('-7 days'));
$end_date = $_GET['end_date'] ?? date('Y-m-d');

// Get all audit trail entries with pagination support
$page = isset($_GET['page']) ? (int)$_GET['page'] : 1;
$perPage = 20;
$offset = ($page - 1) * $perPage;

// Base query
$audit_query = "
    SELECT 
        a.id,
        a.action_type,
        a.action_details,
        a.action_timestamp,
        u.username as performed_by,
        a.affected_table,
        a.record_id
    FROM audit_trail a
    LEFT JOIN admins u ON a.user_id = u.id
    WHERE DATE(a.action_timestamp) BETWEEN :start_date AND :end_date
    ORDER BY a.action_timestamp DESC
    LIMIT :offset, :perPage
";

// Count query for pagination
$count_query = "
    SELECT COUNT(*) as total 
    FROM audit_trail a
    WHERE DATE(a.action_timestamp) BETWEEN :start_date AND :end_date
";

$audit_stmt = $pdo->prepare($audit_query);
$audit_stmt->bindValue(':start_date', $start_date);
$audit_stmt->bindValue(':end_date', $end_date);
$audit_stmt->bindValue(':offset', $offset, PDO::PARAM_INT);
$audit_stmt->bindValue(':perPage', $perPage, PDO::PARAM_INT);
$audit_stmt->execute();
$audit_entries = $audit_stmt->fetchAll();

// Get total count for pagination
$count_stmt = $pdo->prepare($count_query);
$count_stmt->execute([':start_date' => $start_date, ':end_date' => $end_date]);
$totalEntries = $count_stmt->fetchColumn();
$totalPages = ceil($totalEntries / $perPage);

// Calculate pagination range
$startPage = max(1, $page - 2);
$endPage = min($totalPages, $page + 2);

function formatActionDetails($entry) {
    $details = json_decode($entry['action_details'], true);
    if (!$details) return nl2br(htmlspecialchars($entry['action_details']));
    
    $output = '';
    $table = $entry['affected_table'] ?? '';
    $action = strtolower($entry['action_type']);
    
    switch ($action) {
        case 'reset_sales':
            $output = "<strong style='color: #6f42c1;'>Reset sales data:</strong><br>";
            $output .= "Period: " . ucfirst($details['period'] ?? '') . "<br>";
            $output .= "From: " . ($details['start_date'] ?? '') . "<br>";
            $output .= "To: " . ($details['end_date'] ?? '') . "<br>";
            $output .= "Records deleted: " . ($details['records_deleted'] ?? '0');
            break;
            
        case 'create_backup':
            $output = "<strong>Database backup created:</strong><br>";
            $output .= "File: " . ($details['backup_file'] ?? '');
            break;
            
        case 'create':
            $output = "<strong>Created new {$table}:</strong><br>";
            if ($table === 'products') {
                $output .= "Name: " . ($details['name'] ?? '') . "<br>";
                $output .= "Price: " . ($details['price'] ?? '') . "<br>";
                $output .= "Stock: " . ($details['stock'] ?? '');
            } elseif ($table === 'faqs') {
                $output .= "Question: " . ($details['question'] ?? '') . "<br>";
                $output .= "Answer: " . ($details['answer'] ?? '');
            } else {
                $output .= "Name: " . ($details['name'] ?? '');
            }
            break;
            
        case 'update':
            $output = "<strong>Updated {$table}:</strong><br>";
            if ($table === 'faqs') {
                if (isset($details['question'])) {
                    $output .= "<u>Question</u>: '" . ($details['question']['old'] ?? '') . "' → '" . ($details['question']['new'] ?? '') . "'<br>";
                }
                if (isset($details['answer'])) {
                    $output .= "<u>Answer</u>: '" . ($details['answer']['old'] ?? '') . "' → '" . ($details['answer']['new'] ?? '') . "'<br>";
                }
            } else {
                foreach ($details as $field => $change) {
                    if (is_array($change)) {
                        $output .= "<u>{$field}</u>: '" . ($change['old'] ?? '') . "' → '" . ($change['new'] ?? '') . "'<br>";
                    }
                }
            }
            break;
            
        case 'delete':
            $output = "<strong>Deleted {$table}:</strong><br>";
            if ($table === 'products') {
                $output .= "Name: " . ($details['name'] ?? '') . "<br>";
                $output .= "Price: " . ($details['price'] ?? '') . "<br>";
                $output .= "Stock: " . ($details['stock'] ?? '');
            } elseif ($table === 'faqs') {
                $output .= "Question: " . ($details['question'] ?? '') . "<br>";
                $output .= "Answer: " . ($details['answer'] ?? '');
            } else {
                $output .= "Name: " . ($details['name'] ?? '');
            }
            break;
            
        default:
            $output = nl2br(htmlspecialchars($entry['action_details']));
    }
    
    return $output;
}

function getActionBadgeClass($action_type) {
    $action = strtolower($action_type);
    
    switch ($action) {
        case 'create': return 'badge-primary';
        case 'update': return 'badge-warning';
        case 'delete': return 'badge-danger';
        case 'reset_sales': return 'badge-reset';
        case 'reset_sales': return 'badge-dark';
        case 'create_backup': return 'badge-secondary';
        default: return 'badge-info';
    }
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Audit Trail | POS System</title>
    <link rel="stylesheet" href="../assets/css/sidebar.css">
    <link rel="stylesheet" href="../assets/css/admin.css">
    <link rel="stylesheet" href="../assets/css/audit_trail.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
</head>
<body>
    <div class="admin-container">
        <?php include __DIR__ . '/../includes/sidebar.php'; ?>

        <div class="main-content">
            <div class="content-container">
                <h1>Audit Trail</h1>
                
                <!-- Date Filter -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h4>Filter Audit Trail</h4>
                    </div>
                    <div class="card-body">
                        <form method="get" class="row g-3">
                            <div class="col-md-5">
                                <label for="start_date" class="form-label">Start Date</label>
                                <input type="date" class="form-control" id="start_date" name="start_date" value="<?= htmlspecialchars($start_date) ?>">
                            </div>
                            <div class="col-md-5">
                                <label for="end_date" class="form-label">End Date</label>
                                <input type="date" class="form-control" id="end_date" name="end_date" value="<?= htmlspecialchars($end_date) ?>">
                            </div>
                            <div class="col-md-2 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary">Filter</button>
                            </div>
                        </form>
                    </div>
                </div>
                
                <!-- Audit Trail Table -->
                <div class="card">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <h4 class="mb-0">Activity Log</h4>
                        <div>
                            <span class="badge bg-light text-dark">
                                Total Records: <?= number_format($totalEntries) ?>
                            </span>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="data-table">
                                <thead>
                                    <tr>
                                        <th>Timestamp</th>
                                        <th>Action</th>
                                        <th>User</th>
                                        <th>Details</th>
                                        <th>Affected Item</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <?php if (empty($audit_entries)): ?>
                                        <tr>
                                            <td colspan="5" class="text-center py-4">No audit entries found for the selected period</td>
                                        </tr>
                                    <?php else: ?>
                                        <?php foreach ($audit_entries as $entry): ?>
                                            <tr>
                                                <td><?= date('M d, Y h:i A', strtotime($entry['action_timestamp'])) ?></td>
                                                <td>
                                                    <span class="badge <?= getActionBadgeClass($entry['action_type']) ?>">
                                                        <?= htmlspecialchars(ucfirst(strtolower($entry['action_type']))) ?>
                                                    </span>
                                                </td>
                                                <td><?= htmlspecialchars($entry['performed_by'] ?? 'System') ?></td>
                                                <td><?= formatActionDetails($entry) ?></td>
                                                <td>
                                                    <?= htmlspecialchars(ucfirst($entry['affected_table'] ?? '')) ?> #<?= $entry['record_id'] ?>
                                                </td>
                                            </tr>
                                        <?php endforeach; ?>
                                    <?php endif; ?>
                                </tbody>
                            </table>
                        </div>
                        
                        <?php if ($totalPages > 1): ?>
                        <nav class="mt-4">
                            <ul class="pagination justify-content-center" style="list-style-type: none;">
                                <?php if ($page > 1): ?>
                                    <li class="page-item">
                                        <a class="page-link" href="?<?= http_build_query(array_merge($_GET, ['page' => 1])) ?>">
                                            &laquo;
                                        </a>
                                    </li>
                                    <li class="page-item">
                                        <a class="page-link" href="?<?= http_build_query(array_merge($_GET, ['page' => $page - 1])) ?>">
                                            &lsaquo;
                                        </a>
                                    </li>
                                <?php endif; ?>

                                <?php for ($i = $startPage; $i <= $endPage; $i++): ?>
                                    <li class="page-item <?= $i == $page ? 'active' : '' ?>">
                                        <a class="page-link" href="?<?= http_build_query(array_merge($_GET, ['page' => $i])) ?>">
                                            <?= $i ?>
                                        </a>
                                    </li>
                                <?php endfor; ?>

                                <?php if ($page < $totalPages): ?>
                                    <li class="page-item">
                                        <a class="page-link" href="?<?= http_build_query(array_merge($_GET, ['page' => $page + 1])) ?>">
                                            &rsaquo;
                                        </a>
                                    </li>
                                    <li class="page-item">
                                        <a class="page-link" href="?<?= http_build_query(array_merge($_GET, ['page' => $totalPages])) ?>">
                                            &raquo;
                                        </a>
                                    </li>
                                <?php endif; ?>
                            </ul>
                        </nav>
                        <?php endif; ?>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="../assets/js/audit_trail.js"></script>
</body>
</html>