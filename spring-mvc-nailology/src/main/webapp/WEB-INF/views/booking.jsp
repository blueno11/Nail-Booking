<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Lịch Hẹn - Nailology</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
    <jsp:include page="layout/header.jsp" />

    <main class="booking-main">
        <div class="container">
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>
            
            <div class="booking-layout">
                <div class="booking-content">
                    <h1 class="booking-title">Đặt Lịch Hẹn</h1>
                    <p class="booking-subtitle">
                        <a href="${pageContext.request.contextPath}/booking/manage" class="link-manage">
                            Xem hoặc quản lý lịch hẹn đã đặt →
                        </a>
                    </p>
                    
                    <div class="booking-steps">
                        <div class="step active" data-step="1">
                            <span class="step-number">1</span>
                            <span class="step-label">Chọn dịch vụ</span>
                        </div>
                        <div class="step" data-step="2">
                            <span class="step-number">2</span>
                            <span class="step-label">Chọn ngày giờ</span>
                        </div>
                        <div class="step" data-step="3">
                            <span class="step-number">3</span>
                            <span class="step-label">Thông tin</span>
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/booking/submit" method="post" id="bookingForm">
                        <!-- Step 1: Services -->
                        <div class="booking-step-content active" id="step1">
                            <div class="tabs">
                                <div class="tabs-header">
                                    <button type="button" class="tab-btn active" data-tab="hands">Tay</button>
                                    <button type="button" class="tab-btn" data-tab="nailArt">Nail Art</button>
                                    <button type="button" class="tab-btn" data-tab="feet">Chân</button>
                                </div>

                                <div class="tab-content active" id="hands-tab">
                                    <h2 class="tab-title">Dịch Vụ Tay</h2>
                                    <c:forEach var="service" items="${services}">
                                        <c:if test="${fn:toUpperCase(service.category) == 'HANDS'}">
                                            <div class="service-card-booking" data-price="${service.price}" data-duration="${service.duration}">
                                                <label class="service-checkbox-label">
                                                    <input type="checkbox" name="selectedServiceIds" value="${service.id}" class="service-checkbox">
                                                    <div class="service-card-content">
                                                        <div class="service-card-header">
                                                            <h3 class="service-name">${service.name}</h3>
                                                            <span class="service-price">${service.price} AUD</span>
                                                        </div>
                                                        <p class="service-description">${service.description}</p>
                                                        <div class="service-footer">
                                                            <span class="service-duration">${service.duration}</span>
                                                        </div>
                                                    </div>
                                                </label>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>

                                <div class="tab-content" id="nailArt-tab">
                                    <h2 class="tab-title">Nail Art</h2>
                                    <c:forEach var="service" items="${services}">
                                        <c:if test="${fn:toUpperCase(service.category) == 'NAIL_ART'}">
                                            <div class="service-card-booking" data-price="${service.price}" data-duration="${service.duration}">
                                                <label class="service-checkbox-label">
                                                    <input type="checkbox" name="selectedServiceIds" value="${service.id}" class="service-checkbox">
                                                    <div class="service-card-content">
                                                        <div class="service-card-header">
                                                            <h3 class="service-name">${service.name}</h3>
                                                            <span class="service-price">${service.price} AUD</span>
                                                        </div>
                                                        <p class="service-description">${service.description}</p>
                                                        <div class="service-footer">
                                                            <span class="service-duration">${service.duration}</span>
                                                        </div>
                                                    </div>
                                                </label>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>

                                <div class="tab-content" id="feet-tab">
                                    <h2 class="tab-title">Dịch Vụ Chân</h2>
                                    <c:forEach var="service" items="${services}">
                                        <c:if test="${fn:toUpperCase(service.category) == 'FEET'}">
                                            <div class="service-card-booking" data-price="${service.price}" data-duration="${service.duration}">
                                                <label class="service-checkbox-label">
                                                    <input type="checkbox" name="selectedServiceIds" value="${service.id}" class="service-checkbox">
                                                    <div class="service-card-content">
                                                        <div class="service-card-header">
                                                            <h3 class="service-name">${service.name}</h3>
                                                            <span class="service-price">${service.price} AUD</span>
                                                        </div>
                                                        <p class="service-description">${service.description}</p>
                                                        <div class="service-footer">
                                                            <span class="service-duration">${service.duration}</span>
                                                        </div>
                                                    </div>
                                                </label>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="step-actions">
                                <button type="button" class="btn btn-primary" id="toStep2" disabled>Tiếp tục</button>
                            </div>
                        </div>


                        <!-- Step 2: Date, Time, Location -->
                        <div class="booking-step-content" id="step2">
                            <h2 class="step-title">Chọn Chi Nhánh, Ngày & Giờ</h2>
                            
                            <div class="form-group">
                                <label for="locationId">Chi nhánh <span class="required">*</span></label>
                                <select name="locationId" id="locationId" class="form-control" required>
                                    <option value="">-- Chọn chi nhánh --</option>
                                    <c:forEach var="loc" items="${locations}">
                                        <option value="${loc.id}">${loc.name} - ${loc.suburb}</option>
                                    </c:forEach>
                                    <c:if test="${empty locations}">
                                        <option value="1">Nailology - Sydney CBD</option>
                                        <option value="2">Nailology - Parramatta</option>
                                    </c:if>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="date">Ngày hẹn <span class="required">*</span></label>
                                <input type="date" name="date" id="date" class="form-control" required>
                            </div>

                            <div class="form-group">
                                <label>Giờ hẹn <span class="required">*</span></label>
                                <div id="timeSlotsContainer" class="time-slots">
                                    <p style="color:#666; padding:1rem 0;">Vui lòng chọn chi nhánh và ngày để xem khung giờ khả dụng.</p>
                                </div>
                                <input type="hidden" name="time" id="selectedTime" required>
                            </div>

                            <div class="step-actions">
                                <button type="button" class="btn btn-secondary" id="backToStep1">Quay lại</button>
                                <button type="button" class="btn btn-primary" id="toStep3" disabled>Tiếp tục</button>
                            </div>
                        </div>


                        <!-- Step 3: Customer Info -->
                        <div class="booking-step-content" id="step3">
                            <h2 class="step-title">Thông Tin Liên Hệ</h2>
                            
                            <div class="form-group">
                                <label for="customerName">Họ và tên <span class="required">*</span></label>
                                <input type="text" name="customerName" id="customerName" class="form-control" required>
                            </div>

                            <div class="form-group">
                                <label for="email">Email <span class="required">*</span></label>
                                <input type="email" name="email" id="email" class="form-control" required>
                            </div>

                            <div class="form-group">
                                <label for="phone">Số điện thoại <span class="required">*</span></label>
                                <input type="tel" name="phone" id="phone" class="form-control" required>
                            </div>

                            <div class="form-group">
                                <label for="message">Ghi chú (tùy chọn)</label>
                                <textarea name="message" id="message" class="form-control" rows="3" 
                                          placeholder="Yêu cầu đặc biệt, mẫu nail mong muốn..."></textarea>
                            </div>

                            <div class="step-actions">
                                <button type="button" class="btn btn-secondary" id="backToStep2">Quay lại</button>
                                <button type="submit" class="btn btn-primary">Xác Nhận Đặt Lịch</button>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="booking-sidebar">
                    <div class="summary-card">
                        <h2 class="summary-title">Tóm Tắt Lịch Hẹn</h2>
                        <div id="summaryLocation" class="summary-section" style="display:none;">
                            <p class="summary-label">Chi nhánh:</p>
                            <p class="summary-value" id="summaryLocationText"></p>
                        </div>
                        <div id="summaryDateTime" class="summary-section" style="display:none;">
                            <p class="summary-label">Thời gian:</p>
                            <p class="summary-value" id="summaryDateTimeText"></p>
                        </div>
                        <div class="summary-section">
                            <p class="summary-label">Dịch vụ:</p>
                            <div id="summaryItemsDesktop">
                                <p class="summary-empty">Chưa có dịch vụ nào được chọn</p>
                            </div>
                        </div>
                        <div class="summary-total">
                            <span>Tổng Cộng</span>
                            <span id="totalPriceDesktop">0 AUD</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="layout/footer.jsp" />


    <script>
        // Tab switching
        document.querySelectorAll('.tab-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                const tabName = this.getAttribute('data-tab');
                document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
                document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
                document.getElementById(tabName + '-tab').classList.add('active');
            });
        });

        // Step navigation
        function showStep(stepNum) {
            document.querySelectorAll('.booking-step-content').forEach(s => s.classList.remove('active'));
            document.getElementById('step' + stepNum).classList.add('active');
            document.querySelectorAll('.step').forEach(s => {
                const sNum = parseInt(s.getAttribute('data-step'));
                s.classList.toggle('active', sNum <= stepNum);
            });
        }

        document.getElementById('toStep2').addEventListener('click', () => showStep(2));
        document.getElementById('toStep3').addEventListener('click', () => showStep(3));
        document.getElementById('backToStep1').addEventListener('click', () => showStep(1));
        document.getElementById('backToStep2').addEventListener('click', () => showStep(2));

        // Tính tổng thời gian dịch vụ đã chọn
        function getTotalDuration() {
            let total = 0;
            document.querySelectorAll('.service-checkbox:checked').forEach(cb => {
                const card = cb.closest('.service-card-booking');
                const duration = parseInt(card.getAttribute('data-duration')) || 60;
                total += duration;
            });
            return total || 60; // Mặc định 60 phút
        }

        // Load time slots động từ API
        async function loadTimeSlots() {
            const locationId = document.getElementById('locationId').value;
            const date = document.getElementById('date').value;
            const container = document.getElementById('timeSlotsContainer');
            
            if (!locationId || !date) {
                container.innerHTML = '<p style="color:#666; padding:1rem 0;">Vui lòng chọn chi nhánh và ngày để xem khung giờ khả dụng.</p>';
                document.getElementById('selectedTime').value = '';
                validateStep2();
                return;
            }

            container.innerHTML = '<p style="color:#666; padding:1rem 0;">Đang tải khung giờ...</p>';

            try {
                const duration = getTotalDuration();
                const response = await fetch('${pageContext.request.contextPath}/api/booking/slots?locationId=' + locationId + '&date=' + date + '&duration=' + duration);
                const slots = await response.json();

                if (slots.length === 0) {
                    container.innerHTML = '<p style="color:#e74c3c; padding:1rem 0;">Không có khung giờ khả dụng cho ngày này. Vui lòng chọn ngày khác.</p>';
                    return;
                }

                let html = '';
                slots.forEach(slot => {
                    const availableClass = slot.available ? '' : 'disabled';
                    const disabledAttr = slot.available ? '' : 'disabled';
                    html += '<label class="time-slot ' + availableClass + '">' +
                            '<input type="radio" name="timeRadio" value="' + slot.time + '" ' + disabledAttr + ' onchange="selectTime(this.value)">' +
                            '<span class="time-slot-label">' + slot.time + (slot.available ? '' : ' (Hết)') + '</span>' +
                            '</label>';
                });
                container.innerHTML = html;
            } catch (error) {
                console.error('Error loading slots:', error);
                container.innerHTML = '<p style="color:#e74c3c; padding:1rem 0;">Lỗi tải khung giờ. Vui lòng thử lại.</p>';
            }
        }

        function selectTime(time) {
            document.getElementById('selectedTime').value = time;
            validateStep2();
        }

        // Update summary
        function updateSummary() {
            const checkboxes = document.querySelectorAll('.service-checkbox:checked');
            let total = 0;
            const items = [];
            
            checkboxes.forEach(cb => {
                const card = cb.closest('.service-card-booking');
                const name = card.querySelector('.service-name').textContent;
                const price = parseFloat(card.getAttribute('data-price'));
                const duration = card.getAttribute('data-duration');
                total += price;
                items.push({name, price, duration});
            });
            
            const desktopItems = document.getElementById('summaryItemsDesktop');
            if (items.length === 0) {
                desktopItems.innerHTML = '<p class="summary-empty">Chưa có dịch vụ nào được chọn</p>';
            } else {
                desktopItems.innerHTML = items.map(item => 
                    '<div class="summary-item"><div><p class="summary-item-name">' + item.name + '</p>' +
                    '<p class="summary-item-duration">' + item.duration + '</p></div>' +
                    '<p class="summary-item-price">' + item.price + ' AUD</p></div>'
                ).join('');
            }
            
            document.getElementById('totalPriceDesktop').textContent = total + ' AUD';
            document.getElementById('toStep2').disabled = items.length === 0;

            // Reload slots nếu đã chọn location và date (vì duration thay đổi)
            if (document.getElementById('locationId').value && document.getElementById('date').value) {
                loadTimeSlots();
            }
        }
        
        document.querySelectorAll('.service-checkbox').forEach(cb => {
            cb.addEventListener('change', updateSummary);
        });

        // Validate step 2
        function validateStep2() {
            const location = document.getElementById('locationId').value;
            const date = document.getElementById('date').value;
            const time = document.getElementById('selectedTime').value;
            document.getElementById('toStep3').disabled = !(location && date && time);
            
            // Update summary
            if (location) {
                const locText = document.getElementById('locationId').options[document.getElementById('locationId').selectedIndex].text;
                document.getElementById('summaryLocationText').textContent = locText;
                document.getElementById('summaryLocation').style.display = 'block';
            }
            if (date && time) {
                const dateObj = new Date(date);
                const dateStr = dateObj.toLocaleDateString('vi-VN', {weekday: 'long', year: 'numeric', month: 'long', day: 'numeric'});
                document.getElementById('summaryDateTimeText').textContent = dateStr + ' - ' + time;
                document.getElementById('summaryDateTime').style.display = 'block';
            }
        }

        // Event listeners cho load slots
        document.getElementById('locationId').addEventListener('change', function() {
            loadTimeSlots();
            validateStep2();
        });
        document.getElementById('date').addEventListener('change', function() {
            loadTimeSlots();
            validateStep2();
        });

        // Set min date to today
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('date').setAttribute('min', today);
        
        updateSummary();
    </script>
</body>
</html>
