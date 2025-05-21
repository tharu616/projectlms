package com.lms.studentlms.dao;

import com.lms.studentlms.model.AdminLog;
import com.lms.studentlms.util.FileUtils;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
//extends keyword indicates inheritance
public class AdminLogDao extends BaseDao<AdminLog> {
    private static final String FILE_PATH = "src/main/resources/data/admin_logs.txt";
    private static final SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    public AdminLogDao() {
        super(FILE_PATH);
    }
//parameterized constructor
    public void logActivity(String adminEmail, String actionType, String description) {
        AdminLog log = new AdminLog();
        log.setAdminEmail(adminEmail);
        log.setActionType(actionType);
        log.setDescription(description);
        log.setTimestamp(System.currentTimeMillis());

        try {
            List<String> lines = new ArrayList<>();
            lines.add(mapEntityToLine(log));
            FileUtils.writeLinesToFile(FILE_PATH, lines, true); // append mode
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public List<AdminLog> getRecentLogs(int limit) {
        try {
            return FileUtils.readLinesFromFile(FILE_PATH).stream()
                    .map(this::mapEntityFromLine)
                    .filter(log -> log != null)
                    .sorted((a, b) -> Long.compare(b.getTimestamp(), a.getTimestamp())) // Most recent first
                    .limit(limit)
                    .collect(Collectors.toList());
        } catch (IOException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public List<AdminLog> getLogsByAdmin(String adminEmail) {
        try {
            return FileUtils.readLinesFromFile(FILE_PATH).stream()
                    .map(this::mapEntityFromLine)
                    .filter(log -> log != null && log.getAdminEmail().equals(adminEmail))
                    .sorted((a, b) -> Long.compare(b.getTimestamp(), a.getTimestamp())) // Most recent first
                    .collect(Collectors.toList());
        } catch (IOException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public List<AdminLog> getLogsByActionType(String actionType) {
        try {
            return FileUtils.readLinesFromFile(FILE_PATH).stream()
                    .map(this::mapEntityFromLine)
                    .filter(log -> log != null && log.getActionType().equals(actionType))
                    .sorted((a, b) -> Long.compare(b.getTimestamp(), a.getTimestamp())) // Most recent first
                    .collect(Collectors.toList());
        } catch (IOException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    @Override
    protected AdminLog mapEntityFromLine(String line) {
        String[] parts = line.split("\\|");
        if (parts.length >= 4) {
            AdminLog log = new AdminLog();
            log.setAdminEmail(parts[0]);
            log.setActionType(parts[1]);
            log.setDescription(parts[2]);
            try {
                log.setTimestamp(Long.parseLong(parts[3]));
            } catch (NumberFormatException e) {
                log.setTimestamp(System.currentTimeMillis());
            }
            return log;
        }
        return null;
    }

    @Override
    protected String mapEntityToLine(AdminLog log) {
        return log.getAdminEmail() + "|" +
                log.getActionType() + "|" +
                log.getDescription() + "|" +
                log.getTimestamp();
    }
}
