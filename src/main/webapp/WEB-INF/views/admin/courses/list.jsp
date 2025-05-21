<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:01 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Management - Admin Dashboard</title>
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
            <h1 class="text-3xl font-bold text-gray-800">Course Management</h1>
            <a href="${pageContext.request.contextPath}/admin/courses/create" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md">
                <i class="fas fa-plus mr-2"></i> Add New Course
            </a>
        </div>

        <!-- Success Messages -->
        <c:if test="${param.created == 'true'}">
            <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-6" role="alert">
                <p>Course created successfully!</p>
            </div>
        </c:if>

        <c:if test="${param.updated == 'true'}">
            <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-6" role="alert">
                <p>Course updated successfully!</p>
            </div>
        </c:if>

        <!-- Course Listing -->
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                <tr>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Course Code</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Course Name</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">School</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Duration</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Fee</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                <c:forEach var="course" items="${courses}">
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${course.courseCode}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${course.courseName}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${course.school}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${course.duration}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">₹${course.fee}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                            <a href="${pageContext.request.contextPath}/admin/courses/view/${course.courseCode}" class="text-blue-600 hover:text-blue-900 mr-3">
                                <i class="fas fa-eye"></i>
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/courses/edit/${course.courseCode}" class="text-indigo-600 hover:text-indigo-900 mr-3">
                                <i class="fas fa-edit"></i>
                            </a>
                            <a href="#" onclick="confirmDelete('${course.courseCode}', '${course.courseName}')" class="text-red-600 hover:text-red-900">
                                <i class="fas fa-trash"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty courses}">
                    <tr>
                        <td colspan="6" class="px-6 py-4 text-center text-gray-500">No courses found</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden">
    <div class="bg-white rounded-lg p-8 max-w-md">
        <h2 class="text-xl font-bold mb-4">Confirm Deletion</h2>
        <p class="mb-6">Are you sure you want to delete course <span id="courseToDelete" class="font-semibold"></span>? This action cannot be undone.</p>
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
    function confirmDelete(courseCode, courseName) {
        document.getElementById('courseToDelete').textContent = courseName;
        document.getElementById('deleteLink').href = "${pageContext.request.contextPath}/admin/courses/delete/" + courseCode;
        document.getElementById('deleteModal').classList.remove('hidden');
    }

    function closeModal() {
        document.getElementById('deleteModal').classList.add('hidden');
    }
</script>
</body>
</html>
