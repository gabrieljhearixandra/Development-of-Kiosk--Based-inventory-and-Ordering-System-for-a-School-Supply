<?php
require '../config.php';
require 'auth.php';

if (!isAdminLoggedIn()) {
    die('Unauthorized access');
}

$stmt = $pdo->query("SELECT * FROM stock ORDER BY category, name");
$items = $stmt->fetchAll();

foreach ($items as $item): ?>
<tr>
    <td><?php echo $item['id']; ?></td>
    <td>
        <?php if ($item['image_path']): ?>
            <img src="../<?php echo $item['image_path']; ?>" alt="<?php echo $item['name']; ?>" width="50">
        <?php endif; ?>
    </td>
    <td><?php echo htmlspecialchars($item['name']); ?></td>
    <td><?php echo htmlspecialchars($item['category']); ?></td>
    <td>₱<?php echo number_format($item['price'], 2); ?></td>
    <td>
        <span class="<?php echo $item['quantity'] < 10 ? 'text-danger fw-bold' : ''; ?>">
            <?php echo $item['quantity']; ?>
        </span>
    </td>
    <td>
        <button class="btn btn-sm btn-primary edit-item" data-id="<?php echo $item['id']; ?>">Edit</button>
        <button class="btn btn-sm btn-danger delete-item" data-id="<?php echo $item['id']; ?>">Delete</button>
    </td>
</tr>
<?php endforeach; ?>