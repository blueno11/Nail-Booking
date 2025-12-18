<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Nhân viên - Nailology Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        .admin-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        .admin-title {
            font-size: 2rem;
            margin-bottom: 1.5rem;
            color: var(--primary-dark);
        }
        .btn-add {
            display: inline-block;
            margin-bottom: 1.5rem;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: var(--white);
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            border-radius: 0.5rem;
            overflow: hidden;
        }
        th {
            background: var(--primary-color);
            color: var(--white);
            padding: 1rem;
            text-align: left;
        }
        td {
            padding: 1rem;
            border-bottom: 1px solid var(--border-color);
        }
        tr:hover {
            background: #faf7f4;
        }
        .action-links a {
            color: var(--primary-color);
            text-decoration: none;
            margin-right: 1rem;
        }
        .action-links a:hover {
            text-decoration: underline;
        }
        .delete-link {
            color: #e74c3c;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />
    <div class="container admin-container">
        <h1 class="admin-title">Quản lý Nhân viên</h1>

        <a href="${pageContext.request.contextPath}/admin/staff/edit?id=0" class="btn btn-primary btn-add">Thêm nhân viên mới</a>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên</th>
                    <th>SĐT</th>
                    <th>Email</th>
                    <th>Trạng thái</th>
                    <th>Chi nhánh</th>
                    <th>Hành động</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${staffList}" var="s">
                    <tr>
                        <td>${s.id}</td>
                        <td><strong>${s.name}</strong></td>
                        <td>${s.phone}</td>
                        <td>${s.email}</td>
                        <td>
                            <span style="color: ${s.status == 'ACTIVE' ? '#27ae60' : '#e74c3c'}; font-weight:600;">
                                ${s.status}
                            </span>
                        </td>
                        <td>
                            <c:forEach items="${s.locations}" var="loc" varStatus="loop">
                                ${loc.name}<c:if test="${!loop.last}">, </c:if>
                            </c:forEach>
                            <c:if test="${empty s.locations}">
                                <em style="color:#999">Chưa gán</em>
                            </c:if>
                        </td>
                        <td class="action-links">
                            <a href="${pageContext.request.contextPath}/admin/staff/edit?id=${s.id}">Sửa</a>
                            <a href="${pageContext.request.contextPath}/admin/staff/${s.id}/availability">Lịch rảnh</a>
                            <a href="${pageContext.request.contextPath}/admin/staff/delete?id=${s.id}" 
                               class="delete-link"
                               onclick="return confirm('Xóa nhân viên ${s.name}? Hành động này không thể hoàn tác!')">
                                Xóa
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty staffList}">
                    <tr>
                        <td colspan="7" style="text-align:center; padding:2rem; color:#999;">
                            Chưa có nhân viên nào. <a href="${pageContext.request.contextPath}/admin/staff/edit?id=0">Thêm nhân viên đầu tiên</a>
                        </td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <div style="margin-top: 2rem;">
            <a href="${pageContext.request.contextPath}/">← Quay lại trang chủ</a>
        </div>
    </div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" /></body>
</html>