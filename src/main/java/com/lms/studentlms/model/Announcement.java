package com.lms.studentlms.model;

import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.Objects;

public class Announcement {
    private int id;
    private String title;
    private String content;
    private Date publishDate;
    private Date expiryDate;
    private String publishedBy;
    private boolean isActive;

    // Optionally add these if your JSP expects them
    private String targetAudience;
    private Date createDate;
    private Date lastModified;

    public Announcement() {
        this.publishDate = new Date();
        this.isActive = true;
    }

    public Announcement(String title, String content, String publishedBy) {
        this.title = title;
        this.content = content;
        this.publishedBy = publishedBy;
        this.publishDate = new Date();
        this.isActive = true;
    }

    public Announcement(int id, String title, String content, Date publishDate, Date expiryDate, String publishedBy, boolean isActive) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.publishDate = publishDate;
        this.expiryDate = expiryDate;
        this.publishedBy = publishedBy;
        this.isActive = isActive;
    }

    // Getters and setters...

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public Date getPublishDate() { return publishDate; }
    public void setPublishDate(Date publishDate) { this.publishDate = publishDate; }
    public Date getExpiryDate() { return expiryDate; }
    public void setExpiryDate(Date expiryDate) { this.expiryDate = expiryDate; }
    public String getPublishedBy() { return publishedBy; }
    public void setPublishedBy(String publishedBy) { this.publishedBy = publishedBy; }
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    // Optional fields
    public String getTargetAudience() { return targetAudience; }
    public void setTargetAudience(String targetAudience) { this.targetAudience = targetAudience; }
    public Date getCreateDate() { return createDate; }
    public void setCreateDate(Date createDate) { this.createDate = createDate; }
    public Date getLastModified() { return lastModified; }
    public void setLastModified(Date lastModified) { this.lastModified = lastModified; }

    // Formatted date getters
    public String getFormattedPublishDate() {
        if (publishDate == null) return "";
        return new SimpleDateFormat("yyyy-MM-dd").format(publishDate);
    }
    public String getFormattedExpiryDate() {
        if (expiryDate == null) return "No expiry date";
        return new SimpleDateFormat("yyyy-MM-dd").format(expiryDate);
    }
    public String getFormattedCreateDate() {
        if (createDate == null) return "";
        return new SimpleDateFormat("yyyy-MM-dd").format(createDate);
    }
    public String getFormattedLastModified() {
        if (lastModified == null) return "";
        return new SimpleDateFormat("yyyy-MM-dd").format(lastModified);
    }

    // ... equals, hashCode, toString ...
}
