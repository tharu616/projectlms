package com.lms.studentlms.model;

import java.util.Objects;

public class RegistrationRequest {
    private String studentId;
    private String studentName;
    private String courseId;
    private String courseName;
    private String schoolName;
    private long timestamp;
    private int queuePosition;

    public RegistrationRequest() {
        this.timestamp = System.currentTimeMillis();
    }

    public RegistrationRequest(String studentId, String courseId) {
        this.studentId = studentId;
        this.courseId = courseId;
        this.timestamp = System.currentTimeMillis();
    }

    public RegistrationRequest(String studentId, String studentName, String courseId,
                               String courseName, String schoolName) {
        this.studentId = studentId;
        this.studentName = studentName;
        this.courseId = courseId;
        this.courseName = courseName;
        this.schoolName = schoolName;
        this.timestamp = System.currentTimeMillis();
    }

    // Getters and Setters
    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getCourseId() {
        return courseId;
    }

    public void setCourseId(String courseId) {
        this.courseId = courseId;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getSchoolName() {
        return schoolName;
    }

    public void setSchoolName(String schoolName) {
        this.schoolName = schoolName;
    }

    public long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(long timestamp) {
        this.timestamp = timestamp;
    }

    public int getQueuePosition() {
        return queuePosition;
    }

    public void setQueuePosition(int queuePosition) {
        this.queuePosition = queuePosition;
    }

    // Convert to Registration
    public Registration toRegistration() {
        Registration registration = new Registration(studentId, courseId, timestamp);
        return registration;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        RegistrationRequest that = (RegistrationRequest) o;
        return Objects.equals(studentId, that.studentId) &&
                Objects.equals(courseId, that.courseId);
    }

    @Override
    public int hashCode() {
        return Objects.hash(studentId, courseId);
    }

    @Override
    public String toString() {
        return "RegistrationRequest{" +
                "studentId='" + studentId + '\'' +
                ", studentName='" + studentName + '\'' +
                ", courseId='" + courseId + '\'' +
                ", courseName='" + courseName + '\'' +
                ", timestamp=" + timestamp +
                ", queuePosition=" + queuePosition +
                '}';
    }
}
