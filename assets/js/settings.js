document.addEventListener('DOMContentLoaded', function() {
    // Initialize date picker
    const datePicker = flatpickr("#custom_date", {
        dateFormat: "Y-m-d",
        allowInput: true,
        defaultDate: new Date()
    });

    // Period selection toggle
    const resetPeriod = document.getElementById('reset_period');
    const dateContainer = document.getElementById('customDateContainer');
    
    resetPeriod.addEventListener('change', function() {
        if (this.value === 'day' || this.value === 'week') {
            dateContainer.style.display = 'block';
        } else {
            dateContainer.style.display = 'none';
        }
    });

    // Modal functionality
    const modals = document.querySelectorAll('.modal');
    const modalTriggers = document.querySelectorAll('.clickable');
    const closeButtons = document.querySelectorAll('.close-modal');
    
    // Open modal when clicking on card header
    modalTriggers.forEach(trigger => {
        trigger.addEventListener('click', function() {
            const target = this.getAttribute('data-target');
            document.getElementById(target).style.display = 'block';
        });
    });
    
    // Close modal when clicking on X
    closeButtons.forEach(button => {
        button.addEventListener('click', function() {
            this.closest('.modal').style.display = 'none';
        });
    });
    
    // Close modal when clicking outside
    window.addEventListener('click', function(event) {
        modals.forEach(modal => {
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        });
    });

    // Form validation for reset sales
    const resetForm = document.getElementById('resetSalesForm');
    const passwordInput = document.getElementById('admin_password');
    const passwordError = document.getElementById('passwordError');

    resetForm.addEventListener('submit', function(e) {
        let isValid = true;
        
        // Clear previous errors
        passwordError.style.display = 'none';
        passwordInput.classList.remove('invalid');
        
        // Validate password
        if (passwordInput.value.trim() === '') {
            passwordError.textContent = 'Please enter your admin password';
            passwordError.style.display = 'block';
            passwordInput.classList.add('invalid');
            isValid = false;
        }
        
        if (!isValid) {
            e.preventDefault();
            return;
        }
        
        // Build confirmation message
        const period = resetPeriod.value;
        let periodText = '';
        const customDate = datePicker.input.value;
        
        switch (period) {
            case 'day':
                periodText = customDate ? 
                    `daily sales for ${formatDate(customDate)}` : 
                    "today's sales";
                break;
            case 'week':
                const weekDate = customDate ? new Date(customDate) : new Date();
                const weekNum = getWeekNumber(weekDate).week;
                const year = weekDate.getFullYear();
                periodText = `weekly sales for week ${weekNum} of ${year}`;
                break;
            case 'month':
                const monthDate = customDate ? new Date(customDate + '-01') : new Date();
                periodText = `monthly sales for ${monthDate.toLocaleString('default', { month: 'long' })} ${monthDate.getFullYear()}`;
                break;
            case 'year':
                const yearDate = customDate ? new Date(customDate + '-01-01') : new Date();
                periodText = `yearly sales for ${yearDate.getFullYear()}`;
                break;
        }
        
        if (!confirm(`WARNING: This will permanently reset ${periodText} to zero. Are you absolutely sure?`)) {
            e.preventDefault();
        }
    });
    
    // Helper functions
    function formatDate(dateString) {
        const date = new Date(dateString);
        return date.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
    }
    
    function getWeekNumber(date) {
        const d = new Date(date);
        d.setHours(0, 0, 0, 0);
        d.setDate(d.getDate() + 3 - (d.getDay() + 6) % 7);
        const week1 = new Date(d.getFullYear(), 0, 4);
        return {
            week: 1 + Math.round(((d - week1) / 86400000 - 3 + (week1.getDay() + 6) % 7) / 7),
            year: d.getFullYear()
        };
    }
});