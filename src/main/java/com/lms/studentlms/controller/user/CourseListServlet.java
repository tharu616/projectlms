package com.lms.studentlms.controller.user;

import com.lms.studentlms.dao.CourseDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/user/courses")
public class CourseListServlet extends HttpServlet {

    private CourseDao courseDao;

    @Override
    public void init() throws ServletException {
        courseDao = new CourseDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Get filter parameters
        String schoolFilter = request.getParameter("school");

        // Get all courses, optionally filtered by school
        List<Course> courses;
        if (schoolFilter != null && !schoolFilter.isEmpty()) {
            courses = courseDao.getCoursesBySchool(schoolFilter);
            request.setAttribute("schoolFilter", schoolFilter);
        } else {
            courses = courseDao.getAllCourses();
        }

        // Get all available schools for the filter dropdown
        List<String> schools = courseDao.getAllSchools();

        // Set attributes for the JSP
        request.setAttribute("courses", courses);
        request.setAttribute("schools", schools);

        // Forward to the courses list JSP
        request.getRequestDispatcher("/WEB-INF/views/user/courses/list.jsp").forward(request, response);
    }
}
