package com.lms.studentlms.dao;

import com.lms.studentlms.model.CourseRegistration;
import com.lms.studentlms.util.FileUtils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class CourseRegistrationDao extends BaseDao<CourseRegistration> {
    private static final String FILE_PATH = "C:\\Users\\USER\\OneDrive - Sri Lanka Institute of Information Technology\\Desktop\\New folder\\projectlms\\src\\main\\resources\\data\\registrations.txt";

    public CourseRegistrationDao() {
        super(FILE_PATH);
    }

    public List<CourseRegistration> getAllRegistrations() {
        try {
            return findAll();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public CourseRegistration getRegistrationByEmailAndCourse(String email, String courseCode) {
        try {
            List<CourseRegistration> registrations = findAll();
            return registrations.stream()
                    .filter(r -> r.getStudentEmail().equals(email) && r.getCourseCode().equals(courseCode))
                    .findFirst()
                    .orElse(null);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<CourseRegistration> getRegistrationsByEmail(String email) {
        try {
            List<CourseRegistration> registrations = findAll();
            return registrations.stream()
                    .filter(r -> r.getStudentEmail().equals(email))
                    .collect(Collectors.toList());
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public List<CourseRegistration> getRegistrationsByCourse(String courseCode) {
        try {
            List<CourseRegistration> registrations = findAll();
            return registrations.stream()
                    .filter(r -> r.getCourseCode().equals(courseCode))
                    .collect(Collectors.toList());
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public boolean saveRegistration(CourseRegistration registration) {
        try {
            return save(registration);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteRegistration(String email, String courseCode) {
        try {
            List<CourseRegistration> registrations = findAll();
            List<CourseRegistration> updatedRegistrations = registrations.stream()
                    .filter(r -> !(r.getStudentEmail().equals(email) && r.getCourseCode().equals(courseCode)))
                    .collect(Collectors.toList());

            if (updatedRegistrations.size() < registrations.size()) {
                return saveAllOverwrite(updatedRegistrations);
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isUserRegisteredForCourse(String email, String courseCode) {
        CourseRegistration registration = getRegistrationByEmailAndCourse(email, courseCode);
        return registration != null;
    }

    public int getTotalRegistrationCount() {
        try {
            return findAll().size();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public int getPendingRegistrationsCount() {
        // Implement this based on your business logic
        // For example, if you have a status field in CourseRegistration
        return 0;
    }

    @Override
    protected CourseRegistration mapEntityFromLine(String line) {
        try {
            String[] parts = line.split(",");
            if (parts.length >= 6) {
                CourseRegistration registration = new CourseRegistration();
                registration.setStudentEmail(parts[0]);
                registration.setStudentName(parts[1]);
                registration.setCourseCode(parts[2]);
                registration.setCourseName(parts[3]);
                registration.setCourseFee(parts[4]);
                registration.setSchoolName(parts[5]);

                if (parts.length > 6) {
                    try {
                        registration.setTimestamp(Long.parseLong(parts[6]));
                    } catch (NumberFormatException e) {
                        registration.setTimestamp(System.currentTimeMillis());
                    }
                } else {
                    registration.setTimestamp(System.currentTimeMillis());
                }

                return registration;
            }
        } catch (Exception e) {
            e.printStackTrace();
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
