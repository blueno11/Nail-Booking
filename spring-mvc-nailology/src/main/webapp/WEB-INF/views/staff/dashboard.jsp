<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Staff Dashboard - Nailology</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        .dashboard-container { max-width: 1200px; margin: 2rem auto; padding: 0 1rem; }
        .dashboard-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; flex-wrap: wrap; gap: 1rem; }
        .dashboard-title { font-size: 2rem; color: var(--primary-dark); margin: 0; }
        .user-info { display: flex; align-items: center; gap: 1rem; }
        .user-name { font-weight: 600; color: var(--primary-dark); }
        .user-role { font-size: 0.75rem; padding: 0.25rem 0.5rem; background: var(--primary-color); color: white; border-radius: 0.25rem; }
        .dashboard-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 1.5rem; }
        .dashboard-card { background: var(--white); padding: 1.5rem; border-radius: 0.75rem; box-shadow: 0 4px 15px rgba(0,0,0,0.05); transition: transform 0.3s, box-shadow 0.3s; }
        .dashboard-card:hover { transform: translateY(-5px); box-shadow: 0 8px 25px rgba(0,0,0,0.1); }
        .card-icon { width: 50px; height: 50px; border-radius: 0.5rem; display: flex; align-items: center; justify-content: center; font-size: 1.5rem; margin-bottom: 1rem; }
        .card-icon.customers { background: #dbeafe; color: #2563eb; }
        .card-icon.bookings { background: #dcfce7; color: #16a34a; }
        .card-icon.services { background: #fef3c7; color: #d97706; }
        .card-icon.admin { background: #f3e8ff; color: #9333ea; }
        .card-title { font-size: 1.125rem; font-weight: 600; color: var(--primary-dark); margin-bottom: 0.5rem; }
        .card-desc { color: var(--text-light); font-size: 0.875rem; margin-bottom: 1rem; }
        .card-link { color: var(--primary-color); text-decoration: none; font-weight: 500; }
        .card-link:hover { text-decoration: underline; }
        .alert { padding: 1rem; border-radius: 0.5rem; margin-bottom: 1.5rem; }
        .alert-error { background: #fee2e2; color: #dc2626; }
        .quick-stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(150px, 1fr)); gap: 1rem; margin-bottom: 2rem; }
        .stat-card { background: var(--white); padding: 1rem; border-radius: 0.5rem; text-align: center; box-shadow: 0 2px 8px rgba(0,0,0,0.05); }
        .stat-value { font-size: 1.5rem; font-weight: 700; color: var(--primary-color); }
        .stat-label { font-size: 0.75rem; color: var(--text-light); margin-top: 0.25rem; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="dashboard-container">
    <div class="dashboard-header">
        <h1 class="dashboard-title">Staff Dashboard</h1>
        <div class="user-info">
            <span class="user-name">Xin chào, ${staffName}</span>
            <span class="user-role">${staffRole}</span>
            <a href="${pageContext.request.contextPath}/staff/logout" class="btn btn-secondary btn-sm">Đăng xuất</a>
        </div>
    </div>

    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>

    <div class="dashboard-grid">
        <!-- Quản lý khách hàng -->
        <div class="dashboard-card">
            <div class="card-icon customers">👥</div>
            <h3 class="card-title">Quản lý Khách hàng</h3>
            <p class="card-desc">Xem hồ sơ, lịch sử dịch vụ, tuỳ chọn marketing</p>
            <a href="${pageContext.request.contextPath}/staff/customer" class="card-link">Xem danh sách →</a>
        </div>

        <!-- Quản lý Booking -->
        <div class="dashboard-card">
            <div class="card-icon bookings">📅</div>
            <h3 class="card-title">Quản lý Lịch hẹn</h3>
            <p class="card-desc">Duyệt, gán nhân viên, quản lý lịch hẹn</p>
            <div style="display:flex; flex-direction:column; gap:0.5rem;">
                <a href="${pageContext.request.contextPath}/staff/booking" class="card-link">Tất cả lịch hẹn →</a>
                <a href="${pageContext.request.contextPath}/staff/booking/my" class="card-link">Lịch của tôi →</a>
                <a href="${pageContext.request.contextPath}/staff/booking/notifications" class="card-link">
                    Thông báo <c:if test="${unreadNotifications > 0}"><span style="background:#dc2626;color:white;padding:0.125rem 0.5rem;border-radius:1rem;font-size:0.75rem;margin-left:0.25rem;">${unreadNotifications}</span></c:if> →
                </a>
            </div>
        </div>

        <!-- Thống kê khách hàng -->
        <div class="dashboard-card">
            <div class="card-icon services">📊</div>
            <h3 class="card-title">Thống kê</h3>
            <p class="card-desc">Khách hàng mới, top chi tiêu, marketing</p>
            <div style="display:flex; flex-direction:column; gap:0.5rem;">
                <a href="${pageContext.request.contextPath}/staff/customer/top-spenders" class="card-link">Top chi tiêu →</a>
                <a href="${pageContext.request.contextPath}/staff/customer/new?days=30" class="card-link">Khách mới →</a>
                <a href="${pageContext.request.contextPath}/staff/customer?marketing=true" class="card-link">Danh sách marketing →</a>
            </div>
        </div>

        <!-- Admin Panel (chỉ hiện nếu là ADMIN) -->
        <c:if test="${staffRole == 'ADMIN'}">
        <div class="dashboard-card">
            <div class="card-icon admin">⚙️</div>
            <h3 class="card-title">Quản trị hệ thống</h3>
            <p class="card-desc">Quản lý dịch vụ, chi nhánh, nhân viên</p>
            <div style="display:flex; flex-direction:column; gap:0.5rem;">
                <a href="${pageContext.request.contextPath}/admin/services" class="card-link">Dịch vụ →</a>
                <a href="${pageContext.request.contextPath}/admin/locations" class="card-link">Chi nhánh →</a>
                <a href="${pageContext.request.contextPath}/admin/staff" class="card-link">Nhân viên →</a>
                <a href="${pageContext.request.contextPath}/admin/gallery" class="card-link">Gallery →</a>
            </div>
        </div>
        </c:if>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>
