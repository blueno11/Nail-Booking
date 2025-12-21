<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Khách hàng - Nailology Staff</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        .staff-container { max-width: 900px; margin: 2rem auto; padding: 0 1rem; }
        .breadcrumb { margin-bottom: 1rem; }
        .breadcrumb a { color: var(--primary-color); text-decoration: none; }
        .customer-header { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 2rem; flex-wrap: wrap; gap: 1rem; }
        .customer-name { font-size: 2rem; color: var(--primary-dark); margin: 0 0 0.5rem 0; }
        .customer-meta { color: var(--text-light); }
        .header-actions { display: flex; gap: 0.5rem; }
        .info-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 1.5rem; margin-bottom: 2rem; }
        .info-card { background: var(--white); padding: 1.5rem; border-radius: 0.75rem; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .info-card h3 { font-size: 1rem; color: var(--text-light); margin-bottom: 1rem; font-weight: 500; }
        .info-item { margin-bottom: 0.75rem; }
        .info-label { font-size: 0.75rem; color: var(--text-light); text-transform: uppercase; }
        .info-value { font-weight: 500; color: var(--primary-dark); }
        .badge { display: inline-block; padding: 0.25rem 0.5rem; border-radius: 0.25rem; font-size: 0.75rem; font-weight: 600; }
        .badge-active { background: #dcfce7; color: #166534; }
        .badge-inactive { background: #fee2e2; color: #dc2626; }
        .badge-blacklist { background: #1f2937; color: white; }
        .badge-marketing { background: #dbeafe; color: #1d4ed8; }
        .stats-row { display: flex; gap: 1rem; margin-bottom: 2rem; }
        .stat-box { flex: 1; background: var(--white); padding: 1.5rem; border-radius: 0.75rem; text-align: center; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .stat-value { font-size: 2rem; font-weight: 700; color: var(--primary-color); }
        .stat-label { font-size: 0.875rem; color: var(--text-light); }
        .section-title { font-size: 1.25rem; color: var(--primary-dark); margin-bottom: 1rem; }
        .history-list { background: var(--white); border-radius: 0.75rem; overflow: hidden; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
        .history-item { padding: 1rem 1.5rem; border-bottom: 1px solid var(--border-color); display: flex; justify-content: space-between; align-items: center; }
        .history-item:last-child { border-bottom: none; }
        .history-date { font-weight: 500; color: var(--primary-dark); }
        .history-services { font-size: 0.875rem; color: var(--text-light); }
        .history-price { font-weight: 600; color: var(--primary-color); }
        .empty-history { padding: 2rem; text-align: center; color: var(--text-light); }
        .action-buttons { margin-top: 2rem; display: flex; gap: 1rem; flex-wrap: wrap; }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="staff-container">
    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/staff/dashboard">Dashboard</a> / 
        <a href="${pageContext.request.contextPath}/staff/customer">Khách hàng</a> / 
        ${customer.fullName}
    </div>

    <div class="customer-header">
        <div>
            <h1 class="customer-name">${customer.fullName}</h1>
            <div class="customer-meta">
                ${customer.phoneNumber}
                <c:if test="${not empty customer.email}"> • ${customer.email}</c:if>
            </div>
        </div>
        <div class="header-actions">
            <a href="${pageContext.request.contextPath}/staff/customer/${customer.id}/edit" class="btn btn-primary">Chỉnh sửa</a>
            <a href="${pageContext.request.contextPath}/booking?customerId=${customer.id}" class="btn btn-secondary">Đặt lịch</a>
        </div>
    </div>

    <div class="stats-row">
        <div class="stat-box">
            <div class="stat-value">${visitCount}</div>
            <div class="stat-label">Lần ghé thăm</div>
        </div>
        <div class="stat-box">
            <div class="stat-value">
                <fmt:formatNumber value="${customer.totalSpent != null ? customer.totalSpent : 0}" type="currency" currencySymbol="$"/>
            </div>
            <div class="stat-label">Tổng chi tiêu</div>
        </div>
    </div>

    <div class="info-grid">
        <div class="info-card">
            <h3>Thông tin liên hệ</h3>
            <div class="info-item">
                <div class="info-label">Số điện thoại</div>
                <div class="info-value">${customer.phoneNumber}</div>
            </div>
            <div class="info-item">
                <div class="info-label">Email</div>
                <div class="info-value">${not empty customer.email ? customer.email : 'Chưa có'}</div>
            </div>
            <div class="info-item">
                <div class="info-label">Địa chỉ</div>
                <div class="info-value">${not empty customer.address ? customer.address : 'Chưa có'}</div>
            </div>
        </div>

        <div class="info-card">
            <h3>Thông tin khác</h3>
            <div class="info-item">
                <div class="info-label">Ngày sinh</div>
                <div class="info-value">
                    <c:if test="${customer.dateOfBirth != null}">
                        <fmt:formatDate value="${customer.dateOfBirth}" pattern="dd/MM/yyyy"/>
                    </c:if>
                    <c:if test="${customer.dateOfBirth == null}">Chưa có</c:if>
                </div>
            </div>
            <div class="info-item">
                <div class="info-label">Ngày đăng ký</div>
                <div class="info-value"><fmt:formatDate value="${customer.createdDate}" pattern="dd/MM/yyyy"/></div>
            </div>
            <div class="info-item">
                <div class="info-label">Lần ghé cuối</div>
                <div class="info-value">
                    <c:if test="${customer.lastVisitDate != null}">
                        <fmt:formatDate value="${customer.lastVisitDate}" pattern="dd/MM/yyyy HH:mm"/>
                    </c:if>
                    <c:if test="${customer.lastVisitDate == null}">Chưa có</c:if>
                </div>
            </div>
            <div class="info-item">
                <div class="info-label">Trạng thái</div>
                <div class="info-value">
                    <span class="badge badge-${customer.status == 'ACTIVE' ? 'active' : (customer.status == 'BLACKLIST' ? 'blacklist' : 'inactive')}">
                        ${customer.status == 'ACTIVE' ? 'Hoạt động' : (customer.status == 'BLACKLIST' ? 'Blacklist' : 'Ngừng')}
                    </span>
                    <c:if test="${customer.acceptMarketing}">
                        <span class="badge badge-marketing">Marketing</span>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <c:if test="${not empty customer.notes}">
    <div class="info-card" style="margin-bottom:2rem;">
        <h3>Ghi chú</h3>
        <p>${customer.notes}</p>
    </div>
    </c:if>

    <h2 class="section-title">Lịch sử dịch vụ gần đây</h2>
    <div class="history-list">
        <c:if test="${not empty serviceHistory}">
            <c:forEach items="${serviceHistory}" var="booking" end="4">
                <div class="history-item">
                    <div>
                        <div class="history-date">
                            <fmt:formatDate value="${booking.bookingDate}" pattern="dd/MM/yyyy"/> - ${booking.bookingTime}
                        </div>
                        <div class="history-services">${booking.serviceNames}</div>
                    </div>
                    <div class="history-price">
                        <fmt:formatNumber value="${booking.totalPrice}" type="currency" currencySymbol="$"/>
                    </div>
                </div>
            </c:forEach>
        </c:if>
        <c:if test="${empty serviceHistory}">
            <div class="empty-history">Chưa có lịch sử dịch vụ</div>
        </c:if>
    </div>

    <c:if test="${not empty serviceHistory && serviceHistory.size() > 5}">
        <div style="text-align:center; margin-top:1rem;">
            <a href="${pageContext.request.contextPath}/staff/customer/${customer.id}/history" class="btn btn-secondary">Xem tất cả lịch sử</a>
        </div>
    </c:if>

    <div class="action-buttons">
        <form action="${pageContext.request.contextPath}/staff/customer/${customer.id}/update-marketing" method="post" style="display:inline;">
            <input type="hidden" name="accept" value="${!customer.acceptMarketing}"/>
            <button type="submit" class="btn btn-secondary">
                ${customer.acceptMarketing ? 'Tắt' : 'Bật'} Marketing
            </button>
        </form>
        <form action="${pageContext.request.contextPath}/staff/customer/${customer.id}/update-status" method="post" style="display:inline;">
            <select name="status" onchange="this.form.submit()" style="padding:0.5rem 1rem; border-radius:0.375rem; border:1px solid var(--border-color);">
                <option value="">-- Đổi trạng thái --</option>
                <option value="ACTIVE">Hoạt động</option>
                <option value="INACTIVE">Ngừng</option>
                <option value="BLACKLIST">Blacklist</option>
            </select>
        </form>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>
