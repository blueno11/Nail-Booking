<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Lịch Hẹn - Nailology</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
    <jsp:include page="layout/header.jsp" />

    <main class="booking-main">
        <div class="container">
            <h1 class="page-title">Lịch Hẹn Của Bạn</h1>
            <c:if test="${searchType == 'code'}">
                <p class="page-subtitle">Mã đặt lịch: ${bookingCode}</p>
            </c:if>
            <c:if test="${searchType == 'email'}">
                <p class="page-subtitle">Email: ${email}</p>
            </c:if>

            <c:if test="${empty bookings}">
                <div class="empty-state">
                    <p>Không tìm thấy lịch hẹn nào.</p>
                    <a href="${pageContext.request.contextPath}/booking" class="btn btn-primary">Đặt lịch ngay</a>
                </div>
            </c:if>

            <c:if test="${not empty bookings}">
                <div class="booking-list">
                    <c:forEach var="booking" items="${bookings}">
                        <div class="booking-card status-${booking.status.toString().toLowerCase()}">
                            <div class="booking-card-header">
                                <span class="booking-code-tag">#${booking.bookingCode}</span>
                                <span class="booking-status status-${booking.status.toString().toLowerCase()}">
                                    <c:choose>
                                        <c:when test="${booking.status == 'PENDING'}">Chờ xác nhận</c:when>
                                        <c:when test="${booking.status == 'CONFIRMED'}">Đã xác nhận</c:when>
                                        <c:when test="${booking.status == 'CANCELLED'}">Đã hủy</c:when>
                                        <c:when test="${booking.status == 'COMPLETED'}">Hoàn thành</c:when>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="booking-card-body">
                                <div class="booking-info">
                                    <p class="booking-datetime">
                                        <strong>📅</strong> ${booking.bookingDate} - ${booking.bookingTime}
                                    </p>
                                    <p class="booking-location">
                                        <strong>📍</strong> ${booking.location.name} - ${booking.location.suburb}
                                    </p>
                                    <p class="booking-services">
                                        <strong>💅</strong> ${booking.serviceNames}
                                    </p>
                                    <p class="booking-total">
                                        <strong>💰</strong> ${booking.totalPrice} AUD
                                    </p>
                                </div>
                            </div>
                            <div class="booking-card-footer">
                                <a href="${pageContext.request.contextPath}/booking/view/${booking.bookingCode}" 
                                   class="btn btn-secondary btn-sm">Xem chi tiết</a>
                                <c:if test="${booking.status == 'PENDING' || booking.status == 'CONFIRMED'}">
                                    <form action="${pageContext.request.contextPath}/booking/cancel/${booking.bookingCode}" 
                                          method="post" style="display:inline;" 
                                          onsubmit="return confirm('Bạn có chắc muốn hủy lịch hẹn này?');">
                                        <button type="submit" class="btn btn-danger btn-sm">Hủy lịch</button>
                                    </form>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <div class="page-actions">
                <a href="${pageContext.request.contextPath}/booking/manage" class="btn btn-secondary">← Tìm kiếm khác</a>
                <a href="${pageContext.request.contextPath}/booking" class="btn btn-primary">Đặt lịch mới</a>
            </div>
        </div>
    </main>

    <jsp:include page="layout/footer.jsp" />
</body>
</html>
