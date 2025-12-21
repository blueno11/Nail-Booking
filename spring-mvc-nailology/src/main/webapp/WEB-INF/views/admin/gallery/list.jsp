<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Gallery - Nailology Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        .admin-container { max-width: 1200px; margin: 2rem auto; padding: 0 1rem; }
        .admin-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; flex-wrap: wrap; gap: 1rem; }
        .admin-title { font-size: 2rem; color: var(--primary-dark); margin: 0; }
        .admin-nav { display: flex; gap: 0.5rem; flex-wrap: wrap; margin-bottom: 1.5rem; }
        .admin-nav a { padding: 0.5rem 1rem; background: var(--background); border-radius: 0.375rem; text-decoration: none; color: var(--text-color); font-size: 0.875rem; }
        .admin-nav a:hover, .admin-nav a.active { background: var(--primary-color); color: white; }
        .gallery-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 1.5rem; }
        .gallery-card { background: var(--white); border-radius: 0.5rem; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        .gallery-image { height: 180px; background: var(--background); display: flex; align-items: center; justify-content: center; overflow: hidden; }
        .gallery-image img { width: 100%; height: 100%; object-fit: cover; }
        .gallery-placeholder { color: #999; font-size: 0.875rem; }
        .gallery-info { padding: 1rem; }
        .gallery-title { font-weight: 600; color: var(--primary-dark); margin-bottom: 0.25rem; }
        .gallery-caption { font-size: 0.875rem; color: #666; margin-bottom: 0.5rem; }
        .gallery-meta { font-size: 0.75rem; color: #999; }
        .gallery-actions { display: flex; gap: 0.5rem; padding: 0 1rem 1rem; }
        .gallery-actions a { font-size: 0.875rem; color: var(--primary-color); text-decoration: none; }
        .gallery-actions a:hover { text-decoration: underline; }
        .delete-link { color: #e74c3c !important; }
        .empty-state { text-align: center; padding: 3rem; color: #999; background: var(--white); border-radius: 0.5rem; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
<div class="container admin-container">
    <div class="admin-nav">
        <a href="${pageContext.request.contextPath}/admin/services">Dịch vụ</a>
        <a href="${pageContext.request.contextPath}/admin/locations">Chi nhánh</a>
        <a href="${pageContext.request.contextPath}/admin/gallery" class="active">Gallery</a>
        <a href="${pageContext.request.contextPath}/admin/announcements">Thông báo</a>
        <a href="${pageContext.request.contextPath}/admin/staff">Nhân viên</a>
    </div>

    <div class="admin-header">
        <h1 class="admin-title">Quản lý Gallery</h1>
        <a href="${pageContext.request.contextPath}/admin/gallery/edit?id=0" class="btn btn-primary">+ Thêm ảnh</a>
    </div>

    <c:if test="${not empty galleryList}">
    <div class="gallery-grid">
        <c:forEach items="${galleryList}" var="item">
            <div class="gallery-card">
                <div class="gallery-image">
                    <c:choose>
                        <c:when test="${not empty item.imageUrl}">
                            <img src="${item.imageUrl}" alt="${item.title}"/>
                        </c:when>
                        <c:otherwise>
                            <span class="gallery-placeholder">Chưa có ảnh</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="gallery-info">
                    <div class="gallery-title">${not empty item.title ? item.title : 'Không có tiêu đề'}</div>
                    <c:if test="${not empty item.caption}">
                        <div class="gallery-caption">${item.caption}</div>
                    </c:if>
                    <div class="gallery-meta">
                        Loại: ${not empty item.type ? item.type : 'Chưa phân loại'} | 
                        Thứ tự: ${item.displayOrder}
                    </div>
                </div>
                <div class="gallery-actions">
                    <a href="${pageContext.request.contextPath}/admin/gallery/edit?id=${item.id}">Sửa</a>
                    <a href="${pageContext.request.contextPath}/admin/gallery/delete?id=${item.id}" 
                       class="delete-link"
                       onclick="return confirm('Xóa ảnh này?')">Xóa</a>
                </div>
            </div>
        </c:forEach>
    </div>
    </c:if>

    <c:if test="${empty galleryList}">
    <div class="empty-state">
        <p>Chưa có ảnh nào trong gallery.</p>
        <a href="${pageContext.request.contextPath}/admin/gallery/edit?id=0" class="btn btn-primary" style="margin-top:1rem">Thêm ảnh đầu tiên</a>
    </div>
    </c:if>

    <div style="margin-top: 2rem;">
        <a href="${pageContext.request.contextPath}/">← Quay lại trang chủ</a>
    </div>
</div>
<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>
