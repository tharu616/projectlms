package com.lms.studentlms.dao;

import com.lms.studentlms.util.FileUtils;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

public class AnnouncementDao extends BaseDao<Announcement> {
    private static final String FILE_PATH = "src/main/resources/data/announcements.txt";
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
    private static int nextId = 1;

    public AnnouncementDao() {
        super(FILE_PATH);
        initNextId();
    }

    private void initNextId() {
        try {
            List<Announcement> announcements = findAll();
            if (!announcements.isEmpty()) {
                int maxId = announcements.stream()
                        .mapToInt(Announcement::getId)
                        .max()
                        .orElse(0);
                nextId = maxId + 1;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public List<Announcement> findAll() {
        try {
            return FileUtils.readLinesFromFile(FILE_PATH).stream()
                    .map(this::mapEntityFromLine)
                    .filter(announcement -> announcement != null)
                    .collect(Collectors.toList());
        } catch (IOException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public Announcement findById(int id) {
        return findAll().stream()
                .filter(announcement -> announcement.getId() == id)
                .findFirst()
                .orElse(null);
    }

    public List<Announcement> findActiveAnnouncements() {
        Date now = new Date();
        return findAll().stream()
                .filter(announcement -> announcement.isActive() &&
                        (announcement.getExpiryDate() == null || announcement.getExpiryDate().after(now)))
                .collect(Collectors.toList());
    }

    public Announcement create(Announcement announcement) {
        announcement.setId(nextId++);
        if (announcement.getPublishDate() == null) {
            announcement.setPublishDate(new Date());
        }

        try {
            List<String> lines = new ArrayList<>();
            lines.add(mapEntityToLine(announcement));
            FileUtils.writeLinesToFile(FILE_PATH, lines, true); // append mode
            return announcement;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    public Announcement update(Announcement announcement) {
        try {
            List<String> allLines = FileUtils.readLinesFromFile(FILE_PATH);
            List<String> updatedLines = new ArrayList<>();
            boolean updated = false;

            for (String line : allLines) {
                Announcement existing = mapEntityFromLine(line);
                if (existing != null && existing.getId() == announcement.getId()) {
                    updatedLines.add(mapEntityToLine(announcement));
                    updated = true;
                } else {
                    updatedLines.add(line);
                }
            }

            if (updated) {
                FileUtils.writeLinesToFile(FILE_PATH, updatedLines, false); // overwrite mode
                return announcement;
            }

            return null;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean delete(int id) {
        try {
            List<String> allLines = FileUtils.readLinesFromFile(FILE_PATH);
            List<String> updatedLines = allLines.stream()
                    .filter(line -> {
                        Announcement announcement = mapEntityFromLine(line);
                        return announcement == null || announcement.getId() != id;
                    })
                    .collect(Collectors.toList());

            if (updatedLines.size() < allLines.size()) {
                FileUtils.writeLinesToFile(FILE_PATH, updatedLines, false); // overwrite mode
                return true;
            }

            return false;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    protected Announcement mapEntityFromLine(String line) {
        try {
            String[] parts = line.split("\\|");
            if (parts.length >= 5) {
                Announcement announcement = new Announcement();
                announcement.setId(Integer.parseInt(parts[0]));
                announcement.setTitle(parts[1]);
                announcement.setContent(parts[2]);
                announcement.setPublishDate(dateFormat.parse(parts[3]));

                if (parts.length > 4 && !parts[4].equals("null")) {
                    announcement.setExpiryDate(dateFormat.parse(parts[4]));
                }

                if (parts.length > 5) {
                    announcement.setPublishedBy(parts[5]);
                }

                if (parts.length > 6) {
                    announcement.setActive(Boolean.parseBoolean(parts[6]));
                } else {
                    announcement.setActive(true);
                }

                return announcement;
            }
        } catch (ParseException | NumberFormatException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    protected String mapEntityToLine(Announcement announcement) {
        String expiryDate = announcement.getExpiryDate() != null ?
                dateFormat.format(announcement.getExpiryDate()) : "null";

        return announcement.getId() + "|" +
                announcement.getTitle() + "|" +
                announcement.getContent() + "|" +
                dateFormat.format(announcement.getPublishDate()) + "|" +
                expiryDate + "|" +
                announcement.getPublishedBy() + "|" +
                announcement.isActive();
    }
}
