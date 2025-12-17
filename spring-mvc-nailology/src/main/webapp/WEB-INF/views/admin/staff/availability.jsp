<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch rảnh - ${staff.name} - Nailology Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        .admin-container {
            max-width: 900px;
            margin: 2rem auto;
            padding: 2rem;
            background: var(--white);
            border-radius: 0.5rem;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }
        select, input[type="time"] {
            padding: 0.75rem;
            border: 1px solid var(--border-color);
            border-radius: 0.375rem;
            width: 250px;
            font-size: 1rem;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 2rem;
        }
        th {
            background: var(--primary-color);
            color: var(--white);
            padding: 1rem;
        }
        td {
            padding: 1rem;
            border-bottom: 1px solid var(--border-color);
            text-align: center;
        }
        .delete-link {
            color: #e74c3c;
            text-decoration: none;
        }
        .delete-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/layout/header.jsp" />

    <div class="container">
        <div class="admin-container">
            <h1 class="admin-title" style="margin-bottom: 1rem;">Lịch rảnh của <strong>${staff.name}</strong></h1>
            <p><a href="${pageContext.request.contextPath}/admin/staff/edit?id=${staff.id}">← Sửa thông tin nhân viên</a></p>

            <h2 style="margin: 2rem 0 1rem;">Thêm ca làm việc mới</h2>
            <form action="${pageContext.request.contextPath}/admin/staff/availability/save" method="post">
                <input type="hidden" name="staffId" value="${staff.id}"/>

                <div class="form-group">
                    <label>Thứ trong tuần</label>
                    <select name="dayOfWeek" required>
                        <option value="" disabled selected>Chọn thứ</option>
                        <option value="1">Thứ Hai</option>
                        <option value="2">Thứ Ba</option>
                        <option value="3">Thứ Tư</option>
                        <option value="4">Thứ Năm</option>
                        <option value="5">Thứ Sáu</option>
                        <option value="6">Thứ Bảy</option>
                        <option value="7">Chủ Nhật</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Giờ bắt đầu</label>
                    <input type="time" name="startTime" required/>
                </div>

                <div class="form-group">
                    <label>Giờ kết thúc</label>
                    <input type="time" name="endTime" required/>
                </div>

                <button type="submit" class="btn btn-primary">Thêm ca làm việc</button>
            </form>

            <!-- Phần danh sách ca giữ nguyên như cũ -->
            <h2 style="margin: 3rem 0 1rem;">Danh sách ca làm việc hiện tại</h2>
            <table>
                <thead>
                    <tr>
                        <th>Thứ</th>
                        <th>Giờ bắt đầu</th>
                        <th>Giờ kết thúc</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${availList}" var="a">
                        <tr>
                            <td>
                                <c:choose>
                                    <c:when test="${a.dayOfWeek == 1}">Thứ Hai</c:when>
                                    <c:when test="${a.dayOfWeek == 2}">Thứ Ba</c:when>
                                    <c:when test="${a.dayOfWeek == 3}">Thứ Tư</c:when>
                                    <c:when test="${a.dayOfWeek == 4}">Thứ Năm</c:when>
                                    <c:when test="${a.dayOfWeek == 5}">Thứ Sáu</c:when>
                                    <c:when test="${a.dayOfWeek == 6}">Thứ Bảy</c:when>
                                    <c:when test="${a.dayOfWeek == 7}">Chủ Nhật</c:when>
                                </c:choose>
                            </td>
                            <td>${a.startTime}</td>
                            <td>${a.endTime}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/staff/availability/delete?id=${a.id}&staffId=${staff.id}"
                                   class="delete-link"
                                   onclick="return confirm('Xóa ca làm việc này?')">
                                    Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty availList}">
                        <tr>
                            <td colspan="4" style="text-align:center; padding:2rem; color:#999;">
                                Chưa có ca làm việc nào
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>

            <div style="margin-top: 2rem;">
                <a href="${pageContext.request.contextPath}/admin/staff">← Quay lại danh sách nhân viên</a>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>