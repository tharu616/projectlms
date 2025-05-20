package com.lms.studentlms.util;

import com.lms.studentlms.dao.RegistrationQueueDao;
import com.lms.studentlms.model.CourseRegistration;

import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

/**
 * Singleton class that manages the course registration queue.
 * Implements thread-safe operations and persistent storage.
 */
public class QueueManager {
    private static volatile QueueManager instance;
    private final Queue<CourseRegistration> registrationQueue;
    private final RegistrationQueueDao queueDao;
    private boolean isLoaded;

    /**
     * Private constructor to enforce singleton pattern.
     */
    private QueueManager() {
        this.registrationQueue = new LinkedList<>();
        this.queueDao = new RegistrationQueueDao();
        this.isLoaded = false;
    }

    /**
     * Gets the singleton instance using double-checked locking.
     *
     * @return The singleton instance
     */
    public static QueueManager getInstance() {
        if (instance == null) {
            synchronized (QueueManager.class) {
                if (instance == null) {
                    instance = new QueueManager();
                }
            }
        }
        return instance;
    }

    /**
     * Ensures the queue is loaded from persistent storage.
     */
    private void ensureQueueLoaded() {
        if (!isLoaded) {
            synchronized (this) {
                if (!isLoaded) {
                    List<CourseRegistration> storedRegistrations = queueDao.loadQueue();
                    registrationQueue.clear();
                    registrationQueue.addAll(storedRegistrations);
                    isLoaded = true;
                }
            }
        }
    }

    /**
     * Adds a registration request to the queue.
     *
     * @param registration The registration to add
     */
    public void addRegistration(CourseRegistration registration) {
        ensureQueueLoaded();
        synchronized (this) {
            registrationQueue.add(registration);
            queueDao.addRegistration(registration);
        }
    }

    /**
     * Processes and removes the next registration in the queue.
     *
     * @return The next registration, or null if the queue is empty
     */
    public CourseRegistration processNextRegistration() {
        ensureQueueLoaded();
        synchronized (this) {
            CourseRegistration registration = registrationQueue.poll();
            if (registration != null) {
                queueDao.removeFirstRegistration();
            }
            return registration;
        }
    }

    /**
     * Gets all registrations in the queue.
     *
     * @return A list of all registrations
     */
    public List<CourseRegistration> getAllRegistrations() {
        ensureQueueLoaded();
        synchronized (this) {
            return new LinkedList<>(registrationQueue);
        }
    }

    /**
     * Gets the current size of the queue.
     *
     * @return The number of registrations in the queue
     */
    public int getQueueSize() {
        ensureQueueLoaded();
        synchronized (this) {
            return registrationQueue.size();
        }
    }

    /**
     * Checks if the queue is empty.
     *
     * @return true if the queue is empty, false otherwise
     */
    public boolean isQueueEmpty() {
        ensureQueueLoaded();
        synchronized (this) {
            return registrationQueue.isEmpty();
        }
    }

    /**
     * Clears all registrations from the queue.
     */
    public void clearAllRegistrations() {
        ensureQueueLoaded();
        synchronized (this) {
            registrationQueue.clear();
            queueDao.clearAllRequests();
        }
    }

    /**
     * Gets a student's position in the queue.
     *
     * @param studentEmail The student's email
     * @param courseCode The course code
     * @return The position (1-based), or -1 if not found
     */
    public int getStudentPositionInQueue(String studentEmail, String courseCode) {
        ensureQueueLoaded();
        synchronized (this) {
            int position = 1;
            for (CourseRegistration reg : registrationQueue) {
                if (reg.getStudentEmail().equals(studentEmail) &&
                        reg.getCourseCode().equals(courseCode)) {
                    return position;
                }
                position++;
            }
            return -1; // Not found
        }
    }
}
