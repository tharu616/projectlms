<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Courses - Student LMS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">
<div class="min-h-screen flex">
    <!-- Sidebar -->
    <jsp:include page="../../shared/user-sidebar.jsp" />

    <!-- Main Content -->
    <div class="flex-1 p-10">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">My Courses</h1>

        <!-- Filter by School -->
        <div class="mb-6">
            <form action="${pageContext.request.contextPath}/user/courses" method="get" class="flex items-center">
                <label for="school" class="mr-2 text-gray-700">Filter by School:</label>
                <select id="school" name="school" class="px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 mr-2">
                    <option value="">All Schools</option>
                    <c:forEach var="school" items="${schools}">
                        <option value="${school}" ${school eq schoolFilter ? 'selected' : ''}>${school}</option>
                    </c:forEach>
                </select>
                <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md">
                    Filter
                </button>
            </form>
        </div>

        <c:choose>
            <c:when test="${empty courses}">
                <div class="bg-white rounded-lg shadow-md p-8 text-center">
                    <div class="text-gray-400 mb-4">
                        <i class="fas fa-book-open text-5xl"></i>
                    </div>
                    <h2 class="text-xl font-semibold text-gray-800 mb-2">No Courses Found</h2>
                    <p class="text-gray-600 mb-6">No courses found matching your criteria.</p>
                    <a href="${pageContext.request.contextPath}/user/courses" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md">
                        View All Courses
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <c:forEach var="course" items="${courses}">
                        <div class="bg-white rounded-lg shadow-md overflow-hidden">
                            <div class="bg-blue-600 text-white p-4">
                                <h2 class="text-lg font-semibold">${course.courseName}</h2>
                                <p class="text-sm text-blue-100">${course.courseCode}</p>
                            </div>
                            <div class="p-4">
                                <div class="mb-4">
                                    <p class="text-sm text-gray-500">School</p>
                                    <p class="font-medium">${course.school}</p>
                                </div>
                                <div class="mb-4">
                                    <p class="text-sm text-gray-500">Duration</p>
                                    <p class="font-medium">${course.duration}</p>
                                </div>
                                <div class="mb-4">
                                    <p class="text-sm text-gray-500">Fee</p>
                                    <p class="font-medium">₹${course.fee}</p>
                                </div>
                                <div class="mt-6 flex justify-end">
                                    <a href="${pageContext.request.contextPath}/user/course-registration?courseCode=${course.courseCode}" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md">
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
</body>
</html>
