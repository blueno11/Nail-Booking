<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Khách hàng - Nailology Staff</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        .staff-container { max-width: 1200px; margin: 2rem auto; padding: 0 1rem; }
        .page-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 1.5rem; flex-wrap: wrap; gap: 1rem; }
        .page-title { font-size: 1.75rem; color: var(--primary-dark); margin: 0; }
        .breadcrumb { margin-bottom: 1rem; }
        .breadcrumb a { color: var(--primary-color); text-decoration: none; }
        .filters { display: flex; gap: 1rem; margin-bottom: 1.5rem; flex-wrap: wrap; align-items: center; }
        .search-box { flex: 1; min-width: 250px; }
        .search-box input { width: 100%; padding: 0.75rem 1rem; border: 1px solid var(--border-color); border-radius: 0.5rem; }
        .filter-tabs { display: flex; gap: 0.5rem; }
        .filter-tab { padding: 0.5rem 1rem; border: 1px solid var(--border-color); border-radius: 0.375rem; text-decoration: none; color: var(--text-color); font-size: 0.875rem; background: var(--white); }
        .filter-tab:hover, .filter-tab.active { background: var(--primary-color); color: white; border-color: var(--primary-color); }
        table { width: 100%; border-collapse: collapse; background: var(--white); border-radius: 0.5rem; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        th { background: var(--primary-color); color: white; padding: 1rem; text-align: left; font-weight: 500; }
        td { padding: 1rem; border-bottom: 1px solid var(--border-color); }
        tr:hover { background: #faf7f4; }
        .customer-name { font-weight: 600; color: var(--primary-dark); }
        .customer-phone { color: var(--text-light); font-size: 0.875rem; }
        .badge { display: inline-block; padding: 0.25rem 0.5rem; border-radius: 0.25rem; font-size: 0.75rem; font-weight: 600; }
        .badge-active { background: #dcfce7; color: #166534; }
        .badge-inactive { background: #fee2e2; color: #dc2626; }
        .badge-blacklist { background: #1f2937; color: white; }
        .badge-marketing { background: #dbeafe; color: #1d4ed8; }
        .action-links a { color: var(--primary-color); text-decoration: none; margin-right: 0.75rem; font-size: 0.875rem; }
        .action-links a:hover { text-decoration: underline; }
        .stats-bar { display: flex; gap: 1rem; margin-bottom: 1.5rem; }
        .stat-item { background: var(--white); padding: 1rem 1.5rem; border-radius: 0.5rem; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        .stat-value { font-size: 1.5rem; font-weight: 700; color: var(--primary-color); }
        .stat-label { font-size: 0.75rem; color: var(--text-light); }
        .empty-state { text-align: center; padding: 3rem; color: var(--text-light); }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="staff-container">
    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/staff/dashboard">Dashboard</a> / Khách hàng
    </div>

    <div class="page-header">
        <h1 class="page-title">Quản lý Khách hàng</h1>
        <a href="${pageContext.request.contextPath}/staff/customer/create" class="btn btn-primary">+ Thêm khách hàng</a>
    </div>

    <div class="stats-bar">
        <div class="stat-item">
            <div class="stat-value">${activeCount}</div>
            <div class="stat-label">Khách hàng hoạt động</div>
        </div>
    </div>

    <div class="filters">
        <form class="search-box" action="${pageContext.request.contextPath}/staff/customer" method="get">
            <input type="text" name="search" value="${search}" placeholder="Tìm theo tên hoặc SĐT..."/>
        </form>
        <div class="filter-tabs">
            <a href="${pageContext.request.contextPath}/staff/customer?status=ACTIVE" class="filter-tab ${status == 'ACTIVE' && !filterMarketing ? 'active' : ''}">Hoạt động</a>
            <a href="${pageContext.request.contextPath}/staff/customer?status=ALL" class="filter-tab ${status == 'ALL' ? 'active' : ''}">Tất cả</a>
            <a href="${pageContext.request.contextPath}/staff/customer?status=BLACKLIST" class="filter-tab ${status == 'BLACKLIST' ? 'active' : ''}">Blacklist</a>
            <a href="${pageContext.request.contextPath}/staff/customer?marketing=true" class="filter-tab ${filterMarketing ? 'active' : ''}">Marketing</a>
        </div>
    </div>

    <c:if test="${not empty customers}">
    <table>
        <thead>
            <tr>
                <th>Khách hàng</th>
                <th>Email</th>
                <th>Lần ghé cuối</th>
                <th>Tổng chi tiêu</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${customers}" var="c">
                <tr>
                    <td>
                        <div class="customer-name">${c.fullName}</div>
                        <div class="customer-phone">${c.phoneNumber}</div>
                    </td>
                    <td>${c.email}</td>
                    <td>
                        <c:if test="${c.lastVisitDate != null}">
                            <fmt:formatDate value="${c.lastVisitDate}" pattern="dd/MM/yyyy"/>
                        </c:if>
                        <c:if test="${c.lastVisitDate == null}">
                            <span style="color:#999">Chưa có</span>
                        </c:if>
                    </td>
                    <td>
                        <c:if test="${c.totalSpent != null && c.totalSpent > 0}">
                            <fmt:formatNumber value="${c.totalSpent}" type="currency" currencySymbol="$"/>
                        </c:if>
                        <c:if test="${c.totalSpent == null || c.totalSpent == 0}">
                            $0
                        </c:if>
                    </td>
                    <td>
                        <span class="badge badge-${c.status == 'ACTIVE' ? 'active' : (c.status == 'BLACKLIST' ? 'blacklist' : 'inactive')}">
                            ${c.status == 'ACTIVE' ? 'Hoạt động' : (c.status == 'BLACKLIST' ? 'Blacklist' : 'Ngừng')}
                        </span>
                        <c:if test="${c.acceptMarketing}">
                            <span class="badge badge-marketing">Marketing</span>
                        </c:if>
                    </td>
                    <td class="action-links">
                        <a href="${pageContext.request.contextPath}/staff/customer/${c.id}">Chi tiết</a>
                        <a href="${pageContext.request.contextPath}/staff/customer/${c.id}/edit">Sửa</a>
                        <a href="${pageContext.request.contextPath}/staff/customer/${c.id}/history">Lịch sử</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </c:if>

    <c:if test="${empty customers}">
    <div class="empty-state">
        <p>Không tìm thấy khách hàng nào.</p>
        <a href="${pageContext.request.contextPath}/staff/customer/create" class="btn btn-primary" style="margin-top:1rem">Thêm khách hàng đầu tiên</a>
    </div>
    </c:if>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" />
</body>
</html>
