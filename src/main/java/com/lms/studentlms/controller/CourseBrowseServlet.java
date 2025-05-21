package com.lms.studentlms.controller;

import com.lms.studentlms.dao.CourseDao;
import com.lms.studentlms.model.Course;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/courses")
public class CourseBrowseServlet extends HttpServlet {
    private CourseDao courseDao;

    @Override
    public void init() throws ServletException {
        courseDao = new CourseDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get filter parameters
            String schoolFilter = request.getParameter("school");
            String searchQuery = request.getParameter("query");

            // Get courses based on filters
            List<Course> courses;
            if (schoolFilter != null && !schoolFilter.isEmpty()) {
                courses = courseDao.getCoursesBySchool(schoolFilter);
            } else if (searchQuery != null && !searchQuery.isEmpty()) {
                courses = courseDao.searchCourses(searchQuery);
            } else {
                courses = courseDao.getAllCourses();
            }

            // Get all schools for the filter dropdown
            List<String> schools = courseDao.getAllSchools();

            // Set attributes for the JSP
            request.setAttribute("courses", courses);
            request.setAttribute("schools", schools);
            request.setAttribute("selectedSchool", schoolFilter);
            request.setAttribute("searchQuery", searchQuery);

            // Forward to the course listing JSP
            request.getRequestDispatcher("/WEB-INF/views/courses/browse.jsp").forward(request, response);
        } catch (Exception e) {
            // Log the exception
            e.printStackTrace();

            // Forward to error page with details
            request.setAttribute("javax.servlet.error.exception", e);
            request.setAttribute("javax.servlet.error.status_code", 500);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
