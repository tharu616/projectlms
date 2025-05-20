package com.lms.studentlms.dao;

import com.lms.studentlms.model.CourseRegistration;
import com.lms.studentlms.util.FileUtils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class CourseRegistrationDao extends BaseDao<CourseRegistration> {
    private static final String FILE_PATH = "src/main/resources/data/registrations.txt";

    public CourseRegistrationDao() {
        super(FILE_PATH);
    }

    public List<CourseRegistration> getAllRegistrations() throws IOException {
        return findAll();
    }

    public CourseRegistration getRegistrationByEmailAndCourse(String email, String courseCode) throws IOException {
        List<CourseRegistration> registrations = findAll();
        return registrations.stream()
                .filter(r -> r.getStudentEmail().equals(email) && r.getCourseCode().equals(courseCode))
                .findFirst()
                .orElse(null);
    }

    public List<CourseRegistration> getRegistrationsByEmail(String email) throws IOException {
        List<CourseRegistration> registrations = findAll();
        return registrations.stream()
                .filter(r -> r.getStudentEmail().equals(email))
                .collect(Collectors.toList());
    }

    public List<CourseRegistration> getRegistrationsByCourse(String courseCode) throws IOException {
        List<CourseRegistration> registrations = findAll();
        return registrations.stream()
                .filter(r -> r.getCourseCode().equals(courseCode))
                .collect(Collectors.toList());
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

    @Override
    protected CourseRegistration mapEntityFromLine(String line) {
        String[] parts = line.split(",");
        if (parts.length >= 6) {
            CourseRegistration registration = new CourseRegistration(
                    parts[0], // studentEmail
                    parts[1], // studentName
                    parts[2], // courseCode
                    parts[3], // courseName
                    parts[4], // courseFee
                    parts[5]  // schoolName
            );

            if (parts.length > 6) {
                try {
                    registration.setTimestamp(Long.parseLong(parts[6]));
                } catch (NumberFormatException e) {
                    registration.setTimestamp(System.currentTimeMillis());
                }
            }

            return registration;
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
