package com.lms.studentlms.model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class CourseRegistration {
    private String studentEmail;
    private String studentName;
    private String courseCode;
    private String courseName;
    private String courseFee;
    private String schoolName;
    private long timestamp;

    public CourseRegistration() {
        this.timestamp = System.currentTimeMillis();
    }

    public CourseRegistration(String studentEmail, String studentName, String courseCode,
                              String courseName, String courseFee, String schoolName) {
        this.studentEmail = studentEmail;
        this.studentName = studentName;
        this.courseCode = courseCode;
        this.courseName = courseName;
        this.courseFee = courseFee;
        this.schoolName = schoolName;
        this.timestamp = System.currentTimeMillis();
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

    public String getFormattedDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.format(new Date(timestamp));
    }

    @Override
    public String toString() {
        return "CourseRegistration{" +
                "studentEmail='" + studentEmail + '\'' +
                ", studentName='" + studentName + '\'' +
                ", courseCode='" + courseCode + '\'' +
                ", courseName='" + courseName + '\'' +
                ", timestamp=" + timestamp +
                '}';
    }
}
