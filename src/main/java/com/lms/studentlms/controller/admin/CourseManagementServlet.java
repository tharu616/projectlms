package com.lms.studentlms.controller.admin;

import com.lms.studentlms.dao.CourseDao;
import com.lms.studentlms.dao.CourseRegistrationDao;
import com.lms.studentlms.dao.AdminLogDao;
import com.lms.studentlms.model.Course;
import com.lms.studentlms.model.CourseRegistration;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/courses/*")
public class CourseManagementServlet extends HttpServlet {
    private CourseDao courseDao;
    private CourseRegistrationDao registrationDao;
    private AdminLogDao adminLogDao;

    @Override
    public void init() throws ServletException {
        courseDao = new CourseDao();
        registrationDao = new CourseRegistrationDao();
        adminLogDao = new AdminLogDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Check if admin is logged in
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("adminEmail") == null) {
                response.sendRedirect(request.getContextPath() + "/admin/login");
                return;
            }

            String pathInfo = request.getPathInfo();
            if (pathInfo == null || pathInfo.equals("/")) {
                // List all courses
                List<Course> courses = courseDao.getAllCourses();
                request.setAttribute("courses", courses);
                request.getRequestDispatcher("/WEB-INF/views/admin/courses/list.jsp").forward(request, response);
            } else if (pathInfo.equals("/create")) {
                // Show create course form
                List<String> schools = courseDao.getAllSchools();
                request.setAttribute("schools", schools);
                request.getRequestDispatcher("/WEB-INF/views/admin/courses/create.jsp").forward(request, response);
            } else if (pathInfo.startsWith("/edit/")) {
                // Show edit course form
                String courseId = pathInfo.substring("/edit/".length());
                Course course = courseDao.getCourseByCode(courseId);
                if (course != null) {
                    List<String> schools = courseDao.getAllSchools();
                    request.setAttribute("schools", schools);
                    request.setAttribute("course", course);
                    request.getRequestDispatcher("/WEB-INF/views/admin/courses/edit.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/courses");
                }
            } else if (pathInfo.startsWith("/view/")) {
                // Show course details
                String courseId = pathInfo.substring("/view/".length());
                Course course = courseDao.getCourseByCode(courseId);
                if (course != null) {
                    // Get enrollments for this course
                    List<CourseRegistration> enrollments = registrationDao.getRegistrationsByCourse(courseId);

                    // Calculate enrollment statistics
                    Map<String, Integer> enrollmentStats = new HashMap<>();
                    enrollmentStats.put("total", enrollments.size());
                    enrollmentStats.put("completed", 0);
                    enrollmentStats.put("inProgress", enrollments.size());

                    request.setAttribute("course", course);
                    request.setAttribute("enrollments", enrollments);
                    request.setAttribute("enrollmentStats", enrollmentStats);

                    request.getRequestDispatcher("/WEB-INF/views/admin/courses/view.jsp").forward(request, response);
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/courses");
                }
            } else if (pathInfo.startsWith("/delete/")) {
                // Delete course
                String courseId = pathInfo.substring("/delete/".length());
                boolean deleted = courseDao.deleteCourse(courseId);
                if (deleted) {
                    String adminEmail = (String) session.getAttribute("adminEmail");
                    adminLogDao.logActivity(adminEmail, "COURSE_DELETE", "Deleted course: " + courseId);
                }
                response.sendRedirect(request.getContextPath() + "/admin/courses");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/courses");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Check if admin is logged in
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("adminEmail") == null) {
                response.sendRedirect(request.getContextPath() + "/admin/login");
                return;
            }

            String action = request.getParameter("action");
            String adminEmail = (String) session.getAttribute("adminEmail");

            if ("create".equals(action)) {
                // Create new course
                Course course = new Course();
                course.setCourseCode(request.getParameter("courseCode"));
                course.setCourseName(request.getParameter("courseName"));
                course.setDuration(request.getParameter("duration"));
                course.setSchool(request.getParameter("school"));
                course.setDescription(request.getParameter("description"));
                course.setPrerequisites(request.getParameter("prerequisites"));
                course.setLearningOutcomes(request.getParameter("learningOutcomes"));

                try {
                    course.setFee(Double.parseDouble(request.getParameter("fee")));
                } catch (NumberFormatException e) {
                    course.setFee(0.0);
                }

                boolean created = courseDao.saveCourse(course);

                if (created) {
                    adminLogDao.logActivity(adminEmail, "COURSE_CREATE",
                            "Created course: " + course.getCourseCode() + " in school: " + course.getSchool());
                    response.sendRedirect(request.getContextPath() + "/admin/courses?created=true");
                } else {
                    request.setAttribute("error", "Failed to create course");
                    request.setAttribute("course", course);
                    List<String> schools = courseDao.getAllSchools();
                    request.setAttribute("schools", schools);
                    request.getRequestDispatcher("/WEB-INF/views/admin/courses/create.jsp").forward(request, response);
                }
            } else if ("update".equals(action)) {
                // Update existing course
                Course course = new Course();
                course.setCourseCode(request.getParameter("courseCode"));
                course.setCourseName(request.getParameter("courseName"));
                course.setDuration(request.getParameter("duration"));
                course.setSchool(request.getParameter("school"));
                course.setDescription(request.getParameter("description"));
                course.setPrerequisites(request.getParameter("prerequisites"));
                course.setLearningOutcomes(request.getParameter("learningOutcomes"));

                try {
                    course.setFee(Double.parseDouble(request.getParameter("fee")));
                } catch (NumberFormatException e) {
                    course.setFee(0.0);
                }

                boolean updated = courseDao.updateCourse(course);

                if (updated) {
                    adminLogDao.logActivity(adminEmail, "COURSE_UPDATE",
                            "Updated course: " + course.getCourseCode() + " in school: " + course.getSchool());
                    response.sendRedirect(request.getContextPath() + "/admin/courses?updated=true");
                } else {
                    request.setAttribute("error", "Failed to update course");
                    request.setAttribute("course", course);
                    List<String> schools = courseDao.getAllSchools();
                    request.setAttribute("schools", schools);
                    request.getRequestDispatcher("/WEB-INF/views/admin/courses/edit.jsp").forward(request, response);
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/courses");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
