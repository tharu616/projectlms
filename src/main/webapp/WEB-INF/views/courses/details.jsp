<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 11:34 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${course.courseName} - Student LMS</title>
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
        <div class="mb-6">
            <a href="${pageContext.request.contextPath}/courses" class="text-blue-500 hover:underline">
                <i class="fas fa-arrow-left mr-2"></i> Back to Courses
            </a>
        </div>

        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <!-- Course Header -->
            <div class="bg-blue-600 text-white p-6">
                <h1 class="text-3xl font-bold">${course.courseName}</h1>
                <p class="text-blue-100 mt-2">Course Code: ${course.courseCode}</p>
            </div>

            <!-- Course Details -->
            <div class="p-6">
                <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
                    <div class="bg-gray-50 p-4 rounded-lg">
                        <h3 class="text-sm font-medium text-gray-500">School</h3>
                        <p class="text-lg font-semibold text-gray-800">${course.school}</p>
                    </div>
                    <div class="bg-gray-50 p-4 rounded-lg">
                        <h3 class="text-sm font-medium text-gray-500">Duration</h3>
                        <p class="text-lg font-semibold text-gray-800">${course.duration}</p>
                    </div>
                    <div class="bg-gray-50 p-4 rounded-lg">
                        <h3 class="text-sm font-medium text-gray-500">Fee</h3>
                        <p class="text-lg font-semibold text-gray-800">₹${course.fee}</p>
                    </div>
                </div>

                <div class="mb-6">
                    <h2 class="text-xl font-semibold text-gray-800 mb-2">Description</h2>
                    <p class="text-gray-600">${course.description}</p>
                </div>

                <div class="mb-6">
                    <h2 class="text-xl font-semibold text-gray-800 mb-2">Prerequisites</h2>
                    <p class="text-gray-600">${course.prerequisites}</p>
                </div>

                <div class="mb-6">
                    <h2 class="text-xl font-semibold text-gray-800 mb-2">Learning Outcomes</h2>
                    <p class="text-gray-600">${course.learningOutcomes}</p>
                </div>

                <!-- Registration Button -->
                <div class="mt-8">
                    <c:choose>
                        <c:when test="${empty sessionScope.userEmail}">
                            <a href="${pageContext.request.contextPath}/login" class="block w-full bg-blue-500 hover:bg-blue-600 text-white text-center py-3 px-4 rounded-md transition">
                                Login to Register for this Course
                            </a>
                        </c:when>
                        <c:when test="${isRegistered}">
                            <div class="bg-green-100 text-green-800 p-4 rounded-md">
                                <i class="fas fa-check-circle mr-2"></i> You are already registered for this course.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <form action="${pageContext.request.contextPath}/user/register-course" method="post">
                                <input type="hidden" name="courseCode" value="${course.courseCode}">
                                <button type="submit" class="w-full bg-blue-500 hover:bg-blue-600 text-white py-3 px-4 rounded-md transition">
                                    Register for this Course
                                </button>
                            </form>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>

