package com.lms.studentlms.model;

import java.util.Objects;

public class Payment {
    private String studentEmail;
    private String studentName;
    private String courseCode;
    private String courseName;
    private String courseFee;
    private String paymentMethod;
    private String transactionId;
    private long timestamp;

    public Payment() {
        this.timestamp = System.currentTimeMillis();
    }

    public Payment(String studentEmail, String studentName, String courseCode, String courseName,
                   String courseFee, String paymentMethod, String transactionId, long timestamp) {
        this.studentEmail = studentEmail;
        this.studentName = studentName;
        this.courseCode = courseCode;
        this.courseName = courseName;
        this.courseFee = courseFee;
        this.paymentMethod = paymentMethod;
        this.transactionId = transactionId;
        this.timestamp = timestamp;
    }

    // Getters and Setters
    public String getStudentEmail() {
        return studentEmail;
    }

    public void setStudentEmail(String studentEmail) {
        this.studentEmail = studentEmail;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getCourseCode() {
        return courseCode;
    }

    public void setCourseCode(String courseCode) {
        this.courseCode = courseCode;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getCourseFee() {
        return courseFee;
    }

    public void setCourseFee(String courseFee) {
        this.courseFee = courseFee;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(long timestamp) {
        this.timestamp = timestamp;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Payment payment = (Payment) o;
        return Objects.equals(transactionId, payment.transactionId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(transactionId);
    }

    @Override
    public String toString() {
        return "Payment{" +
                "studentEmail='" + studentEmail + '\'' +
                ", courseCode='" + courseCode + '\'' +
                ", transactionId='" + transactionId + '\'' +
                ", timestamp=" + timestamp +
                '}';
    }
}
