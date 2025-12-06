<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>Lịch sử dịch vụ Khách hàng</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .container { max-width: 1000px; margin: 0 auto; padding: 20px; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .btn { padding: 10px 15px; background-color: #007bff; color: white; text-decoration: none; border-radius: 4px; border: none; cursor: pointer; }
        .btn:hover { background-color: #0056b3; }
        .customer-info { background-color: #f8f9fa; padding: 15px; border-radius: 4px; margin-bottom: 20px; border-left: 4px solid #007bff; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #f8f9fa; font-weight: bold; }
        tr:hover { background-color: #f5f5f5; }
        .status-pending { color: orange; }
        .status-confirmed { color: blue; }
        .status-completed { color: green; }
        .status-cancelled { color: red; }
    </style>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />

    <div class="container">
        <div class="header">
            <h1>Lịch sử dịch vụ: ${customer.fullName}</h1>
            <a href="${pageContext.request.contextPath}/customer/${customer.id}" class="btn">← Quay lại</a>
        </div>

        <div class="customer-info">
            <strong>Khách hàng:</strong> ${customer.fullName} | 
            <strong>SĐT:</strong> ${customer.phoneNumber} | 
            <strong>Tổng lần truy cập:</strong> ${visitCount} | 
            <strong>Tổng chi tiêu:</strong> <fmt:formatNumber value="${customer.totalSpent}" type="currency" currencySymbol="đ" />
        </div>

        <c:if test="${empty serviceHistory}">
            <p style="text-align: center; padding: 40px; color: #999; font-size: 16px;">Không có lịch sử dịch vụ</p>
        </c:if>

        <c:if test="${not empty serviceHistory}">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Ngày & Giờ</th>
                        <th>Trạng thái</th>
                        <th>Tổng tiền</th>
                        <th>Nhân viên</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="booking" items="${serviceHistory}">
                        <tr>
                            <td>${booking.id}</td>
                            <td><fmt:formatDate value="${booking.bookingDateTime}" pattern="dd/MM/yyyy HH:mm"/></td>
                            <td>
                                <span class="status-${fn:toLowerCase(booking.status)}">
                                    <c:choose>
                                        <c:when test="${booking.status == 'PENDING'}">Chờ xác nhận</c:when>
                                        <c:when test="${booking.status == 'CONFIRMED'}">Xác nhận</c:when>
                                        <c:when test="${booking.status == 'COMPLETED'}">Hoàn thành</c:when>
                                        <c:when test="${booking.status == 'CANCELLED'}">Huỷ</c:when>
                                        <c:otherwise>${booking.status}</c:otherwise>
                                    </c:choose>
                                </span>
                            </td>
                            <td><fmt:formatNumber value="${booking.totalAmount}" type="currency" currencySymbol="đ" /></td>
                            <td>${booking.staff.fullName != null ? booking.staff.fullName : '-'}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/booking/${booking.id}" class="btn" style="padding: 5px 10px; font-size: 12px;">Xem</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
    </div>

    <jsp:include page="../layout/footer.jsp" />
</body>
</html>
