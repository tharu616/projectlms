package com.lms.studentlms.controller.admin;

import com.lms.studentlms.dao.CourseDao;
import com.lms.studentlms.dao.AdminLogDao;

import com.lms.studentlms.model.Course;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/courses/*")
public class CourseManagementServlet extends HttpServlet {

    private CourseDao courseDao;
    private AdminLogDao adminLogDao;

    @Override
    public void init() throws ServletException {
        courseDao = new CourseDao();
        adminLogDao = new AdminLogDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
            request.getRequestDispatcher("/WEB-INF/views/admin/courses/create.jsp").forward(request, response);
        } else if (pathInfo.startsWith("/edit/")) {
            // Show edit course form
            String courseId = pathInfo.substring("/edit/".length());
            Course course = courseDao.getCourseById(courseId);

            if (course != null) {
                request.setAttribute("course", course);
                request.getRequestDispatcher("/WEB-INF/views/admin/courses/edit.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/courses");
            }
        } else if (pathInfo.startsWith("/view/")) {
            // Show course details
            String courseId = pathInfo.substring("/view/".length());
            Course course = courseDao.getCourseById(courseId);

            if (course != null) {
                request.setAttribute("course", course);
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
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
            Course course = new Course(
                    request.getParameter("courseCode"),
                    request.getParameter("duration"),
                    request.getParameter("fee")
            );

            String schoolName = request.getParameter("schoolName");
            boolean created = courseDao.createCourse(schoolName, course);

            if (created) {
                adminLogDao.logActivity(adminEmail, "COURSE_CREATE",
                        "Created course: " + course.getCourseCode() + " in school: " + schoolName);

                response.sendRedirect(request.getContextPath() + "/admin/courses?created=true");
            } else {
                request.setAttribute("error", "Failed to create course");
                request.setAttribute("course", course);
                request.getRequestDispatcher("/WEB-INF/views/admin/courses/create.jsp").forward(request, response);
            }
        } else if ("update".equals(action)) {
            // Update existing course
            Course course = new Course(
                    request.getParameter("courseCode"),
                    request.getParameter("duration"),
                    request.getParameter("fee")
            );

            String schoolName = request.getParameter("schoolName");
            boolean updated = courseDao.updateCourse(schoolName, course);

            if (updated) {
                adminLogDao.logActivity(adminEmail, "COURSE_UPDATE",
                        "Updated course: " + course.getCourseCode() + " in school: " + schoolName);

                response.sendRedirect(request.getContextPath() + "/admin/courses?updated=true");
            } else {
                request.setAttribute("error", "Failed to update course");
                request.setAttribute("course", course);
                request.getRequestDispatcher("/WEB-INF/views/admin/courses/edit.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/courses");
        }
    }
}
