<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh Toán - Nailology</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #c4a080;
            --primary-dark: #3d3d3d;
            --light-bg: #f5f1ed;
            --white: #ffffff;
            --border: #e0e0e0;
            --success: #28a745;
            --text-color: #3d3d3d;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            background: linear-gradient(135deg, #f5f1ed 0%, #faf8f6 100%);
            font-family: 'Lora', serif;
            color: var(--text-color);
            min-height: 100vh;
        }
        
        .payment-container {
            max-width: 900px;
            margin: 3rem auto;
            padding: 0 1.5rem;
        }
        
        .page-header {
            text-align: center;
            margin-bottom: 3rem;
            padding-bottom: 2rem;
            border-bottom: 2px solid var(--primary);
        }
        
        .page-header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            color: var(--primary-dark);
            margin-bottom: 0.5rem;
        }
        
        .page-header p {
            color: #999;
            font-size: 1rem;
        }
        
        .booking-info {
            background: var(--white);
            padding: 2rem;
            border-radius: 12px;
            margin-bottom: 2.5rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            border-left: 5px solid var(--primary);
        }
        
        .booking-info h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            color: var(--primary-dark);
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border);
        }
        
        .info-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }
        
        .info-item {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }
        
        .info-label {
            font-size: 0.85rem;
            color: #999;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 600;
        }
        
        .info-value {
            font-size: 1rem;
            color: var(--primary-dark);
            font-weight: 500;
        }
        
        .total-amount {
            background: linear-gradient(135deg, var(--primary) 0%, #a9886b 100%);
            color: white;
            padding: 1.5rem;
            border-radius: 8px;
            text-align: center;
            margin-top: 1.5rem;
        }
        
        .total-amount .label {
            font-size: 0.9rem;
            opacity: 0.9;
            margin-bottom: 0.5rem;
        }
        
        .total-amount .amount {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            font-weight: 700;
        }
        
        .payment-section {
            background: var(--white);
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            margin-bottom: 2rem;
        }
        
        .section-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            color: var(--primary-dark);
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border);
        }
        
        .payment-methods-grid {
            display: grid;
            gap: 1rem;
        }
        
        .payment-method {
            cursor: pointer;
            padding: 1.5rem;
            border: 2px solid var(--border);
            border-radius: 10px;
            transition: all 0.3s ease;
            background: var(--white);
            position: relative;
            overflow: hidden;
        }
        
        .payment-method:hover {
            border-color: var(--primary);
            background: #faf8f6;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(196, 160, 128, 0.2);
        }
        
        .payment-method.selected {
            border-color: var(--primary);
            background: linear-gradient(135deg, #fff9f5 0%, #faf8f6 100%);
            box-shadow: 0 4px 20px rgba(196, 160, 128, 0.3);
        }
        
        .payment-method.selected::before {
            content: '✓';
            position: absolute;
            top: 1rem;
            right: 1rem;
            width: 30px;
            height: 30px;
            background: var(--primary);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            line-height: 30px;
            text-align: center;
        }
        
        .payment-method input[type="radio"] {
            position: absolute;
            opacity: 0;
            cursor: pointer;
        }
        
        .method-content {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .method-icon {
            font-size: 2rem;
            width: 60px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: var(--light-bg);
            border-radius: 10px;
            flex-shrink: 0;
        }
        
        .method-details {
            flex: 1;
        }
        
        .method-name {
            font-family: 'Playfair Display', serif;
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--primary-dark);
            margin-bottom: 0.25rem;
        }
        
        .method-desc {
            color: #999;
            font-size: 0.9rem;
        }
        
        .note-section {
            margin-top: 2rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group label {
            display: block;
            font-weight: 600;
            color: var(--primary-dark);
            margin-bottom: 0.75rem;
            font-size: 1rem;
        }
        
        .form-group textarea {
            width: 100%;
            padding: 1rem;
            border: 2px solid var(--border);
            border-radius: 8px;
            font-family: 'Lora', serif;
            font-size: 1rem;
            resize: vertical;
            min-height: 100px;
            transition: border-color 0.3s;
        }
        
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(196, 160, 128, 0.1);
        }
        
        .action-buttons {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }
        
        .btn {
            padding: 1rem 2rem;
            border: none;
            border-radius: 8px;
            font-family: 'Lora', serif;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, var(--primary) 0%, #a9886b 100%);
            color: white;
            flex: 1;
            box-shadow: 0 4px 15px rgba(196, 160, 128, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 25px rgba(196, 160, 128, 0.4);
        }
        
        .btn-secondary {
            background: white;
            color: var(--primary);
            border: 2px solid var(--primary);
        }
        
        .btn-secondary:hover {
            background: var(--primary);
            color: white;
        }
        
        .alert {
            padding: 1.25rem;
            border-radius: 8px;
            margin-bottom: 2rem;
            border-left: 4px solid;
        }
        
        .alert-error {
            background: #fee2e2;
            color: #dc2626;
            border-color: #dc2626;
        }
        
        @media (max-width: 768px) {
            .payment-container {
                padding: 0 1rem;
                margin: 2rem auto;
            }
            
            .page-header h1 {
                font-size: 2rem;
            }
            
            .info-grid {
                grid-template-columns: 1fr;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .method-content {
                flex-direction: column;
                text-align: center;
            }
            
            .total-amount .amount {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/layout/header.jsp" />
    
    <div class="payment-container">
        <!-- Page Header -->
        <div class="page-header">
            <h1>💳 Thanh Toán</h1>
            <p>Hoàn tất thanh toán cho lịch hẹn của bạn</p>
        </div>

        <!-- Alert Messages -->
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <strong>⚠️ Lỗi:</strong> ${error}
            </div>
        </c:if>

        <!-- Booking Information -->
        <div class="booking-info">
            <h3>📋 Thông Tin Đặt Lịch</h3>
            
            <div class="info-grid">
                <div class="info-item">
                    <span class="info-label">🎫 Mã đặt lịch</span>
                    <span class="info-value">${booking.bookingCode}</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">👤 Khách hàng</span>
                    <span class="info-value">${booking.customerName}</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">📧 Email</span>
                    <span class="info-value">${booking.email}</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">📱 Số điện thoại</span>
                    <span class="info-value">${booking.phone}</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">📍 Chi nhánh</span>
                    <span class="info-value">${booking.location.name}</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">📅 Ngày hẹn</span>
                    <span class="info-value">${booking.bookingDate}</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">🕐 Giờ hẹn</span>
                    <span class="info-value">${booking.bookingTime}</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">💅 Dịch vụ</span>
                    <span class="info-value">${booking.serviceNames}</span>
                </div>
            </div>
            
            <div class="total-amount">
                <div class="label">Tổng thanh toán</div>
                <div class="amount">
                    <fmt:formatNumber value="${booking.totalPrice}" type="currency" currencySymbol="$" pattern="#,###$"/>
                </div>
            </div>
        </div>

        <!-- Payment Form -->
        <form action="${pageContext.request.contextPath}/payment/create" method="post" id="paymentForm">
            <input type="hidden" name="bookingId" value="${booking.id}">
            <input type="hidden" name="bookingCode" value="${booking.bookingCode}">
            <input type="hidden" name="amount" value="${booking.totalPrice}">
            <input type="hidden" name="customerName" value="${booking.customerName}">
            <input type="hidden" name="customerEmail" value="${booking.email}">
            <input type="hidden" name="customerPhone" value="${booking.phone}">

            <!-- Payment Methods Section -->
            <div class="payment-section">
                <h3 class="section-title">💳 Chọn Phương Thức Thanh Toán</h3>

                <div class="payment-methods-grid">
                    <!-- Cash -->
                    <div class="payment-method" onclick="selectPaymentMethod('CASH')">
                        <input type="radio" name="paymentMethod" value="CASH" id="cash" required>
                        <div class="method-content">
                            <div class="method-icon">💵</div>
                            <div class="method-details">
                                <div class="method-name">Tiền Mặt</div>
                                <div class="method-desc">Thanh toán trực tiếp tại quầy khi đến làm dịch vụ</div>
                            </div>
                        </div>
                    </div>

                    <!-- Card -->
                    <div class="payment-method" onclick="selectPaymentMethod('CARD')">
                        <input type="radio" name="paymentMethod" value="CARD" id="card">
                        <div class="method-content">
                            <div class="method-icon">💳</div>
                            <div class="method-details">
                                <div class="method-name">Thẻ Tín Dụng/Ghi Nợ</div>
                                <div class="method-desc">Thanh toán bằng thẻ Visa, Mastercard, AMEX</div>
                            </div>
                        </div>
                    </div>

                    <!-- Bank Transfer -->
                    <div class="payment-method" onclick="selectPaymentMethod('BANK_TRANSFER')">
                        <input type="radio" name="paymentMethod" value="BANK_TRANSFER" id="bank">
                        <div class="method-content">
                            <div class="method-icon">🏦</div>
                            <div class="method-details">
                                <div class="method-name">Chuyển Khoản Ngân Hàng</div>
                                <div class="method-desc">Chuyển khoản qua Internet Banking hoặc ATM</div>
                            </div>
                        </div>
                    </div>

                    <!-- MoMo -->
                    <div class="payment-method" onclick="selectPaymentMethod('MOMO')">
                        <input type="radio" name="paymentMethod" value="MOMO" id="momo">
                        <div class="method-content">
                            <div class="method-icon">📱</div>
                            <div class="method-details">
                                <div class="method-name">Ví MoMo</div>
                                <div class="method-desc">Thanh toán qua ví điện tử MoMo</div>
                            </div>
                        </div>
                    </div>

                    <!-- ZaloPay -->
                    <div class="payment-method" onclick="selectPaymentMethod('ZALOPAY')">
                        <input type="radio" name="paymentMethod" value="ZALOPAY" id="zalopay">
                        <div class="method-content">
                            <div class="method-icon">💙</div>
                            <div class="method-details">
                                <div class="method-name">ZaloPay</div>
                                <div class="method-desc">Thanh toán qua ví ZaloPay</div>
                            </div>
                        </div>
                    </div>

                    <!-- VNPay -->
                    <div class="payment-method" onclick="selectPaymentMethod('VNPAY')">
                        <input type="radio" name="paymentMethod" value="VNPAY" id="vnpay">
                        <div class="method-content">
                            <div class="method-icon">🔵</div>
                            <div class="method-details">
                                <div class="method-name">VNPay</div>
                                <div class="method-desc">Thanh toán qua cổng thanh toán VNPay</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Note Section -->
                <div class="note-section">
                    <div class="form-group">
                        <label for="note">📝 Ghi Chú (tùy chọn)</label>
                        <textarea 
                            id="note" 
                            name="note" 
                            rows="3" 
                            placeholder="Nhập ghi chú nếu có (yêu cầu đặc biệt, câu hỏi...)"></textarea>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="action-buttons">
                <button type="submit" class="btn btn-primary">
                    ✓ Xác Nhận Thanh Toán
                </button>
                <a href="${pageContext.request.contextPath}/booking/view/${booking.bookingCode}" class="btn btn-secondary">
                    ← Quay Lại
                </a>
            </div>
        </form>
    </div>

    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />

    <script>
        function selectPaymentMethod(method) {
            // Remove all selected classes
            document.querySelectorAll('.payment-method').forEach(el => {
                el.classList.remove('selected');
            });
            
            // Select the radio button
            const radio = document.getElementById(method.toLowerCase());
            if (radio) {
                radio.checked = true;
                radio.closest('.payment-method').classList.add('selected');
            }
        }

        // Add click listener to radio buttons
        document.querySelectorAll('.payment-method input[type="radio"]').forEach(radio => {
            radio.addEventListener('change', function() {
                document.querySelectorAll('.payment-method').forEach(el => {
                    el.classList.remove('selected');
                });
                this.closest('.payment-method').classList.add('selected');
            });
        });

        // Form validation
        document.getElementById('paymentForm').addEventListener('submit', function(e) {
            const selectedMethod = document.querySelector('input[name="paymentMethod"]:checked');
            if (!selectedMethod) {
                e.preventDefault();
                alert('Vui lòng chọn phương thức thanh toán');
            }
        });
    </script>
</body>
</html>
