<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${location.id == null ? 'Thêm' : 'Sửa'} Chi nhánh - Nailology Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        .admin-container { max-width: 800px; margin: 2rem auto; padding: 0 1rem; }
        .admin-title { font-size: 2rem; color: var(--primary-dark); margin-bottom: 1.5rem; }
        .form-card { background: var(--white); padding: 2rem; border-radius: 0.5rem; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; }
        .form-group { margin-bottom: 1.5rem; }
        .form-group label { display: block; margin-bottom: 0.5rem; font-weight: 500; color: var(--primary-dark); }
        .form-group input, .form-group select, .form-group textarea { width: 100%; padding: 0.75rem; border: 1px solid var(--border-color); border-radius: 0.375rem; font-size: 1rem; }
        .form-group textarea { min-height: 80px; resize: vertical; }
        .checkbox-label { display: flex; align-items: center; gap: 0.5rem; cursor: pointer; }
        .checkbox-label input { width: auto; }
        .form-actions { display: flex; gap: 1rem; margin-top: 2rem; }
        .back-link { display: inline-block; margin-bottom: 1rem; color: var(--primary-color); text-decoration: none; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
<div class="container admin-container">
    <a href="${pageContext.request.contextPath}/admin/locations" class="back-link">← Quay lại danh sách</a>
    <h1 class="admin-title">${location.id == null ? 'Thêm chi nhánh mới' : 'Sửa chi nhánh'}</h1>

    <div class="form-card">
        <form action="${pageContext.request.contextPath}/admin/locations/save" method="post">
            <input type="hidden" name="id" value="${location.id}"/>

            <div class="form-group">
                <label>Tên chi nhánh <span style="color:#e74c3c">*</span></label>
                <input type="text" name="name" value="${location.name}" required placeholder="VD: Nailology CBD"/>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Suburb</label>
                    <input type="text" name="suburb" value="${location.suburb}" placeholder="VD: Melbourne"/>
                </div>
                <div class="form-group">
                    <label>Postcode</label>
                    <input type="text" name="postcode" value="${location.postcode}" placeholder="VD: 3000"/>
                </div>
            </div>

            <div class="form-group">
                <label>Địa chỉ đầy đủ</label>
                <input type="text" name="address" value="${location.address}" placeholder="VD: 123 Collins Street, Melbourne VIC 3000"/>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Số điện thoại</label>
                    <input type="text" name="phone" value="${location.phone}" placeholder="VD: 03 1234 5678"/>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" value="${location.email}" placeholder="VD: cbd@nailology.com"/>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Trạng thái <span style="color:#e74c3c">*</span></label>
                    <select name="status" required>
                        <option value="ACTIVE" ${location.status == 'ACTIVE' ? 'selected' : ''}>Hoạt động</option>
                        <option value="INACTIVE" ${location.status == 'INACTIVE' ? 'selected' : ''}>Tạm đóng</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Thứ tự hiển thị</label>
                    <input type="number" name="displayOrder" value="${location.displayOrder != null ? location.displayOrder : 0}"/>
                </div>
            </div>

            <div class="form-group">
                <label>Điểm nổi bật</label>
                <textarea name="highlight" placeholder="VD: Không gian sang trọng, view đẹp...">${location.highlight}</textarea>
            </div>

            <div class="form-group">
                <label class="checkbox-label">
                    <input type="checkbox" name="coffeeAvailable" value="true" ${location.coffeeAvailable == null || location.coffeeAvailable ? 'checked' : ''}/>
                    Có phục vụ cà phê
                </label>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Lưu chi nhánh</button>
                <a href="${pageContext.request.contextPath}/admin/locations" class="btn btn-secondary">Hủy</a>
            </div>
        </form>
    </div>
</div>
<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>
