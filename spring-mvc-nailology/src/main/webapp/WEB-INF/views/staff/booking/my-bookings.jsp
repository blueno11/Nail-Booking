<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch hẹn của tôi - Nailology</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .booking-container { max-width: 1000px; margin: 2rem auto; padding: 0 1rem; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; }
        .page-title { font-size: 1.75rem; color: var(--primary-dark); margin: 0; }
        .nav-tabs { display: flex; gap: 0.5rem; margin-bottom: 1.5rem; }
        .nav-tab { padding: 0.5rem 1rem; border-radius: 0.375rem; text-decoration: none; color: var(--text-color); background: #f3f4f6; }
        .nav-tab.active { background: var(--primary-color); color: white; }
        .booking-card { background: white; border-radius: 0.75rem; box-shadow: 0 2px 8px rgba(0,0,0,0.05); margin-bottom: 1rem; overflow: hidden; }
        .booking-card-header { display: flex; justify-content: space-between; align-items: center; padding: 1rem; background: #f9fafb; border-bottom: 1px solid #eee; }
        .booking-code { font-weight: 700; color: var(--primary-dark); }
        .booking-date { color: #666; font-size: 0.875rem; }
        .booking-card-body { padding: 1rem; display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; }
        .booking-info label { display: block; font-size: 0.75rem; color: #999; margin-bottom: 0.25rem; }
        .booking-info span { font-weight: 500; }
        .status-badge { padding: 0.25rem 0.75rem; border-radius: 1rem; font-size: 0.75rem; font-weight: 600; }
        .status-PENDING { background: #fef3c7; color: #d97706; }
        .status-CONFIRMED { background: #dcfce7; color: #16a34a; }
        .empty-state { text-align: center; padding: 3rem; color: #999; }
        .empty-state h3 { margin-bottom: 0.5rem; }
    </style>
    <script>
        function getStatusText(status) {
            const map = {'PENDING':'Chờ duyệt','CONFIRMED':'Đã xác nhận','COMPLETED':'Hoàn thành','CANCELLED':'Đã hủy'};
            return map[status] || status;
        }
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('.status-badge').forEach(el => {
                el.textContent = getStatusText(el.textContent.trim());
            });
        });
    </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="booking-container">
    <div class="page-header">
        <h1 class="page-title">📋 Lịch hẹn của tôi</h1>
        <a href="${pageContext.request.contextPath}/staff/dashboard" class="btn btn-secondary">← Dashboard</a>
    </div>

    <div class="nav-tabs">
        <a href="${pageContext.request.contextPath}/staff/booking" class="nav-tab">Tất cả</a>
        <a href="${pageContext.request.contextPath}/staff/booking/my" class="nav-tab active">Lịch của tôi</a>
        <a href="${pageContext.request.contextPath}/staff/booking/notifications" class="nav-tab">Thông báo</a>
    </div>

    <c:if test="${empty bookings}">
    <div class="empty-state">
        <h3>Chưa có lịch hẹn nào được gán cho bạn</h3>
        <p>Các lịch hẹn được gán sẽ hiển thị ở đây</p>
    </div>
    </c:if>

    <c:forEach var="b" items="${bookings}">
    <div class="booking-card">
        <div class="booking-card-header">
            <span class="booking-code">#${b.bookingCode}</span>
            <span class="status-badge status-${b.status}">${b.status}</span>
        </div>
        <div class="booking-card-body">
            <div class="booking-info">
                <label>Khách hàng</label>
                <span>${b.customerName} - ${b.phone}</span>
            </div>
            <div class="booking-info">
                <label>Dịch vụ</label>
                <span>${b.serviceNames}</span>
            </div>
            <div class="booking-info">
                <label>Ngày hẹn</label>
                <span>${b.bookingDate}</span>
            </div>
            <div class="booking-info">
                <label>Giờ hẹn</label>
                <span>${b.bookingTime}</span>
            </div>
            <div class="booking-info">
                <label>Chi nhánh</label>
                <span>${b.location.name}</span>
            </div>
            <div class="booking-info">
                <a href="${pageContext.request.contextPath}/staff/booking/${b.id}" class="btn btn-primary btn-sm">Xem chi tiết →</a>
            </div>
        </div>
    </div>
    </c:forEach>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>
