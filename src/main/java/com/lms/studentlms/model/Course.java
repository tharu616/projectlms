package com.lms.studentlms.model;

public class Course {
    private String courseCode;
    private String courseName;
    private String duration;
    private String school;
    private double fee;
    private String description;
    private String prerequisites;
    private String learningOutcomes;

    public Course() {
    }

    public Course(String courseCode, String courseName, String duration, String school,
                  double fee, String description, String prerequisites, String learningOutcomes) {
        this.courseCode = courseCode;
        this.courseName = courseName;
        this.duration = duration;
        this.school = school;
        this.fee = fee;
        this.description = description;
        this.prerequisites = prerequisites;
        this.learningOutcomes = learningOutcomes;
    }

    // Getters and Setters
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

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public String getSchool() {
        return school;
    }

    public void setSchool(String school) {
        this.school = school;
    }

    public double getFee() {
        return fee;
    }

    public void setFee(double fee) {
        this.fee = fee;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getPrerequisites() {
        return prerequisites;
    }

    public void setPrerequisites(String prerequisites) {
        this.prerequisites = prerequisites;
    }

    public String getLearningOutcomes() {
        return learningOutcomes;
    }

    public void setLearningOutcomes(String learningOutcomes) {
        this.learningOutcomes = learningOutcomes;
    }

    @Override
    public String toString() {
        return "Course{" +
                "courseCode='" + courseCode + '\'' +
                ", courseName='" + courseName + '\'' +
                ", school='" + school + '\'' +
                ", fee=" + fee +
                '}';
    }
}
