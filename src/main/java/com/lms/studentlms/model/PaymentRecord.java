package com.lms.studentlms.model;

import java.util.Date;
import java.text.SimpleDateFormat;

public class PaymentRecord {
    private String studentEmail;
    private String transactionId;
    private Date date;
    private String description;
    private double amount;
    private String status;

    public PaymentRecord() {
        this.date = new Date();
    }

    public PaymentRecord(String studentEmail, String transactionId, Date date,
                         String description, double amount, String status) {
        this.studentEmail = studentEmail;
        this.transactionId = transactionId;
        this.date = date;
        this.description = description;
        this.amount = amount;
        this.status = status;
    }

    // Getters and Setters
    public String getStudentEmail() {
        return studentEmail;
    }

    public void setStudentEmail(String studentEmail) {
        this.studentEmail = studentEmail;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getFormattedDate() {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return formatter.format(date);
    }

    @Override
    public String toString() {
        return "PaymentRecord{" +
                "studentEmail='" + studentEmail + '\'' +
                ", transactionId='" + transactionId + '\'' +
                ", date=" + getFormattedDate() +
                ", amount=" + amount +
                ", status='" + status + '\'' +
                '}';
    }
}
