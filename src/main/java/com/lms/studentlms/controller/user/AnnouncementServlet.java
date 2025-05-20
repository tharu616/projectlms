package com.lms.studentlms.controller.user;

import com.lms.studentlms.dao.AnnouncementDao;

import com.lms.studentlms.model.Announcement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/user/announcements")
public class AnnouncementServlet extends HttpServlet {

    private AnnouncementDao announcementDao;

    @Override
    public void init() throws ServletException {
        announcementDao = new AnnouncementDao();
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

        // Get active announcements
        List<Announcement> announcements = announcementDao.findActiveAnnouncements();

        // Set attributes for the JSP
        request.setAttribute("announcements", announcements);

        // Forward to the announcements list JSP
        request.getRequestDispatcher("/WEB-INF/views/user/announcements/list.jsp").forward(request, response);
    }
}
