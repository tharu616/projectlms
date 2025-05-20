package com.lms.studentlms.controller.admin;

import com.lms.studentlms.dao.UserDao;
import com.lms.studentlms.dao.AdminLogDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/users/*")
public class UserManagementServlet extends HttpServlet {

    private UserDao userDao;
    private AdminLogDao adminLogDao;

    @Override
    public void init() throws ServletException {
        userDao = new UserDao();
        adminLogDao = new AdminLogDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if admin is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // List all users
            List<User> users = userDao.readAllUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("/WEB-INF/views/admin/users/list.jsp").forward(request, response);
        } else if (pathInfo.equals("/create")) {
            // Show create user form
            request.getRequestDispatcher("/WEB-INF/views/admin/users/create.jsp").forward(request, response);
        } else if (pathInfo.startsWith("/edit/")) {
            // Show edit user form
            String email = pathInfo.substring("/edit/".length());
            User user = userDao.getUserByEmail(email);

            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("/WEB-INF/views/admin/users/edit.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/users");
            }
        } else if (pathInfo.startsWith("/view/")) {
            // Show user details
            String email = pathInfo.substring("/view/".length());
            User user = userDao.getUserByEmail(email);

            if (user != null) {
                request.setAttribute("user", user);
                request.getRequestDispatcher("/WEB-INF/views/admin/users/view.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/users");
            }
        } else if (pathInfo.startsWith("/delete/")) {
            // Delete user
            String email = pathInfo.substring("/delete/".length());
            boolean deleted = userDao.deleteUser(email);

            if (deleted) {
                String adminEmail = (String) session.getAttribute("adminEmail");
                adminLogDao.logActivity(adminEmail, "USER_DELETE", "Deleted user: " + email);
            }

            response.sendRedirect(request.getContextPath() + "/admin/users");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if admin is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String action = request.getParameter("action");
        String adminEmail = (String) session.getAttribute("adminEmail");

        if ("create".equals(action)) {
            // Create new user
            User user = new User(
                    request.getParameter("fullName"),
                    request.getParameter("nic"),
                    request.getParameter("email"),
                    request.getParameter("password"),
                    request.getParameter("dateOfBirth"),
                    request.getParameter("gender"),
                    request.getParameter("mobileNumber"),
                    request.getParameter("whatsAppNumber"),
                    request.getParameter("permanentAddress"),
                    request.getParameter("districtOrProvince"),
                    request.getParameter("postalCode"),
                    request.getParameter("indexNumber"),
                    request.getParameter("yearOfCompletion"),
                    List.of(), // Empty certificates list
                    request.getParameter("parentFullName"),
                    request.getParameter("parentContactNumber"),
                    request.getParameter("parentEmail")
            );

            boolean created = userDao.saveUser(user);

            if (created) {
                adminLogDao.logActivity(adminEmail, "USER_CREATE",
                        "Created user: " + user.getEmail());

                response.sendRedirect(request.getContextPath() + "/admin/users?created=true");
            } else {
                request.setAttribute("error", "Failed to create user");
                request.setAttribute("user", user);
                request.getRequestDispatcher("/WEB-INF/views/admin/users/create.jsp").forward(request, response);
            }
        } else if ("update".equals(action)) {
            // Update existing user
            String email = request.getParameter("email");
            User existingUser = userDao.getUserByEmail(email);

            if (existingUser != null) {
                existingUser.setFullName(request.getParameter("fullName"));
                existingUser.setNic(request.getParameter("nic"));
                existingUser.setDateOfBirth(request.getParameter("dateOfBirth"));
                existingUser.setGender(request.getParameter("gender"));
                existingUser.setMobileNumber(request.getParameter("mobileNumber"));
                existingUser.setWhatsAppNumber(request.getParameter("whatsAppNumber"));
                existingUser.setPermanentAddress(request.getParameter("permanentAddress"));
                existingUser.setDistrictOrProvince(request.getParameter("districtOrProvince"));
                existingUser.setPostalCode(request.getParameter("postalCode"));
                existingUser.setIndexNumber(request.getParameter("indexNumber"));
                existingUser.setYearOfCompletion(request.getParameter("yearOfCompletion"));
                existingUser.setParentFullName(request.getParameter("parentFullName"));
                existingUser.setParentContactNumber(request.getParameter("parentContactNumber"));
                existingUser.setParentEmail(request.getParameter("parentEmail"));

                // Update password if provided
                String newPassword = request.getParameter("newPassword");
                if (newPassword != null && !newPassword.isEmpty()) {
                    existingUser.setPassword(newPassword);
                }

                boolean updated = userDao.updateUser(existingUser);

                if (updated) {
                    adminLogDao.logActivity(adminEmail, "USER_UPDATE",
                            "Updated user: " + existingUser.getEmail());

                    response.sendRedirect(request.getContextPath() + "/admin/users?updated=true");
                } else {
                    request.setAttribute("error", "Failed to update user");
                    request.setAttribute("user", existingUser);
                    request.getRequestDispatcher("/WEB-INF/views/admin/users/edit.jsp").forward(request, response);
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/users");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/users");
        }
    }
}
