package com.lms.studentlms.service;

import com.lms.studentlms.dao.RegistrationDao;
import com.lms.studentlms.model.CourseRegistration;
import com.lms.studentlms.model.Registration;
import com.lms.studentlms.util.RegistrationQueueManager;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class RegistrationQueueService {

    private RegistrationQueueManager queueManager;
    private RegistrationDao registrationDao;

    public RegistrationQueueService() {
        this.queueManager = RegistrationQueueManager.getInstance();
        this.registrationDao = new RegistrationDao();
    }

    public void addToQueue(CourseRegistration registration) {
        queueManager.addRegistration(registration);
    }

    public CourseRegistration processNextRegistration() {
        CourseRegistration registration = queueManager.processNextRegistration();
        if (registration != null) {
            try {
                registrationDao.saveRegistration(registration);
            } catch (IOException e) {
                e.printStackTrace();
                // Consider adding the registration back to the queue if saving fails
            }
        }
        return registration;
    }

    public CourseRegistration rejectNextRegistration() {
        return queueManager.processNextRegistration();
    }

    public List<CourseRegistration> getAllQueuedRegistrations() {
        return queueManager.getAllRegistrations();
    }

    public int getQueueSize() {
        return queueManager.getQueueSize();
    }

    public void clearQueue() {
        queueManager.clearAllRegistrations();
    }

    public int getStudentPositionInQueue(String studentEmail, String courseCode) {
        if (studentEmail == null || studentEmail.isEmpty() || courseCode == null || courseCode.isEmpty()) {
            return -1;
        }

        List<CourseRegistration> registrations = queueManager.getAllRegistrations();
        for (int i = 0; i < registrations.size(); i++) {
            CourseRegistration reg = registrations.get(i);
            if (reg.getStudentEmail().equals(studentEmail) && reg.getCourseCode().equals(courseCode)) {
                return i + 1; // Position is 1-based
            }
        }
        return -1; // Not in queue
    }

    public List<CourseRegistration> sortRegistrationsByTime() {
        List<CourseRegistration> registrations = new ArrayList<>(queueManager.getAllRegistrations());

        // Insertion sort by timestamp
        for (int i = 1; i < registrations.size(); i++) {
            CourseRegistration key = registrations.get(i);
            int j = i - 1;

            while (j >= 0 && registrations.get(j).getTimestamp() > key.getTimestamp()) {
                registrations.set(j + 1, registrations.get(j));
                j = j - 1;
            }
            registrations.set(j + 1, key);
        }

        return registrations;
    }
}
