<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nailology - Tiệm Nails & Cà Phê Cao Cấp</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
</head>
<body>
    <jsp:include page="layout/header.jsp" />

    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-decoration"></div>
        <div class="container">
            <div class="hero-content">
                <h1 class="hero-title">
                    Trải Nghiệm Mới Với<br/>Nails & Coffee Culture
                </h1>
                <p class="hero-description">
                    Chăm sóc bản thân, thư giãn tâm hồn. Tại Nailology, chúng tôi mang đến cho bạn một không gian thoải mái để làm đẹp và thưởng thức cà phê chất lượng cao.
                </p>
                <a href="${pageContext.request.contextPath}/booking" class="btn btn-primary btn-large">Đặt Lịch Hẹn Ngay</a>
            </div>
        </div>
    </section>

    <!-- Location Selector -->
    <section class="location-selector">
        <div class="container">
            <div class="section-header">
                <p class="section-label">ĐẶT LỊCH</p>
                <h2 class="section-title">Giữ Lại Thời Gian Của Bạn</h2>
                <p class="section-description">
                    Tiết kiệm thời gian và đặt trước dịch vụ của bạn để có một trải nghiệm mượt mà
                </p>
            </div>
            <div class="location-grid">
                <div class="location-card">
                    <div class="location-content">
                        <p class="location-name">KEW</p>
                        <p class="location-code">3104</p>
                    </div>
                </div>
                <div class="location-card">
                    <div class="location-content">
                        <p class="location-name">ALPHINGTON</p>
                        <p class="location-code">3078</p>
                    </div>
                </div>
                <div class="location-card">
                    <div class="location-content">
                        <p class="location-name">TRUGANINA</p>
                        <p class="location-code">3029</p>
                    </div>
                </div>
                <div class="location-card">
                    <div class="location-content">
                        <p class="location-name">HAMPTON</p>
                        <p class="location-code">3188</p>
                    </div>
                </div>
            </div>
            <div class="text-center">
                <a href="${pageContext.request.contextPath}/booking" class="btn btn-primary">Đặt Lịch Ngay</a>
            </div>
        </div>
    </section>

    <!-- Services Section -->
    <section id="services" class="services">
        <div class="container">
            <div class="section-header">
                <p class="section-label">DỊCH VỤ</p>
                <h2 class="section-title">Dịch Vụ Của Chúng Tôi</h2>
            </div>
            <div class="services-grid">
                <div class="service-card">
                    <div class="service-header">
                        <h3 class="service-name">Làm Móng Tay</h3>
                        <span class="service-price">từ $35</span>
                    </div>
                    <p class="service-description">Dịch vụ làm móng tay chuyên nghiệp với các sản phẩm chất lượng cao</p>
                </div>
                <div class="service-card">
                    <div class="service-header">
                        <h3 class="service-name">Nails Art</h3>
                        <span class="service-price">từ $50</span>
                    </div>
                    <p class="service-description">Thiết kế nail độc đáo theo phong cách của bạn</p>
                </div>
                <div class="service-card">
                    <div class="service-header">
                        <h3 class="service-name">Làm Móng Chân</h3>
                        <span class="service-price">từ $40</span>
                    </div>
                    <p class="service-description">Chăm sóc móng chân toàn diện với các kỹ thuật hiện đại</p>
                </div>
                <div class="service-card">
                    <div class="service-header">
                        <h3 class="service-name">Massage Chân</h3>
                        <span class="service-price">từ $45</span>
                    </div>
                    <p class="service-description">Thư giãn và chăm sóc chân chuyên sâu</p>
                </div>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section id="about" class="about">
        <div class="container">
            <div class="about-grid">
                <div class="about-content">
                    <p class="section-label">VỀ CHÚNG TÔI</p>
                    <h2 class="section-title">Sứ Mệnh Của Nailology</h2>
                    <p class="about-text">
                        Tại Nailology, chúng tôi không chỉ cung cấp dịch vụ làm đẹp móng tay, móng chân, mà còn tạo ra một trải nghiệm hoàn toàn mới kết hợp giữa nails, coffee culture, và không gian thư giãn tuyệt vời.
                    </p>
                    <p class="about-text">
                        Chúng tôi cam kết sử dụng các sản phẩm chất lượng cao, quy trình vệ sinh nghiêm ngặt, và đội ngũ nhân viên được đào tạo chuyên nghiệp để mang đến cho bạn sự hài lòng tối đa.
                    </p>
                </div>
                <div class="about-image">
                    <div class="about-gradient">
                        <p class="about-label">TRẢI NGHIỆM</p>
                        <p class="about-title">Nails & Coffee Culture</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Gallery Section -->
    <section id="gallery" class="gallery">
        <div class="container">
            <div class="section-header">
                <p class="section-label">TÁC PHẨM</p>
                <h2 class="section-title">Hình Ảnh Của Chúng Tôi</h2>
            </div>
            <div class="gallery-grid">
                <div class="gallery-item">
                    <div class="gallery-placeholder">Nail Art Hoa</div>
                </div>
                <div class="gallery-item">
                    <div class="gallery-placeholder">Ombre Gradient</div>
                </div>
                <div class="gallery-item">
                    <div class="gallery-placeholder">Geometric Pattern</div>
                </div>
                <div class="gallery-item">
                    <div class="gallery-placeholder">Glitter Sparkle</div>
                </div>
                <div class="gallery-item">
                    <div class="gallery-placeholder">French Tip Classic</div>
                </div>
                <div class="gallery-item">
                    <div class="gallery-placeholder">Holographic Design</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="contact">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">Liên Hệ Với Chúng Tôi</h2>
                <p class="section-description">
                    Có câu hỏi? Liên hệ với chúng tôi ngay hôm nay
                </p>
            </div>
            <div class="contact-grid">
                <div class="contact-info">
                    <h3 class="contact-title">Thông Tin Liên Hệ</h3>
                    <div class="contact-details">
                        <div class="contact-item">
                            <p class="contact-label">ĐIỆN THOẠI</p>
                            <p class="contact-value">+61 3 XXXX XXXX</p>
                        </div>
                        <div class="contact-item">
                            <p class="contact-label">EMAIL</p>
                            <p class="contact-value">hello@nailology.com.au</p>
                        </div>
                        <div class="contact-item">
                            <p class="contact-label">ĐỊA CHỈ</p>
                            <p class="contact-value">Melbourne, Australia</p>
                        </div>
                    </div>
                </div>
                <form action="${pageContext.request.contextPath}/contact/submit" method="post" class="contact-form">
                    <input type="text" name="name" placeholder="Tên của bạn" class="form-input" required>
                    <input type="email" name="email" placeholder="Email của bạn" class="form-input" required>
                    <textarea name="message" placeholder="Tin nhắn của bạn" rows="4" class="form-textarea" required></textarea>
                    <button type="submit" class="btn btn-primary btn-full">Gửi</button>
                </form>
            </div>
        </div>
    </section>

    <jsp:include page="layout/footer.jsp" />
</body>
</html>

