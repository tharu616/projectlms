<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 11:27 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Courses - Student LMS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">
<div class="min-h-screen flex">
    <!-- Sidebar -->
    <c:if test="${not empty sessionScope.userEmail}">
        <jsp:include page="../shared/user-sidebar.jsp" />
    </c:if>

    <!-- Main Content -->
    <div class="flex-1 p-10">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">Browse Courses</h1>

        <!-- Search and Filter -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <form action="${pageContext.request.contextPath}/courses" method="get" class="flex flex-wrap gap-4">
                <div class="flex-1">
                    <label for="query" class="block text-sm font-medium text-gray-700 mb-1">Search Courses</label>
                    <input type="text" id="query" name="query" value="${searchQuery}"
                           class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                           placeholder="Search by course name or code...">
                </div>
                <div class="w-64">
                    <label for="school" class="block text-sm font-medium text-gray-700 mb-1">Filter by School</label>
                    <select id="school" name="school"
                            class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <option value="">All Schools</option>
                        <c:forEach var="school" items="${schools}">
                            <option value="${school}" ${school eq selectedSchool ? 'selected' : ''}>${school}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="flex items-end">
                    <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md">
                        <i class="fas fa-search mr-2"></i> Search
                    </button>
                </div>
            </form>
        </div>

        <!-- Course Listings -->
        <div class="bg-white rounded-lg shadow-md p-6">
            <h2 class="text-xl font-semibold text-gray-800 mb-4">Available Courses</h2>

            <c:choose>
                <c:when test="${empty courses}">
                    <div class="text-center py-8">
                        <p class="text-gray-500">No courses found matching your criteria.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                        <c:forEach var="course" items="${courses}">
                            <div class="border border-gray-200 rounded-lg overflow-hidden hover:shadow-md transition">
                                <div class="bg-gray-50 px-4 py-2 border-b border-gray-200">
                                    <h3 class="font-semibold text-gray-800">${course.courseCode}</h3>
                                </div>
                                <div class="p-4">
                                    <h4 class="text-lg font-medium text-gray-800 mb-2">${course.courseName}</h4>
                                    <p class="text-sm text-gray-600 mb-4">${course.description}</p>
                                    <div class="flex justify-between items-center">
                                        <span class="text-sm font-medium text-gray-700">${course.school}</span>
                                        <span class="text-sm font-bold text-blue-600">₹${course.fee}</span>
                                    </div>
                                    <div class="mt-4">
                                        <a href="${pageContext.request.contextPath}/courses/details?code=${course.courseCode}"
                                           class="block w-full bg-blue-500 hover:bg-blue-600 text-white text-center py-2 px-4 rounded-md transition">
                                            View Details
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</body>
</html>
