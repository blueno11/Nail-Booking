<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${announcement.id == null ? 'Thêm' : 'Sửa'} Thông báo - Nailology Admin</title>
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
        .form-group textarea { min-height: 120px; resize: vertical; }
        .checkbox-label { display: flex; align-items: center; gap: 0.5rem; cursor: pointer; }
        .checkbox-label input { width: auto; }
        .form-actions { display: flex; gap: 1rem; margin-top: 2rem; }
        .back-link { display: inline-block; margin-bottom: 1rem; color: var(--primary-color); text-decoration: none; }
        .help-text { font-size: 0.75rem; color: #666; margin-top: 0.25rem; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
<div class="container admin-container">
    <a href="${pageContext.request.contextPath}/admin/announcements" class="back-link">← Quay lại danh sách</a>
    <h1 class="admin-title">${announcement.id == null ? 'Thêm thông báo mới' : 'Sửa thông báo'}</h1>

    <div class="form-card">
        <form action="${pageContext.request.contextPath}/admin/announcements/save" method="post">
            <input type="hidden" name="id" value="${announcement.id}"/>

            <div class="form-group">
                <label>Tiêu đề <span style="color:#e74c3c">*</span></label>
                <input type="text" name="title" value="${announcement.title}" required placeholder="VD: Khuyến mãi tháng 12"/>
            </div>

            <div class="form-group">
                <label>Nội dung</label>
                <textarea name="content" placeholder="Nội dung chi tiết của thông báo...">${announcement.content}</textarea>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Nhãn nút CTA</label>
                    <input type="text" name="ctaLabel" value="${announcement.ctaLabel}" placeholder="VD: Đặt lịch ngay"/>
                    <div class="help-text">Nút kêu gọi hành động (nếu có)</div>
                </div>
                <div class="form-group">
                    <label>URL nút CTA</label>
                    <input type="text" name="ctaUrl" value="${announcement.ctaUrl}" placeholder="/booking"/>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Ngày bắt đầu</label>
                    <input type="date" name="startDate" 
                           value="<fmt:formatDate value='${announcement.startDate}' pattern='yyyy-MM-dd'/>"/>
                    <div class="help-text">Để trống = hiển thị ngay</div>
                </div>
                <div class="form-group">
                    <label>Ngày kết thúc</label>
                    <input type="date" name="endDate" 
                           value="<fmt:formatDate value='${announcement.endDate}' pattern='yyyy-MM-dd'/>"/>
                    <div class="help-text">Để trống = không giới hạn</div>
                </div>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Độ ưu tiên</label>
                    <input type="number" name="priority" value="${announcement.priority != null ? announcement.priority : 0}" min="0"/>
                    <div class="help-text">Số lớn hơn = hiển thị trước</div>
                </div>
                <div class="form-group" style="display:flex; align-items:flex-end; padding-bottom:0.75rem;">
                    <label class="checkbox-label">
                        <input type="checkbox" name="active" value="true" ${announcement.active == null || announcement.active ? 'checked' : ''}/>
                        Đang hoạt động
                    </label>
                </div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Lưu thông báo</button>
                <a href="${pageContext.request.contextPath}/admin/announcements" class="btn btn-secondary">Hủy</a>
            </div>
        </form>
    </div>
</div>
<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>
