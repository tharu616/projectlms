package com.lms.studentlms.controller.user;

import com.lms.studentlms.dao.AnnouncementDao;
import com.lms.studentlms.dao.CourseRegistrationDao;
import com.lms.studentlms.dao.PaymentDao;
import com.lms.studentlms.dao.UserDao;
import com.lms.studentlms.model.Announcement;
import com.lms.studentlms.model.CourseRegistration;
import com.lms.studentlms.model.PaymentRecord;
import com.lms.studentlms.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/user/dashboard")
public class DashboardServlet extends HttpServlet {
    private UserDao userDao;
    private CourseRegistrationDao registrationDao;
    private PaymentDao paymentDao;
    private AnnouncementDao announcementDao;

    @Override
    public void init() throws ServletException {
        userDao = new UserDao();
        registrationDao = new CourseRegistrationDao();
        paymentDao = new PaymentDao();
        announcementDao = new AnnouncementDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
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

            // Get user's course registrations
            List<CourseRegistration> registrations = registrationDao.getRegistrationsByEmail(userEmail);

            // Get user's payment history
            List<PaymentRecord> payments = paymentDao.getPaymentRecordsByEmail(userEmail);

            // Get recent announcements
            List<Announcement> announcements = announcementDao.findActiveAnnouncements();

            // Calculate pending payments count
            int pendingPayments = 0;
            if (payments != null) {
                for (PaymentRecord payment : payments) {
                    if ("PENDING".equals(payment.getStatus())) {
                        pendingPayments++;
                    }
                }
            }

            // Set attributes for the JSP
            request.setAttribute("user", user);
            request.setAttribute("registrations", registrations);
            request.setAttribute("payments", payments);
            request.setAttribute("announcements", announcements);
            request.setAttribute("pendingPayments", pendingPayments);
            request.setAttribute("upcomingDeadlines", 0); // Placeholder

            // Forward to the dashboard JSP
            request.getRequestDispatcher("/WEB-INF/views/user/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            // Log the exception
            e.printStackTrace();

            // Forward to error page with details
            request.setAttribute("javax.servlet.error.exception", e);
            request.setAttribute("javax.servlet.error.status_code", 500);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
