<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử dịch vụ - ${customer.fullName}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        .staff-container { max-width: 900px; margin: 2rem auto; padding: 0 1rem; }
        .breadcrumb { margin-bottom: 1rem; }
        .breadcrumb a { color: var(--primary-color); text-decoration: none; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 2rem; }
        .page-title { font-size: 1.75rem; color: var(--primary-dark); margin: 0; }
        .history-table { width: 100%; border-collapse: collapse; background: var(--white); border-radius: 0.5rem; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .history-table th { background: var(--primary-color); color: white; padding: 1rem; text-align: left; }
        .history-table td { padding: 1rem; border-bottom: 1px solid var(--border-color); }
        .history-table tr:hover { background: #faf7f4; }
        .status-badge { padding: 0.25rem 0.5rem; border-radius: 0.25rem; font-size: 0.75rem; font-weight: 600; }
        .status-completed { background: #dcfce7; color: #166534; }
        .status-pending { background: #fef3c7; color: #92400e; }
        .status-cancelled { background: #fee2e2; color: #dc2626; }
        .empty-state { text-align: center; padding: 3rem; color: var(--text-light); background: var(--white); border-radius: 0.5rem; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="staff-container">
    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/staff/dashboard">Dashboard</a> / 
        <a href="${pageContext.request.contextPath}/staff/customer">Khách hàng</a> / 
        <a href="${pageContext.request.contextPath}/staff/customer/${customer.id}">${customer.fullName}</a> / 
        Lịch sử
    </div>

    <div class="page-header">
        <h1 class="page-title">Lịch sử dịch vụ - ${customer.fullName}</h1>
        <a href="${pageContext.request.contextPath}/staff/customer/${customer.id}" class="btn btn-secondary">← Quay lại</a>
    </div>

    <c:if test="${not empty serviceHistory}">
    <table class="history-table">
        <thead>
            <tr>
                <th>Ngày</th>
                <th>Giờ</th>
                <th>Dịch vụ</th>
                <th>Chi nhánh</th>
                <th>Tổng tiền</th>
                <th>Trạng thái</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${serviceHistory}" var="b">
                <tr>
                    <td><fmt:formatDate value="${b.bookingDate}" pattern="dd/MM/yyyy"/></td>
                    <td>${b.bookingTime}</td>
                    <td>${b.serviceNames}</td>
                    <td>${b.location != null ? b.location.name : 'N/A'}</td>
                    <td><fmt:formatNumber value="${b.totalPrice}" type="currency" currencySymbol="$"/></td>
                    <td>
                        <span class="status-badge status-${b.status == 'COMPLETED' ? 'completed' : (b.status == 'CANCELLED' ? 'cancelled' : 'pending')}">
                            ${b.status}
                        </span>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </c:if>

    <c:if test="${empty serviceHistory}">
    <div class="empty-state">
        <p>Khách hàng chưa có lịch sử dịch vụ nào.</p>
        <a href="${pageContext.request.contextPath}/booking?customerId=${customer.id}" class="btn btn-primary" style="margin-top:1rem">Đặt lịch ngay</a>
    </div>
    </c:if>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>
