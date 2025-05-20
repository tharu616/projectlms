package com.lms.studentlms.controller;

import com.lms.studentlms.dao.AnnouncementDao;
import com.lms.studentlms.dao.CourseDao;

import com.lms.studentlms.model.Announcement;
import com.lms.studentlms.model.Course;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

/**
 * Servlet that handles the public home page of the Student Course Registration System.
 * Displays featured courses, announcements, and provides links to login and registration.
 */
@WebServlet(name = "HomeServlet", urlPatterns = {"", "/home"})
public class HomeServlet extends HttpServlet {

    private CourseDao courseDao;
    private AnnouncementDao announcementDao;

    @Override
    public void init() throws ServletException {
        courseDao = new CourseDao();
        announcementDao = new AnnouncementDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("userEmail") != null) {
            // User is already logged in, redirect to dashboard
            response.sendRedirect(request.getContextPath() + "/user/dashboard");
            return;
        } else if (session != null && session.getAttribute("adminEmail") != null) {
            // Admin is already logged in, redirect to admin dashboard
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        // Get featured courses (limit to 6)
        List<Course> featuredCourses = courseDao.getAllCourses();
        if (featuredCourses.size() > 6) {
            featuredCourses = featuredCourses.subList(0, 6);
        }

        // Get public announcements (limit to 3)
        List<Announcement> announcements = announcementDao.findActiveAnnouncements();
        if (announcements.size() > 3) {
            announcements = announcements.subList(0, 3);
        }

        // Get all schools for the filter
        List<String> schools = courseDao.getAllSchools();

        // Set attributes for the JSP
        request.setAttribute("featuredCourses", featuredCourses);
        request.setAttribute("announcements", announcements);
        request.setAttribute("schools", schools);

        // Forward to the home page JSP
        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle search form submission
        String searchQuery = request.getParameter("search");
        String schoolFilter = request.getParameter("school");

        List<Course> searchResults;

        if (searchQuery != null && !searchQuery.trim().isEmpty()) {
            // Search by query
            searchResults = courseDao.searchCourses(searchQuery);
        } else if (schoolFilter != null && !schoolFilter.trim().isEmpty()) {
            // Filter by school
            searchResults = courseDao.getCoursesBySchool(schoolFilter);
        } else {
            // No search criteria, show all courses
            searchResults = courseDao.getAllCourses();
        }

        // Get all schools for the filter
        List<String> schools = courseDao.getAllSchools();

        // Set attributes for the JSP
        request.setAttribute("featuredCourses", searchResults);
        request.setAttribute("searchQuery", searchQuery);
        request.setAttribute("schoolFilter", schoolFilter);
        request.setAttribute("schools", schools);
        request.setAttribute("isSearchResult", true);

        // Forward to the home page JSP
        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
}
