package com.lms.studentlms.dao;

import com.lms.studentlms.model.CourseRegistration;
import com.lms.studentlms.util.FileUtils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class RegistrationDao extends BaseDao<CourseRegistration> {
    private static final String FILE_PATH = "src/main/resources/data/registrations.txt";

    public RegistrationDao() {
        super(FILE_PATH);
    }

    public List<CourseRegistration> getRegistrationsByEmail(String userEmail) throws IOException {
        return FileUtils.readLinesFromFile(FILE_PATH).stream()
                .map(line -> line.split(","))
                .filter(parts -> parts.length >= 7 && parts[0].equalsIgnoreCase(userEmail))
                .map(parts -> {
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
                })
                .collect(Collectors.toList());
    }

    public boolean saveRegistration(CourseRegistration registration) throws IOException {
        List<String> lines = new ArrayList<>();

        // Format: studentEmail,studentName,courseCode,courseName,courseFee,schoolName,timestamp
        lines.add(registration.getStudentEmail() + "," +
                registration.getStudentName() + "," +
                registration.getCourseCode() + "," +
                registration.getCourseName() + "," +
                registration.getCourseFee() + "," +
                registration.getSchoolName() + "," +
                registration.getTimestamp());

        // Save to file (append mode)
        return FileUtils.writeLinesToFile(FILE_PATH, lines, true);
    }

    public List<CourseRegistration> getAllRegistrations() throws IOException {
        return FileUtils.readLinesFromFile(FILE_PATH).stream()
                .map(line -> line.split(","))
                .filter(parts -> parts.length >= 7)
                .map(parts -> {
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
                })
                .collect(Collectors.toList());
    }

    public CourseRegistration getRegistrationByEmailAndCourse(String email, String courseCode) throws IOException {
        return getAllRegistrations().stream()
                .filter(reg -> reg.getStudentEmail().equals(email) && reg.getCourseCode().equals(courseCode))
                .findFirst()
                .orElse(null);
    }

    public List<CourseRegistration> getRegistrationsByCourse(String courseCode) throws IOException {
        return getAllRegistrations().stream()
                .filter(reg -> reg.getCourseCode().equals(courseCode))
                .collect(Collectors.toList());
    }

    public int getTotalRegistrationCount() throws IOException {
        return getAllRegistrations().size();
    }

    public int getPendingRegistrationsCount() throws IOException {
        // In a real implementation, this would check a status field
        // For this example, we'll return 0 since we don't track status
        return 0;
    }

    public boolean deleteRegistration(String email, String courseCode) throws IOException {
        List<String> allLines = FileUtils.readLinesFromFile(FILE_PATH);
        List<String> updatedLines = allLines.stream()
                .filter(line -> {
                    String[] parts = line.split(",");
                    return parts.length < 3 ||
                            !parts[0].equals(email) ||
                            !parts[2].equals(courseCode);
                })
                .collect(Collectors.toList());

        if (updatedLines.size() < allLines.size()) {
            FileUtils.writeLinesToFile(FILE_PATH, updatedLines, false);
            return true;
        }

        return false;
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
