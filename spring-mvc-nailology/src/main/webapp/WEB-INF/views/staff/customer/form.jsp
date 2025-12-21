<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isNew ? 'Thêm' : 'Sửa'} Khách hàng - Nailology Staff</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        .staff-container { max-width: 700px; margin: 2rem auto; padding: 0 1rem; }
        .page-title { font-size: 1.75rem; color: var(--primary-dark); margin-bottom: 1.5rem; }
        .breadcrumb { margin-bottom: 1rem; }
        .breadcrumb a { color: var(--primary-color); text-decoration: none; }
        .form-card { background: var(--white); padding: 2rem; border-radius: 0.75rem; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; }
        .form-group { margin-bottom: 1.5rem; }
        .form-group label { display: block; margin-bottom: 0.5rem; font-weight: 500; color: var(--primary-dark); }
        .form-group input, .form-group select, .form-group textarea { width: 100%; padding: 0.75rem; border: 1px solid var(--border-color); border-radius: 0.375rem; font-size: 1rem; }
        .form-group textarea { min-height: 80px; resize: vertical; }
        .checkbox-label { display: flex; align-items: center; gap: 0.5rem; cursor: pointer; font-weight: normal; }
        .checkbox-label input { width: auto; }
        .form-actions { display: flex; gap: 1rem; margin-top: 2rem; }
        .alert { padding: 1rem; border-radius: 0.5rem; margin-bottom: 1.5rem; }
        .alert-error { background: #fee2e2; color: #dc2626; }
        .required { color: #dc2626; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="staff-container">
    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/staff/dashboard">Dashboard</a> / 
        <a href="${pageContext.request.contextPath}/staff/customer">Khách hàng</a> / 
        ${isNew ? 'Thêm mới' : 'Chỉnh sửa'}
    </div>

    <h1 class="page-title">${isNew ? 'Thêm khách hàng mới' : 'Chỉnh sửa khách hàng'}</h1>

    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>

    <div class="form-card">
        <form action="${pageContext.request.contextPath}/staff/customer/save" method="post">
            <input type="hidden" name="id" value="${customer.id}"/>

            <div class="form-group">
                <label>Họ và tên <span class="required">*</span></label>
                <input type="text" name="fullName" value="${customer.fullName}" required placeholder="Nguyễn Văn A"/>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Số điện thoại <span class="required">*</span></label>
                    <input type="tel" name="phoneNumber" value="${customer.phoneNumber}" required placeholder="0912345678"/>
                </div>
                <div class="form-group">
                    <label>Email</label>
                    <input type="email" name="email" value="${customer.email}" placeholder="email@example.com"/>
                </div>
            </div>

            <div class="form-group">
                <label>Địa chỉ</label>
                <input type="text" name="address" value="${customer.address}" placeholder="123 Đường ABC, Quận XYZ"/>
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Ngày sinh</label>
                    <input type="date" name="dateOfBirth" value="<fmt:formatDate value='${customer.dateOfBirth}' pattern='yyyy-MM-dd'/>"/>
                </div>
                <div class="form-group">
                    <label>Trạng thái</label>
                    <select name="status">
                        <option value="ACTIVE" ${customer.status == 'ACTIVE' || customer.status == null ? 'selected' : ''}>Hoạt động</option>
                        <option value="INACTIVE" ${customer.status == 'INACTIVE' ? 'selected' : ''}>Ngừng hoạt động</option>
                        <option value="BLACKLIST" ${customer.status == 'BLACKLIST' ? 'selected' : ''}>Blacklist</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label>Ghi chú</label>
                <textarea name="notes" placeholder="Ghi chú về khách hàng...">${customer.notes}</textarea>
            </div>

            <div class="form-group">
                <label class="checkbox-label">
                    <input type="checkbox" name="acceptMarketing" value="true" ${customer.acceptMarketing ? 'checked' : ''}/>
                    Đồng ý nhận thông tin marketing
                </label>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Lưu khách hàng</button>
                <a href="${pageContext.request.contextPath}/staff/customer" class="btn btn-secondary">Hủy</a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>
