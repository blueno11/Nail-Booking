<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết booking - Nailology</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="../layout/header.jsp" />

<div class="container">
    <div class="page-header">
        <div>
            <h1>📘 Booking #${booking.id}</h1>
            <p>Chi tiết đặt lịch</p>
        </div>
        <a href="${pageContext.request.contextPath}/booking/list" class="btn btn-secondary">← Quay lại</a>
    </div>

    <div class="card">
        <div class="card-title">Thông tin cơ bản</div>
        <div class="info-row"><div class="info-label">Khách:</div><div class="info-value">${booking.customer != null ? booking.customer.fullName : 'Khách vãng lai'}</div></div>
        <div class="info-row"><div class="info-label">SĐT:</div><div class="info-value">${booking.customer != null ? booking.customer.phoneNumber : '-'}</div></div>
        <div class="info-row"><div class="info-label">Ngày & Giờ:</div><div class="info-value"><fmt:formatDate value="${booking.bookingDateTime}" pattern="dd/MM/yyyy HH:mm"/></div></div>
        <div class="info-row"><div class="info-label">Chi nhánh:</div><div class="info-value">${booking.location != null ? booking.location.name : '-'}</div></div>
        <div class="info-row"><div class="info-label">Kỹ thuật viên:</div><div class="info-value">${booking.staff != null ? booking.staff.name : '-'}</div></div>
        <div class="info-row"><div class="info-label">Dịch vụ:</div><div class="info-value">
            <ul>
                <c:forEach var="s" items="${booking.services}">
                    <li>${s.name} - <fmt:formatNumber value="${s.startingPrice}" type="currency" currencySymbol="đ"/></li>
                </c:forEach>
            </ul>
        </div></div>
        <div class="info-row"><div class="info-label">Tổng tiền:</div><div class="info-value"><fmt:formatNumber value="${booking.totalAmount}" type="currency" currencySymbol="đ"/></div></div>
        <div class="info-row"><div class="info-label">Trạng thái:</div><div class="info-value">${booking.status}</div></div>

        <div style="margin-top:16px;">
            <a class="btn btn-primary" href="${pageContext.request.contextPath}/booking/${booking.id}/edit">Sửa</a>
            <form action="${pageContext.request.contextPath}/booking/${booking.id}/cancel" method="post" style="display:inline;">
                <button class="btn" type="submit" onclick="return confirm('Huỷ booking?');">Huỷ</button>
            </form>
        </div>
    </div>

</div>

<jsp:include page="../layout/footer.jsp" />
</body>
</html>