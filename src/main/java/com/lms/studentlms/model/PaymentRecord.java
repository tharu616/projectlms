package com.lms.studentlms.model;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Objects;

public class PaymentRecord {
    private String studentEmail;
    private String transactionId;
    private Date date;
    private String description;
    private double amount;
    private String status;

    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public PaymentRecord() {
        this.date = new Date();
    }

    public PaymentRecord(String studentEmail, String transactionId, Date date, String description, double amount, String status) {
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
        return dateFormat.format(date);
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        PaymentRecord that = (PaymentRecord) o;
        return Objects.equals(transactionId, that.transactionId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(transactionId);
    }

    @Override
    public String toString() {
        return "PaymentRecord{" +
                "studentEmail='" + studentEmail + '\'' +
                ", transactionId='" + transactionId + '\'' +
                ", date=" + date +
                ", amount=" + amount +
                ", status='" + status + '\'' +
                '}';
    }
}
