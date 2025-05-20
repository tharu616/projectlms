package com.lms.studentlms.controller.user;

import com.lms.studentlms.dao.UserDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/user/profile")
public class ProfileServlet extends HttpServlet {

    private UserDao userDao;

    @Override
    public void init() throws ServletException {
        userDao = new UserDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String userEmail = (String) session.getAttribute("userEmail");

        // Get user information
        User user = userDao.getUserByEmail(userEmail);
        if (user == null) {
            // User not found, invalidate session and redirect to login
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Set user attribute for the JSP
        request.setAttribute("user", user);

        // Forward to the profile JSP
        request.getRequestDispatcher("/WEB-INF/views/user/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String userEmail = (String) session.getAttribute("userEmail");

        // Get existing user
        User user = userDao.getUserByEmail(userEmail);
        if (user == null) {
            // User not found, invalidate session and redirect to login
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Update user information
        user.setMobileNumber(request.getParameter("mobileNumber"));
        user.setWhatsAppNumber(request.getParameter("whatsAppNumber"));
        user.setPermanentAddress(request.getParameter("permanentAddress"));
        user.setDistrictOrProvince(request.getParameter("districtOrProvince"));
        user.setPostalCode(request.getParameter("postalCode"));
        user.setParentFullName(request.getParameter("parentFullName"));
        user.setParentContactNumber(request.getParameter("parentContactNumber"));
        user.setParentEmail(request.getParameter("parentEmail"));

        // Check if password change is requested
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        List<String> errors = new ArrayList<>();

        if (currentPassword != null && !currentPassword.isEmpty() &&
                newPassword != null && !newPassword.isEmpty() &&
                confirmPassword != null && !confirmPassword.isEmpty()) {

            // Validate current password
            if (!userDao.validateUser(userEmail, currentPassword)) {
                errors.add("Current password is incorrect");
            } else if (!newPassword.equals(confirmPassword)) {
                errors.add("New passwords do not match");
            } else if (newPassword.length() < 6) {
                errors.add("New password must be at least 6 characters long");
            } else {
                // Update password
                user.setPassword(newPassword);
            }
        }

        if (errors.isEmpty()) {
            // Save updated user
            boolean updated = userDao.updateUser(user);

            if (updated) {
                request.setAttribute("success", "Profile updated successfully");
            } else {
                request.setAttribute("error", "Failed to update profile");
            }
        } else {
            request.setAttribute("errors", errors);
        }

        // Set user attribute for the JSP
        request.setAttribute("user", user);

        // Forward back to the profile JSP
        request.getRequestDispatcher("/WEB-INF/views/user/profile.jsp").forward(request, response);
    }
}
