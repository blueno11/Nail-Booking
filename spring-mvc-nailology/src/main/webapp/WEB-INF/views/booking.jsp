<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
            <div class="booking-layout">
                <div class="booking-content">
                    <h1 class="booking-title">Đặt Lịch Hẹn</h1>
                    
                    <div class="tabs">
                        <div class="tabs-header">
                            <button class="tab-btn active" data-tab="hands">Tay</button>
                            <button class="tab-btn" data-tab="nailArt">Nail Art</button>
                            <button class="tab-btn" data-tab="feet">Chân</button>
                        </div>

                        <form action="${pageContext.request.contextPath}/booking/submit" method="post" id="bookingForm">
                            <div class="tab-content active" id="hands-tab">
                                <h2 class="tab-title">Dịch Vụ Tay</h2>
                                <c:forEach var="service" items="${services}">
                                    <c:if test="${service.category == 'hands'}">
                                        <div class="service-card-booking">
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
                                    <c:if test="${service.category == 'nailArt'}">
                                        <div class="service-card-booking">
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
                                    <c:if test="${service.category == 'feet'}">
                                        <div class="service-card-booking">
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

                            <div class="booking-summary-mobile">
                                <div class="summary-content">
                                    <h2 class="summary-title">Tóm Tắt Lịch Hẹn</h2>
                                    <div id="summaryItems"></div>
                                    <div class="summary-total">
                                        <span>Tổng Cộng</span>
                                        <span id="totalPrice">0 AUD</span>
                                    </div>
                                    <button type="submit" class="btn btn-primary btn-full" id="submitBtn">Tiếp Tục</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <div class="booking-sidebar">
                    <div class="summary-card">
                        <h2 class="summary-title">Tóm Tắt Lịch Hẹn</h2>
                        <div id="summaryItemsDesktop"></div>
                        <div class="summary-total">
                            <span>Tổng Cộng</span>
                            <span id="totalPriceDesktop">0 AUD</span>
                        </div>
                        <button type="submit" form="bookingForm" class="btn btn-primary btn-full" id="submitBtnDesktop">Tiếp Tục</button>
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
                
                // Update buttons
                document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
                this.classList.add('active');
                
                // Update content
                document.querySelectorAll('.tab-content').forEach(c => c.classList.remove('active'));
                document.getElementById(tabName + '-tab').classList.add('active');
            });
        });

        // Calculate total
        function updateSummary() {
            const checkboxes = document.querySelectorAll('.service-checkbox:checked');
            let total = 0;
            const items = [];
            
            checkboxes.forEach(cb => {
                const card = cb.closest('.service-card-booking');
                const name = card.querySelector('.service-name').textContent;
                const price = parseFloat(card.querySelector('.service-price').textContent);
                const duration = card.querySelector('.service-duration').textContent;
                total += price;
                items.push({name, price, duration});
            });
            
            // Update desktop summary
            const desktopItems = document.getElementById('summaryItemsDesktop');
            const mobileItems = document.getElementById('summaryItems');
            
            if (items.length === 0) {
                desktopItems.innerHTML = '<p class="summary-empty">Chưa có dịch vụ nào được thêm</p>';
                mobileItems.innerHTML = '<p class="summary-empty">Chưa có dịch vụ nào được thêm</p>';
            } else {
                desktopItems.innerHTML = items.map(item => 
                    `<div class="summary-item">
                        <div>
                            <p class="summary-item-name">${item.name}</p>
                            <p class="summary-item-duration">${item.duration}</p>
                        </div>
                        <p class="summary-item-price">${item.price} AUD</p>
                    </div>`
                ).join('');
                mobileItems.innerHTML = desktopItems.innerHTML;
            }
            
            document.getElementById('totalPrice').textContent = total + ' AUD';
            document.getElementById('totalPriceDesktop').textContent = total + ' AUD';
            
            const submitBtns = document.querySelectorAll('#submitBtn, #submitBtnDesktop');
            submitBtns.forEach(btn => {
                btn.disabled = items.length === 0;
                btn.style.opacity = items.length === 0 ? '0.5' : '1';
            });
        }
        
        document.querySelectorAll('.service-checkbox').forEach(cb => {
            cb.addEventListener('change', updateSummary);
        });
        
        updateSummary();
    </script>
</body>
</html>

