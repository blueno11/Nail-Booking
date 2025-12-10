<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt lịch - Nailology</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<jsp:include page="../layout/header.jsp" />

<div class="container">
    <div class="page-header">
        <div>
            <h1>📅 Đặt Lịch</h1>
            <p>Chọn ngày/giờ, chi nhánh và kỹ thuật viên</p>
        </div>
        <a href="${pageContext.request.contextPath}/booking/list" class="btn btn-secondary">Danh sách lịch</a>
    </div>

    <form method="post" action="${pageContext.request.contextPath}/booking/submit" class="form-card">
        <div style="display:flex;gap:20px;flex-wrap:wrap;">
            <div style="flex:1;min-width:320px;">
                <label>Họ tên khách</label>
                <input type="text" name="customerName" value="${bookingForm.customerName}" required>

                <label>Email</label>
                <input type="email" name="email" value="${bookingForm.email}">

                <label>Điện thoại</label>
                <input type="text" name="phone" value="${bookingForm.phone}" required>

                <label>Chi nhánh</label>
                <select name="locationId">
                    <option value="">-- Chọn chi nhánh --</option>
                    <c:forEach var="loc" items="${locations}">
                        <option value="${loc.id}" ${bookingForm.locationId == loc.id ? 'selected' : ''}>${loc.name}</option>
                    </c:forEach>
                </select>

                <label>Kỹ thuật viên</label>
                <select name="staffId">
                    <option value="">-- Chọn kỹ thuật viên --</option>
                    <c:forEach var="s" items="${staffs}">
                        <option value="${s.id}" ${bookingForm.staffId == s.id ? 'selected' : ''}>${s.name}</option>
                    </c:forEach>
                </select>
            </div>

            <div style="flex:1;min-width:320px;">
                <label>Ngày</label>
                <input type="date" name="date" value="${bookingForm.date}" required>

                <label>Giờ</label>
                <input type="time" name="time" value="${bookingForm.time}" required>

                <label>Dịch vụ</label>
                <div style="display:flex;flex-direction:column;gap:8px;max-height:320px;overflow:auto;padding:8px;border:1px solid #eee;border-radius:8px;">
                    <c:forEach var="svc" items="${services}">
                        <label style="font-weight:normal;">
                            <input type="checkbox" name="selectedServiceIds" value="${svc.id}" 
                                   <c:if test="${bookingForm.selectedServiceIds != null && bookingForm.selectedServiceIds.contains(svc.id.intValue())}">checked</c:if> />
                            ${svc.name} - <fmt:formatNumber value="${svc.startingPrice}" type="currency" currencySymbol="đ" />
                        </label>
                    </c:forEach>
                </div>

                <label>Ghi chú</label>
                <textarea name="message" rows="4">${bookingForm.message}</textarea>

                <input type="hidden" name="customerId" value="${selectedCustomerId}" />

                <div style="margin-top:16px;">
                    <button class="btn btn-primary" type="submit">💾 Lưu đặt lịch</button>
                    <a href="${pageContext.request.contextPath}/customer" class="btn btn-secondary">← Quay lại</a>
                </div>
            </div>
        </div>
    </form>
</div>

<jsp:include page="../layout/footer.jsp" />
</body>
</html>