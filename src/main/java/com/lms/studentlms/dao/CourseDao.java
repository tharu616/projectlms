package com.lms.studentlms.dao;

import com.lms.studentlms.model.Course;
import com.lms.studentlms.util.FileUtils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

public class CourseDao extends BaseDao<Course> {
    private static final String FILE_PATH = "C:\\Users\\USER\\OneDrive - Sri Lanka Institute of Information Technology\\Desktop\\New folder\\projectlms\\src\\main\\resources\\data\\courses.txt";

    public CourseDao() {
        super(FILE_PATH);
    }

    public List<Course> getAllCourses() {
        try {
            return findAll();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public Course getCourseByCode(String courseCode) {
        try {
            Optional<Course> courseOpt = findAll().stream()
                    .filter(course -> course.getCourseCode().equals(courseCode))
                    .findFirst();
            return courseOpt.orElse(null);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Course> getCoursesBySchool(String school) {
        try {
            List<Course> allCourses = findAll();
            return allCourses.stream()
                    .filter(course -> course.getSchool().equalsIgnoreCase(school))
                    .collect(Collectors.toList());
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public List<Course> searchCourses(String query) {
        try {
            if (query == null || query.trim().isEmpty()) {
                return getAllCourses();
            }

            String lowercaseQuery = query.toLowerCase();
            List<Course> allCourses = findAll();

            return allCourses.stream()
                    .filter(course ->
                            course.getCourseName().toLowerCase().contains(lowercaseQuery) ||
                                    course.getCourseCode().toLowerCase().contains(lowercaseQuery) ||
                                    course.getDescription().toLowerCase().contains(lowercaseQuery))
                    .collect(Collectors.toList());
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public List<String> getAllSchools() {
        try {
            List<Course> allCourses = findAll();
            return allCourses.stream()
                    .map(Course::getSchool)
                    .distinct()
                    .sorted()
                    .collect(Collectors.toList());
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public boolean saveCourse(Course course) {
        try {
            return save(course);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean createCourse(String schoolName, Course course) {
        course.setSchool(schoolName);
        return saveCourse(course);
    }

    public boolean updateCourse(Course course) {
        try {
            List<Course> courses = findAll();
            List<Course> updatedCourses = new ArrayList<>();
            boolean updated = false;

            for (Course existingCourse : courses) {
                if (existingCourse.getCourseCode().equals(course.getCourseCode())) {
                    updatedCourses.add(course);
                    updated = true;
                } else {
                    updatedCourses.add(existingCourse);
                }
            }

            if (updated) {
                return saveAllOverwrite(updatedCourses);
            }

            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateCourse(String schoolName, Course course) {
        course.setSchool(schoolName);
        return updateCourse(course);
    }

    public boolean deleteCourse(String courseCode) {
        try {
            List<Course> courses = findAll();
            List<Course> updatedCourses = courses.stream()
                    .filter(course -> !course.getCourseCode().equals(courseCode))
                    .collect(Collectors.toList());

            if (updatedCourses.size() < courses.size()) {
                return saveAllOverwrite(updatedCourses);
            }

            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getTotalCourseCount() {
        try {
            return findAll().size();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public Map<String, Integer> getCourseCountBySchool() {
        try {
            List<Course> courses = findAll();
            Map<String, Integer> countBySchool = new HashMap<>();

            for (Course course : courses) {
                String school = course.getSchool();
                countBySchool.put(school, countBySchool.getOrDefault(school, 0) + 1);
            }

            return countBySchool;
        } catch (Exception e) {
            e.printStackTrace();
            return new HashMap<>();
        }
    }

    @Override
    protected Course mapEntityFromLine(String line) {
        try {
            String[] parts = line.split(",");
            if (parts.length >= 8) {
                Course course = new Course();
                course.setCourseCode(parts[0]);
                course.setCourseName(parts[1]);
                course.setDuration(parts[2]);
                course.setSchool(parts[3]);
                course.setFee(Double.parseDouble(parts[4]));
                course.setDescription(parts[5]);
                course.setPrerequisites(parts[6]);
                course.setLearningOutcomes(parts[7]);
                return course;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    protected String mapEntityToLine(Course course) {
        return course.getCourseCode() + "," +
                course.getCourseName() + "," +
                course.getDuration() + "," +
                course.getSchool() + "," +
                course.getFee() + "," +
                course.getDescription() + "," +
                course.getPrerequisites() + "," +
                course.getLearningOutcomes();
    }
}
