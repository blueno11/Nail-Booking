<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Builder Gels Menu - Nailology</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
    
    <style>
        /* Tôi giữ nguyên CSS của bạn vì nó đã đẹp rồi */
        .services-section { padding: 80px 0; background: #fafafa; }
        .section-intro { text-align: center; margin-bottom: 60px; }
        .section-intro .section-label { font-family: 'Lora', serif; font-size: 0.85rem; letter-spacing: 2px; text-transform: uppercase; color: #c9a77c; margin-bottom: 10px; }
        .section-intro h2 { font-family: 'Playfair Display', serif; font-size: 2.5rem; font-weight: 700; color: #2c2c2c; margin-bottom: 15px; }
        .section-intro p { font-family: 'Lora', serif; color: #666; font-size: 1.1rem; }
        .category-block { margin-bottom: 60px; }
        .category-header { background: linear-gradient(135deg, #c9a77c 0%, #b8935e 100%); color: white; padding: 25px 40px; border-radius: 8px 8px 0 0; }
        .category-header h3 { font-family: 'Playfair Display', serif; font-size: 1.8rem; font-weight: 600; margin: 0; }
        .services-list { background: white; border-radius: 0 0 8px 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); overflow: hidden; }
        .service-item { padding: 30px 40px; border-bottom: 1px solid #e9ecef; transition: background-color 0.3s ease; }
        .service-item:last-child { border-bottom: none; }
        .service-item:hover { background-color: #fafafa; }
        .service-header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 12px; }
        .service-name { font-family: 'Playfair Display', serif; font-size: 1.4rem; font-weight: 600; color: #2c2c2c; flex: 1; }
        .service-price { font-family: 'Lora', serif; font-size: 1.3rem; font-weight: 600; color: #c9a77c; white-space: nowrap; margin-left: 20px; }
        .service-description { font-family: 'Lora', serif; color: #666; font-size: 1rem; line-height: 1.7; margin-bottom: 12px; }
        .service-meta { display: flex; gap: 20px; flex-wrap: wrap; }
        .service-duration { font-family: 'Lora', serif; display: inline-flex; align-items: center; color: #888; font-size: 0.9rem; }
        .service-duration::before { content: "⏱"; margin-right: 6px; font-size: 1rem; }
        .badge { display: inline-block; padding: 4px 14px; background: #c9a77c; color: white; border-radius: 20px; font-size: 0.8rem; font-weight: 500; margin-left: 12px; font-family: 'Lora', serif; }
        .empty-state { text-align: center; padding: 80px 20px; background: white; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.08); }
        .empty-state h3 { font-family: 'Playfair Display', serif; font-size: 1.8rem; color: #666; margin-bottom: 15px; }
        .empty-state p { font-family: 'Lora', serif; color: #999; font-size: 1rem; }
        
        /* Location Filter Styles */
        .location-filter-section { padding: 20px 0; background: white; border-bottom: 1px solid #eee; }
        .filter-wrapper { display: flex; justify-content: center; align-items: center; gap: 15px; }
        .filter-label { font-family: 'Lora', serif; font-weight: 600; color: #2c2c2c; }
        .location-buttons { display: flex; gap: 10px; flex-wrap: wrap; justify-content: center;}
        .location-btn {
            display: inline-block;
            padding: 10px 20px;
            border: 1px solid #c9a77c;
            color: #c9a77c;
            text-decoration: none;
            border-radius: 4px;
            font-family: 'Lora', serif;
            transition: all 0.3s ease;
        }
        .location-btn:hover, .location-btn.active {
            background-color: #c9a77c;
            color: white;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-hero h1 { font-size: 2rem; }
            .location-filter-section { position: relative; top: 0; }
            .filter-wrapper { flex-direction: column; align-items: stretch; text-align: center;}
            .location-buttons { flex-direction: column; }
            .location-btn { width: 100%; text-align: center; }
            .service-header { flex-direction: column; }
            .service-price { margin-left: 0; margin-top: 10px; }
            .category-header, .service-item { padding: 20px 25px; }
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/layout/header.jsp" />

    <section class="page-hero" style="background: #2c2c2c; color: white; padding: 60px 0; text-align: center;">
        <div class="container">
            <h1 style="font-family: 'Playfair Display', serif;">Builder Gels Menu</h1>
            <p style="font-family: 'Lora', serif; opacity: 0.8;">Khám phá các dịch vụ Builder Gel chuyên nghiệp của chúng tôi</p>
        </div>
    </section>

    <section class="location-filter-section">
        <div class="container">
            <div class="filter-wrapper">
                <span class="filter-label">Chọn Chi Nhánh:</span>
                <div class="location-buttons">
                    <a href="${pageContext.request.contextPath}/builder-gels" 
                       class="location-btn ${empty selectedLocationId ? 'active' : ''}">
                        Tất cả chi nhánh
                    </a>

                    <c:forEach items="${locations}" var="location">
                        <a href="${pageContext.request.contextPath}/builder-gels?locationId=${location.id}" 
                           class="location-btn ${selectedLocationId == location.id ? 'active' : ''}">
                            ${location.name}
                            <c:if test="${not empty location.suburb}">
                                - ${location.suburb}
                            </c:if>
                        </a>
                    </c:forEach>
                </div>
            </div>
        </div>
    </section>

    <section class="services-section">
        <div class="container">
            <div class="section-intro">
                <p class="section-label">DỊCH VỤ</p>
                <h2>
                    <c:choose>
                        <c:when test="${not empty selectedLocation}">
                            Builder Gels tại ${selectedLocation.name}
                        </c:when>
                        <c:otherwise>
                            Tất cả Builder Gels
                        </c:otherwise>
                    </c:choose>
                </h2>
                <p>
                    <c:choose>
                        <c:when test="${totalServices > 0}">
                            Đang hiển thị ${totalServices} dịch vụ
                        </c:when>
                        <c:otherwise>
                            Không có dịch vụ nào
                        </c:otherwise>
                    </c:choose>
                </p>
            </div>

            <c:choose>
                <c:when test="${not empty servicesByCategory}">
                    <c:forEach items="${servicesByCategory}" var="entry">
                        <div class="category-block">
                            <div class="category-header">
                                <h3>${entry.key}</h3>
                            </div>
                            <div class="services-list">
                                <c:forEach items="${entry.value}" var="service">
                                    <div class="service-item">
                                        <div class="service-header">
                                            <div class="service-name">
                                                ${service.name}
                                                <c:if test="${service.homepageFeatured}">
                                                    <span class="badge">Nổi Bật</span>
                                                </c:if>
                                            </div>
                                            <div class="service-price">
                                                <c:choose>
                                                    <c:when test="${not empty service.startingPrice}">
                                                        <fmt:formatNumber value="${service.startingPrice}" 
                                                                        type="number" 
                                                                        groupingUsed="true" 
                                                                        maxFractionDigits="0"/>đ
                                                    </c:when>
                                                    <c:otherwise>
                                                        Liên hệ
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        
                                        <c:if test="${not empty service.description}">
                                            <p class="service-description">${service.description}</p>
                                        </c:if>
                                        
                                        <div class="service-meta">
                                            <c:if test="${not empty service.durationLabel}">
                                                <span class="service-duration">${service.durationLabel}</span>
                                            </c:if>
                                            <c:if test="${empty service.durationLabel && not empty service.durationMinutes}">
                                                <span class="service-duration">${service.durationMinutes} phút</span>
                                            </c:if>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <h3>Không tìm thấy dịch vụ</h3>
                        <p>
                            <c:choose>
                                <c:when test="${not empty selectedLocation}">
                                    Chi nhánh <strong>${selectedLocation.name}</strong> hiện chưa có dịch vụ Builder Gel nào.
                                    <br>Vui lòng chọn chi nhánh khác.
                                </c:when>
                                <c:otherwise>
                                    Hiện tại hệ thống chưa cập nhật dịch vụ.
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>