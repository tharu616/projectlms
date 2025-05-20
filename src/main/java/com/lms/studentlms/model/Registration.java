package com.lms.studentlms.model;

import java.util.Objects;

public class Registration {
    private String studentId;
    private String courseId;
    private long timestamp;
    private String status;

    public Registration() {
        this.timestamp = System.currentTimeMillis();
        this.status = "PENDING";
    }

    public Registration(String studentId, String courseId) {
        this.studentId = studentId;
        this.courseId = courseId;
        this.timestamp = System.currentTimeMillis();
        this.status = "PENDING";
    }

    public Registration(String studentId, String courseId, long timestamp) {
        this.studentId = studentId;
        this.courseId = courseId;
        this.timestamp = timestamp;
        this.status = "PENDING";
    }

    // Getters and Setters
    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(long timestamp) {
        this.timestamp = timestamp;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Registration that = (Registration) o;
        return Objects.equals(studentId, that.studentId) &&
                Objects.equals(courseId, that.courseId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(studentId, courseId);
    }

    @Override
    public String toString() {
        return "Registration{" +
                "studentId='" + studentId + '\'' +
                ", courseId='" + courseId + '\'' +
                ", timestamp=" + timestamp +
                ", status='" + status + '\'' +
                '}';
    }
}
