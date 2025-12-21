<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Chi nhánh - Nailology Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        .admin-container { max-width: 1200px; margin: 2rem auto; padding: 0 1rem; }
        .admin-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; flex-wrap: wrap; gap: 1rem; }
        .admin-title { font-size: 2rem; color: var(--primary-dark); margin: 0; }
        .admin-nav { display: flex; gap: 0.5rem; flex-wrap: wrap; margin-bottom: 1.5rem; }
        .admin-nav a { padding: 0.5rem 1rem; background: var(--background); border-radius: 0.375rem; text-decoration: none; color: var(--text-color); font-size: 0.875rem; }
        .admin-nav a:hover, .admin-nav a.active { background: var(--primary-color); color: white; }
        table { width: 100%; border-collapse: collapse; background: var(--white); box-shadow: 0 4px 6px rgba(0,0,0,0.05); border-radius: 0.5rem; overflow: hidden; }
        th { background: var(--primary-color); color: var(--white); padding: 1rem; text-align: left; font-weight: 500; }
        td { padding: 1rem; border-bottom: 1px solid var(--border-color); }
        tr:hover { background: #faf7f4; }
        .action-links a { color: var(--primary-color); text-decoration: none; margin-right: 1rem; }
        .action-links a:hover { text-decoration: underline; }
        .delete-link { color: #e74c3c !important; }
        .status-active { color: #27ae60; font-weight: 600; }
        .status-inactive { color: #e74c3c; font-weight: 600; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
<div class="container admin-container">
    <div class="admin-nav">
        <a href="${pageContext.request.contextPath}/admin/services">Dịch vụ</a>
        <a href="${pageContext.request.contextPath}/admin/locations" class="active">Chi nhánh</a>
        <a href="${pageContext.request.contextPath}/admin/gallery">Gallery</a>
        <a href="${pageContext.request.contextPath}/admin/announcements">Thông báo</a>
        <a href="${pageContext.request.contextPath}/admin/staff">Nhân viên</a>
    </div>

    <div class="admin-header">
        <h1 class="admin-title">Quản lý Chi nhánh</h1>
        <a href="${pageContext.request.contextPath}/admin/locations/edit?id=0" class="btn btn-primary">+ Thêm chi nhánh</a>
    </div>

    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Tên chi nhánh</th>
                <th>Địa chỉ</th>
                <th>SĐT</th>
                <th>Trạng thái</th>
                <th>Thứ tự</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${locationList}" var="loc">
                <tr>
                    <td>${loc.id}</td>
                    <td>
                        <strong>${loc.name}</strong>
                        <c:if test="${not empty loc.suburb}">
                            <br><small style="color:#666">${loc.suburb} ${loc.postcode}</small>
                        </c:if>
                    </td>
                    <td>${loc.address}</td>
                    <td>${loc.phone}</td>
                    <td>
                        <span class="${loc.status == 'ACTIVE' ? 'status-active' : 'status-inactive'}">
                            ${loc.status == 'ACTIVE' ? 'Hoạt động' : 'Tạm đóng'}
                        </span>
                    </td>
                    <td>${loc.displayOrder}</td>
                    <td class="action-links">
                        <a href="${pageContext.request.contextPath}/admin/locations/edit?id=${loc.id}">Sửa</a>
                        <a href="${pageContext.request.contextPath}/admin/locations/delete?id=${loc.id}" 
                           class="delete-link"
                           onclick="return confirm('Xóa chi nhánh ${loc.name}?')">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty locationList}">
                <tr><td colspan="7" style="text-align:center; padding:2rem; color:#999;">Chưa có chi nhánh nào.</td></tr>
            </c:if>
        </tbody>
    </table>

    <div style="margin-top: 2rem;">
        <a href="${pageContext.request.contextPath}/">← Quay lại trang chủ</a>
    </div>
</div>
<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>
