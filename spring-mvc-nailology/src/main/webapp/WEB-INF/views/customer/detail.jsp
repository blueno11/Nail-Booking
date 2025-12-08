<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết Khách hàng - Nailology</title>
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
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 40px;
            padding-bottom: 30px;
            border-bottom: 2px solid var(--primary);
            gap: 20px;
        }

        .header-content h1 {
            font-family: 'Playfair Display', serif;
            font-size: 42px;
            font-weight: 600;
            color: var(--dark);
            margin-bottom: 5px;
        }

        .header-content p {
            color: #999;
            font-size: 14px;
        }

        .action-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 12px 20px;
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

        .btn-danger {
            background: #dc3545;
            color: white;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
        }

        .btn-danger:hover {
            background: #c82333;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(220, 53, 69, 0.4);
        }

        .card {
            background: white;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05);
            border-left: 5px solid var(--primary);
        }

        .card-title {
            font-family: 'Playfair Display', serif;
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 20px;
            color: var(--dark);
        }

        .info-row {
            display: grid;
            grid-template-columns: 200px 1fr;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid var(--border);
        }

        .info-row:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .info-label {
            font-weight: 600;
            color: #999;
            font-size: 13px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .info-value {
            color: var(--dark);
            font-weight: 500;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-bottom: 20px;
        }

        .stat-box {
            background: linear-gradient(135deg, var(--light-bg) 0%, #faf8f6 100%);
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            border-left: 4px solid var(--primary);
        }

        .stat-value {
            font-family: 'Playfair Display', serif;
            font-size: 28px;
            font-weight: 600;
            color: var(--primary);
        }

        .stat-label {
            font-size: 12px;
            color: #999;
            margin-top: 8px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
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

        .marketing-badge {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .marketing-yes {
            background: rgba(40, 167, 69, 0.1);
            color: var(--success);
        }

        .marketing-no {
            background: rgba(220, 53, 69, 0.1);
            color: var(--danger);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th, td {
            border: 1px solid var(--border);
            padding: 12px;
            text-align: left;
        }

        th {
            background: linear-gradient(135deg, var(--light-bg) 0%, #faf8f6 100%);
            font-weight: 600;
            color: var(--dark);
        }

        tr:hover {
            background-color: #f9f8f7;
        }

        .message {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 14px;
        }

        .success {
            background: rgba(40, 167, 69, 0.1);
            color: var(--success);
            border-left: 4px solid var(--success);
        }

        .metadata {
            background: #f9f8f7;
            padding: 15px;
            border-radius: 8px;
            font-size: 12px;
            color: #999;
        }

        @media (max-width: 768px) {
            .header {
                flex-direction: column;
            }

            .info-row {
                grid-template-columns: 1fr;
            }

            .header-content h1 {
                font-size: 28px;
            }
        }
    </style>
    <script>
        function deleteCustomer() {
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = '${pageContext.request.contextPath}/customer/${customer.id}/delete';
            document.body.appendChild(form);
            form.submit();
        }
    </script>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />

    <div class="container">
        <!-- Header -->
        <div class="header">
            <div class="header-content">
                <h1>${customer.fullName}</h1>
                <p>ID: ${customer.id} | Khách hàng kể từ <fmt:formatDate value="${customer.createdDate}" pattern="dd/MM/yyyy"/></p>
            </div>
            <div class="action-buttons">
                <a href="${pageContext.request.contextPath}/customer/${customer.id}/edit" class="btn btn-primary">✎ Chỉnh sửa</a>
                <a href="${pageContext.request.contextPath}/customer/${customer.id}/service-history" class="btn btn-secondary">📋 Lịch sử</a>
                <button class="btn btn-danger" onclick="if(confirm('Bạn có chắc chắn muốn xoá khách hàng này? Hành động này không thể hoàn tác.')) { deleteCustomer(); }">🗑️ Xoá</button>
                <a href="${pageContext.request.contextPath}/customer" class="btn btn-secondary">← Quay lại</a>
            </div>
        </div>

        <!-- Messages -->
        <c:if test="${not empty param.success}">
            <div class="message success">✓ Cập nhật thành công</div>
        </c:if>

        <!-- Statistics -->
        <div class="card">
            <div class="card-title">📊 Thống kê</div>
            <div class="stats-grid">
                <div class="stat-box">
                    <div class="stat-value">${visitCount}</div>
                    <div class="stat-label">Lần Truy Cập</div>
                </div>
                <div class="stat-box">
                    <div class="stat-value"><fmt:formatNumber value="${customer.totalSpent}" type="number" maxFractionDigits="0"/></div>
                    <div class="stat-label">Tổng Chi Tiêu (đ)</div>
                </div>
                <div class="stat-box">
                    <c:if test="${not empty customer.lastVisitDate}">
                        <div class="stat-value"><fmt:formatDate value="${customer.lastVisitDate}" pattern="dd/MM/yyyy"/></div>
                        <div class="stat-label">Lần Truy Cập Cuối</div>
                    </c:if>
                    <c:if test="${empty customer.lastVisitDate}">
                        <div class="stat-value">-</div>
                        <div class="stat-label">Chưa Có Lần Truy Cập</div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Basic Information -->
        <div class="card">
            <div class="card-title">👤 Thông Tin Cơ Bản</div>
            
            <div class="info-row">
                <div class="info-label">📱 Điện Thoại</div>
                <div class="info-value">${customer.phoneNumber}</div>
            </div>
            <div class="info-row">
                <div class="info-label">✉️ Email</div>
                <div class="info-value">${not empty customer.email ? customer.email : 'N/A'}</div>
            </div>
            <div class="info-row">
                <div class="info-label">📍 Địa Chỉ</div>
                <div class="info-value">${not empty customer.address ? customer.address : 'N/A'}</div>
            </div>
            <div class="info-row">
                <div class="info-label">🎂 Ngày Sinh</div>
                <div class="info-value">
                    <c:if test="${not empty customer.dateOfBirth}">
                        <fmt:formatDate value="${customer.dateOfBirth}" pattern="dd/MM/yyyy"/>
                    </c:if>
                    <c:if test="${empty customer.dateOfBirth}">N/A</c:if>
                </div>
            </div>
            <div class="info-row">
                <div class="info-label">📝 Ghi Chú</div>
                <div class="info-value">${not empty customer.notes ? customer.notes : 'Không có'}</div>
            </div>
        </div>

        <!-- Status & Preferences -->
        <div class="card">
            <div class="card-title">⚙️ Trạng Thái & Tùy Chọn</div>
            
            <div class="info-row">
                <div class="info-label">Trạng Thái</div>
                <div class="info-value">
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
                </div>
            </div>

            <div class="info-row">
                <div class="info-label">Nhận Marketing</div>
                <div class="info-value">
                    <c:if test="${customer.acceptMarketing}">
                        <span class="marketing-badge marketing-yes">✓ Có</span>
                    </c:if>
                    <c:if test="${not customer.acceptMarketing}">
                        <span class="marketing-badge marketing-no">✗ Không</span>
                    </c:if>
                </div>
            </div>

            <div style="margin-top: 20px;">
                <form method="post" style="display: inline;" action="${pageContext.request.contextPath}/customer/${customer.id}/update-marketing">
                    <input type="hidden" name="accept" value="${not customer.acceptMarketing}">
                    <button type="submit" class="btn btn-secondary" style="width: auto;">
                        ${customer.acceptMarketing ? '✗ Huỷ' : '✓ Kích hoạt'} Marketing
                    </button>
                </form>
            </div>
        </div>

        <!-- Recent Service History -->
        <c:if test="${not empty serviceHistory}">
            <div class="card">
                <div class="card-title">📅 Lịch Sử Dịch Vụ Gần Đây</div>
                <table>
                    <thead>
                        <tr>
                            <th>Thời Gian</th>
                            <th>Trạng Thái</th>
                            <th>Tổng Tiền</th>
                            <th>Chi Tiết</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="booking" items="${serviceHistory}" begin="0" end="4">
                            <tr>
                                <td><fmt:formatDate value="${booking.bookingDateTime}" pattern="dd/MM/yyyy HH:mm"/></td>
                                <td>${booking.status}</td>
                                <td><fmt:formatNumber value="${booking.totalAmount}" type="currency" currencySymbol="đ" /></td>
                                <td><a href="${pageContext.request.contextPath}/booking/${booking.id}" class="btn btn-secondary" style="padding: 6px 12px; font-size: 12px;">Chi tiết</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <c:if test="${visitCount > 5}">
                    <div style="margin-top: 15px;">
                        <a href="${pageContext.request.contextPath}/customer/${customer.id}/service-history" class="btn btn-secondary">Xem toàn bộ lịch sử →</a>
                    </div>
                </c:if>
            </div>
        </c:if>

        <!-- Metadata -->
        <div class="metadata">
            📋 Hồ sơ được tạo lúc: <fmt:formatDate value="${customer.createdDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
            <c:if test="${not empty customer.lastVisitDate}">
                | Truy cập cuối: <fmt:formatDate value="${customer.lastVisitDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
            </c:if>
        </div>
    </div>

    <jsp:include page="../layout/footer.jsp" />
</body>
</html>
