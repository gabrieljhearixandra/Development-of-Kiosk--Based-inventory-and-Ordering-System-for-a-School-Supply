<?php
require_once '../includes/db.php';
$pdo = $conn; // Create an alias

try {
    $faqsItems = $pdo->query("SELECT * FROM faqs ORDER BY created_at DESC")->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    die("Database error: " . $e->getMessage());
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help Center</title>
    <link rel="stylesheet" href="faq.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    <div class="faq-container">
        <div class="faq-header">
            <button class="btn-back" onclick="window.history.back()">
                <i class="bi bi-arrow-left"></i> Back
            </button>
            <h1>Help Center</h1>
        </div>
        
        <div class="search-container">
            <input type="text" id="searchInput" class="search-input" placeholder="Search help topics...">
        </div>
        
        <div class="faq-list">
            <?php if (empty($faqsItems)): ?>
                <div class="no-faqs">No help topics available yet.</div>
            <?php else: ?>
                <?php foreach ($faqsItems as $item): ?>
                <div class="faq-item">
                    <div class="faq-question" onclick="toggleAnswer(this)">
                        <span><?php echo htmlspecialchars($item['question']); ?></span>
                        <i class="bi bi-chevron-down"></i>
                    </div>
                    <div class="faq-answer">
                        <?php echo htmlspecialchars($item['answer']); ?>
                    </div>
                </div>
                <?php endforeach; ?>
            <?php endif; ?>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Hide any existing help button
            const helpBtn = document.getElementById("help-button");
            if (helpBtn) {
                helpBtn.style.display = 'none';
            }
        
            // Set a flag in localStorage to indicate we're on FAQ page
            localStorage.setItem('onFAQPage', 'true');
        });
    
       
        window.addEventListener('beforeunload', function() {
            localStorage.removeItem('onFAQPage');
        });
    </script>
    <script>
        localStorage.setItem('onFAQPage', 'true');
    </script>

    <script src="faq.js"></script>
</body>
</html>