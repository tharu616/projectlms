package com.lms.studentlms.service;

import com.lms.studentlms.dao.CourseDao;
import com.lms.studentlms.model.Course;

import java.util.List;
import java.util.Map;

public class CourseService {

    private CourseDao courseDao;

    public CourseService() {
        this.courseDao = new CourseDao();
    }

    public List<Course> getAllCourses() {
        return courseDao.getAllCourses();
    }

    public Course getCourseByCode(String courseCode) {
        if (courseCode == null || courseCode.isEmpty()) {
            return null;
        }
        return courseDao.getCourseByCode(courseCode);
    }

    public List<Course> getCoursesBySchool(String schoolName) {
        if (schoolName == null || schoolName.isEmpty()) {
            return List.of();
        }
        return courseDao.getCoursesBySchool(schoolName);
    }

    public List<String> getAllSchools() {
        return courseDao.getAllSchools();
    }

    public boolean createCourse(String schoolName, Course course) {
        if (schoolName == null || schoolName.isEmpty() || course == null ||
                course.getCourseCode() == null || course.getCourseCode().isEmpty()) {
            return false;
        }

        // Check if course already exists
        Course existingCourse = courseDao.getCourseByCode(course.getCourseCode());
        if (existingCourse != null) {
            return false;
        }

        return courseDao.createCourse(schoolName, course);
    }

    public boolean updateCourse(String schoolName, Course course) {
        if (schoolName == null || schoolName.isEmpty() || course == null ||
                course.getCourseCode() == null || course.getCourseCode().isEmpty()) {
            return false;
        }

        // Check if course exists
        Course existingCourse = courseDao.getCourseByCode(course.getCourseCode());
        if (existingCourse == null) {
            return false;
        }

        return courseDao.updateCourse(schoolName, course);
    }

    public boolean deleteCourse(String courseCode) {
        if (courseCode == null || courseCode.isEmpty()) {
            return false;
        }
        return courseDao.deleteCourse(courseCode);
    }

    public List<Course> searchCourses(String query) {
        if (query == null || query.isEmpty()) {
            return List.of();
        }
        return courseDao.searchCourses(query);
    }

    public int getTotalCourseCount() {
        return courseDao.getTotalCourseCount();
    }

    public Map<String, Integer> getCourseCountBySchool() {
        return courseDao.getCourseCountBySchool();
    }
}
