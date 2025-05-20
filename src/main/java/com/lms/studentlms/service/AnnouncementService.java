package com.lms.studentlms.service;

import com.lms.studentlms.dao.AnnouncementDao;
import com.lms.studentlms.model.Announcement;

import java.util.Date;
import java.util.List;

public class AnnouncementService {

    private AnnouncementDao announcementDao;

    public AnnouncementService() {
        this.announcementDao = new AnnouncementDao();
    }

    public List<Announcement> getAllAnnouncements() {
        return announcementDao.findAll();
    }

    public List<Announcement> getActiveAnnouncements() {
        return announcementDao.findActiveAnnouncements();
    }

    public Announcement getAnnouncementById(int id) {
        if (id <= 0) {
            return null;
        }
        return announcementDao.findById(id);
    }

    public Announcement createAnnouncement(String title, String content, String publishedBy,
                                           Date expiryDate, boolean isActive) {
        if (title == null || title.isEmpty() || content == null || content.isEmpty() ||
                publishedBy == null || publishedBy.isEmpty()) {
            return null;
        }

        Announcement announcement = new Announcement();
        announcement.setTitle(title);
        announcement.setContent(content);
        announcement.setPublishedBy(publishedBy);
        announcement.setPublishDate(new Date());
        announcement.setExpiryDate(expiryDate);
        announcement.setActive(isActive);

        return announcementDao.create(announcement);
    }

    public Announcement updateAnnouncement(int id, String title, String content,
                                           Date expiryDate, boolean isActive) {
        if (id <= 0 || title == null || title.isEmpty() || content == null || content.isEmpty()) {
            return null;
        }

        Announcement existing = announcementDao.findById(id);
        if (existing == null) {
            return null;
        }

        existing.setTitle(title);
        existing.setContent(content);
        existing.setExpiryDate(expiryDate);
        existing.setActive(isActive);

        return announcementDao.update(existing);
    }

    public boolean deleteAnnouncement(int id) {
        if (id <= 0) {
            return false;
        }
        return announcementDao.delete(id);
    }
}
