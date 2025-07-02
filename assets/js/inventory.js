// Modal elements defined globally
const modals = {
    product: {
        type: 'product',
        openBtn: document.getElementById('add-product-btn'),
        modal: document.getElementById('product-modal'),
        closeBtn: document.querySelector('#product-modal .close-btn'),
        cancelBtn: document.getElementById('cancel-product-btn'),
        title: document.getElementById('product-modal-title'),
        form: document.getElementById('product-form'),
        actionField: document.getElementById('product-action'),
        idField: document.getElementById('product-id')
    },
    category: {
        type: 'category',
        openBtn: document.getElementById('add-category-btn'),
        modal: document.getElementById('category-modal'),
        closeBtn: document.querySelector('#category-modal .close-btn'),
        cancelBtn: document.getElementById('cancel-category-btn'),
        title: document.getElementById('category-modal-title'),
        form: document.getElementById('category-form'),
        actionField: document.getElementById('category-action'),
        idField: document.getElementById('category-id')
    }
};

// Setup image preview functionality
function setupImagePreview(inputId, previewId) {
    const input = document.getElementById(inputId);
    const preview = document.getElementById(previewId);
    
    if (input && preview) {
        input.addEventListener('change', function() {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                }
                reader.readAsDataURL(file);
            } else {
                preview.style.display = 'none';
            }
        });
    }
}

// Reset modal form fields
function resetModal(modal) {
    if (modal.form) modal.form.reset();
    if (modal.actionField) modal.actionField.value = modal.type === 'product' ? 'add_product' : 'add_category';
    if (modal.idField) modal.idField.value = '';
    if (modal.title) modal.title.textContent = modal.type === 'product' ? 'Add New Product' : 'Add New Category';
    
    // Clear image preview for product only
    if (modal.type === 'product') {
        const preview = document.getElementById('image-preview');
        if (preview) {
            preview.src = '';
            preview.style.display = 'none';
        }
    }
}

// Fetch product data for editing
function fetchProductData(productId) {
    fetch(`../api/get_product.php?id=${productId}`)
        .then(response => {
            if (!response.ok) {
                throw new Error(`Failed to fetch product (HTTP ${response.status})`);
            }
            return response.json();
        })
        .then(data => {
            if (data.error) {
                throw new Error(data.error);
            }
            
            const modal = modals.product;
            modal.actionField.value = 'update_product';
            modal.idField.value = data.id;
            modal.title.textContent = 'Edit Product';
            
            // Fill form fields
            document.getElementById('product-name').value = data.name;
            document.getElementById('product-description').value = data.description || '';
            document.getElementById('product-category').value = data.category_id || '';
            document.getElementById('product-price').value = data.price;
            document.getElementById('product-stock').value = data.stock || 0;
            document.getElementById('current-image').value = data.image_path || '';
            
            // Show current image if exists
            const preview = document.getElementById('image-preview');
            if (data.image_path) {
                preview.src = data.image_path;
                preview.style.display = 'block';
            } else {
                preview.style.display = 'none';
            }
            
            modal.modal.style.display = 'block';
        })
        .catch(error => {
            console.error('Error fetching product:', error);
            alert(`Error loading product data: ${error.message}`);
        });
}

// Fetch category data for editing
function fetchCategoryData(categoryId) {
    fetch(`../api/get_category.php?id=${categoryId}`)
        .then(response => {
            if (!response.ok) {
                throw new Error(`Failed to fetch category (HTTP ${response.status})`);
            }
            return response.json();
        })
        .then(data => {
            if (data.error) {
                throw new Error(data.error);
            }
            
            const modal = modals.category;
            modal.actionField.value = 'update_category';
            modal.idField.value = data.id;
            modal.title.textContent = 'Edit Category';
            
            // Fill form fields
            document.getElementById('category-name').value = data.name;
            document.getElementById('category-description').value = data.description || '';
            
            modal.modal.style.display = 'block';
        })
        .catch(error => {
            console.error('Error fetching category:', error);
            alert(`Error loading category data: ${error.message}`);
        });
}

function deleteItem(type, id) {
    const formData = new FormData();
    formData.append('action', `delete_${type}`);
    formData.append('id', id);
    
    fetch('inventory.php', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (response.ok) {
            window.location.reload();
        } else {
            throw new Error('Delete operation failed');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Error deleting item. Please try again.');
    });
}

function filterTable(tableId, searchTerm) {
    const table = document.getElementById(tableId);
    if (!table) return;
    
    const rows = table.querySelectorAll('tbody tr');
    rows.forEach(row => {
        const cells = row.querySelectorAll('td');
        let rowMatches = false;
        
        cells.forEach(cell => {
            if (cell.textContent.toLowerCase().includes(searchTerm)) {
                rowMatches = true;
            }
        });
        
        row.style.display = rowMatches ? '' : 'none';
    });
}

document.addEventListener('DOMContentLoaded', function() {
    // Tab functionality
    const tabButtons = document.querySelectorAll('.tab-btn');
    const tabContents = document.querySelectorAll('.tab-content');
    
    tabButtons.forEach(button => {
        button.addEventListener('click', () => {
            tabButtons.forEach(btn => btn.classList.remove('active'));
            tabContents.forEach(content => content.classList.remove('active'));
            
            button.classList.add('active');
            const tabId = button.getAttribute('data-tab') + '-tab';
            document.getElementById(tabId).classList.add('active');
        });
    });

    // Setup modal open/close handlers
    Object.values(modals).forEach(modal => {
        if (modal.openBtn && modal.modal) {
            modal.openBtn.addEventListener('click', () => {
                resetModal(modal);
                modal.modal.style.display = 'block';
            });
        }
        
        if (modal.closeBtn) {
            modal.closeBtn.addEventListener('click', () => {
                modal.modal.style.display = 'none';
            });
        }
        
        if (modal.cancelBtn) {
            modal.cancelBtn.addEventListener('click', () => {
                modal.modal.style.display = 'none';
            });
        }
    });

    // Close modal when clicking outside
    window.addEventListener('click', (event) => {
        if (event.target.classList.contains('modal')) {
            event.target.style.display = 'none';
        }
    });

    // Image preview functionality for product only
    setupImagePreview('product-image', 'image-preview');

    // Edit product buttons
    document.querySelectorAll('.edit-product').forEach(button => {
        button.addEventListener('click', function() {
            const productId = this.getAttribute('data-id');
            fetchProductData(productId);
        });
    });

    // Delete product buttons
    document.querySelectorAll('.delete-product').forEach(button => {
        button.addEventListener('click', function() {
            const productId = this.getAttribute('data-id');
            if (confirm('Are you sure you want to delete this product?')) {
                deleteItem('product', productId);
            }
        });
    });

    // Edit category buttons
    document.querySelectorAll('.edit-category').forEach(button => {
        button.addEventListener('click', function() {
            const categoryId = this.getAttribute('data-id');
            fetchCategoryData(categoryId);
        });
    });

    // Delete category buttons
    document.querySelectorAll('.delete-category').forEach(button => {
        button.addEventListener('click', function() {
            const categoryId = this.getAttribute('data-id');
            if (confirm('Are you sure you want to delete this category? Products in this category will become uncategorized.')) {
                deleteItem('category', categoryId);
            }
        });
    });

    // Search functionality
    const searchBtn = document.getElementById('search-btn');
    if (searchBtn) {
        searchBtn.addEventListener('click', function() {
            const searchTerm = document.getElementById('global-search').value.toLowerCase();
            filterTable('products-table', searchTerm);
            filterTable('categories-table', searchTerm);
        });
    }

    // Allow search on Enter key
    const searchInput = document.getElementById('global-search');
    if (searchInput) {
        searchInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                const searchTerm = this.value.toLowerCase();
                filterTable('products-table', searchTerm);
                filterTable('categories-table', searchTerm);
            }
        });
    }
});