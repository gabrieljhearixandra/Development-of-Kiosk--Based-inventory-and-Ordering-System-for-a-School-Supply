<?php
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}
?>
<!-- Sidebar Container -->
<div class="sidebar-container">
    <div class="sidebar">
        <div class="sidebar-header">
            <h3>POS Admin</h3>
            <p>Welcome, <?php echo $_SESSION['admin_username']; ?></p>
        </div>
        <ul class="nav flex-column">
            <li class="nav-item <?php echo basename($_SERVER['PHP_SELF']) === 'dashboard.php' ? 'active' : ''; ?>">
                <a class="nav-link" href="dashboard.php">
                    <i class="bi bi-speedometer2"></i> Dashboard
                </a>
            </li>
            <li class="nav-item <?php echo basename($_SERVER['PHP_SELF']) === 'sales.php' ? 'active' : ''; ?>">
                <a class="nav-link" href="sales.php">
                    <i class="bi bi-currency-dollar"></i> Sales
                </a>
            </li>
            <li class="nav-item <?php echo basename($_SERVER['PHP_SELF']) === 'inventory.php' ? 'active' : ''; ?>">
                <a class="nav-link" href="inventory.php">
                    <i class="bi bi-box-seam"></i> Inventory
                </a>
            </li>
            <li class="nav-item <?php echo basename($_SERVER['PHP_SELF']) === 'audit_trail.php' ? 'active' : ''; ?>">
                <a class="nav-link" href="audit_trail.php">
                    <i class="bi bi-clipboard-check"></i> Audit Trail
                </a>
            </li>
            <li class="nav-item <?php echo basename($_SERVER['PHP_SELF']) === 'support.php' ? 'active' : ''; ?>">
                <a class="nav-link" href="support.php">
                    <i class="bi bi-question-circle"></i> Support
                </a>
            </li>
            <li class="nav-item <?php echo basename($_SERVER['PHP_SELF']) === 'settings.php' ? 'active' : ''; ?>">
                <a class="nav-link" href="settings.php">
                    <i class="bi bi-gear"></i> Settings
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="../includes/logout.php">
                    <i class="bi bi-box-arrow-right"></i> Logout
                </a>
            </li>
        </ul>
    </div>
</div>