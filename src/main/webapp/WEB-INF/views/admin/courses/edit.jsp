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
    <title>Edit Course - Student LMS</title>
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
            <h1 class="text-3xl font-bold text-gray-800">Edit Course</h1>
            <a href="${pageContext.request.contextPath}/admin/courses" class="bg-gray-500 hover:bg-gray-600 text-white py-2 px-4 rounded-md transition flex items-center">
                <i class="fas fa-arrow-left mr-2"></i> Back to Courses
            </a>
        </div>

        <!-- Error Messages -->
        <c:if test="${not empty error}">
            <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4" role="alert">
                <p>${error}</p>
            </div>
        </c:if>

        <!-- Course Form -->
        <div class="bg-white rounded-lg shadow-md p-6">
            <form action="${pageContext.request.contextPath}/admin/courses" method="post" class="space-y-6">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="originalCourseCode" value="${course.courseCode}">

                <!-- Course Information -->
                <div>
                    <h2 class="text-xl font-semibold text-gray-800 mb-4">Course Information</h2>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label for="courseCode" class="block text-sm font-medium text-gray-700 mb-1">Course Code *</label>
                            <input type="text" id="courseCode" name="courseCode" value="${course.courseCode}" required
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <p class="text-xs text-gray-500 mt-1">Unique identifier for the course (e.g., CS101)</p>
                        </div>
                        <div>
                            <label for="duration" class="block text-sm font-medium text-gray-700 mb-1">Duration *</label>
                            <input type="text" id="duration" name="duration" value="${course.duration}" required
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <p class="text-xs text-gray-500 mt-1">Course duration (e.g., 3 months, 1 year)</p>
                        </div>
                        <div>
                            <label for="fee" class="block text-sm font-medium text-gray-700 mb-1">Course Fee *</label>
                            <input type="text" id="fee" name="fee" value="${course.fee}" required
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                            <p class="text-xs text-gray-500 mt-1">Course fee (e.g., 25000.00)</p>
                        </div>
                        <div>
                            <label for="schoolName" class="block text-sm font-medium text-gray-700 mb-1">School *</label>
                            <select id="schoolName" name="schoolName" required
                                    class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="">Select School</option>
                                <c:forEach var="school" items="${schools}">
                                    <option value="${school}" ${course.school == school ? 'selected' : ''}>${school}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>

                <!-- Course Details -->
                <div>
                    <h2 class="text-xl font-semibold text-gray-800 mb-4">Course Details</h2>
                    <div class="grid grid-cols-1 gap-6">
                        <div>
                            <label for="description" class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                            <textarea id="description" name="description" rows="4"
                                      class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">${course.description}</textarea>
                        </div>
                        <div>
                            <label for="prerequisites" class="block text-sm font-medium text-gray-700 mb-1">Prerequisites</label>
                            <textarea id="prerequisites" name="prerequisites" rows="2"
                                      class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">${course.prerequisites}</textarea>
                            <p class="text-xs text-gray-500 mt-1">List any prerequisites for this course</p>
                        </div>
                        <div>
                            <label for="objectives" class="block text-sm font-medium text-gray-700 mb-1">Learning Objectives</label>
                            <textarea id="objectives" name="objectives" rows="3"
                                      class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">${course.objectives}</textarea>
                        </div>
                    </div>
                </div>

                <div class="flex justify-end space-x-3">
                    <a href="${pageContext.request.contextPath}/admin/courses" class="px-4 py-2 bg-gray-200 text-gray-800 rounded-md hover:bg-gray-300 transition">
                        Cancel
                    </a>
                    <button type="submit" class="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600 transition">
                        Update Course
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
