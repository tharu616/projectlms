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

@WebServlet("/user/payment/confirmation")
public class PaymentConfirmationServlet extends HttpServlet {
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

            // Get transaction ID from request parameter
            String transactionId = request.getParameter("transactionId");
            if (transactionId == null || transactionId.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/user/dashboard");
                return;
            }

            // Get payment details
            Payment payment = paymentDao.getPaymentByTransactionId(transactionId);
            if (payment != null) {
                request.setAttribute("payment", payment);
            }

            // Get payment record
            PaymentRecord record = paymentDao.getPaymentRecordByTransactionId(transactionId);
            if (record != null) {
                request.setAttribute("paymentRecord", record);
            }

            // Forward to confirmation page
            request.getRequestDispatcher("/WEB-INF/views/user/payments/payment-confirmation.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
