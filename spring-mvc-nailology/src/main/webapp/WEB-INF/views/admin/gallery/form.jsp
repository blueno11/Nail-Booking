<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${gallery.id == null ? 'Thêm' : 'Sửa'} Ảnh Gallery - Nailology Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        .admin-container { max-width: 700px; margin: 2rem auto; padding: 0 1rem; }
        .admin-title { font-size: 2rem; color: var(--primary-dark); margin-bottom: 1.5rem; }
        .form-card { background: var(--white); padding: 2rem; border-radius: 0.5rem; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; }
        .form-group { margin-bottom: 1.5rem; }
        .form-group label { display: block; margin-bottom: 0.5rem; font-weight: 500; color: var(--primary-dark); }
        .form-group input, .form-group select, .form-group textarea { width: 100%; padding: 0.75rem; border: 1px solid var(--border-color); border-radius: 0.375rem; font-size: 1rem; }
        .form-group textarea { min-height: 80px; resize: vertical; }
        .form-actions { display: flex; gap: 1rem; margin-top: 2rem; }
        .back-link { display: inline-block; margin-bottom: 1rem; color: var(--primary-color); text-decoration: none; }
        .image-preview { margin-top: 0.5rem; max-width: 300px; border-radius: 0.375rem; overflow: hidden; }
        .image-preview img { width: 100%; height: auto; display: block; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
<div class="container admin-container">
    <a href="${pageContext.request.contextPath}/admin/gallery" class="back-link">← Quay lại danh sách</a>
    <h1 class="admin-title">${gallery.id == null ? 'Thêm ảnh mới' : 'Sửa ảnh'}</h1>

    <div class="form-card">
        <form action="${pageContext.request.contextPath}/admin/gallery/save" method="post">
            <input type="hidden" name="id" value="${gallery.id}"/>

            <div class="form-group">
                <label>Tiêu đề</label>
                <input type="text" name="title" value="${gallery.title}" placeholder="VD: Nail Art Hoa Hồng"/>
            </div>

            <div class="form-group">
                <label>URL Ảnh <span style="color:#e74c3c">*</span></label>
                <input type="url" name="imageUrl" id="imageUrl" value="${gallery.imageUrl}" required 
                       placeholder="https://example.com/image.jpg" onchange="previewImage()"/>
                <c:if test="${not empty gallery.imageUrl}">
                    <div class="image-preview" id="preview">
                        <img src="${gallery.imageUrl}" alt="Preview"/>
                    </div>
                </c:if>
                <div class="image-preview" id="newPreview" style="display:none;">
                    <img id="previewImg" src="" alt="Preview"/>
                </div>
            </div>

            <div class="form-group">
                <label>Mô tả</label>
                <textarea name="caption" placeholder="Mô tả ngắn về ảnh...">${gallery.caption}</textarea>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Loại</label>
                    <select name="type">
                        <option value="">-- Chọn loại --</option>
                        <option value="NAIL_ART" ${gallery.type == 'NAIL_ART' ? 'selected' : ''}>Nail Art</option>
                        <option value="MANICURE" ${gallery.type == 'MANICURE' ? 'selected' : ''}>Manicure</option>
                        <option value="PEDICURE" ${gallery.type == 'PEDICURE' ? 'selected' : ''}>Pedicure</option>
                        <option value="SALON" ${gallery.type == 'SALON' ? 'selected' : ''}>Salon</option>
                        <option value="OTHER" ${gallery.type == 'OTHER' ? 'selected' : ''}>Khác</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Thứ tự hiển thị</label>
                    <input type="number" name="displayOrder" value="${gallery.displayOrder != null ? gallery.displayOrder : 0}"/>
                </div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Lưu ảnh</button>
                <a href="${pageContext.request.contextPath}/admin/gallery" class="btn btn-secondary">Hủy</a>
            </div>
        </form>
    </div>
</div>
<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
<script>
function previewImage() {
    var url = document.getElementById('imageUrl').value;
    var preview = document.getElementById('newPreview');
    var img = document.getElementById('previewImg');
    var oldPreview = document.getElementById('preview');
    if (url) {
        img.src = url;
        preview.style.display = 'block';
        if (oldPreview) oldPreview.style.display = 'none';
    } else {
        preview.style.display = 'none';
    }
}
</script>
</body>
</html>
