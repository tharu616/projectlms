<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:24 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Announcement - Student LMS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">
<div class="min-h-screen flex">
    <!-- Sidebar -->
    <jsp:include page="../../shared/admin-sidebar.jsp" />

    <!-- Main Content -->
    <div class="flex-1 p-10">
        <div class="flex justify-between items-center mb-6">
            <h1 class="text-3xl font-bold text-gray-800">Edit Announcement</h1>
            <a href="${pageContext.request.contextPath}/admin/announcements" class="bg-gray-500 hover:bg-gray-600 text-white py-2 px-4 rounded-md transition flex items-center">
                <i class="fas fa-arrow-left mr-2"></i> Back to Announcements
            </a>
        </div>

        <!-- Error Messages -->
        <c:if test="${not empty error}">
            <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4" role="alert">
                <p>${error}</p>
            </div>
        </c:if>

        <!-- Announcement Form -->
        <div class="bg-white rounded-lg shadow-md p-6">
            <form action="${pageContext.request.contextPath}/admin/announcements" method="post" class="space-y-6">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="id" value="${announcement.id}">

                <!-- Announcement Details -->
                <div>
                    <h2 class="text-xl font-semibold text-gray-800 mb-4">Announcement Details</h2>
                    <div class="grid grid-cols-1 gap-6">
                        <div>
                            <label for="title" class="block text-sm font-medium text-gray-700 mb-1">Title *</label>
                            <input type="text" id="title" name="title" value="${announcement.title}" required
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="content" class="block text-sm font-medium text-gray-700 mb-1">Content *</label>
                            <textarea id="content" name="content" rows="6" required
                                      class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">${announcement.content}</textarea>
                        </div>
                    </div>
                </div>

                <!-- Publication Settings -->
                <div>
                    <h2 class="text-xl font-semibold text-gray-800 mb-4">Publication Settings</h2>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label for="publishDate" class="block text-sm font-medium text-gray-700 mb-1">Publish Date *</label>
                            <input type="date" id="publishDate" name="publishDate" value="${announcement.formattedPublishDate}" required
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="expiryDate" class="block text-sm font-medium text-gray-700 mb-1">Expiry Date</label>
                            <input type="date" id="expiryDate" name="expiryDate" value="${announcement.formattedExpiryDate}"
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <p class="text-xs text-gray-500 mt-1">Leave blank for no expiry</p>
                        </div>
                        <div class="flex items-center">
                            <input type="checkbox" id="isActive" name="isActive" ${announcement.active ? 'checked' : ''}
                                   class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded">
                            <label for="isActive" class="ml-2 block text-sm text-gray-900">
                                Active
                            </label>
                        </div>
                        <div>
                            <label for="targetAudience" class="block text-sm font-medium text-gray-700 mb-1">Target Audience</label>
                            <select id="targetAudience" name="targetAudience"
                                    class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="ALL" ${announcement.targetAudience == 'ALL' ? 'selected' : ''}>All Users</option>
                                <option value="STUDENTS" ${announcement.targetAudience == 'STUDENTS' ? 'selected' : ''}>Students Only</option>
                                <option value="ADMINS" ${announcement.targetAudience == 'ADMINS' ? 'selected' : ''}>Admins Only</option>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Publication Info -->
                <div>
                    <h2 class="text-xl font-semibold text-gray-800 mb-4">Publication Info</h2>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <p class="text-sm font-medium text-gray-700">Published By</p>
                            <p class="text-gray-900">${announcement.publishedBy}</p>
                        </div>
                        <div>
                            <p class="text-sm font-medium text-gray-700">Last Modified</p>
                            <p class="text-gray-900">${announcement.formattedLastModified}</p>
                        </div>
                    </div>
                </div>

                <div class="flex justify-end space-x-3">
                    <a href="${pageContext.request.contextPath}/admin/announcements" class="px-4 py-2 bg-gray-200 text-gray-800 rounded-md hover:bg-gray-300 transition">
                        Cancel
                    </a>
                    <button type="submit" class="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600 transition">
                        Update Announcement
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
