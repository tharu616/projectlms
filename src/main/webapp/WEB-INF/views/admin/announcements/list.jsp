<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:24 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Announcements - Admin Dashboard</title>
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
            <h1 class="text-3xl font-bold text-gray-800">Announcements</h1>
            <a href="${pageContext.request.contextPath}/admin/announcements/create" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md">
                <i class="fas fa-plus mr-2"></i> Create Announcement
            </a>
        </div>

        <!-- Success Messages -->
        <c:if test="${param.created == 'true'}">
            <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-6" role="alert">
                <p>Announcement created successfully!</p>
            </div>
        </c:if>

        <c:if test="${param.updated == 'true'}">
            <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-6" role="alert">
                <p>Announcement updated successfully!</p>
            </div>
        </c:if>

        <!-- Search and Filter -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <div class="flex flex-wrap gap-4">
                <div class="flex-1">
                    <form action="${pageContext.request.contextPath}/admin/announcements" method="get" class="flex gap-2">
                        <input type="text" name="search" placeholder="Search by title or content"
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                               value="${param.search}">
                        <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md">
                            <i class="fas fa-search"></i>
                        </button>
                    </form>
                </div>
                <div>
                    <select id="statusFilter" onchange="filterByStatus(this.value)"
                            class="px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <option value="">All Statuses</option>
                        <option value="active" ${statusFilter == 'active' ? 'selected' : ''}>Active</option>
                        <option value="inactive" ${statusFilter == 'inactive' ? 'selected' : ''}>Inactive</option>
                    </select>
                </div>
            </div>
        </div>

        <!-- Announcement Listing -->
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                <tr>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Title</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Published By</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Publish Date</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Expiry Date</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                <c:forEach var="announcement" items="${announcements}">
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${announcement.title}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${announcement.publishedBy}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                            <fmt:formatDate value="${announcement.publishDate}" pattern="yyyy-MM-dd" />
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                            <c:if test="${not empty announcement.expiryDate}">
                                <fmt:formatDate value="${announcement.expiryDate}" pattern="yyyy-MM-dd" />
                            </c:if>
                            <c:if test="${empty announcement.expiryDate}">
                                No Expiry
                            </c:if>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="px-2 py-1 inline-flex text-xs leading-5 font-semibold rounded-full
                                        ${announcement.active ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}">
                                            ${announcement.active ? 'Active' : 'Inactive'}
                                    </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                            <a href="${pageContext.request.contextPath}/admin/announcements/view/${announcement.id}" class="text-blue-600 hover:text-blue-900 mr-3">
                                <i class="fas fa-eye"></i>
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/announcements/edit/${announcement.id}" class="text-indigo-600 hover:text-indigo-900 mr-3">
                                <i class="fas fa-edit"></i>
                            </a>
                            <a href="#" onclick="confirmDelete(${announcement.id}, '${announcement.title}')" class="text-red-600 hover:text-red-900">
                                <i class="fas fa-trash"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty announcements}">
                    <tr>
                        <td colspan="6" class="px-6 py-4 text-center text-gray-500">No announcements found</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        <div class="mt-4 flex justify-between items-center">
            <div class="text-sm text-gray-500">
                Showing 1 to ${announcements.size()} of ${announcements.size()} results
            </div>
            <div class="flex space-x-2">
                <button class="px-3 py-1 border border-gray-300 rounded-md bg-white text-gray-500 hover:bg-gray-50 disabled:opacity-50" disabled>
                    <i class="fas fa-chevron-left"></i>
                </button>
                <button class="px-3 py-1 border border-gray-300 rounded-md bg-blue-500 text-white hover:bg-blue-600">1</button>
                <button class="px-3 py-1 border border-gray-300 rounded-md bg-white text-gray-500 hover:bg-gray-50 disabled:opacity-50" disabled>
                    <i class="fas fa-chevron-right"></i>
                </button>
            </div>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden">
    <div class="bg-white rounded-lg p-8 max-w-md">
        <h2 class="text-xl font-bold mb-4">Confirm Deletion</h2>
        <p class="mb-6">Are you sure you want to delete the announcement "<span id="announcementToDelete" class="font-semibold"></span>"? This action cannot be undone.</p>
        <div class="flex justify-end space-x-4">
            <button onclick="closeModal()" class="bg-gray-300 hover:bg-gray-400 text-gray-800 py-2 px-4 rounded">
                Cancel
            </button>
            <a id="deleteLink" href="#" class="bg-red-500 hover:bg-red-600 text-white py-2 px-4 rounded">
                Delete
            </a>
        </div>
    </div>
</div>

<script>
    function filterByStatus(status) {
        window.location.href = '${pageContext.request.contextPath}/admin/announcements?status=' + status;
    }

    function confirmDelete(id, title) {
        document.getElementById('announcementToDelete').textContent = title;
        document.getElementById('deleteLink').href = "${pageContext.request.contextPath}/admin/announcements/delete/" + id;
        document.getElementById('deleteModal').classList.remove('hidden');
    }

    function closeModal() {
        document.getElementById('deleteModal').classList.add('hidden');
    }
</script>
</body>
</html>
