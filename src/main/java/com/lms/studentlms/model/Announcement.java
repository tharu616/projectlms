package com.lms.studentlms.model;

import java.util.Date;
import java.util.Objects;

public class Announcement {
    private int id;
    private String title;
    private String content;
    private Date publishDate;
    private Date expiryDate;
    private String publishedBy;
    private boolean isActive;

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

    public Announcement(int id, String title, String content, Date publishDate,
                        Date expiryDate, String publishedBy, boolean isActive) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.publishDate = publishDate;
        this.expiryDate = expiryDate;
        this.publishedBy = publishedBy;
        this.isActive = isActive;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(Date publishDate) {
        this.publishDate = publishDate;
    }

    public Date getExpiryDate() {
        return expiryDate;
    }

    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

    public String getPublishedBy() {
        return publishedBy;
    }

    public void setPublishedBy(String publishedBy) {
        this.publishedBy = publishedBy;
    }

    public boolean isActive() {
        return isActive;
    }

    public void setActive(boolean active) {
        isActive = active;
    }

    // Check if announcement is current (not expired)
    public boolean isCurrent() {
        if (!isActive) {
            return false;
        }

        if (expiryDate == null) {
            return true;
        }

        return expiryDate.after(new Date());
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Announcement that = (Announcement) o;
        return id == that.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    @Override
    public String toString() {
        return "Announcement{" +
                "id=" + id +
                ", title='" + title + '\'' +
                ", publishDate=" + publishDate +
                ", expiryDate=" + expiryDate +
                ", isActive=" + isActive +
                '}';
    }
}
