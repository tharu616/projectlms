package com.lms.studentlms.controller.admin;

import com.lms.studentlms.dao.AdminLogDao;
import com.lms.studentlms.dao.CourseRegistrationDao;
import com.lms.studentlms.model.CourseRegistration;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/registrations/*")
public class RegistrationManagementServlet extends HttpServlet {
    private CourseRegistrationDao registrationDao;
    private AdminLogDao adminLogDao;

    @Override
    public void init() throws ServletException {
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
                // List all registrations
                List<CourseRegistration> registrations = registrationDao.getAllRegistrations();
                request.setAttribute("registrations", registrations);
                request.getRequestDispatcher("/WEB-INF/views/admin/registrations/list.jsp").forward(request, response);
            } else if (pathInfo.startsWith("/view/")) {
                // Show registration details
                String[] parts = pathInfo.substring("/view/".length()).split("/");
                if (parts.length == 2) {
                    String email = parts[0];
                    String courseCode = parts[1];
                    CourseRegistration registration = registrationDao.getRegistrationByEmailAndCourse(email, courseCode);
                    if (registration != null) {
                        request.setAttribute("registration", registration);
                        request.getRequestDispatcher("/WEB-INF/views/admin/registrations/view.jsp").forward(request, response);
                        return;
                    }
                }
                response.sendRedirect(request.getContextPath() + "/admin/registrations");
            } else if (pathInfo.startsWith("/student/")) {
                // Show registrations for a specific student
                String email = pathInfo.substring("/student/".length());
                List<CourseRegistration> studentRegistrations = registrationDao.getRegistrationsByEmail(email);
                request.setAttribute("studentEmail", email);
                request.setAttribute("registrations", studentRegistrations);
                request.getRequestDispatcher("/WEB-INF/views/admin/registrations/student.jsp").forward(request, response);
            } else if (pathInfo.startsWith("/course/")) {
                // Show registrations for a specific course
                String courseCode = pathInfo.substring("/course/".length());
                List<CourseRegistration> courseRegistrations = registrationDao.getRegistrationsByCourse(courseCode);
                request.setAttribute("courseCode", courseCode);
                request.setAttribute("registrations", courseRegistrations);
                request.getRequestDispatcher("/WEB-INF/views/admin/registrations/course.jsp").forward(request, response);
            } else if (pathInfo.startsWith("/delete/")) {
                // Delete registration
                String[] parts = pathInfo.substring("/delete/".length()).split("/");
                if (parts.length == 2) {
                    String email = parts[0];
                    String courseCode = parts[1];
                    boolean deleted = registrationDao.deleteRegistration(email, courseCode);
                    if (deleted) {
                        String adminEmail = (String) session.getAttribute("adminEmail");
                        adminLogDao.logActivity(adminEmail, "REGISTRATION_DELETE",
                                "Deleted registration: " + email + " for course: " + courseCode);
                    }
                }
                response.sendRedirect(request.getContextPath() + "/admin/registrations");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/registrations");
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
                // Create new registration
                CourseRegistration registration = new CourseRegistration();
                registration.setStudentEmail(request.getParameter("studentEmail"));
                registration.setStudentName(request.getParameter("studentName"));
                registration.setCourseCode(request.getParameter("courseCode"));
                registration.setCourseName(request.getParameter("courseName"));
                registration.setCourseFee(request.getParameter("courseFee"));
                registration.setSchoolName(request.getParameter("schoolName"));
                registration.setTimestamp(System.currentTimeMillis());

                boolean created = registrationDao.saveRegistration(registration);

                if (created) {
                    adminLogDao.logActivity(adminEmail, "REGISTRATION_CREATE",
                            "Created registration: " + registration.getStudentEmail() + " for " + registration.getCourseCode());
                    response.sendRedirect(request.getContextPath() + "/admin/registrations?created=true");
                } else {
                    request.setAttribute("error", "Failed to create registration");
                    request.setAttribute("registration", registration);
                    request.getRequestDispatcher("/WEB-INF/views/admin/registrations/create.jsp").forward(request, response);
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/registrations");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
