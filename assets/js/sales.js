document.addEventListener('DOMContentLoaded', function() {
    // Initialize date pickers
    flatpickr("#start_date", {
        dateFormat: "Y-m-d",
        defaultDate: document.getElementById("start_date").value
    });
    
    flatpickr("#end_date", {
        dateFormat: "Y-m-d",
        defaultDate: document.getElementById("end_date").value
    });
    
    // Export to Excel functionality
    $('#export-excel').on('click', function() {
        const startDate = $('#start_date').val();
        const endDate = $('#end_date').val();
        
        window.location.href = `../includes/export_sales.php?start_date=${startDate}&end_date=${endDate}`;
    });
});