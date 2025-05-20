package com.lms.studentlms.controller.auth;

import com.lms.studentlms.dao.AdminLogDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    private AdminLogDao adminLogDao;

    @Override
    public void init() throws ServletException {
        adminLogDao = new AdminLogDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session != null) {
            // Check if this is an admin logout
            String adminEmail = (String) session.getAttribute("adminEmail");
            if (adminEmail != null) {
                // Log admin logout
                adminLogDao.logActivity(adminEmail, "LOGOUT", "Admin logout");
            }

            // Invalidate the session
            session.invalidate();
        }

        // Redirect to login page
        response.sendRedirect(request.getContextPath() + "/login");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle POST requests the same as GET
        doGet(request, response);
    }
}
