$(document).ready(function() {
    // Initialize datepicker
    if (typeof flatpickr !== 'undefined') {
        flatpickr("#start_date, #end_date", {
            dateFormat: "Y-m-d"
        });
    }
    
    // Auto-refresh every 5 minutes (300000 ms)
    setInterval(function() {
        window.location.reload();
    }, 300000);
    
    // Handle pagination clicks with loading indicator
    $(document).on('click', '.page-link', function(e) {
        e.preventDefault();
        var link = $(this);
        var url = link.attr('href');
        
        if (!url || link.parent().hasClass('disabled')) {
            return;
        }
        
        // Show loading spinner
        link.append('<span class="loading-spinner"></span>');
        link.find('.loading-spinner').css('display', 'inline-block');
        
        // Disable all pagination links during loading
        $('.page-link').parent().addClass('disabled');
        
        // Load the new page
        window.location.href = url;
    });
});