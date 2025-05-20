package com.lms.studentlms.controller.user;

import com.lms.studentlms.dao.CourseDao;
import com.lms.studentlms.dao.UserDao;
import com.lms.studentlms.util.RegistrationQueueManager;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/user/course-registration")
public class CourseRegistrationServlet extends HttpServlet {

    private CourseDao courseDao;
    private UserDao userDao;
    private RegistrationQueueManager queueManager;

    @Override
    public void init() throws ServletException {
        courseDao = new CourseDao();
        userDao = new UserDao();
        queueManager = RegistrationQueueManager.getInstance();
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

        // Get course ID from request
        String courseCode = request.getParameter("courseCode");
        if (courseCode == null || courseCode.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/user/courses");
            return;
        }

        // Get course details
        Course course = courseDao.getCourseByCode(courseCode);
        if (course == null) {
            response.sendRedirect(request.getContextPath() + "/user/courses");
            return;
        }

        // Set course attribute for the JSP
        request.setAttribute("course", course);

        // Forward to the registration confirmation JSP
        request.getRequestDispatcher("/WEB-INF/views/user/courses/details.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is logged in
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userEmail") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String userEmail = (String) session.getAttribute("userEmail");

        // Get course code from request
        String courseCode = request.getParameter("courseCode");
        if (courseCode == null || courseCode.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/user/courses");
            return;
        }

        // Get course details
        Course course = courseDao.getCourseByCode(courseCode);
        if (course == null) {
            response.sendRedirect(request.getContextPath() + "/user/courses");
            return;
        }

        // Get user details
        User user = userDao.getUserByEmail(userEmail);
        if (user == null) {
            session.invalidate();
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Create registration request
        CourseRegistration registration = new CourseRegistration(
                userEmail,
                user.getFullName(),
                courseCode,
                course.getCourseCode(), // This might be redundant, adjust as needed
                course.getFee(),
                request.getParameter("schoolName")
        );

        // Add to registration queue
        queueManager.addRegistration(registration);

        // Store registration information in session for payment
        session.setAttribute("enrolledCourseCode", courseCode);
        session.setAttribute("enrolledCourseName", course.getCourseCode());
        session.setAttribute("enrolledSchool", request.getParameter("schoolName"));
        session.setAttribute("enrolledCourseFee", course.getFee());

        // Redirect to payment page
        response.sendRedirect(request.getContextPath() + "/user/payment");
    }
}
