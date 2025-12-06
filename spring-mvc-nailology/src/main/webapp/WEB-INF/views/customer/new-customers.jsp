<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
    <title>Khách Hàng Mới - Nailology</title>
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
        }
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { background: linear-gradient(135deg, #f5f1ed 0%, #faf8f6 100%); font-family: 'Lora', serif; color: var(--dark); }
        .container { max-width: 1400px; margin: 0 auto; padding: 40px 20px; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 40px; padding-bottom: 30px; border-bottom: 2px solid var(--primary); }
        .page-header h1 { font-family: 'Playfair Display', serif; font-size: 42px; font-weight: 600; color: var(--dark); }
        .page-header p { color: #999; font-size: 14px; margin-top: 5px; }
        .btn { padding: 12px 24px; border-radius: 8px; border: none; cursor: pointer; font-family: 'Lora', serif; font-size: 14px; font-weight: 500; transition: all 0.3s ease; text-decoration: none; display: inline-block; }
        .btn-primary { background: linear-gradient(135deg, var(--primary) 0%, #a9886b 100%); color: white; box-shadow: 0 4px 15px rgba(196, 160, 128, 0.3); }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(196, 160, 128, 0.4); }
        .btn-secondary { background: white; color: var(--primary); border: 2px solid var(--primary); }
        .btn-secondary:hover { background: var(--primary); color: white; }
        .customers-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 25px; margin-bottom: 40px; }
        .customer-card { background: white; border-radius: 12px; overflow: hidden; box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05); transition: all 0.3s ease; border-top: 4px solid var(--primary); }
        .customer-card:hover { transform: translateY(-8px); box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15); }
        .customer-card-header { background: linear-gradient(135deg, var(--light-bg) 0%, #faf8f6 100%); padding: 20px; border-bottom: 1px solid var(--border); }
        .customer-name { font-family: 'Playfair Display', serif; font-size: 20px; font-weight: 600; color: var(--dark); margin-bottom: 5px; }
        .customer-id { font-size: 12px; color: #999; letter-spacing: 0.5px; }
        .customer-card-body { padding: 20px; }
        .info-row { display: flex; justify-content: space-between; margin-bottom: 12px; font-size: 14px; }
        .info-label { color: #999; font-weight: 500; }
        .info-value { color: var(--dark); font-weight: 500; }
        .status-badge { display: inline-block; padding: 6px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.5px; background: rgba(40, 167, 69, 0.1); color: var(--success); }
        .customer-card-footer { padding: 15px 20px; background: #f9f8f7; border-top: 1px solid var(--border); display: flex; gap: 8px; }
        .customer-card-footer .btn { flex: 1; text-align: center; margin: 0; }
        .empty-state { text-align: center; padding: 60px 20px; }
        .empty-state-icon { font-size: 64px; margin-bottom: 20px; opacity: 0.3; }
        .empty-state-title { font-family: 'Playfair Display', serif; font-size: 24px; color: var(--dark); margin-bottom: 10px; }
        .empty-state-text { color: #999; margin-bottom: 30px; }
    </style>
</head>
<body>
    <jsp:include page="../layout/header.jsp" />

    <div class="container">
        <div class="page-header">
            <div>
                <h1>✨ Khách Hàng Mới</h1>
                <p>Khách hàng đăng ký trong ${days} ngày qua (${fn:length(customers)})</p>
            </div>
            <a href="${pageContext.request.contextPath}/customer" class="btn btn-secondary">← Quay Lại</a>
        </div>

        <c:if test="${empty customers}">
            <div class="empty-state">
                <div class="empty-state-icon">✨</div>
                <div class="empty-state-title">Không có khách hàng mới</div>
                <div class="empty-state-text">Chưa có khách hàng mới đăng ký trong ${days} ngày qua</div>
                <a href="${pageContext.request.contextPath}/customer" class="btn btn-primary">← Quay Lại</a>
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
                                <span class="info-label">📅 Đăng Ký:</span>
                                <span class="info-value"><fmt:formatDate value="${customer.createdDate}" pattern="dd/MM/yyyy"/></span>
                            </div>
                            <div class="info-row">
                                <span class="info-label">Trạng Thái:</span>
                                <span>
                                    <c:if test="${customer.status == 'ACTIVE'}">
                                        <span class="status-badge">Hoạt Động</span>
                                    </c:if>
                                </span>
                            </div>
                        </div>
                        <div class="customer-card-footer">
                            <a href="${pageContext.request.contextPath}/customer/${customer.id}" class="btn btn-secondary">Xem Chi Tiết</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </div>

    <jsp:include page="../layout/footer.jsp" />
</body>
</html>
