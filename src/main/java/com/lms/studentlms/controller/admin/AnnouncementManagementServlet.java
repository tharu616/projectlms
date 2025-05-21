package com.lms.studentlms.controller.admin;

import com.lms.studentlms.dao.AdminLogDao;
import com.lms.studentlms.dao.AnnouncementDao;
import com.lms.studentlms.model.Announcement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/admin/announcements/*")
public class AnnouncementManagementServlet extends HttpServlet {

    private AnnouncementDao announcementDao;
    private AdminLogDao adminLogDao;
    private SimpleDateFormat dateFormat;


    @Override
    public void init() throws ServletException {
        announcementDao = new AnnouncementDao();
        adminLogDao = new AdminLogDao();
        dateFormat = new SimpleDateFormat("yyyy-MM-dd");
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
            // List all announcements
            List<Announcement> announcements = announcementDao.findAll();
            request.setAttribute("announcements", announcements);
            request.getRequestDispatcher("/WEB-INF/views/admin/announcements/list.jsp").forward(request, response);
        } else if (pathInfo.equals("/create")) {
            // Show create announcement form
            request.getRequestDispatcher("/WEB-INF/views/admin/announcements/create.jsp").forward(request, response);
        } else if (pathInfo.startsWith("/edit/")) {
            // Show edit announcement form
            String idStr = pathInfo.substring("/edit/".length());
            try {
                int id = Integer.parseInt(idStr);
                Announcement announcement = announcementDao.findById(id);
                if (announcement != null) {
                    request.setAttribute("announcement", announcement);
                    request.getRequestDispatcher("/WEB-INF/views/admin/announcements/edit.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                // Invalid ID format
            }
            response.sendRedirect(request.getContextPath() + "/admin/announcements");
        } else if (pathInfo.startsWith("/view/")) {
            // Show announcement details
            String idStr = pathInfo.substring("/view/".length());
            try {
                int id = Integer.parseInt(idStr);
                Announcement announcement = announcementDao.findById(id);
                if (announcement != null) {
                    request.setAttribute("announcement", announcement);
                    request.getRequestDispatcher("/WEB-INF/views/admin/announcements/view.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                // Invalid ID format
            }
            response.sendRedirect(request.getContextPath() + "/admin/announcements");
        } else if (pathInfo.startsWith("/delete/")) {
            // Delete announcement
            String idStr = pathInfo.substring("/delete/".length());
            try {
                int id = Integer.parseInt(idStr);
                boolean deleted = announcementDao.delete(id);
                if (deleted) {
                    String adminEmail = (String) session.getAttribute("adminEmail");
                    adminLogDao.logActivity(adminEmail, "ANNOUNCEMENT_DELETE", "Deleted announcement: " + id);
                }
            } catch (NumberFormatException e) {
                // Invalid ID format
            }
            response.sendRedirect(request.getContextPath() + "/admin/announcements");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/announcements");
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

        String adminEmail = (String) session.getAttribute("adminEmail");
        String action = request.getParameter("action");

        if ("create".equals(action)) {
            // Create new announcement
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            boolean isActive = "true".equals(request.getParameter("isActive"));
            Date publishDate = new Date(); // Default to now
            Date expiryDate = null;

            try {
                String publishDateStr = request.getParameter("publishDate");
                if (publishDateStr != null && !publishDateStr.isEmpty()) {
                    publishDate = dateFormat.parse(publishDateStr);
                }

                String expiryDateStr = request.getParameter("expiryDate");
                if (expiryDateStr != null && !expiryDateStr.isEmpty()) {
                    expiryDate = dateFormat.parse(expiryDateStr);
                }
            } catch (ParseException e) {
                // Use default dates
            }

            Announcement announcement = new Announcement();
            announcement.setTitle(title);
            announcement.setContent(content);
            announcement.setPublishDate(publishDate);
            announcement.setExpiryDate(expiryDate);
            announcement.setPublishedBy(adminEmail);
            announcement.setActive(isActive);

            Announcement created = announcementDao.create(announcement);
            if (created != null) {
                adminLogDao.logActivity(adminEmail, "ANNOUNCEMENT_CREATE",
                        "Created announcement: " + created.getTitle());
                response.sendRedirect(request.getContextPath() + "/admin/announcements?created=true");
            } else {
                request.setAttribute("error", "Failed to create announcement");
                request.setAttribute("announcement", announcement);
                request.getRequestDispatcher("/WEB-INF/views/admin/announcements/create.jsp").forward(request, response);
            }
        } else if ("update".equals(action)) {
            // Update existing announcement
            int id = Integer.parseInt(request.getParameter("id"));
            Announcement existing = announcementDao.findById(id);

            if (existing != null) {
                existing.setTitle(request.getParameter("title"));
                existing.setContent(request.getParameter("content"));
                existing.setActive("true".equals(request.getParameter("isActive")));

                try {
                    String publishDateStr = request.getParameter("publishDate");
                    if (publishDateStr != null && !publishDateStr.isEmpty()) {
                        existing.setPublishDate(dateFormat.parse(publishDateStr));
                    }

                    String expiryDateStr = request.getParameter("expiryDate");
                    if (expiryDateStr != null && !expiryDateStr.isEmpty()) {
                        existing.setExpiryDate(dateFormat.parse(expiryDateStr));
                    }
                } catch (ParseException e) {
                    // Keep existing dates
                }

                Announcement updated = announcementDao.update(existing);
                if (updated != null) {
                    adminLogDao.logActivity(adminEmail, "ANNOUNCEMENT_UPDATE",
                            "Updated announcement: " + updated.getTitle());
                    response.sendRedirect(request.getContextPath() + "/admin/announcements?updated=true");
                } else {
                    request.setAttribute("error", "Failed to update announcement");
                    request.setAttribute("announcement", existing);
                    request.getRequestDispatcher("/WEB-INF/views/admin/announcements/edit.jsp").forward(request, response);
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/announcements");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/announcements");
        }
    }
}
