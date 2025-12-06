<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Chọn Khách hàng cho Booking</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .container { max-width: 900px; margin: 0 auto; padding: 20px; }
        .tabs { display: flex; gap: 10px; margin-bottom: 20px; }
        .tab-button {
            padding: 10px 20px;
            background-color: #f8f9fa;
            border: 1px solid #ddd;
            border-radius: 4px 4px 0 0;
            cursor: pointer;
            font-weight: bold;
        }
        .tab-button.active {
            background-color: #007bff;
            color: white;
            border: 1px solid #007bff;
        }
        .tab-content {
            display: none;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 0 4px 4px 4px;
        }
        .tab-content.active {
            display: block;
        }
        .search-box { margin-bottom: 20px; }
        .search-box input { padding: 8px; width: 300px; }
        .search-box button { padding: 8px 15px; background-color: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #f8f9fa; font-weight: bold; }
        tr:hover { background-color: #f5f5f5; cursor: pointer; }
        .btn { padding: 8px 15px; background-color: #007bff; color: white; text-decoration: none; border-radius: 4px; border: none; cursor: pointer; margin: 2px; }
        .btn:hover { background-color: #0056b3; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input[type="text"],
        input[type="email"],
        input[type="tel"],
        input[type="date"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .form-section {
            max-width: 500px;
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 4px;
        }
    </style>
    <script>
        function switchTab(tabName) {
            // Hide all tabs
            document.querySelectorAll('.tab-content').forEach(tab => {
                tab.classList.remove('active');
            });
            document.querySelectorAll('.tab-button').forEach(btn => {
                btn.classList.remove('active');
            });
            
            // Show selected tab
            document.getElementById(tabName).classList.add('active');
            event.target.classList.add('active');
        }

        function selectCustomer(customerId, customerName, customerPhone) {
            // Redirect to booking with selected customer
            window.location.href = '/booking?customerId=' + customerId;
        }
    </script>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />

    <div class="container">
        <h1>Liên kết Booking với Khách hàng</h1>

        <!-- Tabs -->
        <div class="tabs">
            <button class="tab-button active" onclick="switchTab('existing-customers')">Khách hàng hiện có</button>
            <button class="tab-button" onclick="switchTab('new-customer')">Thêm khách hàng mới</button>
        </div>

        <!-- Tab 1: Danh sách khách hàng hiện có -->
        <div id="existing-customers" class="tab-content active">
            <div class="search-box">
                <form method="get" action="${pageContext.request.contextPath}/customer/select-for-booking">
                    <input type="text" name="search" placeholder="Tìm kiếm theo tên hoặc số điện thoại..."
                           value="${search}">
                    <button type="submit">Tìm kiếm</button>
                </form>
            </div>

            <c:if test="${empty customers}">
                <p style="text-align: center; padding: 40px; color: #999;">Không tìm thấy khách hàng</p>
            </c:if>

            <c:if test="${not empty customers}">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Tên khách hàng</th>
                            <th>Số điện thoại</th>
                            <th>Email</th>
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
                                <td>
                                    <button class="btn" onclick="selectCustomer(${customer.id}, '${customer.fullName}', '${customer.phoneNumber}')">
                                        Chọn
                                    </button>
                                    <a href="${pageContext.request.contextPath}/customer/${customer.id}" class="btn" style="background-color: #6c757d;">Xem</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>

        <!-- Tab 2: Thêm khách hàng mới -->
        <div id="new-customer" class="tab-content">
            <div class="form-section">
                <h3>Tạo khách hàng mới</h3>
                <form method="post" action="${pageContext.request.contextPath}/customer/create-from-booking">
                    <div class="form-group">
                        <label for="fullName">Tên khách hàng *</label>
                        <input type="text" id="fullName" name="fullName" required>
                    </div>

                    <div class="form-group">
                        <label for="phoneNumber">Số điện thoại *</label>
                        <input type="tel" id="phoneNumber" name="phoneNumber" required>
                    </div>

                    <div class="form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email">
                    </div>

                    <div class="form-group">
                        <label for="address">Địa chỉ</label>
                        <input type="text" id="address" name="address">
                    </div>

                    <div class="form-group">
                        <input type="checkbox" id="acceptMarketing" name="acceptMarketing" value="true" checked>
                        <label for="acceptMarketing" style="display: inline; margin: 0;">Chấp nhận nhận thông tin khuyến mãi</label>
                    </div>

                    <div class="form-group">
                        <button type="submit" class="btn" style="width: 100%; padding: 12px;">✓ Tạo & Tiếp tục đặt lịch</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <jsp:include page="../layout/footer.jsp" />
</body>
</html>
