<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông báo - Nailology</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .notif-container { max-width: 800px; margin: 2rem auto; padding: 0 1rem; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; }
        .page-title { font-size: 1.75rem; color: var(--primary-dark); margin: 0; }
        .nav-tabs { display: flex; gap: 0.5rem; margin-bottom: 1.5rem; }
        .nav-tab { padding: 0.5rem 1rem; border-radius: 0.375rem; text-decoration: none; color: var(--text-color); background: #f3f4f6; }
        .nav-tab.active { background: var(--primary-color); color: white; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
<div class="notif-container">
    <div class="page-header">
        <h1 class="page-title">🔔 Thông báo <c:if test="${unreadCount > 0}"><span style="font-size:1rem;color:#dc2626;">(${unreadCount} chưa đọc)</span></c:if></h1>
        <a href="${pageContext.request.contextPath}/staff/dashboard" class="btn btn-secondary">← Dashboard</a>
    </div>
    <div class="nav-tabs">
        <a href="${pageContext.request.contextPath}/staff/booking" class="nav-tab">Tất cả</a>
        <a href="${pageContext.request.contextPath}/staff/booking/my" class="nav-tab">Lịch của tôi</a>
        <a href="${pageContext.request.contextPath}/staff/booking/notifications" class="nav-tab active">Thông báo</a>
    </div>

    <c:if test="${unreadCount > 0}">
    <form action="${pageContext.request.contextPath}/staff/booking/notifications/read-all" method="post" style="margin-bottom:1rem;">
        <button type="submit" class="btn btn-secondary btn-sm">Đánh dấu tất cả đã đọc</button>
    </form>
    </c:if>

    <c:if test="${empty notifications}">
    <div style="text-align:center;padding:3rem;color:#999;">
        <h3>Không có thông báo nào</h3>
    </div>
    </c:if>

    <c:forEach var="n" items="${notifications}">
    <div style="background:${n.isRead ? 'white' : '#fffbeb'};border-radius:0.5rem;padding:1rem;margin-bottom:0.75rem;box-shadow:0 2px 8px rgba(0,0,0,0.05);display:flex;justify-content:space-between;align-items:flex-start;">
        <div>
            <div style="font-weight:600;color:var(--primary-dark);margin-bottom:0.25rem;">${n.title}</div>
            <div style="color:#666;font-size:0.875rem;">${n.message}</div>
            <div style="color:#999;font-size:0.75rem;margin-top:0.5rem;">${n.createdAt}</div>
        </div>
        <c:if test="${!n.isRead}">
        <form action="${pageContext.request.contextPath}/staff/booking/notifications/${n.id}/read" method="post">
            <button type="submit" style="background:none;border:none;color:var(--primary-color);cursor:pointer;font-size:0.75rem;">Đánh dấu đã đọc</button>
        </form>
        </c:if>
    </div>
    </c:forEach>
</div>
<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>