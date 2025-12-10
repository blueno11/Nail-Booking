<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách lịch - Nailology</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="../layout/header.jsp" />
<div class="container">
    <div class="page-header">
        <div>
            <h1>📋 Danh sách đặt lịch</h1>
            <p>Quản lý và kiểm tra các booking</p>
        </div>
        <a href="${pageContext.request.contextPath}/booking" class="btn btn-primary">+ Đặt Lịch Mới</a>
    </div>

    <c:if test="${empty bookings}">
        <div class="empty-state">
            <div class="empty-state-icon">📭</div>
            <div class="empty-state-title">Không có lịch</div>
            <div class="empty-state-text">Chưa có booking nào được tạo.</div>
        </div>
    </c:if>

    <c:if test="${not empty bookings}">
        <table style="width:100%;border-collapse:collapse;">
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
                        <td>${b.id}</td>
                        <td>${b.customer != null ? b.customer.fullName : b.customerName}</td>
                        <td><fmt:formatDate value="${b.bookingDateTime}" pattern="dd/MM/yyyy HH:mm"/></td>
                        <td>${b.location != null ? b.location.name : '-'}</td>
                        <td>${b.staff != null ? b.staff.name : '-'}</td>
                        <td><fmt:formatNumber value="${b.totalAmount}" type="currency" currencySymbol="đ"/></td>
                        <td>${b.status}</td>
                        <td>
                            <a class="btn" href="${pageContext.request.contextPath}/booking/${b.id}">Xem</a>
                            <a class="btn" href="${pageContext.request.contextPath}/booking/${b.id}/edit">Sửa</a>
                            <form action="${pageContext.request.contextPath}/booking/${b.id}/cancel" method="post" style="display:inline;">
                                <button class="btn" type="submit" onclick="return confirm('Bạn có chắc muốn huỷ booking này?');">Huỷ</button>
                            </form>
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