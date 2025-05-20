package com.lms.studentlms.controller.admin;

import com.lms.studentlms.dao.CourseDao;
import com.lms.studentlms.dao.PaymentDao;
import com.lms.studentlms.dao.RegistrationDao;
import com.lms.studentlms.dao.UserDao;
import com.lms.studentlms.dao.AdminLogDao;
import com.lms.studentlms.model.AdminLog;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/dashboard")
public class DashboardServlet extends HttpServlet {

    private UserDao userDao;
    private CourseDao courseDao;
    private RegistrationDao registrationDao;
    private PaymentDao paymentDao;
    private AdminLogDao adminLogDao;

    @Override
    public void init() throws ServletException {
        userDao = new UserDao();
        courseDao = new CourseDao();
        registrationDao = new RegistrationDao();
        paymentDao = new PaymentDao();
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

        // Get statistics for dashboard
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalUsers", userDao.getTotalUserCount());
        stats.put("totalCourses", courseDao.getTotalCourseCount());
        stats.put("totalRegistrations", registrationDao.getTotalRegistrationCount());
        stats.put("totalRevenue", paymentDao.getTotalRevenue());
        stats.put("pendingRegistrations", registrationDao.getPendingRegistrationsCount());

        // Get recent activity logs
        List<AdminLog> recentLogs = adminLogDao.getRecentLogs(10);

        // Set attributes for the JSP
        request.setAttribute("stats", stats);
        request.setAttribute("recentLogs", recentLogs);

        // Forward to the dashboard JSP
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);
    }
}
