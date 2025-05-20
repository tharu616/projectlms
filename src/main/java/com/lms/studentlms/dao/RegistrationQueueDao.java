package com.lms.studentlms.dao;

import com.lms.studentlms.util.FileUtils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class RegistrationQueueDao extends BaseDao<CourseRegistration> {
    private static final String FILE_PATH = "src/main/resources/data/registration_queue.txt";

    public RegistrationQueueDao() {
        super(FILE_PATH);
    }

    public List<CourseRegistration> loadQueue() {
        try {
            return FileUtils.readLinesFromFile(FILE_PATH).stream()
                    .map(this::mapEntityFromLine)
                    .filter(reg -> reg != null)
                    .collect(Collectors.toList());
        } catch (IOException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public boolean addRegistration(CourseRegistration registration) {
        try {
            List<String> lines = new ArrayList<>();
            lines.add(mapEntityToLine(registration));
            return FileUtils.writeLinesToFile(FILE_PATH, lines, true); // append mode
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean removeFirstRegistration() {
        try {
            List<String> lines = FileUtils.readLinesFromFile(FILE_PATH);
            if (!lines.isEmpty()) {
                lines.remove(0); // Remove the first line (FIFO)
                FileUtils.writeLinesToFile(FILE_PATH, lines, false); // overwrite mode
                return true;
            }
            return false;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean saveQueue(List<CourseRegistration> queue) {
        try {
            List<String> lines = queue.stream()
                    .map(this::mapEntityToLine)
                    .collect(Collectors.toList());
            FileUtils.writeLinesToFile(FILE_PATH, lines, false); // overwrite mode
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getStudentPositionInQueue(String studentEmail, String courseCode) {
        try {
            List<String> lines = FileUtils.readLinesFromFile(FILE_PATH);
            for (int i = 0; i < lines.size(); i++) {
                String line = lines.get(i);
                String[] parts = line.split(",");
                if (parts.length >= 3 &&
                        parts[0].equals(studentEmail) &&
                        parts[2].equals(courseCode)) {
                    return i + 1; // Position is 1-based
                }
            }
            return -1; // Not found
        } catch (IOException e) {
            e.printStackTrace();
            return -1;
        }
    }

    public boolean clearAllRequests() {
        try {
            FileUtils.writeLinesToFile(FILE_PATH, new ArrayList<>(), false); // overwrite with empty list
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    protected CourseRegistration mapEntityFromLine(String line) {
        String[] parts = line.split(",");
        if (parts.length >= 7) {
            CourseRegistration reg = new CourseRegistration(
                    parts[0], // studentEmail
                    parts[1], // studentName
                    parts[2], // courseCode
                    parts[3], // courseName
                    parts[4], // courseFee
                    parts[5]  // schoolName
            );
            try {
                reg.setTimestamp(Long.parseLong(parts[6]));
            } catch (NumberFormatException e) {
                reg.setTimestamp(System.currentTimeMillis());
            }
            return reg;
        }
        return null;
    }

    @Override
    protected String mapEntityToLine(CourseRegistration registration) {
        return registration.getStudentEmail() + "," +
                registration.getStudentName() + "," +
                registration.getCourseCode() + "," +
                registration.getCourseName() + "," +
                registration.getCourseFee() + "," +
                registration.getSchoolName() + "," +
                registration.getTimestamp();
    }
}
