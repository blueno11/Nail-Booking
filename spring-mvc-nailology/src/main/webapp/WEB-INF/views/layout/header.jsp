<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header class="header">
    <div class="container">
        <div class="header-content">
            <a href="${pageContext.request.contextPath}/" class="logo">nailology</a>
            
            <nav class="nav-desktop">
                <a href="${pageContext.request.contextPath}/builder-gels" class="nav-link">DỊCH VỤ</a>
                <a href="#about" class="nav-link">VỀ CHÚNG TÔI</a>
                <a href="#gallery" class="nav-link">HÌNH ẢNH</a>
                <a href="#contact" class="nav-link">LIÊN HỆ</a>
                <a href="${pageContext.request.contextPath}/booking" class="btn btn-primary">ĐẶT LỊCH</a>
                
                <c:choose>
                    <c:when test="${not empty sessionScope.staffId}">
                        <a href="${pageContext.request.contextPath}/staff/dashboard" class="nav-link" style="margin-left:1rem;">
                            👤 ${sessionScope.staffName}
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/staff/login" class="nav-link" style="margin-left:1rem;">ĐĂNG NHẬP</a>
                    </c:otherwise>
                </c:choose>
            </nav>

            <button class="menu-toggle" id="menuToggle">☰</button>
        </div>
        
        <div class="nav-mobile" id="mobileMenu" style="display: none;">
            <a href="#services" class="nav-link">DỊCH VỤ</a>
            <a href="#about" class="nav-link">VỀ CHÚNG TÔI</a>
            <a href="#gallery" class="nav-link">HÌNH ẢNH</a>
            <a href="#contact" class="nav-link">LIÊN HỆ</a>
            <a href="${pageContext.request.contextPath}/booking" class="btn btn-primary">ĐẶT LỊCH</a>
            
            <c:choose>
                <c:when test="${not empty sessionScope.staffId}">
                    <a href="${pageContext.request.contextPath}/staff/dashboard" class="nav-link">👤 ${sessionScope.staffName}</a>
                    <a href="${pageContext.request.contextPath}/staff/logout" class="nav-link">Đăng xuất</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/staff/login" class="nav-link">ĐĂNG NHẬP</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>

<script>
document.getElementById('menuToggle').addEventListener('click', function() {
    var menu = document.getElementById('mobileMenu');
    menu.style.display = menu.style.display === 'none' ? 'block' : 'none';
});
</script>

