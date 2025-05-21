package com.lms.studentlms.util;

import com.lms.studentlms.dao.CourseRegistrationDao;
import com.lms.studentlms.model.CourseRegistration;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class RegistrationQueueManager {
    private static final String QUEUE_FILE_PATH = "C:\\Users\\USER\\OneDrive - Sri Lanka Institute of Information Technology\\Desktop\\New folder\\projectlms\\src\\main\\resources\\data\\ registration_queue.txt";
    private static RegistrationQueueManager instance;
    private CourseRegistrationDao registrationDao;

    private RegistrationQueueManager() {
        this.registrationDao = new CourseRegistrationDao();
    }

    public static synchronized RegistrationQueueManager getInstance() {
        if (instance == null) {
            instance = new RegistrationQueueManager();
        }
        return instance;
    }

    public List<CourseRegistration> getPendingRegistrations() {
        try {
            if (!Files.exists(Paths.get(QUEUE_FILE_PATH))) {
                return new ArrayList<>();
            }

            List<String> lines = Files.readAllLines(Paths.get(QUEUE_FILE_PATH));
            List<CourseRegistration> registrations = new ArrayList<>();

            for (String line : lines) {
                String[] parts = line.split(",");
                if (parts.length >= 7) {
                    CourseRegistration registration = new CourseRegistration(
                            parts[0], // studentEmail
                            parts[1], // studentName
                            parts[2], // courseCode
                            parts[3], // courseName
                            parts[4], // courseFee
                            parts[5]  // schoolName
                    );

                    try {
                        registration.setTimestamp(Long.parseLong(parts[6]));
                    } catch (NumberFormatException e) {
                        registration.setTimestamp(System.currentTimeMillis());
                    }

                    registrations.add(registration);
                }
            }

            return registrations;
        } catch (IOException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    // Add the missing method that's causing the error
    public CourseRegistration processNextRegistration() {
        List<CourseRegistration> pendingRegistrations = getPendingRegistrations();

        if (pendingRegistrations.isEmpty()) {
            return null;
        }

        // Sort by timestamp (oldest first)
        pendingRegistrations.sort((r1, r2) -> Long.compare(r1.getTimestamp(), r2.getTimestamp()));

        // Get the first (oldest) registration
        CourseRegistration nextRegistration = pendingRegistrations.get(0);

        // Remove it from the queue
        removeFromQueue(nextRegistration.getStudentEmail(), nextRegistration.getCourseCode());

        return nextRegistration;
    }

    public boolean addRegistration(CourseRegistration registration) {
        try {
            String line = formatRegistrationLine(registration);
            List<String> lines = new ArrayList<>();
            lines.add(line);

            return FileUtils.writeLinesToFile(QUEUE_FILE_PATH, lines, true);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int processQueue() {
        List<CourseRegistration> pendingRegistrations = getPendingRegistrations();
        int processed = 0;

        for (CourseRegistration registration : pendingRegistrations) {
            boolean saved = registrationDao.saveRegistration(registration);
            if (saved) {
                processed++;
            }
        }

        if (processed > 0) {
            clearQueue();
        }

        return processed;
    }

    public boolean approveRegistration(String studentEmail, String courseCode) {
        List<CourseRegistration> pendingRegistrations = getPendingRegistrations();

        for (CourseRegistration registration : pendingRegistrations) {
            if (registration.getStudentEmail().equals(studentEmail) &&
                    registration.getCourseCode().equals(courseCode)) {
                boolean saved = registrationDao.saveRegistration(registration);
                if (saved) {
                    removeFromQueue(studentEmail, courseCode);
                    return true;
                }
            }
        }

        return false;
    }

    public boolean rejectRegistration(String studentEmail, String courseCode) {
        return removeFromQueue(studentEmail, courseCode);
    }

    public int clearQueue() {
        try {
            int size = getPendingRegistrations().size();
            Files.write(Paths.get(QUEUE_FILE_PATH), new ArrayList<>());
            return size;
        } catch (IOException e) {
            e.printStackTrace();
            return 0;
        }
    }

    // Also add these methods from the RegistrationQueueService
    public List<CourseRegistration> getAllRegistrations() {
        return getPendingRegistrations();
    }

    public int getQueueSize() {
        return getPendingRegistrations().size();
    }

    public void clearAllRegistrations() {
        clearQueue();
    }

    public int getStudentPositionInQueue(String studentEmail, String courseCode) {
        if (studentEmail == null || studentEmail.isEmpty() || courseCode == null || courseCode.isEmpty()) {
            return -1;
        }

        List<CourseRegistration> registrations = getPendingRegistrations();
        // Sort by timestamp (oldest first)
        registrations.sort((r1, r2) -> Long.compare(r1.getTimestamp(), r2.getTimestamp()));

        for (int i = 0; i < registrations.size(); i++) {
            CourseRegistration reg = registrations.get(i);
            if (reg.getStudentEmail().equals(studentEmail) && reg.getCourseCode().equals(courseCode)) {
                return i + 1; // Position is 1-based
            }
        }

        return -1; // Not in queue
    }

    private boolean removeFromQueue(String studentEmail, String courseCode) {
        try {
            List<CourseRegistration> pendingRegistrations = getPendingRegistrations();
            List<CourseRegistration> updatedRegistrations = pendingRegistrations.stream()
                    .filter(r -> !(r.getStudentEmail().equals(studentEmail) && r.getCourseCode().equals(courseCode)))
                    .collect(Collectors.toList());

            if (updatedRegistrations.size() < pendingRegistrations.size()) {
                List<String> lines = updatedRegistrations.stream()
                        .map(this::formatRegistrationLine)
                        .collect(Collectors.toList());

                Files.write(Paths.get(QUEUE_FILE_PATH), lines);
                return true;
            }

            return false;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    private String formatRegistrationLine(CourseRegistration registration) {
        return registration.getStudentEmail() + "," +
                registration.getStudentName() + "," +
                registration.getCourseCode() + "," +
                registration.getCourseName() + "," +
                registration.getCourseFee() + "," +
                registration.getSchoolName() + "," +
                registration.getTimestamp();
    }
}
