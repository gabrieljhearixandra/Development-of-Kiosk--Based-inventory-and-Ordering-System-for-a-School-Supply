let cart = [];
let products = []; 
let categories = [];

// DOM Elements
const initialScreen = document.getElementById('initial-screen');
const categoriesScreen = document.getElementById('categories-screen');
const itemsScreen = document.getElementById('items-screen');
const reviewScreen = document.getElementById('review-screen');
const itemsListContainer = document.getElementById('items-list-container');
const orderItemsContainer = document.getElementById('order-items-container');
const itemCountElement = document.getElementById('item-count');
const totalAmountElement = document.getElementById('total-amount');
const itemsScreenTitle = document.getElementById('items-screen-title');
const categoriesList = document.getElementById('categories-list-container');

// Initialize the app when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    initializeApp();
});

document.getElementById('search-item').addEventListener('input', filterCategories);

// Fetch products from database
function fetchProducts() {
    return fetch('api/get_product.php')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            if (data.error) throw new Error(data.error);
            console.log('Products loaded:', data);
            // Ensure prices are numbers and fix image paths
            return data.map(product => ({
                ...product,
                price: parseFloat(product.price),
                image_path: product.image_path ? cleanImagePath(product.image_path) : null,
                stock: product.current_stock || 0
            }));
        });
}

// Helper function to clean image paths
function cleanImagePath(path) {
    // Remove any duplicate path segments
    if (path.includes('uploads/products/')) {
        return path.replace(/^.*uploads\/products\//, 'uploads/products/');
    }
    return `uploads/products/${path}`;
}

function fetchCategories() {
    return fetch('api/get_category.php')
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            if (data.error) throw new Error(data.error);
            console.log('Categories loaded:', data);
            return data;
        });
}

// Add to initializeApp()
async function initializeApp() {
    try {
        [products, categories] = await Promise.all([
            fetchProducts(),
            fetchCategories()
        ]);
        populateCategories();

        // Only show help button on main kiosk page
        if (window.location.pathname === "/pos-system3/") {
            addHelpButton();
        }

        updateCartSummary();
    } catch (error) {
        console.error('Error initializing app:', error);
    }
}


// Help Button Function
function addHelpButton() {

    // Prevent duplicate help buttons
    if (document.getElementById('help-button')) return;

    const helpButton = document.createElement('button');
    helpButton.id = 'help-button';
    helpButton.className = 'help-button';
    helpButton.textContent = '?';
    helpButton.style.position = 'fixed';
    helpButton.style.bottom = '20px';
    helpButton.style.right = '20px';
    helpButton.style.zIndex = '9999';
    helpButton.style.padding = '10px 15px';
    helpButton.style.borderRadius = '50%';
    helpButton.style.backgroundColor = '#3498db';
    helpButton.style.color = '#fff';
    helpButton.style.border = 'none';
    helpButton.style.fontSize = '20px';
    helpButton.style.cursor = 'pointer';
    helpButton.style.display = 'none';

    helpButton.onclick = () => {
        localStorage.setItem('onFAQPage', 'true');
        showHelpCenter();
    };

    document.body.appendChild(helpButton);

    // Update visibility
    function updateButtonVisibility() {
        const isCategoriesVisible = !categoriesScreen.classList.contains('hidden');
        const isOnFAQPage = window.location.pathname.includes('faq.php') || 
                            localStorage.getItem('onFAQPage') === 'true';

        helpButton.style.display = (isCategoriesVisible && !isOnFAQPage) ? 'flex' : 'none';
    }

    // Initial check
    updateButtonVisibility();

    // Observe screen changes
    const observer = new MutationObserver(updateButtonVisibility);
    observer.observe(categoriesScreen, { attributes: true, attributeFilter: ['class'] });

    // Recheck when page loads or navigates
    window.addEventListener('popstate', () => {
        localStorage.setItem('onFAQPage', 'false');
        updateButtonVisibility();
    });
}

// Redirect to FAQ
function showHelpCenter() {
    window.location.href = 'faq/faq.php';
}







function showHelpCenter() {
    window.location.href = 'faq/faq.php';
}

// Populate categories dynamically from database
function populateCategories() {
    // Clear existing categories (except "All Items")
    categoriesList.innerHTML = '<div class="category-item" onclick="showAllItems()">All Items</div>';
    
    // Add categories from database
    categories.forEach(category => {
        const categoryItem = document.createElement('div');
        categoryItem.className = 'category-item';
        categoryItem.textContent = category.name;
        categoryItem.onclick = () => showItemsByCategory(category.id);
        categoriesList.appendChild(categoryItem);
    });
}

// Show all items
function showAllItems() {
    itemsScreenTitle.textContent = 'All Items';
    displayItems(products);
    categoriesScreen.classList.add('hidden');
    itemsScreen.classList.remove('hidden');
}

// Show items by category ID
function showItemsByCategory(categoryId) {
    const category = categories.find(c => c.id == categoryId);
    if (!category) return;
    
    itemsScreenTitle.textContent = category.name;
    const filteredItems = products.filter(item => item.category_id == categoryId);
    displayItems(filteredItems);
    categoriesScreen.classList.add('hidden');
    itemsScreen.classList.remove('hidden');
}

// Display items in the items screen
function displayItems(items) {
    itemsListContainer.innerHTML = '';
    
    items.forEach(item => {
        const itemElement = document.createElement('div');
        itemElement.className = 'item-card';
        
        // Construct correct image path
        let imagePath = 'assets/images/default-product.jpg';
        if (item.image_path) {
            imagePath = item.image_path;
        }
        
        const cartItem = cart.find(cartItem => cartItem.id === item.id);
        const currentQuantity = cartItem ? cartItem.quantity : 0;
        
        itemElement.innerHTML = `
            <img src="${imagePath}" alt="${item.name}" 
                 onerror="this.onerror=null;this.src='assets/images/default-product.jpg'" 
                 style="width: 80px; height: 80px; object-fit: cover;">
            <h3>${item.name}</h3>
            <p>₱${item.price.toFixed(2)}</p>
            ${currentQuantity > 0 ? 
                `<div class="item-quantity">In cart: ${currentQuantity}</div>` : ''}
            ${item.stock > 0 ? 
                `<button class="btn-add" onclick="addToCart(${item.id})">Add</button>` : 
                '<button class="btn-add disabled" disabled>Out of Stock</button>'}
        `;
        itemsListContainer.appendChild(itemElement);
    });
}

// Add to cart function
function addToCart(productId) {
    const product = products.find(p => p.id == productId);
    if (!product) return;
    
    // Check if item already in cart
    const existingItem = cart.find(item => item.id == productId);
    
    if (product.stock > 0) {
        if (existingItem) {
            if (existingItem.quantity < product.stock) {
                existingItem.quantity++;
            } else {
                alert('Cannot add more than available stock');
                return;
            }
        } else {
            cart.push({
                id: product.id,
                name: product.name,
                price: product.price,
                quantity: 1,
                image: product.image_path
            });
        }
    } else {
        alert('This product is out of stock');
        return;
    }
    
    updateCartSummary();
}

// Update cart summary
function updateCartSummary() {
    const itemCount = cart.reduce((total, item) => total + item.quantity, 0);
    const totalAmount = cart.reduce((total, item) => total + (item.price * item.quantity), 0);
    
    itemCountElement.textContent = `${itemCount} ${itemCount === 1 ? 'item' : 'items'}`;
    totalAmountElement.textContent = totalAmount.toFixed(2);
}

// Show categories screen
function showCategories() {
    initialScreen.classList.add('hidden');
    categoriesScreen.classList.remove('hidden');
    
}

// Hide categories screen
function hideCategories() {
    categoriesScreen.classList.add('hidden');
    initialScreen.classList.remove('hidden');
}

// Hide items screen
function hideItems() {
    itemsScreen.classList.add('hidden');
    categoriesScreen.classList.remove('hidden');
}

// Show review screen with all cart items
function showReviewItems() {
    orderItemsContainer.innerHTML = '';
    
    if (cart.length === 0) {
        orderItemsContainer.innerHTML = '<div class="empty-cart">Your cart is empty</div>';
        itemsScreen.classList.add('hidden');
        reviewScreen.classList.remove('hidden');
        return;
    }
    
    cart.forEach(item => {
        // Construct correct image path
        let imagePath = 'assets/images/default-product.jpg';
        if (item.image) {
            imagePath = item.image;
        }
        
        const orderItem = document.createElement('div');
        orderItem.className = 'order-item';
        orderItem.innerHTML = `
            <div class="order-item-image">
                <img src="${imagePath}" 
                     alt="${item.name}" 
                     onerror="this.onerror=null;this.src='assets/images/default-product.jpg'"
                     style="width: 60px; height: 60px; object-fit: cover;">
            </div>
            <div class="order-item-details">
                <h3>${item.name}</h3>
                <div class="quantity-controls">
                    <button class="btn-quantity" onclick="decrementQuantity(${item.id})">-</button>
                    <span class="quantity">${item.quantity}</span>
                    <button class="btn-quantity" onclick="incrementQuantity(${item.id})">+</button>
                </div>
                <p class="price">₱${item.price.toFixed(2)}</p>
            </div>
            <div class="order-item-subtotal">
                <p>₱${(item.price * item.quantity).toFixed(2)}</p>
                <button class="btn-remove" onclick="removeFromCart(${item.id})">
                    <i class="bi bi-trash"></i>
                </button>
            </div>
        `;
        orderItemsContainer.appendChild(orderItem);
    });
    
    updateCartSummary();
    itemsScreen.classList.add('hidden');
    reviewScreen.classList.remove('hidden');
}

// Increment item quantity
function incrementQuantity(productId) {
    const item = cart.find(i => i.id == productId);
    if (!item) return;
    
    const product = products.find(p => p.id == productId);
    if (!product) return;
    
    if (item.quantity < product.stock) {
        item.quantity++;
        showReviewItems(); // Refresh the display
    } else {
        alert('Cannot add more than available stock');
    }
}

// Decrement item quantity
function decrementQuantity(productId) {
    const itemIndex = cart.findIndex(i => i.id == productId);
    if (itemIndex === -1) return;
    
    if (cart[itemIndex].quantity > 1) {
        cart[itemIndex].quantity--;
    } else {
        cart.splice(itemIndex, 1);
    }
    showReviewItems(); // Refresh the display
}

// Remove item completely from cart
function removeFromCart(productId) {
    const itemIndex = cart.findIndex(i => i.id == productId);
    if (itemIndex !== -1) {
        cart.splice(itemIndex, 1);
        showReviewItems(); // Refresh the display
    }
}

// Hide review screen
function hideReview() {
    reviewScreen.classList.add('hidden');
    itemsScreen.classList.remove('hidden');
}


// Process order and show receipt
function processOrder() {
    if (cart.length === 0) {
        alert('Your cart is empty');
        return;
    }
    
    const orderData = {
        items: cart.map(item => ({
            id: item.id,
            name: item.name,
            quantity: item.quantity,
            price: item.price
        })),
        total: cart.reduce((total, item) => total + (item.price * item.quantity), 0)
    };
    
    fetch('process_order.php', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({
            order: JSON.stringify(orderData)
        })
    })
    .then(async response => {
        const contentType = response.headers.get('content-type');
        if (!contentType || !contentType.includes('application/json')) {
            const text = await response.text();
            throw new Error(`Invalid response: ${text}`);
        }
        
        const data = await response.json();
        
        if (!response.ok) {
            throw new Error(data.message || 'Unknown error occurred');
        }
        
        if (data.error) {
            throw new Error(data.message || 'Order processing failed');
        }
        
        // Display the receipt HTML from the server
        document.getElementById('receipt-container').innerHTML = data.receipt_html;
        
        // Show receipt screen
        reviewScreen.classList.add('hidden');
        document.getElementById('receipt-screen').classList.remove('hidden');
        
        // Clear cart after successful order
        cart = [];
        updateCartSummary();
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Error processing order: ' + error.message);
    });
}

// Print receipt (for demo purposes, just shows an alert)

function printReceipt() {
    const receiptContent = document.getElementById('receipt-container').innerHTML;
    const printWindow = window.open('', '', 'width=600,height=600');
    printWindow.document.write(`
        <!DOCTYPE html>
        <html>
        <head>
            <title>Receipt</title>
            <style>
                body { font-family: 'Courier New', monospace; }
                .receipt { width: 100%; max-width: 400px; margin: 0 auto; }
                .receipt-header { text-align: center; margin-bottom: 15px; }
                .receipt-item { display: flex; justify-content: space-between; margin-bottom: 8px; }
                .receipt-total { margin-top: 15px; padding-top: 10px; border-top: 2px dashed #ddd; }
                .total-line { display: flex; justify-content: space-between; font-weight: bold; }
                .receipt-footer { text-align: center; margin-top: 20px; }
                @media print { 
                    body { margin: 0; padding: 0; }
                    .receipt { box-shadow: none; padding: 0; width: 100%; }
                }
            </style>
        </head>
        <body onload="window.print();window.close()">
            ${receiptContent}
        </body>
        </html>
    `);
    printWindow.document.close();
}

// Return to home screen
function returnToHome() {
    document.getElementById('receipt-screen').classList.add('hidden');
    initialScreen.classList.remove('hidden');
}

// Filter items based on search input
function filterItems() {
    const searchTerm = document.getElementById('search-item-list').value.toLowerCase();
    const currentItems = itemsScreenTitle.textContent === 'All Items' ? 
        products : 
        products.filter(item => {
            const category = categories.find(c => c.id == item.category_id);
            return category && category.name === itemsScreenTitle.textContent;
        });
    
    const filteredItems = currentItems.filter(item => 
        item.name.toLowerCase().includes(searchTerm) || 
        (item.category_name && item.category_name.toLowerCase().includes(searchTerm))
    );
    
    displayItems(filteredItems);
}

// to filter categories:
function filterCategories() {
    const searchTerm = document.getElementById('search-item').value.toLowerCase();
    const categoryItems = document.querySelectorAll('.category-item');
    
    categoryItems.forEach(item => {
        const categoryName = item.textContent.toLowerCase();
        if (categoryName.includes(searchTerm) || searchTerm === '') {
            item.style.display = 'block';
        } else {
            item.style.display = 'none';
        }
    });
}