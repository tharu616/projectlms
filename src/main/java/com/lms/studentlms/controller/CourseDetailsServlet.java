package com.lms.studentlms.controller;

import com.lms.studentlms.dao.CourseDao;
import com.lms.studentlms.dao.CourseRegistrationDao;
import com.lms.studentlms.model.Course;
import com.lms.studentlms.util.RegistrationQueueManager;
import com.lms.studentlms.model.CourseRegistration;
import com.lms.studentlms.model.User;
import com.lms.studentlms.dao.UserDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/courses/details")
public class CourseDetailsServlet extends HttpServlet {
    private CourseDao courseDao;
    private CourseRegistrationDao registrationDao;
    private UserDao userDao;
    private RegistrationQueueManager queueManager;

    @Override
    public void init() throws ServletException {
        courseDao = new CourseDao();
        registrationDao = new CourseRegistrationDao();
        userDao = new UserDao();
        queueManager = RegistrationQueueManager.getInstance();
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

            Course course = courseDao.getCourseByCode(courseCode);
            if (course == null) {
                response.sendRedirect(request.getContextPath() + "/courses");
                return;
            }

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
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Check if user is logged in
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("userEmail") == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            String userEmail = (String) session.getAttribute("userEmail");
            String courseCode = request.getParameter("courseCode");

            if (courseCode == null || courseCode.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/courses");
                return;
            }

            // Check if user is already registered
            boolean isRegistered = registrationDao.isUserRegisteredForCourse(userEmail, courseCode);
            if (isRegistered) {
                response.sendRedirect(request.getContextPath() + "/user/courses");
                return;
            }

            // Get course and user details
            Course course = courseDao.getCourseByCode(courseCode);
            User user = userDao.getUserByEmail(userEmail);

            if (course == null || user == null) {
                response.sendRedirect(request.getContextPath() + "/courses");
                return;
            }

            // Create registration
            CourseRegistration registration = new CourseRegistration(
                    userEmail,
                    user.getFullName(),
                    courseCode,
                    course.getCourseName(),
                    String.valueOf(course.getFee()),
                    course.getSchool()
            );

            // Add to registration queue
            boolean added = queueManager.addRegistration(registration);

            if (added) {
                // Store registration information in session for payment
                session.setAttribute("enrolledCourseCode", courseCode);
                session.setAttribute("enrolledCourseName", course.getCourseName());
                session.setAttribute("enrolledSchool", course.getSchool());
                session.setAttribute("enrolledCourseFee", String.valueOf(course.getFee()));

                // Redirect to payment page or confirmation
                response.sendRedirect(request.getContextPath() + "/user/payment");
            } else {
                request.setAttribute("error", "Failed to register for course. Please try again.");
                request.setAttribute("course", course);
                request.getRequestDispatcher("/WEB-INF/views/courses/details.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
