package com.lms.studentlms.controller.user;

import com.lms.studentlms.dao.CourseDao;
import com.lms.studentlms.dao.PaymentDao;
import com.lms.studentlms.dao.UserDao;
import com.lms.studentlms.model.Course;
import com.lms.studentlms.model.Payment;
import com.lms.studentlms.model.PaymentRecord;
import com.lms.studentlms.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.UUID;

@WebServlet("/user/payment")
public class PaymentServlet extends HttpServlet {
    private CourseDao courseDao;
    private UserDao userDao;
    private PaymentDao paymentDao;

    @Override
    public void init() throws ServletException {
        courseDao = new CourseDao();
        userDao = new UserDao();
        paymentDao = new PaymentDao();
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

            // Get course information from session
            String courseCode = (String) session.getAttribute("enrolledCourseCode");
            String courseName = (String) session.getAttribute("enrolledCourseName");
            String schoolName = (String) session.getAttribute("enrolledSchool");
            String courseFee = (String) session.getAttribute("enrolledCourseFee");

            if (courseCode == null || courseName == null || courseFee == null) {
                // If session doesn't have course info, try to get it from request parameter
                courseCode = request.getParameter("courseCode");
                if (courseCode != null) {
                    Course course = courseDao.getCourseByCode(courseCode);
                    if (course != null) {
                        courseName = course.getCourseName();
                        schoolName = course.getSchool();
                        courseFee = String.valueOf(course.getFee());

                        // Store in session for later use
                        session.setAttribute("enrolledCourseCode", courseCode);
                        session.setAttribute("enrolledCourseName", courseName);
                        session.setAttribute("enrolledSchool", schoolName);
                        session.setAttribute("enrolledCourseFee", courseFee);
                    }
                }
            }

            // Set attributes for the JSP
            request.setAttribute("courseCode", courseCode);
            request.setAttribute("courseName", courseName);
            request.setAttribute("schoolName", schoolName);
            request.setAttribute("courseFee", courseFee);

            // Forward to the payment JSP
            request.getRequestDispatcher("/WEB-INF/views/user/payments/payment.jsp").forward(request, response);
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
            // Check if user is logged in
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("userEmail") == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            String userEmail = (String) session.getAttribute("userEmail");

            // Get course information from session
            String courseCode = (String) session.getAttribute("enrolledCourseCode");
            String courseName = (String) session.getAttribute("enrolledCourseName");
            String courseFee = (String) session.getAttribute("enrolledCourseFee");

            if (courseCode == null || courseName == null || courseFee == null) {
                response.sendRedirect(request.getContextPath() + "/courses");
                return;
            }

            // Get user details
            User user = userDao.getUserByEmail(userEmail);
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            // Get payment details from form
            String paymentMethod = request.getParameter("paymentMethod");
            if (paymentMethod == null || paymentMethod.isEmpty()) {
                paymentMethod = "CREDIT_CARD"; // Default payment method
            }

            // Generate transaction ID
            String transactionId = "TRX" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();

            // Create payment record
            Payment payment = new Payment(
                    userEmail,
                    user.getFullName(),
                    courseCode,
                    courseName,
                    courseFee,
                    paymentMethod,
                    transactionId,
                    System.currentTimeMillis()
            );

            // Save payment
            boolean saved = paymentDao.savePayment(payment);

            // Also create a payment record
            PaymentRecord record = new PaymentRecord(
                    userEmail,
                    transactionId,
                    new java.util.Date(),
                    "Payment for " + courseName + " course",
                    Double.parseDouble(courseFee),
                    "COMPLETED"
            );
            paymentDao.savePaymentRecord(record);

            if (saved) {
                // Clear session attributes
                session.removeAttribute("enrolledCourseCode");
                session.removeAttribute("enrolledCourseName");
                session.removeAttribute("enrolledSchool");
                session.removeAttribute("enrolledCourseFee");

                // Redirect to payment confirmation
                response.sendRedirect(request.getContextPath() + "/user/payment/confirmation?transactionId=" + transactionId);
            } else {
                request.setAttribute("error", "Failed to process payment. Please try again.");
                request.setAttribute("courseCode", courseCode);
                request.setAttribute("courseName", courseName);
                request.setAttribute("courseFee", courseFee);
                request.getRequestDispatcher("/WEB-INF/views/user/payments/payment.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
