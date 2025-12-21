package com.nailology.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Filter bảo vệ khu vực Staff (/staff/*)
 * Yêu cầu đăng nhập với role STAFF hoặc ADMIN
 */
public class StaffAuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();

        // Cho phép truy cập trang login
        if (requestURI.equals(contextPath + "/staff/login") || 
            requestURI.equals(contextPath + "/staff/logout")) {
            chain.doFilter(request, response);
            return;
        }

        // Kiểm tra đã đăng nhập chưa
        boolean isLoggedIn = false;
        String userRole = null;

        if (session != null) {
            Object staffId = session.getAttribute("staffId");
            userRole = (String) session.getAttribute("staffRole");
            isLoggedIn = (staffId != null);
        }

        if (!isLoggedIn) {
            // Chưa đăng nhập -> redirect về trang login
            httpResponse.sendRedirect(contextPath + "/staff/login?redirect=" + 
                java.net.URLEncoder.encode(requestURI, "UTF-8"));
            return;
        }

        // Đã đăng nhập -> cho phép truy cập
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
