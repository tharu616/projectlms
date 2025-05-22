package com.lms.studentlms.controller.user;

import com.lms.studentlms.dao.CourseRegistrationDao;
import com.lms.studentlms.model.CourseRegistration;
import com.lms.studentlms.util.RegistrationQueueManager;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/user/registration-status")
public class RegistrationStatusServlet extends HttpServlet {

    private CourseRegistrationDao registrationDao;
    private RegistrationQueueManager queueManager;
//polymorphism
    @Override
    public void init() throws ServletException {
        registrationDao = new CourseRegistrationDao();
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

        String userEmail = (String) session.getAttribute("userEmail");

        // Get user's course registrations
        List<CourseRegistration> registrations = registrationDao.getRegistrationsByEmail(userEmail);

        // Get user's position in queue for pending registrations
        String courseCode = request.getParameter("courseCode");
        int queuePosition = -1;

        if (courseCode != null && !courseCode.isEmpty()) {
            queuePosition = queueManager.getStudentPositionInQueue(userEmail, courseCode);
        }

        // Set attributes for the JSP
        request.setAttribute("registrations", registrations);
        request.setAttribute("queuePosition", queuePosition);
        request.setAttribute("courseCode", courseCode);

        // Forward to the registration status JSP
        request.getRequestDispatcher("/WEB-INF/views/user/registrations/queue-status.jsp").forward(request, response);
    }
}
