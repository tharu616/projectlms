package com.lms.studentlms.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Filter that restricts access to admin pages to authenticated administrators only.
 * Redirects unauthenticated users to the admin login page.
 */
@WebFilter("/admin/*")
public class AdminAuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Get the current path
        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());

        // Skip filter for login page and resources
        if (path.equals("/admin/login") || path.startsWith("/admin/assets/")) {
            chain.doFilter(request, response);
            return;
        }

        // Check if admin is logged in
        HttpSession session = httpRequest.getSession(false);
        boolean isLoggedIn = session != null && session.getAttribute("adminEmail") != null;

        if (isLoggedIn) {
            // Admin is logged in, proceed with the request
            chain.doFilter(request, response);
        } else {
            // Admin is not logged in, redirect to login page
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/admin/login");
        }
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}
