package com.lms.studentlms.controller.user;

import com.lms.studentlms.dao.PaymentDao;

import com.lms.studentlms.model.Payment;
import com.lms.studentlms.model.PaymentRecord;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@WebServlet("/user/payment/*")
public class PaymentServlet extends HttpServlet {

    private PaymentDao paymentDao;

    @Override
    public void init() throws ServletException {
        paymentDao = new PaymentDao();
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
        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {
            // Show payment form
            request.getRequestDispatcher("/WEB-INF/views/user/payments/make-payment.jsp").forward(request, response);
        } else if (pathInfo.equals("/history")) {
            // Show payment history
            List<PaymentRecord> payments = paymentDao.getPaymentRecordsByEmail(userEmail);
            request.setAttribute("payments", payments);
            request.getRequestDispatcher("/WEB-INF/views/user/payments/payment-history.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/user/payment");
        }
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
        String userName = (String) session.getAttribute("userName");

        // Get payment information
        String courseCode = (String) session.getAttribute("enrolledCourseCode");
        String courseName = (String) session.getAttribute("enrolledCourseName");
        String courseFee = (String) session.getAttribute("enrolledCourseFee");
        String paymentMethod = request.getParameter("paymentMethod");

        if (courseCode == null || courseName == null || courseFee == null) {
            // No course selected for payment
            response.sendRedirect(request.getContextPath() + "/user/courses");
            return;
        }

        // Generate transaction ID
        String transactionId = "TXN" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();

        // Create payment record
        Payment payment = new Payment(
                userEmail,
                userName,
                courseCode,
                courseName,
                courseFee,
                paymentMethod,
                transactionId,
                System.currentTimeMillis()
        );

        // Save payment
        boolean saved = paymentDao.savePayment(payment);

        // Create payment record for admin tracking
        if (saved) {
            PaymentRecord record = new PaymentRecord(
                    userEmail,
                    transactionId,
                    new Date(),
                    "Payment for course " + courseCode,
                    Double.parseDouble(courseFee),
                    "PENDING"
            );

            paymentDao.savePaymentRecord(record);

            // Clear session attributes
            session.removeAttribute("enrolledCourseCode");
            session.removeAttribute("enrolledCourseName");
            session.removeAttribute("enrolledSchool");
            session.removeAttribute("enrolledCourseFee");

            // Set success message
            request.setAttribute("success", "Payment submitted successfully!");
            request.setAttribute("transactionId", transactionId);
            request.getRequestDispatcher("/WEB-INF/views/user/payments/payment-success.jsp").forward(request, response);
        } else {
            // Set error message
            request.setAttribute("error", "Payment processing failed. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/user/payments/make-payment.jsp").forward(request, response);
        }
    }
}
