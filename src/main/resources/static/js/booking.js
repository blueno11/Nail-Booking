// Booking page functionality
let selectedServices = [];

document.addEventListener('DOMContentLoaded', function() {
    // Initialize tab to show 'hands' by default
    showTab('hands');
    
    // Add event listeners to all service cards
    document.querySelectorAll('.service-card').forEach(card => {
        const checkbox = card.querySelector('.service-checkbox');
        
        card.addEventListener('click', function(e) {
            // Don't toggle if clicking directly on checkbox
            if (e.target !== checkbox) {
                checkbox.checked = !checkbox.checked;
            }
            toggleService(card);
        });
        
        checkbox.addEventListener('click', function(e) {
            e.stopPropagation();
            toggleService(card);
        });
    });
});

function showTab(tabName) {
    // Hide all tab contents
    document.querySelectorAll('.tab-content').forEach(content => {
        content.classList.add('hidden');
    });
    
    // Remove active style from all tabs
    document.querySelectorAll('[id^="tab-"]').forEach(tab => {
        tab.style.borderColor = 'transparent';
        tab.style.color = '#666';
    });
    
    // Show selected tab content
    const content = document.getElementById('content-' + tabName);
    if (content) {
        content.classList.remove('hidden');
    }
    
    // Add active style to selected tab
    const tab = document.getElementById('tab-' + tabName);
    if (tab) {
        tab.style.borderColor = '#c4a080';
        tab.style.color = '#c4a080';
    }
}

function toggleService(card) {
    const checkbox = card.querySelector('.service-checkbox');
    const serviceId = parseInt(card.getAttribute('data-service-id'));
    const serviceName = card.getAttribute('data-service-name');
    const servicePrice = parseFloat(card.getAttribute('data-service-price'));
    const serviceDuration = card.getAttribute('data-service-duration');
    
    if (checkbox.checked) {
        // Add service
        if (!selectedServices.find(s => s.id === serviceId)) {
            selectedServices.push({
                id: serviceId,
                name: serviceName,
                price: servicePrice,
                duration: serviceDuration
            });
            card.classList.add('selected');
        }
    } else {
        // Remove service
        selectedServices = selectedServices.filter(s => s.id !== serviceId);
        card.classList.remove('selected');
    }
    
    updateSummary();
}

function updateSummary() {
    const summaryContent = document.getElementById('summary-content');
    const summaryServices = document.getElementById('summary-services');
    const servicesList = document.getElementById('services-list');
    const totalPrice = document.getElementById('total-price');
    const continueBtn = document.getElementById('continue-btn');
    
    if (selectedServices.length === 0) {
        summaryContent.classList.remove('hidden');
        summaryServices.classList.add('hidden');
        continueBtn.disabled = true;
        continueBtn.style.backgroundColor = '#ccc';
    } else {
        summaryContent.classList.add('hidden');
        summaryServices.classList.remove('hidden');
        continueBtn.disabled = false;
        continueBtn.style.backgroundColor = '#c4a080';
        
        // Update services list
        servicesList.innerHTML = '';
        selectedServices.forEach(service => {
            const serviceItem = document.createElement('div');
            serviceItem.className = 'flex justify-between items-start';
            serviceItem.innerHTML = `
                <div>
                    <p class="font-medium" style="color: #3d3d3d;">${service.name}</p>
                    <p class="text-sm" style="color: #888;">${service.duration}</p>
                </div>
                <p class="font-semibold" style="color: #c4a080;">${service.price} AUD</p>
            `;
            servicesList.appendChild(serviceItem);
        });
        
        // Update total price
        const total = selectedServices.reduce((sum, s) => sum + s.price, 0);
        totalPrice.textContent = total + ' AUD';
    }
}

function handleNext() {
    if (selectedServices.length === 0) {
        alert('Vui lòng chọn ít nhất một dịch vụ');
        return;
    }
    
    // TODO: Navigate to next step (date/time selection)
    console.log('Selected services:', selectedServices);
    alert('Tính năng chọn ngày giờ sẽ được triển khai trong bước tiếp theo');
}

