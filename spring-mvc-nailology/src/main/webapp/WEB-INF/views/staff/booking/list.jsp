<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Lịch hẹn - Nailology</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .booking-container { max-width: 1200px; margin: 2rem auto; padding: 0 1rem; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; flex-wrap: wrap; gap: 1rem; }
        .page-title { font-size: 1.75rem; color: var(--primary-dark); margin: 0; }
        .filter-bar { display: flex; gap: 1rem; flex-wrap: wrap; margin-bottom: 1.5rem; }
        .filter-bar select, .filter-bar input { padding: 0.5rem; border: 1px solid #ddd; border-radius: 0.375rem; }
        .stats-row { display: flex; gap: 1rem; margin-bottom: 1.5rem; }
        .stat-badge { padding: 0.5rem 1rem; border-radius: 0.5rem; font-weight: 600; }
        .stat-pending { background: #fef3c7; color: #d97706; }
        .stat-confirmed { background: #dcfce7; color: #16a34a; }
        .booking-table { width: 100%; border-collapse: collapse; background: white; border-radius: 0.5rem; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.05); }
        .booking-table th, .booking-table td { padding: 1rem; text-align: left; border-bottom: 1px solid #eee; }
        .booking-table th { background: var(--primary-color); color: white; font-weight: 600; }
        .booking-table tr:hover { background: #f9fafb; }
        .status-badge { padding: 0.25rem 0.75rem; border-radius: 1rem; font-size: 0.75rem; font-weight: 600; }
        .status-PENDING { background: #fef3c7; color: #d97706; }
        .status-CONFIRMED { background: #dcfce7; color: #16a34a; }
        .status-COMPLETED { background: #dbeafe; color: #2563eb; }
        .status-CANCELLED { background: #fee2e2; color: #dc2626; }
        .btn-view { padding: 0.375rem 0.75rem; background: var(--primary-color); color: white; border-radius: 0.25rem; text-decoration: none; font-size: 0.875rem; }
        .btn-view:hover { background: var(--primary-dark); }
        .nav-tabs { display: flex; gap: 0.5rem; margin-bottom: 1rem; }
        .nav-tab { padding: 0.5rem 1rem; border-radius: 0.375rem; text-decoration: none; color: var(--text-color); background: #f3f4f6; }
        .nav-tab.active { background: var(--primary-color); color: white; }
        .alert { padding: 1rem; border-radius: 0.5rem; margin-bottom: 1rem; }
        .alert-success { background: #dcfce7; color: #16a34a; }
        .alert-error { background: #fee2e2; color: #dc2626; }
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
        <h1 class="page-title">📅 Quản lý Lịch hẹn</h1>
        <a href="${pageContext.request.contextPath}/staff/dashboard" class="btn btn-secondary">← Dashboard</a>
    </div>

    <div class="nav-tabs">
        <a href="${pageContext.request.contextPath}/staff/booking" class="nav-tab active">Tất cả</a>
        <a href="${pageContext.request.contextPath}/staff/booking/my" class="nav-tab">Lịch của tôi</a>
        <a href="${pageContext.request.contextPath}/staff/booking/notifications" class="nav-tab">Thông báo</a>
    </div>

    <c:if test="${not empty success}">
        <div class="alert alert-success">${success}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>

    <div class="stats-row">
        <span class="stat-badge stat-pending">⏳ Chờ duyệt: ${pendingCount}</span>
        <span class="stat-badge stat-confirmed">✅ Đã xác nhận: ${confirmedCount}</span>
    </div>

    <form class="filter-bar" method="get">
        <select name="status">
            <option value="">-- Trạng thái --</option>
            <option value="PENDING" ${selectedStatus == 'PENDING' ? 'selected' : ''}>Chờ duyệt</option>
            <option value="CONFIRMED" ${selectedStatus == 'CONFIRMED' ? 'selected' : ''}>Đã xác nhận</option>
            <option value="COMPLETED" ${selectedStatus == 'COMPLETED' ? 'selected' : ''}>Hoàn thành</option>
            <option value="CANCELLED" ${selectedStatus == 'CANCELLED' ? 'selected' : ''}>Đã hủy</option>
        </select>
        <input type="date" name="date" value="${selectedDate}" />
        <button type="submit" class="btn btn-primary">Lọc</button>
        <a href="${pageContext.request.contextPath}/staff/booking" class="btn btn-secondary">Reset</a>
    </form>

    <table class="booking-table">
        <thead>
            <tr>
                <th>Mã</th>
                <th>Khách hàng</th>
                <th>Dịch vụ</th>
                <th>Chi nhánh</th>
                <th>Ngày</th>
                <th>Giờ</th>
                <th>Trạng thái</th>
                <th>NV phục vụ</th>
                <th></th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="b" items="${bookings}">
            <tr>
                <td><strong>${b.bookingCode}</strong></td>
                <td>${b.customerName}<br><small>${b.phone}</small></td>
                <td>${b.serviceNames}</td>
                <td>${b.location.name}</td>
                <td>${b.bookingDate}</td>
                <td>${b.bookingTime}</td>
                <td><span class="status-badge status-${b.status}">${b.status}</span></td>
                <td>${b.assignedStaff != null ? b.assignedStaff.name : '-'}</td>
                <td><a href="${pageContext.request.contextPath}/staff/booking/${b.id}" class="btn-view">Xem</a></td>
            </tr>
            </c:forEach>
            <c:if test="${empty bookings}">
            <tr><td colspan="9" style="text-align:center; padding:2rem; color:#999;">Không có lịch hẹn nào</td></tr>
            </c:if>
        </tbody>
    </table>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>
