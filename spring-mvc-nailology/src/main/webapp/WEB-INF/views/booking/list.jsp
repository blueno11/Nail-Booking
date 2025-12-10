<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách lịch - Nailology</title>
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
            --success: #28a745;
            --warning: #ffc107;
            --danger: #dc3545;
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { background: linear-gradient(135deg, #f5f1ed 0%, #faf8f6 100%); font-family: 'Lora', serif; color: var(--dark); min-height: 100vh; }
        .container { max-width: 1400px; margin: 0 auto; padding: 40px 20px; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; padding-bottom: 30px; border-bottom: 2px solid var(--primary); }
        .page-header h1 { font-family: 'Playfair Display', serif; font-size: 42px; font-weight: 600; color: var(--dark); }
        .page-header p { color: #999; font-size: 14px; margin-top: 5px; }
        .btn { padding: 12px 24px; border-radius: 8px; border: none; cursor: pointer; font-family: 'Lora', serif; font-size: 14px; font-weight: 500; transition: all 0.3s ease; text-decoration: none; display: inline-block; }
        .btn-primary { background: linear-gradient(135deg, var(--primary) 0%, #a9886b 100%); color: white; box-shadow: 0 4px 15px rgba(196, 160, 128, 0.3); }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(196, 160, 128, 0.4); }
        .btn-secondary { background: white; color: var(--primary); border: 2px solid var(--primary); padding: 8px 16px; font-size: 12px; }
        .btn-secondary:hover { background: var(--primary); color: white; }
        .btn-danger { background: rgba(220, 53, 69, 0.1); color: var(--danger); padding: 8px 16px; font-size: 12px; }
        .btn-danger:hover { background: var(--danger); color: white; }
        
        .booking-table { width: 100%; border-collapse: collapse; background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05); }
        .booking-table thead { background: linear-gradient(135deg, var(--light-bg) 0%, #faf8f6 100%); border-bottom: 2px solid var(--border); }
        .booking-table th { padding: 16px; text-align: left; font-weight: 600; color: var(--dark); font-size: 13px; text-transform: uppercase; letter-spacing: 0.5px; }
        .booking-table td { padding: 16px; border-bottom: 1px solid var(--border); }
        .booking-table tbody tr:hover { background: rgba(196, 160, 128, 0.03); }
        
        .status-badge { display: inline-block; padding: 6px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px; }
        .status-pending { background: rgba(255, 193, 7, 0.1); color: #ffc107; }
        .status-confirmed { background: rgba(40, 167, 69, 0.1); color: var(--success); }
        .status-completed { background: rgba(52, 152, 219, 0.1); color: #3498db; }
        .status-cancelled { background: rgba(220, 53, 69, 0.1); color: var(--danger); }
        
        .empty-state { text-align: center; padding: 60px 20px; }
        .empty-state-icon { font-size: 64px; margin-bottom: 20px; opacity: 0.3; }
        .empty-state-title { font-family: 'Playfair Display', serif; font-size: 24px; color: var(--dark); margin-bottom: 10px; }
        .empty-state-text { color: #999; margin-bottom: 30px; }
        
        .amount { font-family: 'Playfair Display', serif; font-weight: 600; color: var(--primary); }
        .action-buttons { display: flex; gap: 6px; flex-wrap: wrap; }
        
        @media (max-width: 768px) {
            .page-header { flex-direction: column; align-items: flex-start; gap: 16px; }
            .page-header h1 { font-size: 32px; }
            .booking-table { font-size: 12px; }
            .booking-table th, .booking-table td { padding: 12px; }
            .action-buttons { flex-direction: column; }
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp" />
<div class="container">
    <div class="page-header">
        <div>
            <h1>📋 Danh sách Lịch</h1>
            <p>Quản lý và kiểm tra các booking</p>
        </div>
        <a href="${pageContext.request.contextPath}/booking" class="btn btn-primary">+ Đặt Lịch Mới</a>
    </div>

    <c:if test="${empty bookings}">
        <div class="empty-state">
            <div class="empty-state-icon">📭</div>
            <div class="empty-state-title">Không có lịch</div>
            <div class="empty-state-text">Chưa có booking nào được tạo. Hãy tạo booking đầu tiên của bạn!</div>
            <a href="${pageContext.request.contextPath}/booking" class="btn btn-primary">+ Đặt Lịch Mới</a>
        </div>
    </c:if>

    <c:if test="${not empty bookings}">
        <table class="booking-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Khách</th>
                    <th>Ngày & Giờ</th>
                    <th>Chi nhánh</th>
                    <th>Kỹ thuật viên</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="b" items="${bookings}">
                    <tr>
                        <td>#${b.id}</td>
                        <td><strong>${b.customer != null ? b.customer.fullName : 'Khách vãng lai'}</strong></td>
                        <td><fmt:formatDate value="${b.bookingDateTime}" pattern="dd/MM/yyyy HH:mm"/></td>
                        <td>${b.location != null ? b.location.name : '-'}</td>
                        <td>${b.staff != null ? b.staff.name : '-'}</td>
                        <td class="amount"><fmt:formatNumber value="${b.totalAmount}" type="currency" currencySymbol="đ"/></td>
                        <td>
                            <span class="status-badge status-${fn:toLowerCase(b.status)}">
                                <c:choose>
                                    <c:when test="${b.status == 'PENDING'}">Chờ xác nhận</c:when>
                                    <c:when test="${b.status == 'CONFIRMED'}">Xác nhận</c:when>
                                    <c:when test="${b.status == 'COMPLETED'}">Hoàn thành</c:when>
                                    <c:when test="${b.status == 'CANCELLED'}">Đã huỷ</c:when>
                                    <c:otherwise>${b.status}</c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                        <td>
                            <div class="action-buttons">
                                <a class="btn btn-secondary" href="${pageContext.request.contextPath}/booking/${b.id}">Xem</a>
                                <a class="btn btn-secondary" href="${pageContext.request.contextPath}/booking/${b.id}/edit">Sửa</a>
                                <c:if test="${b.status != 'CANCELLED'}">
                                    <form action="${pageContext.request.contextPath}/booking/${b.id}/cancel" method="post" style="display:inline;">
                                        <button class="btn btn-danger" type="submit" onclick="return confirm('Bạn có chắc muốn huỷ booking này?');">Huỷ</button>
                                    </form>
                                </c:if>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>
<jsp:include page="../layout/footer.jsp" />
</body>
</html>