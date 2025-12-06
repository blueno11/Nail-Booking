<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Top Chi Tiêu - Nailology</title>
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
        .btn-secondary { background: white; color: var(--primary); border: 2px solid var(--primary); width: 100%; text-align: center; }
        .btn-secondary:hover { background: var(--primary); color: white; }
        .top-cards { display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 25px; margin-bottom: 25px; }
        .rank-card { background: white; border-radius: 12px; padding: 25px; box-shadow: 0 2px 12px rgba(0, 0, 0, 0.05); border-top: 4px solid var(--primary); position: relative; overflow: hidden; transition: all 0.3s ease; }
        .rank-card:hover { transform: translateY(-8px); box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15); }
        .rank-badge { position: absolute; top: 10px; right: 10px; font-size: 24px; }
        .rank-number { font-family: 'Playfair Display', serif; font-size: 32px; font-weight: 600; color: var(--primary); margin-bottom: 5px; }
        .rank-label { font-size: 11px; text-transform: uppercase; color: #999; letter-spacing: 0.5px; margin-bottom: 15px; }
        .rank-name { font-family: 'Playfair Display', serif; font-size: 20px; font-weight: 600; color: var(--dark); margin-bottom: 15px; }
        .rank-info { font-size: 13px; margin-bottom: 8px; color: #666; }
        .rank-spending { font-family: 'Playfair Display', serif; font-size: 26px; font-weight: 600; color: var(--primary); margin: 15px 0; }
        .rank-button { margin-top: 15px; }
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
                <h1>👑 Top Chi Tiêu Cao Nhất</h1>
                <p>10 khách hàng chi tiêu hàng đầu</p>
            </div>
            <a href="${pageContext.request.contextPath}/customer" class="btn btn-secondary" style="width: auto; border: 2px solid var(--primary);">← Quay Lại</a>
        </div>

        <c:if test="${empty customers}">
            <div class="empty-state">
                <div class="empty-state-icon">👑</div>
                <div class="empty-state-title">Không có dữ liệu</div>
                <div class="empty-state-text">Chưa có khách hàng nào để hiển thị</div>
                <a href="${pageContext.request.contextPath}/customer" class="btn btn-primary">← Quay Lại</a>
            </div>
        </c:if>

        <c:if test="${not empty customers}">
            <div class="top-cards">
                <c:forEach var="customer" items="${customers}" varStatus="status">
                    <div class="rank-card">
                        <div class="rank-badge">
                            <c:choose>
                                <c:when test="${status.index == 0}">🥇</c:when>
                                <c:when test="${status.index == 1}">🥈</c:when>
                                <c:when test="${status.index == 2}">🥉</c:when>
                                <c:otherwise>⭐</c:otherwise>
                            </c:choose>
                        </div>
                        <div class="rank-number">#${status.index + 1}</div>
                        <div class="rank-label">Xếp Hạng</div>
                        <div class="rank-name">${customer.fullName}</div>
                        <div class="rank-info">📱 ${customer.phoneNumber}</div>
                        <div class="rank-info">✉️ ${not empty customer.email ? customer.email : 'N/A'}</div>
                        <div class="rank-spending">
                            <fmt:formatNumber value="${customer.totalSpent}" type="currency" currencySymbol="đ"/>
                        </div>
                        <div class="rank-button">
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
