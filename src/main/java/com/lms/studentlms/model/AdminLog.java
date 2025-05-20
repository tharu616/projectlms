package com.lms.studentlms.model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class AdminLog {
    private String adminEmail;
    private String actionType;
    private String description;
    private long timestamp;

    public AdminLog() {
        this.timestamp = System.currentTimeMillis();
    }

    public AdminLog(String adminEmail, String actionType, String description) {
        this.adminEmail = adminEmail;
        this.actionType = actionType;
        this.description = description;
        this.timestamp = System.currentTimeMillis();
    }

    // Getters and Setters
    public String getAdminEmail() {
        return adminEmail;
    }

    public void setAdminEmail(String adminEmail) {
        this.adminEmail = adminEmail;
    }

    public String getActionType() {
        return actionType;
    }

    public void setActionType(String actionType) {
        this.actionType = actionType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public long getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(long timestamp) {
        this.timestamp = timestamp;
    }

    public String getFormattedTimestamp() {
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return formatter.format(new Date(timestamp));
    }

    @Override
    public String toString() {
        return "AdminLog{" +
                "adminEmail='" + adminEmail + '\'' +
                ", actionType='" + actionType + '\'' +
                ", timestamp=" + getFormattedTimestamp() +
                '}';
    }
}
