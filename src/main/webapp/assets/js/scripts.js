/**
 * Student LMS - Main JavaScript File
 * Contains all the client-side functionality for the Student LMS application
 */

// Wait for the DOM to be fully loaded
document.addEventListener('DOMContentLoaded', function() {
    // Initialize all components
    initializeSidebar();
    initializeDropdowns();
    initializeAlerts();
    initializeFormValidation();
    initializeDataTables();
    initializeCharts();
});

/**
 * Sidebar Toggle Functionality
 */
function initializeSidebar() {
    const sidebarToggle = document.getElementById('sidebar-toggle');
    const sidebar = document.querySelector('.sidebar');
    const mainContent = document.querySelector('.main-content');

    if (sidebarToggle) {
        sidebarToggle.addEventListener('click', function() {
            sidebar.classList.toggle('sidebar-collapsed');
            mainContent.classList.toggle('main-content-expanded');

            // Update toggle icon
            const icon = sidebarToggle.querySelector('i');
            if (icon) {
                if (sidebar.classList.contains('sidebar-collapsed')) {
                    icon.classList.remove('fa-chevron-left');
                    icon.classList.add('fa-chevron-right');
                } else {
                    icon.classList.remove('fa-chevron-right');
                    icon.classList.add('fa-chevron-left');
                }
            }
        });
    }

    // Collapse sidebar on mobile by default
    const handleResize = () => {
        if (window.innerWidth < 768 && sidebar) {
            sidebar.classList.add('sidebar-collapsed');
            mainContent.classList.add('main-content-expanded');
        } else if (sidebar) {
            sidebar.classList.remove('sidebar-collapsed');
            mainContent.classList.remove('main-content-expanded');
        }
    };

    // Initial check and add event listener for window resize
    handleResize();
    window.addEventListener('resize', handleResize);
}

/**
 * Dropdown Menu Functionality
 */
function initializeDropdowns() {
    const dropdownToggles = document.querySelectorAll('.dropdown-toggle');

    dropdownToggles.forEach(toggle => {
        toggle.addEventListener('click', function(e) {
            e.preventDefault();
            e.stopPropagation();

            const dropdown = this.nextElementSibling;

            // Close all other dropdowns
            document.querySelectorAll('.dropdown-menu').forEach(menu => {
                if (menu !== dropdown) {
                    menu.classList.remove('show');
                }
            });

            // Toggle current dropdown
            dropdown.classList.toggle('show');
        });
    });

    // Close dropdowns when clicking outside
    document.addEventListener('click', function(e) {
        if (!e.target.closest('.dropdown')) {
            document.querySelectorAll('.dropdown-menu').forEach(menu => {
                menu.classList.remove('show');
            });
        }
    });
}

/**
 * Alert Dismissal Functionality
 */
function initializeAlerts() {
    const alertCloseButtons = document.querySelectorAll('.alert .close');

    alertCloseButtons.forEach(button => {
        button.addEventListener('click', function() {
            const alert = this.closest('.alert');

            // Add fade-out animation
            alert.style.opacity = '0';

            // Remove alert after animation completes
            setTimeout(() => {
                alert.remove();
            }, 300);
        });
    });

    // Auto-dismiss alerts after 5 seconds
    document.querySelectorAll('.alert-auto-dismiss').forEach(alert => {
        setTimeout(() => {
            if (alert) {
                alert.style.opacity = '0';
                setTimeout(() => {
                    alert.remove();
                }, 300);
            }
        }, 5000);
    });
}

/**
 * Form Validation
 */
function initializeFormValidation() {
    const forms = document.querySelectorAll('.needs-validation');

    forms.forEach(form => {
        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }

            form.classList.add('was-validated');
        }, false);
    });

    // Custom validation for password match
    const passwordConfirmFields = document.querySelectorAll('input[data-match-password]');

    passwordConfirmFields.forEach(field => {
        field.addEventListener('input', function() {
            const passwordField = document.getElementById(this.getAttribute('data-match-password'));

            if (passwordField.value !== this.value) {
                this.setCustomValidity('Passwords do not match');
            } else {
                this.setCustomValidity('');
            }
        });
    });
}

/**
 * DataTables Initialization
 */
function initializeDataTables() {
    const tables = document.querySelectorAll('.datatable');

    tables.forEach(table => {
        if (typeof $.fn.DataTable !== 'undefined') {
            $(table).DataTable({
                responsive: true,
                language: {
                    search: "_INPUT_",
                    searchPlaceholder: "Search...",
                    lengthMenu: "Show _MENU_ entries",
                    info: "Showing _START_ to _END_ of _TOTAL_ entries",
                    infoEmpty: "Showing 0 to 0 of 0 entries",
                    infoFiltered: "(filtered from _MAX_ total entries)"
                }
            });
        }
    });
}

/**
 * Chart.js Initialization
 */
function initializeCharts() {
    // Registration Chart
    const registrationChart = document.getElementById('registrationChart');
    if (registrationChart && typeof Chart !== 'undefined') {
        new Chart(registrationChart, {
            type: 'line',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                datasets: [{
                    label: 'Registrations',
                    data: [65, 59, 80, 81, 56, 55, 40, 45, 60, 70, 75, 90],
                    fill: false,
                    borderColor: '#3b82f6',
                    tension: 0.1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    }

    // Revenue Chart
    const revenueChart = document.getElementById('revenueChart');
    if (revenueChart && typeof Chart !== 'undefined') {
        new Chart(revenueChart, {
            type: 'bar',
            data: {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                datasets: [{
                    label: 'Revenue',
                    data: [12500, 19000, 15000, 18000, 14000, 22000, 17000, 19500, 21000, 25000, 23000, 28000],
                    backgroundColor: '#10b981',
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            callback: function(value) {
                                return '$' + value;
                            }
                        }
                    }
                }
            }
        });
    }

    // Course Distribution Chart
    const courseDistributionChart = document.getElementById('courseDistributionChart');
    if (courseDistributionChart && typeof Chart !== 'undefined') {
        new Chart(courseDistributionChart, {
            type: 'doughnut',
            data: {
                labels: ['Science', 'Technology', 'Engineering', 'Mathematics', 'Arts', 'Business'],
                datasets: [{
                    data: [25, 20, 15, 18, 12, 10],
                    backgroundColor: [
                        '#3b82f6', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6', '#ec4899'
                    ]
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        });
    }
}

/**
 * Payment Form Handling
 */
function handlePaymentMethodChange() {
    const paymentMethodRadios = document.querySelectorAll('input[name="paymentMethod"]');
    const paymentDetailsContainers = {
        creditCard: document.getElementById('creditCardDetails'),
        bankTransfer: document.getElementById('bankTransferDetails'),
        other: document.getElementById('otherDetails')
    };

    if (paymentMethodRadios.length > 0) {
        paymentMethodRadios.forEach(radio => {
            radio.addEventListener('change', function() {
                // Hide all payment details containers
                Object.values(paymentDetailsContainers).forEach(container => {
                    if (container) container.style.display = 'none';
                });

                // Show the selected payment details container
                const selectedMethod = this.value.toLowerCase();
                if (selectedMethod === 'credit_card' && paymentDetailsContainers.creditCard) {
                    paymentDetailsContainers.creditCard.style.display = 'block';
                } else if (selectedMethod === 'bank_transfer' && paymentDetailsContainers.bankTransfer) {
                    paymentDetailsContainers.bankTransfer.style.display = 'block';
                } else if (selectedMethod === 'other' && paymentDetailsContainers.other) {
                    paymentDetailsContainers.other.style.display = 'block';
                }
            });
        });

        // Trigger change event on the checked radio button
        const checkedRadio = document.querySelector('input[name="paymentMethod"]:checked');
        if (checkedRadio) {
            checkedRadio.dispatchEvent(new Event('change'));
        }
    }
}

// Call payment method handler when document is loaded
document.addEventListener('DOMContentLoaded', function() {
    handlePaymentMethodChange();
});

/**
 * File Upload Preview
 */
function initializeFileUploadPreview() {
    const fileInputs = document.querySelectorAll('input[type="file"][data-preview]');

    fileInputs.forEach(input => {
        const previewElement = document.getElementById(input.getAttribute('data-preview'));

        if (previewElement) {
            input.addEventListener('change', function() {
                if (this.files && this.files[0]) {
                    const reader = new FileReader();

                    reader.onload = function(e) {
                        previewElement.src = e.target.result;
                        previewElement.style.display = 'block';
                    };

                    reader.readAsDataURL(this.files[0]);
                }
            });
        }
    });
}

// Initialize file upload preview
document.addEventListener('DOMContentLoaded', function() {
    initializeFileUploadPreview();
});
