<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Báo cáo doanh thu</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f6fa;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 900px;
            margin: auto;
            background: #ffffff;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.08);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        .filter-box {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-group {
            flex: 1;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
        }

        input[type="datetime-local"] {
            width: 100%;
            padding: 8px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }

        button {
            margin-top: 22px;
            padding: 10px 18px;
            border: none;
            background: #007bff;
            color: white;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background: #0056b3;
        }

        .result-box {
            margin-top: 30px;
            padding: 20px;
            background: #f1f8ff;
            border-left: 5px solid #007bff;
        }

        .revenue {
            font-size: 26px;
            color: #28a745;
            font-weight: bold;
        }

        .error {
            background: #ffe5e5;
            color: #c00;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 15px;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>📊 Báo cáo doanh thu</h2>

    <!-- HIỂN THỊ LỖI -->
    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <!-- FORM LỌC -->
    <form action="${pageContext.request.contextPath}/payment/report" method="get">
        <div class="filter-box">

            <div class="form-group">
                <label>Ngày bắt đầu</label>
                <input type="datetime-local"
                       name="startDate"
                       value="${startDate.toString().substring(0,16)}"
                       required>
            </div>

            <div class="form-group">
                <label>Ngày kết thúc</label>
                <input type="datetime-local"
                       name="endDate"
                       value="${endDate.toString().substring(0,16)}"
                       required>
            </div>

            <div class="form-group" style="flex:0.4">
                <button type="submit">Lọc</button>
            </div>

        </div>
    </form>

    <!-- KẾT QUẢ -->
    <div class="result-box">
        <p><strong>Tổng doanh thu:</strong></p>
        <p class="revenue">
            <c:out value="${totalRevenue}" /> VNĐ
        </p>
    </div>

</div>

</body>
</html>
