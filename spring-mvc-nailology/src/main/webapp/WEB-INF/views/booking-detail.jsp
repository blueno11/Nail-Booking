<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Lịch Hẹn - Nailology</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
    <jsp:include page="layout/header.jsp" />

    <main class="booking-main">
        <div class="container">
            <c:if test="${not empty success}">
                <div class="alert alert-success">${success}</div>
            </c:if>
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <div class="detail-card">
                <div class="detail-header">
                    <h1 class="page-title">Chi Tiết Lịch Hẹn</h1>
                    <span class="booking-status status-${booking.status.toString().toLowerCase()}">
                        <c:choose>
                            <c:when test="${booking.status == 'PENDING'}">Chờ xác nhận</c:when>
                            <c:when test="${booking.status == 'CONFIRMED'}">Đã xác nhận</c:when>
                            <c:when test="${booking.status == 'CANCELLED'}">Đã hủy</c:when>
                            <c:when test="${booking.status == 'COMPLETED'}">Hoàn thành</c:when>
                        </c:choose>
                    </span>
                </div>

                <div class="detail-section">
                    <h2>Thông Tin Đặt Lịch</h2>
                    <div class="detail-grid">
                        <div class="detail-item">
                            <span class="detail-label">Mã đặt lịch:</span>
                            <span class="detail-value booking-code">${booking.bookingCode}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Ngày hẹn:</span>
                            <span class="detail-value">${booking.bookingDate}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Giờ hẹn:</span>
                            <span class="detail-value">${booking.bookingTime}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Chi nhánh:</span>
                            <span class="detail-value">${booking.location.name} - ${booking.location.suburb}</span>
                        </div>
                    </div>
                </div>

                <div class="detail-section">
                    <h2>Dịch Vụ Đã Chọn</h2>
                    <p class="detail-services">${booking.serviceNames}</p>
                    <div class="detail-summary">
                        <span>Tổng thời gian: ${booking.totalDurationMinutes} phút</span>
                        <span class="detail-total">Tổng tiền: ${booking.totalPrice} AUD</span>
                    </div>
                </div>

                <div class="detail-section">
                    <h2>Thông Tin Khách Hàng</h2>
                    <div class="detail-grid">
                        <div class="detail-item">
                            <span class="detail-label">Họ tên:</span>
                            <span class="detail-value">${booking.customerName}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Email:</span>
                            <span class="detail-value">${booking.email}</span>
                        </div>
                        <div class="detail-item">
                            <span class="detail-label">Điện thoại:</span>
                            <span class="detail-value">${booking.phone}</span>
                        </div>
                        <c:if test="${not empty booking.message}">
                            <div class="detail-item full-width">
                                <span class="detail-label">Ghi chú:</span>
                                <span class="detail-value">${booking.message}</span>
                            </div>
                        </c:if>
                    </div>
                </div>


                <c:if test="${booking.status == 'PENDING' || booking.status == 'CONFIRMED'}">
                    <div class="detail-section">
                        <h2>Thay Đổi Lịch Hẹn</h2>
                        <form action="${pageContext.request.contextPath}/booking/update/${booking.id}" method="post" class="edit-form">
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="locationId">Chi nhánh</label>
                                    <select name="locationId" id="locationId" class="form-control">
                                        <c:forEach var="loc" items="${locations}">
                                            <option value="${loc.id}" ${loc.id == booking.location.id ? 'selected' : ''}>
                                                ${loc.name} - ${loc.suburb}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="date">Ngày hẹn</label>
                                    <input type="date" name="date" id="date" class="form-control" value="${booking.bookingDate}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Giờ hẹn</label>
                                <div class="time-slots">
                                    <c:forEach var="slot" items="${timeSlots}">
                                        <label class="time-slot">
                                            <input type="radio" name="time" value="${slot}" 
                                                   ${slot == booking.bookingTime.toString().substring(0,5) ? 'checked' : ''}>
                                            <span class="time-slot-label">${slot}</span>
                                        </label>
                                    </c:forEach>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="message">Ghi chú</label>
                                <textarea name="message" id="message" class="form-control" rows="2">${booking.message}</textarea>
                            </div>
                            <button type="submit" class="btn btn-primary">Cập Nhật Lịch Hẹn</button>
                        </form>
                    </div>
                </c:if>

                <div class="detail-actions">
                    <a href="${pageContext.request.contextPath}/booking/manage" class="btn btn-secondary">← Quay lại</a>
                    <c:if test="${(booking.status == 'PENDING' || booking.status == 'CONFIRMED') && !isPaid}">
        <a href="${pageContext.request.contextPath}/payment/create?bookingId=${booking.id}"
           class="btn btn-success">
            💳 Thanh Toán
        </a>
    </c:if>
                    <c:if test="${booking.status == 'PENDING' || booking.status == 'CONFIRMED'}">
                        <form action="${pageContext.request.contextPath}/booking/cancel/${booking.bookingCode}" 
                              method="post" style="display:inline;"
                              onsubmit="return confirm('Bạn có chắc muốn hủy lịch hẹn này?');">
                            <button type="submit" class="btn btn-danger">Hủy Lịch Hẹn</button>
                        </form>
                    </c:if>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="layout/footer.jsp" />
</body>
</html>
