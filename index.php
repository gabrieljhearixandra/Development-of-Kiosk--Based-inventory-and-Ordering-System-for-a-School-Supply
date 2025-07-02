<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>POS System - Order</title>
    <link rel="stylesheet" href="assets/css/style.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="faq/faq.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
</head>
<body>
    
    <div class="pos-container">

        <!-- Initial Screen -->
        <div id="initial-screen" class="screen">
            <div class="touch-to-order" onclick="showCategories()">
                <h1>Touch to Order</h1>
            </div>
        </div>

        <!-- Categories Screen -->
        <div id="categories-screen" class="screen hidden">
            <div class="header">
                <h2>Categories</h2>
                <button class="btn btn-back" onclick="hideCategories()">← Back</button>
            </div>
            <div class="search-bar">
                <input type="text" id="search-item" placeholder="Search categories...">
            </div>
            <div class="categories-list" id="categories-list-container">
                <div class="category-item" onclick="showAllItems()">All Items</div>
            </div>
        </div>

        <!-- Items Screen -->
        <div id="items-screen" class="screen hidden">
            <div class="header">
                <h2 id="items-screen-title">All Items</h2>
                <button class="btn btn-back" onclick="hideItems()">← Back</button>
            </div>
            <div class="search-bar">
                <input type="text" id="search-item-list" placeholder="Search items..." oninput="filterItems()">
            </div>
            <div class="items-list" id="items-list-container">
                
            </div>
            <div class="order-summary">
                <span id="item-count">0 items</span>
                <button class="btn btn-review" onclick="showReviewItems()">Review Order</button>
            </div>
        </div>

        <!-- Review Order Screen -->
        <div id="review-screen" class="screen hidden">
            <div class="header">
                <h2>Review Order</h2>
                <button class="btn btn-back" onclick="hideReview()">← Back</button>
            </div>
            <div class="order-items" id="order-items-container">
               
            </div>
            <div class="order-total">
                <h3>Total: ₱<span id="total-amount">0.00</span></h3>
                <button class="btn btn-proceed" onclick="processOrder()">Proceed</button>
            </div>
        </div>

        <!-- Receipt Screen -->
        <div id="receipt-screen" class="screen hidden">
            <div class="header">
                <h2>Order Receipt</h2>
                <button class="btn btn-back" onclick="returnToHome()">← Home</button>
            </div>
            <div class="receipt-container" id="receipt-container">
              
            </div>
            <div class="receipt-actions">
                <button class="btn btn-print" onclick="printReceipt()">
                    <i class="bi bi-printer"></i> Print Receipt
                </button>
            </div>

            <div class="payment-instruction">
                <p>Please proceed to the staff and hand over the cash payment with your receipt.</p>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="assets/js/main.js"></script>
    
</body>
</html>