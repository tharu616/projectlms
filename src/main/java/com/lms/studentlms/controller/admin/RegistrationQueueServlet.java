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

@WebServlet("/admin/registration-queue/*")
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
        // Check if admin is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // Show queue management page
            List<CourseRegistration> pendingRegistrations = queueManager.getAllRegistrations();
            request.setAttribute("pendingRegistrations", pendingRegistrations);
            request.setAttribute("queueSize", queueManager.getQueueSize());
            request.getRequestDispatcher("/WEB-INF/views/admin/registration-queue/list.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/registration-queue");
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

        String adminEmail = (String) session.getAttribute("adminEmail");
        String action = request.getParameter("action");

        if ("approveRegistration".equals(action)) {
            // Process registration from queue
            CourseRegistration registration = queueManager.processNextRegistration();

            if (registration != null) {
                // Save to completed registrations
                registrationDao.saveRegistration(registration);

                adminLogDao.logActivity(adminEmail, "REGISTRATION_APPROVE",
                        "Approved registration: " + registration.getStudentEmail() + " for " + registration.getCourseCode());
            }

            response.sendRedirect(request.getContextPath() + "/admin/registration-queue");
        } else if ("rejectRegistration".equals(action)) {
            // Process and reject registration from queue
            CourseRegistration registration = queueManager.processNextRegistration();

            if (registration != null) {
                adminLogDao.logActivity(adminEmail, "REGISTRATION_REJECT",
                        "Rejected registration: " + registration.getStudentEmail() + " for " + registration.getCourseCode());
            }

            response.sendRedirect(request.getContextPath() + "/admin/registration-queue");
        } else if ("clearQueue".equals(action)) {
            // Clear all pending registrations
            int count = queueManager.getQueueSize();
            queueManager.clearAllRegistrations();

            adminLogDao.logActivity(adminEmail, "REGISTRATION_CLEAR_QUEUE",
                    "Cleared registration queue with " + count + " items");

            response.sendRedirect(request.getContextPath() + "/admin/registration-queue");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/registration-queue");
        }
    }
}
