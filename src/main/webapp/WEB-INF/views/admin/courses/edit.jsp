<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:02 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Course - Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">
<div class="min-h-screen flex">
    <!-- Sidebar -->
    <jsp:include page="../../shared/admin-sidebar.jsp" />

    <!-- Main Content -->
    <div class="flex-1 p-10">
        <div class="mb-6">
            <a href="${pageContext.request.contextPath}/admin/courses" class="text-blue-500 hover:underline">
                <i class="fas fa-arrow-left mr-2"></i> Back to Courses
            </a>
        </div>

        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <div class="bg-blue-600 text-white p-6">
                <h1 class="text-3xl font-bold">Edit Course</h1>
                <p class="text-blue-100 mt-2">Course Code: ${course.courseCode}</p>
            </div>

            <div class="p-6">
                <c:if test="${not empty error}">
                    <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-6" role="alert">
                        <p>${error}</p>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/admin/courses" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="courseCode" value="${course.courseCode}">

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                        <div>
                            <label for="courseName" class="block text-sm font-medium text-gray-700 mb-1">Course Name</label>
                            <input type="text" id="courseName" name="courseName" required
                                   value="${course.courseName}"
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="duration" class="block text-sm font-medium text-gray-700 mb-1">Duration</label>
                            <input type="text" id="duration" name="duration" required
                                   value="${course.duration}"
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                        <div>
                            <label for="school" class="block text-sm font-medium text-gray-700 mb-1">School</label>
                            <select id="school" name="school" required
                                    class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <c:forEach var="schoolName" items="${schools}">
                                    <option value="${schoolName}" ${schoolName eq course.school ? 'selected' : ''}>${schoolName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div>
                            <label for="fee" class="block text-sm font-medium text-gray-700 mb-1">Fee (₹)</label>
                            <input type="number" id="fee" name="fee" required step="0.01" min="0"
                                   value="${course.fee}"
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                    </div>

                    <div class="mb-6">
                        <label for="description" class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                        <textarea id="description" name="description" rows="4" required
                                  class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">${course.description}</textarea>
                    </div>

                    <div class="mb-6">
                        <label for="prerequisites" class="block text-sm font-medium text-gray-700 mb-1">Prerequisites</label>
                        <textarea id="prerequisites" name="prerequisites" rows="3"
                                  class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">${course.prerequisites}</textarea>
                    </div>

                    <div class="mb-6">
                        <label for="learningOutcomes" class="block text-sm font-medium text-gray-700 mb-1">Learning Outcomes</label>
                        <textarea id="learningOutcomes" name="learningOutcomes" rows="3" required
                                  class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">${course.learningOutcomes}</textarea>
                    </div>

                    <div class="mt-8 flex justify-end space-x-4">
                        <a href="${pageContext.request.contextPath}/admin/courses" class="bg-gray-300 hover:bg-gray-400 text-gray-800 py-2 px-4 rounded-md">
                            Cancel
                        </a>
                        <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md">
                            <i class="fas fa-save mr-2"></i> Update Course
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>
