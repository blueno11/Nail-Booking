<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Lịch Hẹn - Nailology</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
    <jsp:include page="layout/header.jsp" />

    <main class="booking-main">
        <div class="container">
            <div class="manage-card">
                <h1 class="page-title">Quản Lý Lịch Hẹn</h1>
                <p class="page-subtitle">Nhập thông tin để tra cứu lịch hẹn của bạn</p>
                
                <c:if test="${not empty success}">
                    <div class="alert alert-success">${success}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-error">${error}</div>
                </c:if>

                <div class="search-tabs">
                    <button type="button" class="search-tab active" data-tab="byCode">Tìm theo mã</button>
                    <button type="button" class="search-tab" data-tab="byEmail">Tìm theo email</button>
                </div>

                <form action="${pageContext.request.contextPath}/booking/search" method="post" class="search-form" id="searchByCode">
                    <div class="form-group">
                        <label for="bookingCode">Mã đặt lịch <span class="required">*</span></label>
                        <input type="text" name="bookingCode" id="bookingCode" class="form-control" 
                               placeholder="Nhập mã đặt lịch (VD: NL12345678)">
                    </div>
                    <button type="submit" class="btn btn-primary btn-full">Tìm Lịch Hẹn</button>
                </form>

                <form action="${pageContext.request.contextPath}/booking/search" method="post" class="search-form" id="searchByEmail" style="display:none;">
                    <div class="form-group">
                        <label for="email">Email <span class="required">*</span></label>
                        <input type="email" name="email" id="email" class="form-control" 
                               placeholder="Nhập email đã dùng khi đặt lịch">
                    </div>

                    <div class="form-group">
                        <label for="phone">Số điện thoại (tùy chọn)</label>
                        <input type="tel" name="phone" id="phone" class="form-control" 
                               placeholder="Nhập số điện thoại để lọc chính xác hơn">
                    </div>

                    <button type="submit" class="btn btn-primary btn-full">Tìm Lịch Hẹn</button>
                </form>

                <script>
                    document.querySelectorAll('.search-tab').forEach(tab => {
                        tab.addEventListener('click', function() {
                            document.querySelectorAll('.search-tab').forEach(t => t.classList.remove('active'));
                            this.classList.add('active');
                            const tabName = this.getAttribute('data-tab');
                            document.getElementById('searchByCode').style.display = tabName === 'byCode' ? 'block' : 'none';
                            document.getElementById('searchByEmail').style.display = tabName === 'byEmail' ? 'block' : 'none';
                        });
                    });
                </script>

                <div class="manage-links">
                    <a href="${pageContext.request.contextPath}/booking" class="link-booking">← Đặt lịch mới</a>
                </div>
            </div>
        </div>
    </main>

    <jsp:include page="layout/footer.jsp" />
</body>
</html>
