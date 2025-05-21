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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/user/payment/history")
public class PaymentHistoryServlet extends HttpServlet {
    private PaymentDao paymentDao;

    @Override
    public void init() throws ServletException {
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

            String userEmail = (String) session.getAttribute("userEmail");

            // Get payment records for the user
            List<PaymentRecord> paymentRecords = paymentDao.getPaymentRecordsByEmail(userEmail);
            List<Payment> payments = new ArrayList<>();
            try {
                payments = paymentDao.getPaymentsByEmail(userEmail);
            } catch (Exception e) {
                // Handle exception but continue
                e.printStackTrace();
            }

            // Calculate totals
            double totalAmount = paymentRecords.stream().mapToDouble(PaymentRecord::getAmount).sum();
            int completedPayments = (int) paymentRecords.stream()
                    .filter(p -> "COMPLETED".equals(p.getStatus()))
                    .count();
            int pendingPayments = (int) paymentRecords.stream()
                    .filter(p -> "PENDING".equals(p.getStatus()))
                    .count();

            // Set attributes for the JSP
            request.setAttribute("paymentRecords", paymentRecords);
            request.setAttribute("payments", payments);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("completedPayments", completedPayments);
            request.setAttribute("pendingPayments", pendingPayments);

            // Forward to the payment history JSP - FIX THE PATH HERE
            request.getRequestDispatcher("/WEB-INF/views/user/payments/payment-history.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
