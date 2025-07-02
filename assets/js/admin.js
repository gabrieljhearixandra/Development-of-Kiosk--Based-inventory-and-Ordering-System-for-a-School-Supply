// Admin dashboard functionality
document.addEventListener('DOMContentLoaded', function() {
    // Initialize tooltips
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
    
    // Handle form submissions with AJAX
    $('form.ajax-form').on('submit', function(e) {
        e.preventDefault();
        
        const form = $(this);
        const submitBtn = form.find('button[type="submit"]');
        const originalText = submitBtn.text();
        
        submitBtn.prop('disabled', true).html('<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Processing...');
        
        $.ajax({
            url: form.attr('action'),
            method: form.attr('method'),
            data: form.serialize(),
            success: function(response) {
                if (response.success) {
                    showAlert('success', response.message);
                    if (response.redirect) {
                        setTimeout(() => {
                            window.location.href = response.redirect;
                        }, 1500);
                    }
                } else {
                    showAlert('danger', response.message);
                }
            },
            error: function() {
                showAlert('danger', 'An error occurred. Please try again.');
            },
            complete: function() {
                submitBtn.prop('disabled', false).text(originalText);
            }
        });
    });
});

function showAlert(type, message) {
    const alertHtml = `
        <div class="alert alert-${type} alert-dismissible fade show" role="alert">
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    `;
    
    $('#alerts-container').html(alertHtml);
}

// Inventory management
function addStockItem() {
    const formData = new FormData();
    formData.append('name', $('#item-name').val());
    formData.append('category', $('#item-category').val());
    formData.append('price', $('#item-price').val());
    formData.append('quantity', $('#item-quantity').val());
    
    const imageFile = $('#item-image')[0].files[0];
    if (imageFile) {
        formData.append('image', imageFile);
    }
    
    $.ajax({
        url: '../includes/add_stock_item.php',
        method: 'POST',
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            const result = JSON.parse(response);
            if (result.success) {
                showAlert('success', 'Item added successfully!');
                $('#addItemModal').modal('hide');
                loadInventory();
            } else {
                showAlert('danger', result.message);
            }
        },
        error: function() {
            showAlert('danger', 'Error connecting to server');
        }
    });
}

function loadInventory() {
    $.ajax({
        url: '../includes/get_inventory.php',
        method: 'GET',
        success: function(response) {
            $('#inventory-table tbody').html(response);
        },
        error: function() {
            showAlert('danger', 'Error loading inventory');
        }
    });
}

// Forgot Password functionality
document.addEventListener('DOMContentLoaded', function() {
    const forgotPasswordLink = document.getElementById('forgot-password-link');
    const contactInfo = document.getElementById('contact-info');
    
    if (forgotPasswordLink && contactInfo) {
        forgotPasswordLink.addEventListener('click', function(e) {
            e.preventDefault();
            contactInfo.style.display = contactInfo.style.display === 'none' ? 'block' : 'none';
        });
    }
});