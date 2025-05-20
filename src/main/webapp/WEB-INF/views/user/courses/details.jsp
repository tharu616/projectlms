<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:36 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${course.courseCode} - Course Details - Student LMS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">
<div class="min-h-screen flex flex-col">
    <!-- Header -->
    <header class="bg-blue-600 text-white shadow-md">
        <div class="container mx-auto px-4 py-4 flex justify-between items-center">
            <h1 class="text-2xl font-bold">Student LMS</h1>
            <div class="flex items-center space-x-4">
                <div class="relative group">
                    <button class="flex items-center space-x-1">
                        <span>${user.fullName}</span>
                        <i class="fas fa-chevron-down text-sm"></i>
                    </button>
                    <div class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 z-10 hidden group-hover:block">
                        <a href="${pageContext.request.contextPath}/user/dashboard" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">
                            <i class="fas fa-tachometer-alt mr-2"></i> Dashboard
                        </a>
                        <a href="${pageContext.request.contextPath}/user/profile" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">
                            <i class="fas fa-user-circle mr-2"></i> Profile
                        </a>
                        <a href="${pageContext.request.contextPath}/logout" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">
                            <i class="fas fa-sign-out-alt mr-2"></i> Logout
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <div class="flex-grow container mx-auto px-4 py-8">
        <div class="flex justify-between items-center mb-6">
            <h1 class="text-3xl font-bold text-gray-800">Course Details</h1>
            <a href="${pageContext.request.contextPath}/user/courses" class="bg-gray-500 hover:bg-gray-600 text-white py-2 px-4 rounded-md transition flex items-center">
                <i class="fas fa-arrow-left mr-2"></i> Back to Courses
            </a>
        </div>

        <!-- Success/Error Messages -->
        <c:if test="${not empty success}">
            <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-4" role="alert">
                <p>${success}</p>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4" role="alert">
                <p>${error}</p>
            </div>
        </c:if>

        <!-- Course Details -->
        <div class="bg-white rounded-lg shadow-md overflow-hidden mb-6">
            <div class="bg-blue-500 text-white p-6">
                <div class="flex items-center">
                    <div class="flex-shrink-0 h-16 w-16 bg-white rounded-full flex items-center justify-center text-blue-500 text-2xl">
                        <i class="fas fa-book"></i>
                    </div>
                    <div class="ml-6">
                        <h2 class="text-2xl font-bold">${course.courseCode}</h2>
                        <p class="text-blue-100">School: ${course.school}</p>
                    </div>
                </div>
            </div>

            <div class="p-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Course Information -->
                    <div>
                        <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Course Information</h3>
                        <div class="space-y-3">
                            <div>
                                <p class="text-sm text-gray-500">Course Code</p>
                                <p class="text-gray-800">${course.courseCode}</p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Duration</p>
                                <p class="text-gray-800">${course.duration}</p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">School</p>
                                <p class="text-gray-800">${course.school}</p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Fee</p>
                                <p class="text-gray-800">$${course.fee}</p>
                            </div>
                        </div>
                    </div>

                    <!-- Course Details -->
                    <div>
                        <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Course Details</h3>
                        <div class="space-y-3">
                            <div>
                                <p class="text-sm text-gray-500">Description</p>
                                <p class="text-gray-800">${course.description}</p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Prerequisites</p>
                                <p class="text-gray-800">${course.prerequisites}</p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Learning Objectives</p>
                                <p class="text-gray-800">${course.objectives}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Registration Status -->
        <c:choose>
            <c:when test="${isRegistered}">
                <div class="bg-green-50 border border-green-200 rounded-lg p-6 mb-6">
                    <div class="flex">
                        <div class="flex-shrink-0">
                            <i class="fas fa-check-circle text-green-400 text-xl"></i>
                        </div>
                        <div class="ml-3">
                            <h3 class="text-lg font-medium text-green-800">You are enrolled in this course</h3>
                            <div class="mt-2 text-green-700">
                                <p>Registration Date: ${registration.formattedDate}</p>
                                <p>Status: ${registration.status}</p>
                            </div>
                            <div class="mt-4">
                                <a href="${pageContext.request.contextPath}/user/registrations" class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
                                    View My Registrations
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:when test="${inQueue}">
                <div class="bg-yellow-50 border border-yellow-200 rounded-lg p-6 mb-6">
                    <div class="flex">
                        <div class="flex-shrink-0">
                            <i class="fas fa-clock text-yellow-400 text-xl"></i>
                        </div>
                        <div class="ml-3">
                            <h3 class="text-lg font-medium text-yellow-800">Your registration is in the queue</h3>
                            <div class="mt-2 text-yellow-700">
                                <p>Queue Position: ${queuePosition}</p>
                                <p>Request Date: ${queueDate}</p>
                            </div>
                            <div class="mt-4">
                                <a href="${pageContext.request.contextPath}/user/registration-status?courseCode=${course.courseCode}" class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-yellow-600 hover:bg-yellow-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-yellow-500">
                                    Check Status
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Registration Form -->
                <div class="bg-white rounded-lg shadow-md p-6">
                    <h3 class="text-lg font-semibold text-gray-800 mb-4">Register for this Course</h3>

                    <form action="${pageContext.request.contextPath}/user/course-registration" method="post" class="space-y-4">
                        <input type="hidden" name="courseCode" value="${course.courseCode}">
                        <input type="hidden" name="schoolName" value="${course.school}">

                        <div class="bg-gray-50 p-4 rounded-md">
                            <p class="text-gray-600">
                                By registering for this course, you agree to pay the course fee of <span class="font-semibold">$${course.fee}</span>.
                                After registration, you will be directed to the payment page.
                            </p>
                        </div>

                        <div class="flex items-start">
                            <div class="flex items-center h-5">
                                <input id="terms" name="terms" type="checkbox" required
                                       class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded">
                            </div>
                            <div class="ml-3 text-sm">
                                <label for="terms" class="font-medium text-gray-700">I agree to the terms and conditions</label>
                                <p class="text-gray-500">By registering, you agree to our <a href="#" class="text-blue-600 hover:text-blue-500">Terms of Service</a> and <a href="#" class="text-blue-600 hover:text-blue-500">Privacy Policy</a>.</p>
                            </div>
                        </div>

                        <div>
                            <button type="submit" class="w-full bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md transition">
                                Register for Course
                            </button>
                        </div>
                    </form>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Footer -->
    <footer class="bg-white shadow-inner mt-auto">
        <div class="container mx-auto px-4 py-6">
            <p class="text-center text-gray-600 text-sm">
                &copy; 2025 Student Learning Management System. All rights reserved.
            </p>
        </div>
    </footer>
</div>
</body>
</html>
