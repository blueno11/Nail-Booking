<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Quản lý Khách hàng - Nailology</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Lora:wght@400;500&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #c4a080;
            --dark: #3d3d3d;
            --accent: #d4af9e;
            --light-bg: #f5f1ed;
            --white: #ffffff;
            --border: #e0e0e0;
            --success: #28a745;
            --danger: #dc3545;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #f5f1ed 0%, #faf8f6 100%);
            font-family: 'Lora', serif;
            color: var(--dark);
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        /* Header Section */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 40px;
            padding-bottom: 30px;
            border-bottom: 2px solid var(--primary);
        }

        .page-header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 42px;
            font-weight: 600;
            color: var(--dark);
            letter-spacing: -0.5px;
        }

        .page-header p {
            color: #999;
            font-size: 14px;
            margin-top: 5px;
        }

        /* Buttons */
        .btn {
            padding: 12px 24px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-family: 'Lora', serif;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary) 0%, #a9886b 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(196, 160, 128, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(196, 160, 128, 0.4);
        }

        .btn-secondary {
            background: white;
            color: var(--primary);
            border: 2px solid var(--primary);
        }

        .btn-secondary:hover {
            background: var(--primary);
            color: white;
        }

        .btn-sm {
            padding: 8px 16px;
            font-size: 12px;
        }

        /* Stats Section */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            border-left: 5px solid var(--primary);
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .stat-label {
            font-size: 13px;
            color: #999;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 10px;
        }

        .stat-value {
            font-size: 32px;
            font-weight: 600;
            color: var(--primary);
            font-family: 'Playfair Display', serif;
        }

        /* Search Section */
        .search-section {
            background: white;
            padding: 25px;
            border-radius: 12px;
            margin-bottom: 30px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
        }

        .search-form {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            align-items: center;
        }

        .search-form input {
            flex: 1;
            min-width: 250px;
            padding: 12px 16px;
            border: 2px solid var(--border);
            border-radius: 8px;
            font-family: 'Lora', serif;
            font-size: 14px;
            transition: border-color 0.3s;
        }

        .search-form input:focus {
            outline: none;
            border-color: var(--primary);
        }

        /* Customers Grid */
        .customers-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .customer-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            border-top: 4px solid var(--primary);
        }

        .customer-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
        }

        .customer-card-header {
            background: linear-gradient(135deg, var(--light-bg) 0%, #faf8f6 100%);
            padding: 20px;
            border-bottom: 1px solid var(--border);
        }

        .customer-name {
            font-family: 'Playfair Display', serif;
            font-size: 20px;
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 5px;
        }

        .customer-id {
            font-size: 12px;
            color: #999;
            letter-spacing: 0.5px;
        }

        .customer-card-body {
            padding: 20px;
        }

        .info-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            font-size: 14px;
        }

        .info-label {
            color: #999;
            font-weight: 500;
        }

        .info-value {
            color: var(--dark);
            font-weight: 500;
        }

        .status-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .status-active {
            background: rgba(40, 167, 69, 0.1);
            color: var(--success);
        }

        .status-inactive {
            background: rgba(255, 193, 7, 0.1);
            color: #ffc107;
        }

        .status-blacklist {
            background: rgba(220, 53, 69, 0.1);
            color: var(--danger);
        }

        .marketing-status {
            font-size: 13px;
            font-weight: 600;
            padding: 4px 8px;
            border-radius: 6px;
        }

        .marketing-yes {
            background: rgba(40, 167, 69, 0.1);
            color: var(--success);
        }

        .marketing-no {
            background: rgba(220, 53, 69, 0.1);
            color: var(--danger);
        }

        .customer-spending {
            font-family: 'Playfair Display', serif;
            font-size: 18px;
            font-weight: 600;
            color: var(--primary);
        }

        .customer-card-footer {
            padding: 15px 20px;
            background: #f9f8f7;
            border-top: 1px solid var(--border);
            display: flex;
            gap: 8px;
        }

        .customer-card-footer .btn {
            flex: 1;
            text-align: center;
            margin: 0;
        }

        /* Empty State */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
        }

        .empty-state-icon {
            font-size: 64px;
            margin-bottom: 20px;
            opacity: 0.3;
        }

        .empty-state-title {
            font-family: 'Playfair Display', serif;
            font-size: 24px;
            color: var(--dark);
            margin-bottom: 10px;
        }

        .empty-state-text {
            color: #999;
            margin-bottom: 30px;
        }

        /* Messages */
        .message {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 14px;
        }

        .message.success {
            background: rgba(40, 167, 69, 0.1);
            color: var(--success);
            border-left: 4px solid var(--success);
        }

        .message.error {
            background: rgba(220, 53, 69, 0.1);
            color: var(--danger);
            border-left: 4px solid var(--danger);
        }

        /* Responsive */
        @media (max-width: 768px) {
            .page-header {
                flex-direction: column;
                align-items: flex-start;
                margin-bottom: 30px;
            }

            .search-form {
                flex-direction: column;
            }

            .search-form input,
            .search-form button {
                width: 100%;
            }

            .customers-grid {
                grid-template-columns: 1fr;
            }

            .page-header h1 {
                font-size: 28px;
                margin-bottom: 10px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />

    <div class="container">
        <!-- Page Header -->
        <div class="page-header">
            <div>
                <h1>Khách Hàng</h1>
                <p>Quản lý và theo dõi thông tin khách hàng</p>
            </div>
            <a href="${pageContext.request.contextPath}/customer/create" class="btn btn-primary">+ Thêm Khách Hàng</a>
        </div>

        <!-- Messages -->
        <c:if test="${not empty param.success}">
            <div class="message success">
                <span>✓</span> Thao tác thành công
            </div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div class="message error">
                <span>✗</span> Lỗi: ${param.error}
            </div>
        </c:if>

        <!-- Statistics -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-label">Khách Hàng Hoạt Động</div>
                <div class="stat-value">${activeCount}</div>
            </div>
            <div class="stat-card">
                <div class="stat-label">Tổng Khách Hàng</div>
                <div class="stat-value">${customers.size() > 0 ? customers.size() : 0}</div>
            </div>
        </div>

        <!-- Search Section -->
        <div class="search-section">
            <form method="get" action="${pageContext.request.contextPath}/customer" class="search-form">
                <input type="text" name="search" placeholder="Tìm kiếm theo tên hoặc số điện thoại..." 
                       value="${search}">
                <button type="submit" class="btn btn-primary btn-sm">🔍 Tìm Kiếm</button>
                <a href="${pageContext.request.contextPath}/customer" class="btn btn-secondary btn-sm">Xoá Bộ Lọc</a>
                <a href="${pageContext.request.contextPath}/customer/top-spenders" class="btn btn-secondary btn-sm">👑 Top Chi Tiêu</a>
                <a href="${pageContext.request.contextPath}/customer/new-customers" class="btn btn-secondary btn-sm">✨ Khách Mới</a>
            </form>
        </div>

        <!-- Customers Display -->
        <c:if test="${empty customers}">
            <div class="empty-state">
                <div class="empty-state-icon">👤</div>
                <div class="empty-state-title">Không có khách hàng nào</div>
                <div class="empty-state-text">Bắt đầu bằng cách thêm khách hàng đầu tiên</div>
                <a href="${pageContext.request.contextPath}/customer/create" class="btn btn-primary">+ Thêm Khách Hàng Mới</a>
            </div>
        </c:if>

        <c:if test="${not empty customers}">
            <div class="customers-grid">
                <c:forEach var="customer" items="${customers}">
                    <div class="customer-card">
                        <div class="customer-card-header">
                            <div class="customer-name">${customer.fullName}</div>
                            <div class="customer-id">ID: ${customer.id}</div>
                        </div>
                        <div class="customer-card-body">
                            <div class="info-row">
                                <span class="info-label">📱 Điện Thoại:</span>
                                <span class="info-value">${customer.phoneNumber}</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">✉️ Email:</span>
                                <span class="info-value">${not empty customer.email ? customer.email : 'N/A'}</span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Tổng Chi Tiêu:</span>
                                <span class="customer-spending"><fmt:formatNumber value="${customer.totalSpent}" type="currency" currencySymbol="đ" /></span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Trạng Thái:</span>
                                <span>
                                    <c:choose>
                                        <c:when test="${customer.status == 'ACTIVE'}">
                                            <span class="status-badge status-active">Hoạt Động</span>
                                        </c:when>
                                        <c:when test="${customer.status == 'INACTIVE'}">
                                            <span class="status-badge status-inactive">Không Hoạt Động</span>
                                        </c:when>
                                        <c:when test="${customer.status == 'BLACKLIST'}">
                                            <span class="status-badge status-blacklist">Danh Sách Đen</span>
                                        </c:when>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Marketing:</span>
                                <span>
                                    <c:if test="${customer.acceptMarketing}">
                                        <span class="marketing-status marketing-yes">✓ Có</span>
                                    </c:if>
                                    <c:if test="${not customer.acceptMarketing}">
                                        <span class="marketing-status marketing-no">✗ Không</span>
                                    </c:if>
                                </span>
                            </div>
                        </div>
                        <div class="customer-card-footer">
                            <a href="${pageContext.request.contextPath}/customer/${customer.id}" class="btn btn-secondary">Xem Chi Tiết</a>
                            <a href="${pageContext.request.contextPath}/customer/${customer.id}/edit" class="btn btn-primary">Chỉnh Sửa</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </div>

    <jsp:include page="../layout/footer.jsp" />
</body>
</html>