<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt Lịch Thành Công - Nailology</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
    <jsp:include page="layout/header.jsp" />

    <main class="booking-main">
        <div class="container">
            <div class="success-card">
                <div class="success-icon">✓</div>
                <h1 class="success-title">Đặt Lịch Thành Công!</h1>
                <p class="success-message">Cảm ơn bạn đã đặt lịch tại Nailology.</p>
                
                <c:if test="${not empty bookingCode}">
                    <div class="booking-code-box">
                        <p class="booking-code-label">Mã đặt lịch của bạn:</p>
                        <p class="booking-code">${bookingCode}</p>
                        <p class="booking-code-note">Vui lòng lưu lại mã này để tra cứu hoặc quản lý lịch hẹn.</p>
                    </div>
                </c:if>
                
                <p class="success-info">Chúng tôi sẽ gửi email xác nhận đến địa chỉ email của bạn.</p>
                
                <div class="success-actions">
                    <a href="${pageContext.request.contextPath}/booking/manage" class="btn btn-secondary">Quản lý lịch hẹn</a>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Về trang chủ</a>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="layout/footer.jsp" />
</body>
</html>
