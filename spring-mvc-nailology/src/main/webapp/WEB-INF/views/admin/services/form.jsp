<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${service.id == null ? 'Thêm' : 'Sửa'} Dịch vụ - Nailology Admin</title>
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
        .form-group textarea { min-height: 100px; resize: vertical; }
        .checkbox-group { display: flex; gap: 2rem; flex-wrap: wrap; }
        .checkbox-label { display: flex; align-items: center; gap: 0.5rem; cursor: pointer; }
        .checkbox-label input { width: auto; }
        .location-checkboxes { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 0.5rem; }
        .form-actions { display: flex; gap: 1rem; margin-top: 2rem; }
        .back-link { display: inline-block; margin-bottom: 1rem; color: var(--primary-color); text-decoration: none; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
<div class="container admin-container">
    <a href="${pageContext.request.contextPath}/admin/services" class="back-link">← Quay lại danh sách</a>
    <h1 class="admin-title">${service.id == null ? 'Thêm dịch vụ mới' : 'Sửa dịch vụ'}</h1>

    <div class="form-card">
        <form action="${pageContext.request.contextPath}/admin/services/save" method="post">
            <input type="hidden" name="id" value="${service.id}"/>

            <div class="form-group">
                <label>Tên dịch vụ <span style="color:#e74c3c">*</span></label>
                <input type="text" name="name" value="${service.name}" required/>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Danh mục</label>
                    <select name="category">
                        <option value="NAIL" ${service.category == 'NAIL' ? 'selected' : ''}>Nail</option>
                        <option value="PEDICURE" ${service.category == 'PEDICURE' ? 'selected' : ''}>Pedicure</option>
                        <option value="MANICURE" ${service.category == 'MANICURE' ? 'selected' : ''}>Manicure</option>
                        <option value="BUILDER_GEL" ${service.category == 'BUILDER_GEL' ? 'selected' : ''}>Builder Gel</option>
                        <option value="OTHER" ${service.category == 'OTHER' ? 'selected' : ''}>Khác</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Nhãn danh mục</label>
                    <input type="text" name="categoryLabel" value="${service.categoryLabel}" placeholder="VD: Dịch vụ Nail"/>
                </div>
            </div>

            <div class="form-group">
                <label>Mô tả</label>
                <textarea name="description">${service.description}</textarea>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Thời gian (phút)</label>
                    <input type="number" name="durationMinutes" value="${service.durationMinutes}" min="0"/>
                </div>
                <div class="form-group">
                    <label>Nhãn thời gian</label>
                    <input type="text" name="durationLabel" value="${service.durationLabel}" placeholder="VD: 45-60 phút"/>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Giá từ ($)</label>
                    <input type="number" name="startingPrice" value="${service.startingPrice}" step="0.01" min="0"/>
                </div>
                <div class="form-group">
                    <label>Thứ tự hiển thị</label>
                    <input type="number" name="displayOrder" value="${service.displayOrder != null ? service.displayOrder : 0}"/>
                </div>
            </div>

            <div class="form-group">
                <label>Tùy chọn</label>
                <div class="checkbox-group">
                    <label class="checkbox-label">
                        <input type="checkbox" name="homepageFeatured" value="true" ${service.homepageFeatured ? 'checked' : ''}/>
                        Hiển thị trang chủ
                    </label>
                    <label class="checkbox-label">
                        <input type="checkbox" name="isBuilderGel" value="true" ${service.isBuilderGel ? 'checked' : ''}/>
                        Builder Gel
                    </label>
                </div>
            </div>

            <c:if test="${not empty locationList}">
            <div class="form-group">
                <label>Chi nhánh áp dụng</label>
                <div class="location-checkboxes">
                    <c:forEach items="${locationList}" var="loc">
                        <label class="checkbox-label">
                            <input type="checkbox" name="locationIds" value="${loc.id}"
                                <c:forEach items="${service.locations}" var="sl">
                                    <c:if test="${sl.id == loc.id}">checked</c:if>
                                </c:forEach>
                            />
                            ${loc.name}
                        </label>
                    </c:forEach>
                </div>
            </div>
            </c:if>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Lưu dịch vụ</button>
                <a href="${pageContext.request.contextPath}/admin/services" class="btn btn-secondary">Hủy</a>
            </div>
        </form>
    </div>
</div>
<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>
