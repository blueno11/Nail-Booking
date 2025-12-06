<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>Khách hàng nhận Marketing</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; }
        .btn { padding: 10px 15px; background-color: #007bff; color: white; text-decoration: none; border-radius: 4px; border: none; cursor: pointer; }
        .btn:hover { background-color: #0056b3; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #f8f9fa; font-weight: bold; }
        tr:hover { background-color: #f5f5f5; }
    </style>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />

    <div class="container">
        <div class="header">
            <h1>📧 Khách hàng nhận Marketing (${fn:length(customers)})</h1>
            <a href="${pageContext.request.contextPath}/customer" class="btn">← Quay lại</a>
        </div>

        <c:if test="${empty customers}">
            <p style="text-align: center; padding: 40px; color: #999;">Không có khách hàng nào đồng ý nhận marketing</p>
        </c:if>

        <c:if test="${not empty customers}">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên khách hàng</th>
                        <th>Số điện thoại</th>
                        <th>Email</th>
                        <th>Tổng chi tiêu</th>
                        <th>Thao tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="customer" items="${customers}">
                        <tr>
                            <td>${customer.id}</td>
                            <td><strong>${customer.fullName}</strong></td>
                            <td>${customer.phoneNumber}</td>
                            <td>${customer.email}</td>
                            <td><fmt:formatNumber value="${customer.totalSpent}" type="currency" currencySymbol="đ" /></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/customer/${customer.id}" class="btn">Xem</a>
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
