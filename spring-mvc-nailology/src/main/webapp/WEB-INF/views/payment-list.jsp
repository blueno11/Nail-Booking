<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Quản lý thanh toán</title>

    <style>
        body {
            margin: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            background: #f4f6f9;
        }

        .container {
            max-width: 1200px;
            margin: 30px auto;
            background: #ffffff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.06);
        }

        h2 {
            margin-bottom: 10px;
        }

        .stats {
            margin-bottom: 20px;
            font-size: 14px;
        }

        .stats span {
            margin-right: 20px;
            font-weight: 600;
        }

        /* ===== FORM ===== */
        .filter-box {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 15px;
        }

        select, input {
            padding: 8px 10px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 14px;
        }

        button {
            padding: 8px 15px;
            border: none;
            border-radius: 6px;
            background: #007bff;
            color: #fff;
            cursor: pointer;
            font-size: 14px;
        }

        button:hover {
            background: #0056b3;
        }

        /* ===== TABLE ===== */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #e0e0e0;
            text-align: center;
            font-size: 14px;
        }

        th {
            background: #f8f9fa;
            font-weight: 600;
        }

        tr:hover {
            background: #f9f9f9;
        }

        /* ===== BADGE ===== */
        .badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            color: #fff;
            display: inline-block;
        }

        .PENDING { background: #f59e0b; }
        .COMPLETED { background: #22c55e; }
        .FAILED { background: #ef4444; }
        .REFUNDED { background: #6b7280; }

        a {
            color: #2563eb;
            text-decoration: none;
            font-weight: 500;
        }

        a:hover {
            text-decoration: underline;
        }

        .empty {
            padding: 20px;
            text-align: center;
            color: #777;
        }

        .success { color: #16a34a; }
        .error { color: #dc2626; }
    </style>
</head>

<body>

<div class="container">

    <h2>📋 Quản lý thanh toán</h2>

    <!-- Thông báo -->
    <c:if test="${not empty success}">
        <p class="success">${success}</p>
    </c:if>
    <c:if test="${not empty error}">
        <p class="error">${error}</p>
    </c:if>

    <!-- Thống kê -->
    <div class="stats">
        <span>⏳ Chờ thanh toán: ${pendingCount}</span>
        <span>✅ Đã thanh toán: ${completedCount}</span>
    </div>

    <!-- Lọc + tìm kiếm -->
    <form action="${pageContext.request.contextPath}/payment/manage" method="get" class="filter-box">
        <select name="status">
            <option value="">-- Tất cả trạng thái --</option>
            <c:forEach items="${paymentStatuses}" var="st">
                <option value="${st}" <c:if test="${selectedStatus == st}">selected</c:if>>
                    ${st}
                </option>
            </c:forEach>
        </select>

        <input type="text" name="paymentCode" placeholder="Mã payment">
        <input type="text" name="email" placeholder="Email">
        <input type="text" name="phone" placeholder="SĐT">

        <button type="submit">🔍 Tìm kiếm</button>
    </form>

    <!-- Table -->
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Mã Payment</th>
            <th>Booking</th>
            <th>Số tiền</th>
            <th>Phương thức</th>
            <th>Trạng thái</th>
            <th>Email</th>
            <th>SĐT</th>
            <th>Ngày tạo</th>
            <th>Thao tác</th>
        </tr>
        </thead>
        <tbody>

        <c:if test="${empty payments}">
            <tr>
                <td colspan="10" class="empty">Không có dữ liệu</td>
            </tr>
        </c:if>

        <c:forEach items="${payments}" var="p">
            <tr>
                <td>${p.id}</td>
                <td>${p.paymentCode}</td>
                <td>${p.booking.bookingCode}</td>
                <td>
                    <fmt:formatNumber value="${p.amount}" type="currency" currencySymbol="₫"/>
                </td>
                <td>${p.paymentMethod}</td>
                <td>
                    <span class="badge ${p.status}">${p.status}</span>
                </td>
                <td>${p.customerEmail}</td>
                <td>${p.customerPhone}</td>
                <td>${p.createdAt.toString().substring(0,16)}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/payment/view/${p.paymentCode}">
                        Chi tiết
                    </a>
                </td>
            </tr>
        </c:forEach>

        </tbody>
    </table>

</div>

</body>
</html>
