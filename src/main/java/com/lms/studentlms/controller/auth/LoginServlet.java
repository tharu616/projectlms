package com.lms.studentlms.controller.auth;

import com.lms.studentlms.dao.UserDao;
import com.lms.studentlms.dao.AdminDao;
import com.lms.studentlms.dao.AdminLogDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Optional;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDao userDao;
    private AdminDao adminDao;
    private AdminLogDao adminLogDao;

    @Override
    public void init() throws ServletException {
        userDao = new UserDao();
        adminDao = new AdminDao();
        adminLogDao = new AdminLogDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("userEmail") != null) {
            // User is already logged in, redirect to dashboard
            response.sendRedirect(request.getContextPath() + "/user/dashboard");
            return;
        } else if (session != null && session.getAttribute("adminEmail") != null) {
            // Admin is already logged in, redirect to admin dashboard
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        // Show login form
        request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");

        // Validate input
        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Email and password are required");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
            return;
        }

        // Check if admin login
        if ("admin".equals(userType)) {
            boolean isValidAdmin = adminDao.validateAdmin(email, password);

            if (isValidAdmin) {
                // Create session for admin
                HttpSession session = request.getSession();
                session.setAttribute("adminEmail", email);

                // Get admin name for display
                Optional<Admin> adminOpt = adminDao.getAdminByEmail(email);
                if (adminOpt.isPresent()) {
                    session.setAttribute("adminName", adminOpt.get().getFullName());
                } else {
                    session.setAttribute("adminName", "Administrator");
                }

                // Log admin login
                adminLogDao.logActivity(email, "LOGIN", "Admin login successful");

                // Redirect to admin dashboard
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                return;
            } else {
                request.setAttribute("error", "Invalid admin credentials");
                request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
                return;
            }
        }

        // Regular user login
        boolean isValidUser = userDao.validateUser(email, password);

        if (isValidUser) {
            // Create session for user
            HttpSession session = request.getSession();
            session.setAttribute("userEmail", email);

            // Get user details for display
            User user = userDao.getUserByEmail(email);
            if (user != null) {
                session.setAttribute("userName", user.getFullName());
                session.setAttribute("userRegisterNumber", user.getRegisterNumber());
            }

            // Redirect to user dashboard
            response.sendRedirect(request.getContextPath() + "/user/dashboard");
        } else {
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("/WEB-INF/views/auth/login.jsp").forward(request, response);
        }
    }
}
