package com.lms.studentlms.service;

import com.lms.studentlms.dao.CourseDao;
import com.lms.studentlms.dao.RegistrationDao;
import com.lms.studentlms.dao.UserDao;
import com.lms.studentlms.model.Course;
import com.lms.studentlms.model.CourseRegistration;
import com.lms.studentlms.model.User;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class RegistrationService {
    private RegistrationDao registrationDao;
    private CourseDao courseDao;
    private UserDao userDao;

    public RegistrationService() {
        this.registrationDao = new RegistrationDao();
        this.courseDao = new CourseDao();
        this.userDao = new UserDao();
    }

    public List<CourseRegistration> getRegistrationsByEmail(String userEmail) {
        if (userEmail == null || userEmail.isEmpty()) {
            return new ArrayList<>();
        }

        try {
            return registrationDao.getRegistrationsByEmail(userEmail);
        } catch (IOException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public boolean registerForCourse(String userEmail, String courseCode) {
        if (userEmail == null || userEmail.isEmpty() || courseCode == null || courseCode.isEmpty()) {
            return false;
        }

        // Check if user exists
        User user = userDao.getUserByEmail(userEmail);
        if (user == null) {
            return false;
        }

        // Check if course exists
        Course course = courseDao.getCourseByCode(courseCode);
        if (course == null) {
            return false;
        }

        // Check if already registered
        try {
            CourseRegistration existingRegistration = registrationDao.getRegistrationByEmailAndCourse(userEmail, courseCode);
            if (existingRegistration != null) {
                return false;
            }

            // Create registration
            CourseRegistration registration = new CourseRegistration(
                    userEmail,
                    user.getFullName(),
                    courseCode,
                    course.getCourseName(),
                    String.valueOf(course.getFee()),  // Convert double to String
                    course.getSchool()  // Get the actual school name
            );

            return registrationDao.saveRegistration(registration);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<CourseRegistration> getAllRegistrations() {
        try {
            return registrationDao.getAllRegistrations();
        } catch (IOException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public CourseRegistration getRegistrationByEmailAndCourse(String email, String courseCode) {
        if (email == null || email.isEmpty() || courseCode == null || courseCode.isEmpty()) {
            return null;
        }

        try {
            return registrationDao.getRegistrationByEmailAndCourse(email, courseCode);
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<CourseRegistration> getRegistrationsByCourse(String courseCode) {
        if (courseCode == null || courseCode.isEmpty()) {
            return new ArrayList<>();
        }

        try {
            return registrationDao.getRegistrationsByCourse(courseCode);
        } catch (IOException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public int getTotalRegistrationCount() {
        try {
            return registrationDao.getTotalRegistrationCount();
        } catch (IOException e) {
            e.printStackTrace();
            return 0;
        }
    }

    public boolean cancelRegistration(String email, String courseCode) {
        if (email == null || email.isEmpty() || courseCode == null || courseCode.isEmpty()) {
            return false;
        }

        try {
            return registrationDao.deleteRegistration(email, courseCode);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
}
