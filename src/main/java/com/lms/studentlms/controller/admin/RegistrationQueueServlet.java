package com.lms.studentlms.controller.admin;

import com.lms.studentlms.dao.AdminLogDao;
import com.lms.studentlms.dao.CourseRegistrationDao;
import com.lms.studentlms.model.CourseRegistration;
import com.lms.studentlms.util.RegistrationQueueManager;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/registration-queue")
public class RegistrationQueueServlet extends HttpServlet {
    private RegistrationQueueManager queueManager;
    private CourseRegistrationDao registrationDao;
    private AdminLogDao adminLogDao;

    @Override
    public void init() throws ServletException {
        queueManager = RegistrationQueueManager.getInstance();
        registrationDao = new CourseRegistrationDao();
        adminLogDao = new AdminLogDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Check if admin is logged in
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("adminEmail") == null) {
                response.sendRedirect(request.getContextPath() + "/admin/login");
                return;
            }

            // Get pending registrations
            List<CourseRegistration> pendingRegistrations = queueManager.getPendingRegistrations();
            request.setAttribute("pendingRegistrations", pendingRegistrations);
            request.setAttribute("queueSize", pendingRegistrations.size());

            request.getRequestDispatcher("/WEB-INF/views/admin/registrations/queue.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Check if admin is logged in
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("adminEmail") == null) {
                response.sendRedirect(request.getContextPath() + "/admin/login");
                return;
            }

            String adminEmail = (String) session.getAttribute("adminEmail");
            String action = request.getParameter("action");

            if ("processQueue".equals(action)) {
                // Process all pending registrations
                int processed = queueManager.processQueue();
                adminLogDao.logActivity(adminEmail, "REGISTRATION_QUEUE_PROCESS",
                        "Processed " + processed + " registrations from queue");
                response.sendRedirect(request.getContextPath() + "/admin/registration-queue?processed=" + processed);
            } else if ("clearQueue".equals(action)) {
                // Clear the registration queue
                int cleared = queueManager.clearQueue();
                adminLogDao.logActivity(adminEmail, "REGISTRATION_QUEUE_CLEAR",
                        "Cleared " + cleared + " registrations from queue");
                response.sendRedirect(request.getContextPath() + "/admin/registration-queue?cleared=" + cleared);
            } else if ("approveRegistration".equals(action)) {
                // Approve a specific registration
                String studentEmail = request.getParameter("studentEmail");
                String courseCode = request.getParameter("courseCode");

                if (studentEmail != null && courseCode != null) {
                    boolean approved = queueManager.approveRegistration(studentEmail, courseCode);
                    if (approved) {
                        adminLogDao.logActivity(adminEmail, "REGISTRATION_APPROVE",
                                "Approved registration: " + studentEmail + " for " + courseCode);
                    }
                }
                response.sendRedirect(request.getContextPath() + "/admin/registration-queue");
            } else if ("rejectRegistration".equals(action)) {
                // Reject a specific registration
                String studentEmail = request.getParameter("studentEmail");
                String courseCode = request.getParameter("courseCode");

                if (studentEmail != null && courseCode != null) {
                    boolean rejected = queueManager.rejectRegistration(studentEmail, courseCode);
                    if (rejected) {
                        adminLogDao.logActivity(adminEmail, "REGISTRATION_REJECT",
                                "Rejected registration: " + studentEmail + " for " + courseCode);
                    }
                }
                response.sendRedirect(request.getContextPath() + "/admin/registration-queue");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/registration-queue");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
