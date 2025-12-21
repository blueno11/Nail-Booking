package com.nailology.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Filter bảo vệ khu vực Admin (/admin/*)
 * Yêu cầu đăng nhập với role ADMIN
 */
public class AdminAuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String contextPath = httpRequest.getContextPath();

        // Kiểm tra đã đăng nhập và có quyền ADMIN
        boolean isAdmin = false;

        if (session != null) {
            Object staffId = session.getAttribute("staffId");
            String userRole = (String) session.getAttribute("staffRole");
            isAdmin = (staffId != null && "ADMIN".equals(userRole));
        }

        if (!isAdmin) {
            // Không có quyền -> redirect về staff login hoặc trang lỗi
            if (session != null && session.getAttribute("staffId") != null) {
                // Đã đăng nhập nhưng không phải admin
                httpResponse.sendRedirect(contextPath + "/staff/dashboard?error=access_denied");
            } else {
                // Chưa đăng nhập
                httpResponse.sendRedirect(contextPath + "/staff/login?redirect=" + 
                    java.net.URLEncoder.encode(httpRequest.getRequestURI(), "UTF-8"));
            }
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
