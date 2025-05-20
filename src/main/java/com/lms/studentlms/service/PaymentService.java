package com.lms.studentlms.service;

import com.lms.studentlms.dao.PaymentDao;
import com.lms.studentlms.model.Payment;
import com.lms.studentlms.model.PaymentRecord;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

public class PaymentService {

    private PaymentDao paymentDao;

    public PaymentService() {
        this.paymentDao = new PaymentDao();
    }

    public boolean processPayment(String studentEmail, String studentName, String courseCode,
                                  String courseName, String courseFee, String paymentMethod) {
        if (studentEmail == null || studentEmail.isEmpty() ||
                courseCode == null || courseCode.isEmpty() ||
                courseFee == null || courseFee.isEmpty() ||
                paymentMethod == null || paymentMethod.isEmpty()) {
            return false;
        }

        // Generate transaction ID
        String transactionId = "TXN" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();

        // Create payment
        Payment payment = new Payment(
                studentEmail,
                studentName,
                courseCode,
                courseName,
                courseFee,
                paymentMethod,
                transactionId,
                System.currentTimeMillis()
        );

        try {
            // Save payment
            boolean paymentSaved = paymentDao.savePayment(payment);

            if (paymentSaved) {
                // Create payment record for admin tracking
                PaymentRecord record = new PaymentRecord(
                        studentEmail,
                        transactionId,
                        new Date(),
                        "Payment for course " + courseCode,
                        Double.parseDouble(courseFee),
                        "PENDING"
                );

                return paymentDao.savePaymentRecord(record);
            }

            return false;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Payment> getPaymentsByEmail(String userEmail) {
        if (userEmail == null || userEmail.isEmpty()) {
            return new ArrayList<>();
        }

        try {
            return paymentDao.getPaymentsByEmail(userEmail);
        } catch (IOException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public Payment getPaymentByTransactionId(String transactionId) {
        if (transactionId == null || transactionId.isEmpty()) {
            return null;
        }

        try {
            return paymentDao.getPaymentByTransactionId(transactionId);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<PaymentRecord> getAllPaymentRecords() {
        return paymentDao.getAllPayments();
    }

    public List<PaymentRecord> getPaymentRecordsByEmail(String email) {
        if (email == null || email.isEmpty()) {
            return new ArrayList<>();
        }
        return paymentDao.getPaymentRecordsByEmail(email);
    }

    public List<PaymentRecord> getPaymentsByStatus(String status) {
        if (status == null || status.isEmpty()) {
            return new ArrayList<>();
        }
        return paymentDao.getPaymentsByStatus(status);
    }

    public boolean updatePaymentStatus(String transactionId, String newStatus) {
        if (transactionId == null || transactionId.isEmpty() ||
                newStatus == null || newStatus.isEmpty()) {
            return false;
        }
        return paymentDao.updatePaymentStatus(transactionId, newStatus);
    }

    public double getTotalRevenue() {
        return paymentDao.getTotalRevenue();
    }
}
