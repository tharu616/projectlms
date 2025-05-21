package com.lms.studentlms.controller.admin;

import com.lms.studentlms.dao.AdminLogDao;
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
import java.util.List;

@WebServlet("/admin/payments/*")
public class PaymentManagementServlet extends HttpServlet {
    private PaymentDao paymentDao;
    private AdminLogDao adminLogDao;

    @Override
    public void init() throws ServletException {
        paymentDao = new PaymentDao();
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

            String pathInfo = request.getPathInfo();
            if (pathInfo == null || pathInfo.equals("/")) {
                // List all payments
                List<PaymentRecord> payments = paymentDao.getAllPayments();

                // Get statistics for dashboard
                double totalRevenue = paymentDao.getTotalRevenue();
                int pendingPayments = paymentDao.getPendingPaymentsCount();
                int completedPayments = paymentDao.getCompletedPaymentsCount();

                request.setAttribute("payments", payments);
                request.setAttribute("totalRevenue", totalRevenue);
                request.setAttribute("pendingPayments", pendingPayments);
                request.setAttribute("completedPayments", completedPayments);

                request.getRequestDispatcher("/WEB-INF/views/admin/payments/list.jsp").forward(request, response);
            } else if (pathInfo.equals("/record-new")) {
                // Show form to record new payment
                request.getRequestDispatcher("/WEB-INF/views/admin/payments/create.jsp").forward(request, response);
            } else if (pathInfo.startsWith("/view/")) {
                // Show payment details
                String transactionId = pathInfo.substring("/view/".length());
                PaymentRecord paymentRecord = paymentDao.getPaymentRecordByTransactionId(transactionId);

                if (paymentRecord != null) {
                    request.setAttribute("payment", paymentRecord);
                    request.getRequestDispatcher("/WEB-INF/views/admin/payments/view.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/payments");
                }
            } else if (pathInfo.equals("/pending")) {
                // Show pending payments
                List<PaymentRecord> pendingPayments = paymentDao.getPaymentsByStatus("PENDING");
                request.setAttribute("payments", pendingPayments);
                request.setAttribute("statusFilter", "PENDING");
                request.getRequestDispatcher("/WEB-INF/views/admin/payments/list.jsp").forward(request, response);
            } else if (pathInfo.equals("/completed")) {
                // Show completed payments
                List<PaymentRecord> completedPayments = paymentDao.getPaymentsByStatus("COMPLETED");
                request.setAttribute("payments", completedPayments);
                request.setAttribute("statusFilter", "COMPLETED");
                request.getRequestDispatcher("/WEB-INF/views/admin/payments/list.jsp").forward(request, response);
            } else if (pathInfo.equals("/failed")) {
                // Show failed payments
                List<PaymentRecord> failedPayments = paymentDao.getPaymentsByStatus("FAILED");
                request.setAttribute("payments", failedPayments);
                request.setAttribute("statusFilter", "FAILED");
                request.getRequestDispatcher("/WEB-INF/views/admin/payments/list.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/payments");
            }
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

            if ("recordPayment".equals(action)) {
                // Record new payment
                String studentEmail = request.getParameter("studentEmail");
                String transactionId = "TRX" + System.currentTimeMillis() % 1000000;
                String description = request.getParameter("description");
                double amount = Double.parseDouble(request.getParameter("amount"));
                String status = request.getParameter("status");

                PaymentRecord record = new PaymentRecord(
                        studentEmail,
                        transactionId,
                        new java.util.Date(),
                        description,
                        amount,
                        status
                );

                boolean created = paymentDao.savePaymentRecord(record);
                if (created) {
                    adminLogDao.logActivity(adminEmail, "PAYMENT_RECORD",
                            "Recorded payment: " + transactionId + " for " + studentEmail);
                    response.sendRedirect(request.getContextPath() + "/admin/payments?created=true");
                } else {
                    request.setAttribute("error", "Failed to record payment");
                    request.setAttribute("payment", record);
                    request.getRequestDispatcher("/WEB-INF/views/admin/payments/create.jsp").forward(request, response);
                }
            } else if ("updateStatus".equals(action)) {
                String transactionId = request.getParameter("transactionId");
                String newStatus = request.getParameter("status");

                if (transactionId != null && newStatus != null) {
                    boolean updated = paymentDao.updatePaymentStatus(transactionId, newStatus);
                    if (updated) {
                        adminLogDao.logActivity(adminEmail, "PAYMENT_UPDATE",
                                "Updated payment status: " + transactionId + " to " + newStatus);
                    }
                }
                // Redirect back to payments list
                response.sendRedirect(request.getContextPath() + "/admin/payments");
            } else if ("addNote".equals(action)) {
                String transactionId = request.getParameter("transactionId");
                String note = request.getParameter("note");

                if (transactionId != null && note != null && !note.trim().isEmpty()) {
                    boolean updated = paymentDao.addPaymentNote(transactionId, note);
                    if (updated) {
                        adminLogDao.logActivity(adminEmail, "PAYMENT_NOTE",
                                "Added note to payment: " + transactionId);
                    }
                }
                // Redirect back to payment details
                response.sendRedirect(request.getContextPath() + "/admin/payments/view/" + transactionId);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/payments");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
