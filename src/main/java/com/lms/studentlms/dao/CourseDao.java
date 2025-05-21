package com.lms.studentlms.dao;

import com.lms.studentlms.model.Course;
import com.lms.studentlms.util.FileUtils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class CourseDao extends BaseDao<Course> {
    private static final String FILE_PATH = "C:\\Users\\USER\\OneDrive - Sri Lanka Institute of Information Technology\\Desktop\\New folder\\projectlms\\src\\main\\resources\\data\\courses.txt";
    private static final String SCHOOLS_FILE_PATH = "C:\\Users\\USER\\OneDrive - Sri Lanka Institute of Information Technology\\Desktop\\New folder\\projectlms\\src\\main\\resources\\data\\schools.txt";

    public CourseDao() {
        super(FILE_PATH);
    }

    public List<Course> getAllCourses() {
        try {
            List<String> lines = FileUtils.readLinesFromFile(FILE_PATH);
            List<Course> courses = new ArrayList<>();

            for (String line : lines) {
                String[] parts = line.split(",");
                if (parts.length >= 4) {
                    Course course = new Course(
                            parts[0], // courseCode
                            parts[1], // duration
                            parts[3]  // fee
                    );
                    courses.add(course);
                }
            }

            return courses;
        } catch (IOException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public Course getCourseByCode(String courseCode) {
        try {
            List<String> lines = FileUtils.readLinesFromFile(FILE_PATH);

            for (String line : lines) {
                String[] parts = line.split(",");
                if (parts.length >= 4 && parts[0].equals(courseCode)) {
                    return new Course(
                            parts[0], // courseCode
                            parts[1], // duration
                            parts[3]  // fee
                    );
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return null; // Course not found
    }

    public Course getCourseById(String courseId) {
        return getCourseByCode(courseId); // In this implementation, id is the same as code
    }

    public List<Course> getCoursesBySchool(String schoolName) {
        try {
            List<String> lines = FileUtils.readLinesFromFile(FILE_PATH);
            List<Course> courses = new ArrayList<>();

            for (String line : lines) {
                String[] parts = line.split(",");
                if (parts.length >= 4 && parts[2].equals(schoolName)) {
                    Course course = new Course(
                            parts[0], // courseCode
                            parts[1], // duration
                            parts[3]  // fee
                    );
                    courses.add(course);
                }
            }

            return courses;
        } catch (IOException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public List<String> getAllSchools() {
        try {
            List<String> lines = FileUtils.readLinesFromFile(SCHOOLS_FILE_PATH);
            return lines.stream()
                    .filter(line -> !line.trim().isEmpty())
                    .collect(Collectors.toList());
        } catch (IOException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public boolean createCourse(String schoolName, Course course) {
        try {
            List<String> lines = new ArrayList<>();
            lines.add(course.getCourseCode() + "," +
                    course.getDuration() + "," +
                    schoolName + "," +
                    course.getFee());

            FileUtils.writeLinesToFile(FILE_PATH, lines, true); // append mode
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateCourse(String schoolName, Course course) {
        try {
            List<String> allLines = FileUtils.readLinesFromFile(FILE_PATH);
            List<String> updatedLines = new ArrayList<>();
            boolean updated = false;

            for (String line : allLines) {
                String[] parts = line.split(",");
                if (parts.length >= 4 && parts[0].equals(course.getCourseCode())) {
                    // This is the course to update
                    updatedLines.add(course.getCourseCode() + "," +
                            course.getDuration() + "," +
                            schoolName + "," +
                            course.getFee());
                    updated = true;
                } else {
                    updatedLines.add(line);
                }
            }

            if (updated) {
                FileUtils.writeLinesToFile(FILE_PATH, updatedLines, false); // overwrite mode
                return true;
            }

            return false;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteCourse(String courseCode) {
        try {
            List<String> allLines = FileUtils.readLinesFromFile(FILE_PATH);
            List<String> updatedLines = allLines.stream()
                    .filter(line -> {
                        String[] parts = line.split(",");
                        return parts.length < 4 || !parts[0].equals(courseCode);
                    })
                    .collect(Collectors.toList());

            if (updatedLines.size() < allLines.size()) {
                FileUtils.writeLinesToFile(FILE_PATH, updatedLines, false); // overwrite mode
                return true;
            }

            return false;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Course> searchCourses(String query) {
        query = query.toLowerCase();
        List<Course> allCourses = getAllCourses();

        String finalQuery = query;
        return allCourses.stream()
                .filter(course ->
                        course.getCourseCode().toLowerCase().contains(finalQuery) ||
                                course.getDuration().toLowerCase().contains(finalQuery) ||
                                course.getFee().toLowerCase().contains(finalQuery))
                .collect(Collectors.toList());
    }

    public int getTotalCourseCount() {
        try {
            List<String> lines = FileUtils.readLinesFromFile(FILE_PATH);
            return (int) lines.stream()
                    .filter(line -> !line.trim().isEmpty())
                    .count();
        } catch (IOException e) {
            e.printStackTrace();
            return 0;
        }
    }

    public Map<String, Integer> getCourseCountBySchool() {
        Map<String, Integer> countMap = new HashMap<>();

        try {
            List<String> lines = FileUtils.readLinesFromFile(FILE_PATH);

            for (String line : lines) {
                String[] parts = line.split(",");
                if (parts.length >= 4) {
                    String school = parts[2];
                    countMap.put(school, countMap.getOrDefault(school, 0) + 1);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return countMap;
    }

    @Override
    protected Course mapEntityFromLine(String line) {
        String[] parts = line.split(",");
        if (parts.length >= 4) {
            return new Course(
                    parts[0], // courseCode
                    parts[1], // duration
                    parts[3]  // fee
            );
        }
        return null;
    }

    @Override
    protected String mapEntityToLine(Course course) {
        // Note: This doesn't include the school name, which is needed for the file format
        // This method should be used with caution or modified to include school
        return course.getCourseCode() + "," +
                course.getDuration() + "," +
                "Unknown School" + "," + // Placeholder
                course.getFee();
    }
}
