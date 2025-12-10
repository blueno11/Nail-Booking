<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết booking - Nailology</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Lora:wght@400;500&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #c4a080;
            --dark: #3d3d3d;
            --accent: #d4af9e;
            --light-bg: #f5f1ed;
            --white: #ffffff;
            --border: #e0e0e0;
            --danger: #dc3545;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { background: linear-gradient(135deg, #f5f1ed 0%, #faf8f6 100%); font-family: 'Lora', serif; color: var(--dark); min-height: 100vh; }
        .container { max-width: 1000px; margin: 0 auto; padding: 40px 20px; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; padding-bottom: 30px; border-bottom: 2px solid var(--primary); }
        .page-header h1 { font-family: 'Playfair Display', serif; font-size: 42px; font-weight: 600; color: var(--dark); }
        .page-header p { color: #999; font-size: 14px; margin-top: 5px; }
        .btn { padding: 12px 24px; border-radius: 8px; border: none; cursor: pointer; font-family: 'Lora', serif; font-size: 14px; font-weight: 500; transition: all 0.3s ease; text-decoration: none; display: inline-block; }
        .btn-primary { background: linear-gradient(135deg, var(--primary) 0%, #a9886b 100%); color: white; box-shadow: 0 4px 15px rgba(196, 160, 128, 0.3); }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(196, 160, 128, 0.4); }
        .btn-secondary { background: white; color: var(--primary); border: 2px solid var(--primary); }
        .btn-secondary:hover { background: var(--primary); color: white; }
        .btn-danger { background: rgba(220, 53, 69, 0.1); color: var(--danger); }
        .btn-danger:hover { background: var(--danger); color: white; }
        
        .card { background: white; padding: 30px; border-radius: 12px; box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05); border-top: 4px solid var(--primary); margin-bottom: 24px; }
        .card-title { font-family: 'Playfair Display', serif; font-size: 22px; font-weight: 600; color: var(--dark); margin-bottom: 24px; display: flex; align-items: center; gap: 10px; }
        .info-row { display: flex; justify-content: space-between; align-items: flex-start; padding: 16px 0; border-bottom: 1px solid var(--border); }
        .info-row:last-child { border-bottom: none; }
        .info-label { font-weight: 600; color: var(--dark); min-width: 150px; }
        .info-value { color: #666; flex: 1; text-align: right; }
        
        .status-badge { display: inline-block; padding: 6px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px; }
        .status-pending { background: rgba(255, 193, 7, 0.1); color: #ffc107; }
        .status-confirmed { background: rgba(40, 167, 69, 0.1); color: #28a745; }
        .status-completed { background: rgba(52, 152, 219, 0.1); color: #3498db; }
        .status-cancelled { background: rgba(220, 53, 69, 0.1); color: var(--danger); }
        
        .services-list { display: flex; flex-direction: column; gap: 12px; margin-top: 12px; }
        .service-item { background: #f9f8f7; padding: 12px; border-radius: 8px; display: flex; justify-content: space-between; align-items: center; }
        .service-name { font-weight: 500; }
        .service-price { font-family: 'Playfair Display', serif; font-weight: 600; color: var(--primary); }
        
        .action-buttons { display: flex; gap: 12px; margin-top: 24px; flex-wrap: wrap; }
        .amount { font-family: 'Playfair Display', serif; font-weight: 600; color: var(--primary); font-size: 18px; }
        
        @media (max-width: 768px) {
            .page-header { flex-direction: column; align-items: flex-start; gap: 16px; }
            .page-header h1 { font-size: 32px; }
            .info-row { flex-direction: column; gap: 8px; }
            .info-value { text-align: left; }
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" />

<div class="container">
    <div class="page-header">
        <div>
            <h1>📘 Booking #${booking.id}</h1>
            <p>Chi tiết đặt lịch</p>
        </div>
        <a href="${pageContext.request.contextPath}/booking/list" class="btn btn-secondary">← Quay Lại</a>
    </div>

    <div class="card">
        <div class="card-title">👤 Thông Tin Khách</div>
        <div class="info-row">
            <div class="info-label">Tên khách</div>
            <div class="info-value"><strong>${booking.customer != null ? booking.customer.fullName : 'Khách vãng lai'}</strong></div>
        </div>
        <div class="info-row">
            <div class="info-label">Điện thoại</div>
            <div class="info-value">${booking.customer != null ? booking.customer.phoneNumber : '-'}</div>
        </div>
        <div class="info-row">
            <div class="info-label">Email</div>
            <div class="info-value">${booking.customer != null && booking.customer.email != null ? booking.customer.email : '-'}</div>
        </div>
    </div>

    <div class="card">
        <div class="card-title">🕐 Thông Tin Lịch</div>
        <div class="info-row">
            <div class="info-label">Ngày & Giờ</div>
            <div class="info-value"><fmt:formatDate value="${booking.bookingDateTime}" pattern="dd/MM/yyyy HH:mm"/></div>
        </div>
        <div class="info-row">
            <div class="info-label">Chi nhánh</div>
            <div class="info-value">${booking.location != null ? booking.location.name : '-'}</div>
        </div>
        <div class="info-row">
            <div class="info-label">Kỹ thuật viên</div>
            <div class="info-value">${booking.staff != null ? booking.staff.name : '-'}</div>
        </div>
        <div class="info-row">
            <div class="info-label">Trạng thái</div>
            <div class="info-value">
                <span class="status-badge status-${fn:toLowerCase(booking.status)}">
                    <c:choose>
                        <c:when test="${booking.status == 'PENDING'}">Chờ xác nhận</c:when>
                        <c:when test="${booking.status == 'CONFIRMED'}">Xác nhận</c:when>
                        <c:when test="${booking.status == 'COMPLETED'}">Hoàn thành</c:when>
                        <c:when test="${booking.status == 'CANCELLED'}">Đã huỷ</c:when>
                        <c:otherwise>${booking.status}</c:otherwise>
                    </c:choose>
                </span>
            </div>
        </div>
    </div>

    <div class="card">
        <div class="card-title">💇 Dịch Vụ & Giá</div>
        <c:if test="${empty booking.services}">
            <p style="color: #999;">Không có dịch vụ nào</p>
        </c:if>
        <c:if test="${not empty booking.services}">
            <div class="services-list">
                <c:forEach var="s" items="${booking.services}">
                    <div class="service-item">
                        <span class="service-name">${s.name}</span>
                        <span class="service-price"><fmt:formatNumber value="${s.startingPrice}" type="currency" currencySymbol="đ"/></span>
                    </div>
                </c:forEach>
            </div>
            <div class="info-row" style="margin-top: 16px; padding-top: 16px; border-top: 2px solid var(--border); font-size: 18px;">
                <div class="info-label">Tổng tiền</div>
                <div class="info-value amount"><fmt:formatNumber value="${booking.totalAmount}" type="currency" currencySymbol="đ"/></div>
            </div>
        </c:if>
    </div>

    <div class="action-buttons">
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/booking/${booking.id}/edit">✏️ Sửa Lịch</a>
        <c:if test="${booking.status != 'CANCELLED'}">
            <form action="${pageContext.request.contextPath}/booking/${booking.id}/cancel" method="post" style="display:inline;">
                <button class="btn btn-danger" type="submit" onclick="return confirm('Bạn có chắc muốn huỷ booking này?');">🗑️ Huỷ Lịch</button>
            </form>
        </c:if>
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/booking/list">← Danh Sách Lịch</a>
    </div>

</div>

<jsp:include page="../layout/footer.jsp" />
</body>
</html>