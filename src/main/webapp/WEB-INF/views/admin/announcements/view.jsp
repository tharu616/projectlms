<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:25 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Announcement Details - Student LMS</title>
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
            <h1 class="text-3xl font-bold text-gray-800">Announcement Details</h1>
            <div class="flex space-x-2">
                <a href="${pageContext.request.contextPath}/admin/announcements/edit/${announcement.id}" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md transition flex items-center">
                    <i class="fas fa-edit mr-2"></i> Edit Announcement
                </a>
                <a href="${pageContext.request.contextPath}/admin/announcements" class="bg-gray-500 hover:bg-gray-600 text-white py-2 px-4 rounded-md transition flex items-center">
                    <i class="fas fa-arrow-left mr-2"></i> Back to Announcements
                </a>
            </div>
        </div>

        <!-- Announcement Details -->
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <!-- Header -->
            <div class="bg-blue-500 text-white p-6">
                <div class="flex items-center">
                    <div class="flex-shrink-0 h-16 w-16 bg-white rounded-full flex items-center justify-center text-blue-500 text-2xl">
                        <i class="fas fa-bullhorn"></i>
                    </div>
                    <div class="ml-6">
                        <h2 class="text-2xl font-bold">${announcement.title}</h2>
                        <p class="text-blue-100">
                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-blue-200 text-blue-800">
                                    ${announcement.active ? 'Active' : 'Inactive'}
                                </span>
                            <span class="ml-2">Published by ${announcement.publishedBy}</span>
                        </p>
                    </div>
                </div>
            </div>

            <!-- Announcement Content -->
            <div class="p-6">
                <div class="mb-8">
                    <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Content</h3>
                    <div class="prose max-w-none">
                        <p class="text-gray-800 whitespace-pre-line">${announcement.content}</p>
                    </div>
                </div>

                <div class="mb-8">
                    <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Publication Details</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-y-4">
                        <div>
                            <p class="text-sm text-gray-500">Publish Date</p>
                            <p class="text-gray-800">${announcement.formattedPublishDate}</p>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">Expiry Date</p>
                            <p class="text-gray-800">${announcement.formattedExpiryDate != null ? announcement.formattedExpiryDate : 'No expiry date'}</p>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">Status</p>
                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full
                                    ${announcement.active ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'}">
                                ${announcement.active ? 'Active' : 'Inactive'}
                            </span>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">Target Audience</p>
                            <p class="text-gray-800">${announcement.targetAudience}</p>
                        </div>
                    </div>
                </div>

                <div>
                    <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Publication Info</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-y-4">
                        <div>
                            <p class="text-sm text-gray-500">Published By</p>
                            <p class="text-gray-800">${announcement.publishedBy}</p>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">Created On</p>
                            <p class="text-gray-800">${announcement.formattedCreateDate}</p>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">Last Modified</p>
                            <p class="text-gray-800">${announcement.formattedLastModified}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="mt-6 flex justify-end space-x-3">
            <a href="#" onclick="confirmDelete(${announcement.id}, '${announcement.title}')" class="px-4 py-2 bg-red-500 text-white rounded-md hover:bg-red-600 transition flex items-center">
                <i class="fas fa-trash mr-2"></i> Delete Announcement
            </a>
            <a href="${pageContext.request.contextPath}/admin/announcements/edit/${announcement.id}" class="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600 transition flex items-center">
                <i class="fas fa-edit mr-2"></i> Edit Announcement
            </a>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="hidden fixed inset-0 bg-gray-500 bg-opacity-75 flex items-center justify-center">
    <div class="bg-white rounded-lg p-6 max-w-sm mx-auto">
        <h3 class="text-lg font-medium text-gray-900 mb-4">Confirm Deletion</h3>
        <p class="text-sm text-gray-500 mb-4">Are you sure you want to delete the announcement <span id="announcementTitle" class="font-medium"></span>? This action cannot be undone.</p>
        <div class="flex justify-end space-x-3">
            <button onclick="closeModal()" class="px-4 py-2 bg-gray-200 text-gray-800 rounded-md hover:bg-gray-300 transition">
                Cancel
            </button>
            <a id="deleteLink" href="#" class="px-4 py-2 bg-red-500 text-white rounded-md hover:bg-red-600 transition">
                Delete
            </a>
        </div>
    </div>
</div>

<script>
    function confirmDelete(id, title) {
        document.getElementById('announcementTitle').textContent = title;
        document.getElementById('deleteLink').href = '${pageContext.request.contextPath}/admin/announcements/delete/' + id;
        document.getElementById('deleteModal').classList.remove('hidden');
    }

    function closeModal() {
        document.getElementById('deleteModal').classList.add('hidden');
    }
</script>
</body>
</html>

