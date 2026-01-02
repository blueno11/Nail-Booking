<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Thanh Toán - Nailology</title>
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
            --warning: #ffc107;
            --danger: #dc3545;
            --info: #17a2b8;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            background: linear-gradient(135deg, #f5f1ed 0%, #faf8f6 100%);
            font-family: 'Lora', serif;
            color: var(--primary-dark);
            min-height: 100vh;
        }
        
        .detail-container {
            max-width: 1000px;
            margin: 3rem auto;
            padding: 0 1.5rem;
        }
        
        .breadcrumb {
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            color: #999;
        }
        
        .breadcrumb a {
            color: var(--primary);
            text-decoration: none;
            transition: color 0.3s;
        }
        
        .breadcrumb a:hover {
            color: var(--primary-dark);
            text-decoration: underline;
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
            margin-bottom: 1rem;
        }
        
        .payment-code {
            font-size: 1.5rem;
            color: var(--primary);
            font-weight: 700;
            margin-bottom: 1rem;
        }
        
        .status-badge {
            display: inline-block;
            padding: 0.5rem 1.5rem;
            border-radius: 25px;
            font-weight: 600;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .status-PENDING {
            background: #fff3cd;
            color: #856404;
        }
        
        .status-COMPLETED {
            background: #d4edda;
            color: #155724;
        }
        
        .status-FAILED {
            background: #f8d7da;
            color: #721c24;
        }
        
        .status-REFUNDED {
            background: #d1ecf1;
            color: #0c5460;
        }
        
        .alert {
            padding: 1.25rem;
            border-radius: 8px;
            margin-bottom: 2rem;
            border-left: 4px solid;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
        
        .alert-success {
            background: #d4edda;
            color: #155724;
            border-color: #28a745;
        }
        
        .alert-error {
            background: #f8d7da;
            color: #721c24;
            border-color: #dc3545;
        }
        
        .detail-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }
        
        .info-card {
            background: var(--white);
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            border-left: 5px solid var(--primary);
        }
        
        .info-card h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.25rem;
            color: var(--primary-dark);
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .info-item {
            margin-bottom: 1.25rem;
        }
        
        .info-item:last-child {
            margin-bottom: 0;
        }
        
        .info-label {
            font-size: 0.85rem;
            color: #999;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 600;
            margin-bottom: 0.5rem;
            display: block;
        }
        
        .info-value {
            font-size: 1.05rem;
            color: var(--primary-dark);
            font-weight: 500;
        }
        
        .amount-large {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            color: var(--primary);
            font-weight: 700;
        }
        
        .method-badge {
            display: inline-block;
            padding: 0.375rem 1rem;
            background: linear-gradient(135deg, var(--primary) 0%, #a9886b 100%);
            color: white;
            border-radius: 20px;
            font-size: 0.9rem;
            font-weight: 600;
        }
        
        .note-box {
            background: var(--light-bg);
            padding: 1.25rem;
            border-radius: 8px;
            border-left: 3px solid var(--primary);
            margin-top: 1rem;
        }
        
        .note-box p {
            margin: 0;
            color: #666;
            line-height: 1.6;
        }
        
        .actions-card {
            background: var(--white);
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            margin-top: 2rem;
        }
        
        .actions-card h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.25rem;
            color: var(--primary-dark);
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border);
        }
        
        .action-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 0.875rem 1.75rem;
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
        
        .btn-success {
            background: var(--success);
            color: white;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
        }
        
        .btn-success:hover {
            background: #218838;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(40, 167, 69, 0.4);
        }
        
        .btn-warning {
            background: var(--warning);
            color: var(--primary-dark);
            box-shadow: 0 4px 15px rgba(255, 193, 7, 0.3);
        }
        
        .btn-warning:hover {
            background: #e0a800;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 193, 7, 0.4);
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
        
        .btn-info {
            background: var(--info);
            color: white;
            box-shadow: 0 4px 15px rgba(23, 162, 184, 0.3);
        }
        
        .btn-info:hover {
            background: #138496;
            transform: translateY(-2px);
        }
        
        /* Modal */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.6);
            backdrop-filter: blur(5px);
        }
        
        .modal-content {
            background-color: var(--white);
            margin: 10% auto;
            padding: 0;
            border-radius: 12px;
            width: 90%;
            max-width: 500px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.3);
            animation: slideIn 0.3s ease-out;
        }
        
        @keyframes slideIn {
            from {
                transform: translateY(-50px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
        
        .modal-header {
            padding: 1.5rem 2rem;
            border-bottom: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .modal-header h3 {
            font-family: 'Playfair Display', serif;
            color: var(--primary-dark);
            margin: 0;
        }
        
        .close {
            font-size: 2rem;
            font-weight: bold;
            color: #999;
            cursor: pointer;
            border: none;
            background: none;
            line-height: 1;
        }
        
        .close:hover {
            color: var(--primary-dark);
        }
        
        .modal-body {
            padding: 2rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group label {
            display: block;
            font-weight: 600;
            color: var(--primary-dark);
            margin-bottom: 0.75rem;
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
        }
        
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(196, 160, 128, 0.1);
        }
        
        .warning-box {
            background: #fff3cd;
            padding: 1rem;
            border-radius: 8px;
            border-left: 3px solid #ffc107;
            margin-bottom: 1.5rem;
        }
        
        .warning-box strong {
            display: block;
            margin-bottom: 0.5rem;
            color: #856404;
        }
        
        .modal-footer {
            padding: 1.5rem 2rem;
            border-top: 1px solid var(--border);
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
        }
        
        @media (max-width: 768px) {
            .detail-container {
                padding: 0 1rem;
                margin: 2rem auto;
            }
            
            .page-header h1 {
                font-size: 2rem;
            }
            
            .detail-grid {
                grid-template-columns: 1fr;
            }
            
            .action-buttons {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }
            
            .modal-content {
                width: 95%;
                margin: 5% auto;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/layout/header.jsp" />
    
    <div class="detail-container">
        <!-- Breadcrumb -->
        <div class="breadcrumb">
            <a href="${pageContext.request.contextPath}/">Trang chủ</a> / 
            <a href="${pageContext.request.contextPath}/payment/manage">Quản lý thanh toán</a> / 
            Chi tiết
        </div>

        <!-- Page Header -->
        <div class="page-header">
            <h1>💳 Chi Tiết Thanh Toán</h1>
            <div class="payment-code">#${payment.paymentCode}</div>
            <span class="status-badge status-${payment.status}">
                <c:choose>
                    <c:when test="${payment.status == 'PENDING'}">⏳ Chờ Thanh Toán</c:when>
                    <c:when test="${payment.status == 'COMPLETED'}">✓ Đã Thanh Toán</c:when>
                    <c:when test="${payment.status == 'FAILED'}">✗ Thất Bại</c:when>
                    <c:when test="${payment.status == 'REFUNDED'}">↻ Đã Hoàn Tiền</c:when>
                </c:choose>
            </span>
        </div>

        <!-- Alert Messages -->
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <span style="font-size: 1.5rem;">✓</span>
                <span>${success}</span>
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <span style="font-size: 1.5rem;">⚠</span>
                <span>${error}</span>
            </div>
        </c:if>

        <!-- Payment Information -->
        <div class="detail-grid">
            <!-- Payment Details -->
            <div class="info-card">
                <h3>💰 Thông Tin Thanh Toán</h3>
                
                <div class="info-item">
                    <span class="info-label">Mã thanh toán</span>
                    <span class="info-value">${payment.paymentCode}</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Số tiền</span>
                    <span class="amount-large">
                        <fmt:formatNumber value="${payment.amount}" type="currency" currencySymbol="$" pattern="#,###$"/>
                    </span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Phương thức thanh toán</span>
                    <span class="method-badge">
                        <c:choose>
                            <c:when test="${payment.paymentMethod == 'CASH'}">💵 Tiền Mặt</c:when>
                            <c:when test="${payment.paymentMethod == 'CARD'}">💳 Thẻ</c:when>
                            <c:when test="${payment.paymentMethod == 'BANK_TRANSFER'}">🏦 Chuyển Khoản</c:when>
                            <c:when test="${payment.paymentMethod == 'MOMO'}">📱 MoMo</c:when>
                            <c:when test="${payment.paymentMethod == 'ZALOPAY'}">💙 ZaloPay</c:when>
                            <c:when test="${payment.paymentMethod == 'VNPAY'}">🔵 VNPay</c:when>
                            <c:otherwise>${payment.paymentMethod}</c:otherwise>
                        </c:choose>
                    </span>
                </div>
                
                <c:if test="${not empty payment.transactionId}">
                    <div class="info-item">
                        <span class="info-label">Mã giao dịch</span>
                        <span class="info-value">${payment.transactionId}</span>
                    </div>
                </c:if>
                
                <div class="info-item">
                    <span class="info-label">Ngày tạo</span>
                    <span class="info-value">${payment.createdAt}</span>

                </div>
                
                <c:if test="${payment.status == 'COMPLETED' && not empty payment.paidAt}">
                    <div class="info-item">
                        <span class="info-label">Ngày thanh toán</span>
                        <span class="info-value">
                            <fmt:formatDate value="${payment.paidAt}" pattern="dd/MM/yyyy HH:mm:ss"/>
                        </span>
                    </div>
                </c:if>
                
                <c:if test="${not empty payment.note}">
                    <div class="note-box">
                        <strong style="font-size: 0.85rem; color: var(--primary-dark);">📝 Ghi chú:</strong>
                        <p>${payment.note}</p>
                    </div>
                </c:if>
            </div>

            <!-- Customer & Booking Info -->
            <div class="info-card">
                <h3>👤 Khách Hàng & Đặt Lịch</h3>
                
                <div class="info-item">
                    <span class="info-label">Tên khách hàng</span>
                    <span class="info-value">${payment.customerName}</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Email</span>
                    <span class="info-value">${payment.customerEmail}</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Số điện thoại</span>
                    <span class="info-value">${payment.customerPhone}</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Mã đặt lịch</span>
                    <span class="info-value">
                        <a href="${pageContext.request.contextPath}/booking/view/${booking.bookingCode}" 
                           style="color: var(--primary); text-decoration: none; font-weight: 600;">
                            ${booking.bookingCode} →
                        </a>
                    </span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Chi nhánh</span>
                    <span class="info-value">${booking.location.name}</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Ngày hẹn</span>
                    <span class="info-value">${booking.bookingDate} - ${booking.bookingTime}</span>

                </div>
                
                <div class="info-item">
                    <span class="info-label">Dịch vụ</span>
                    <span class="info-value">${booking.serviceNames}</span>
                </div>
                
                <div class="info-item">
                    <span class="info-label">Trạng thái booking</span>
                    <span class="status-badge status-${booking.status}">${booking.status}</span>
                </div>
            </div>
        </div>

        <!-- Actions -->
        <div class="actions-card">
            <h3>⚡ Thao Tác</h3>
            
            <div class="action-buttons">
                <!-- Xác nhận thanh toán (nếu PENDING) -->
                <c:if test="${payment.status == 'PENDING'}">
                    <form action="${pageContext.request.contextPath}/payment/confirm/${payment.paymentCode}" 
                          method="post" style="display: inline;">
                        <button type="submit" class="btn btn-success" 
                                onclick="return confirm('Xác nhận đã nhận thanh toán?')">
                            ✓ Xác Nhận Thanh Toán
                        </button>
                    </form>
                </c:if>
                
                <!-- Hoàn tiền (nếu COMPLETED) -->
                <c:if test="${payment.status == 'COMPLETED'}">
                    <button type="button" class="btn btn-warning" onclick="openRefundModal()">
                        ↻ Hoàn Tiền
                    </button>
                </c:if>
                
                <!-- Xem booking -->
                <a href="${pageContext.request.contextPath}/booking/view/${booking.bookingCode}" 
                   class="btn btn-info">
                    📋 Xem Booking
                </a>
                
                <!-- Quay lại -->
                <a href="${pageContext.request.contextPath}/payment/manage" class="btn btn-secondary">
                    ← Quay Lại Danh Sách
                </a>
            </div>
        </div>
    </div>

    <!-- Refund Modal -->
    <div id="refundModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3>↻ Hoàn Tiền</h3>
                <button class="close" onclick="closeRefundModal()">&times;</button>
            </div>
            <form action="${pageContext.request.contextPath}/payment/refund/${payment.id}" method="post">
                <div class="modal-body">
                    <div class="warning-box">
                        <strong>⚠️ Cảnh báo:</strong>
                        <p>Hành động này không thể hoàn tác. Vui lòng xác nhận bạn muốn hoàn tiền cho khách hàng.</p>
                    </div>
                    
                    <div class="form-group">
                        <label for="refundNote">Lý do hoàn tiền <span style="color: var(--danger);">*</span></label>
                        <textarea id="refundNote" name="note" required 
                                  placeholder="Nhập lý do hoàn tiền (bắt buộc)..."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="closeRefundModal()">
                        Hủy
                    </button>
                    <button type="submit" class="btn btn-warning">
                        Xác Nhận Hoàn Tiền
                    </button>
                </div>
            </form>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />

    <script>
        function openRefundModal() {
            document.getElementById('refundModal').style.display = 'block';
        }

        function closeRefundModal() {
            document.getElementById('refundModal').style.display = 'none';
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('refundModal');
            if (event.target == modal) {
                closeRefundModal();
            }
        }

        // Close modal with ESC key
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                closeRefundModal();
            }
        });
    </script>
</body>
</html>
