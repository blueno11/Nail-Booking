<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${staff.id == null || staff.id == 0 ? 'Thêm mới' : 'Sửa'} Nhân viên - Nailology Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        .admin-container {
            max-width: 800px;
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
            color: var(--primary-dark);
        }
        input[type="text"], input[type="email"], select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--border-color);
            border-radius: 0.375rem;
            font-size: 1rem;
        }
        .checkbox-group {
            margin: 1rem 0;
        }
        .checkbox-item {
            margin-bottom: 0.75rem;
        }
        .btn-group {
            margin-top: 2rem;
            display: flex;
            gap: 1rem;
        }
    </style>
</head>
<body>
   <jsp:include page="/WEB-INF/views/layout/header.jsp" />

    <div class="container">
        <div class="admin-container">
            <h1 class="admin-title" style="margin-bottom: 2rem;">
                ${staff.id == null || staff.id == 0 ? 'Thêm mới' : 'Sửa'} Nhân viên
            </h1>

            <form action="${pageContext.request.contextPath}/admin/staff/save" method="post">
                <input type="hidden" name="id" value="${staff.id}"/>

                <!-- Trick bind checkbox ManyToMany -->
                <c:forEach items="${staff.locations}" var="selectedLoc">
                    <input type="hidden" name="_locations" value="${selectedLoc.id}"/>
                </c:forEach>

                <div class="form-group">
                    <label>Tên nhân viên *</label>
                    <input type="text" name="name" value="${staff.name}" required/>
                </div>

                <div class="form-group">
                    <label>Số điện thoại</label>
                    <input type="text" name="phone" value="${staff.phone}"/>
                </div>

                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" value="${staff.email}"/>
                </div>

                <div class="form-group">
                    <label>Trạng thái</label>
                    <select name="status">
                        <option value="ACTIVE" ${staff.status == 'ACTIVE' || staff.status == null ? 'selected' : ''}>Hoạt động</option>
                        <option value="INACTIVE" ${staff.status == 'INACTIVE' ? 'selected' : ''}>Ngừng hoạt động</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Chi nhánh làm việc</label>
                    <div class="checkbox-group">
                        <c:if test="${empty locationList}">
                            <p style="color:#999"><em>Chưa có chi nhánh nào trong hệ thống.</em></p>
                        </c:if>
                        <c:forEach items="${locationList}" var="loc">
                            <div class="checkbox-item">
                                <input type="checkbox" name="locations" value="${loc.id}" id="loc${loc.id}"
                                       <c:forEach items="${staff.locations}" var="selectedLoc">
                                           <c:if test="${selectedLoc.id == loc.id}">checked</c:if>
                                       </c:forEach> />
                                <label for="loc${loc.id}">${loc.name} (${loc.suburb})</label>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <div class="btn-group">
                    <button type="submit" class="btn btn-primary">Lưu nhân viên</button>
                    <a href="${pageContext.request.contextPath}/admin/staff" class="btn">Hủy</a>
                </div>
            </form>
        </div>
    </div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>