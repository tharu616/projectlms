package com.lms.studentlms.controller;

import com.lms.studentlms.dao.CourseDao;
import com.lms.studentlms.dao.CourseRegistrationDao;
import com.lms.studentlms.model.Course;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Optional;

@WebServlet("/courses/details")
public class CourseDetailsServlet extends HttpServlet {
    private CourseDao courseDao;
    private CourseRegistrationDao registrationDao;

    @Override
    public void init() throws ServletException {
        courseDao = new CourseDao();
        registrationDao = new CourseRegistrationDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String courseCode = request.getParameter("code");
            if (courseCode == null || courseCode.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/courses");
                return;
            }

            // Option 1: If CourseDao.getCourseByCode returns Course (not Optional)
            Course course = courseDao.getCourseByCode(courseCode);
            if (course == null) {
                response.sendRedirect(request.getContextPath() + "/courses");
                return;
            }

            /* Option 2: If you want to modify CourseDao to return Optional<Course>
            Optional<Course> courseOpt = courseDao.getCourseByCode(courseCode);
            if (!courseOpt.isPresent()) {
                response.sendRedirect(request.getContextPath() + "/courses");
                return;
            }
            Course course = courseOpt.get();
            */

            request.setAttribute("course", course);

            // Check if user is logged in and already registered for this course
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("userEmail") != null) {
                String userEmail = (String) session.getAttribute("userEmail");
                boolean isRegistered = registrationDao.isUserRegisteredForCourse(userEmail, courseCode);
                request.setAttribute("isRegistered", isRegistered);
            }

            request.getRequestDispatcher("/WEB-INF/views/courses/details.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("javax.servlet.error.exception", e);
            request.setAttribute("javax.servlet.error.status_code", 500);
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
