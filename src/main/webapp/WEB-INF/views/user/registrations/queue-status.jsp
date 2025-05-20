<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:40 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Queue Status - Student LMS</title>
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
            <h1 class="text-3xl font-bold text-gray-800">Registration Queue Status</h1>
            <a href="${pageContext.request.contextPath}/user/registrations/my-courses" class="bg-gray-500 hover:bg-gray-600 text-white py-2 px-4 rounded-md transition flex items-center">
                <i class="fas fa-arrow-left mr-2"></i> Back to My Courses
            </a>
        </div>

        <!-- Course Selection -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <form action="${pageContext.request.contextPath}/user/registration-status" method="get" class="flex flex-wrap gap-4">
                <div class="flex-1 min-w-[200px]">
                    <label for="courseCode" class="block text-sm font-medium text-gray-700 mb-1">Select Course</label>
                    <select id="courseCode" name="courseCode" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <option value="">-- Select a course --</option>
                        <c:forEach var="registration" items="${pendingRegistrations}">
                            <option value="${registration.courseCode}" ${courseCode == registration.courseCode ? 'selected' : ''}>
                                    ${registration.courseCode} - ${registration.courseName}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div class="flex items-end">
                    <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md transition">
                        Check Status
                    </button>
                </div>
            </form>
        </div>

        <!-- Queue Status -->
        <c:if test="${not empty courseCode}">
            <div class="bg-white rounded-lg shadow-md p-6">
                <h2 class="text-xl font-semibold text-gray-800 mb-4">Queue Status for ${courseDetails.courseCode}</h2>

                <c:choose>
                    <c:when test="${queuePosition > 0}">
                        <div class="bg-blue-50 border border-blue-200 rounded-lg p-6 mb-6">
                            <div class="flex">
                                <div class="flex-shrink-0">
                                    <i class="fas fa-info-circle text-blue-400 text-xl"></i>
                                </div>
                                <div class="ml-3">
                                    <h3 class="text-lg font-medium text-blue-800">Your registration is in the queue</h3>
                                    <div class="mt-2 text-blue-700">
                                        <p>Your current position in the queue: <span class="font-bold">${queuePosition}</span></p>
                                        <p>Estimated processing time: <span class="font-bold">${estimatedTime}</span></p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Queue Progress -->
                        <div class="mb-6">
                            <h3 class="text-lg font-medium text-gray-800 mb-2">Queue Progress</h3>
                            <div class="w-full bg-gray-200 rounded-full h-4">
                                <div class="bg-blue-500 h-4 rounded-full" style="width: ${progressPercentage}%"></div>
                            </div>
                            <div class="flex justify-between mt-1 text-xs text-gray-500">
                                <span>Position ${queuePosition}</span>
                                <span>Total in queue: ${queueSize}</span>
                            </div>
                        </div>

                        <!-- What Happens Next -->
                        <div>
                            <h3 class="text-lg font-medium text-gray-800 mb-2">What Happens Next?</h3>
                            <ol class="list-decimal list-inside space-y-2 text-gray-700">
                                <li>Your registration request will be processed in the order it was received.</li>
                                <li>Once approved, you will receive an email notification.</li>
                                <li>You can then proceed to make the payment to confirm your enrollment.</li>
                                <li>After payment, your course registration will be complete.</li>
                            </ol>
                        </div>
                    </c:when>
                    <c:when test="${isRegistered}">
                        <div class="bg-green-50 border border-green-200 rounded-lg p-6">
                            <div class="flex">
                                <div class="flex-shrink-0">
                                    <i class="fas fa-check-circle text-green-400 text-xl"></i>
                                </div>
                                <div class="ml-3">
                                    <h3 class="text-lg font-medium text-green-800">Your registration has been approved!</h3>
                                    <div class="mt-2 text-green-700">
                                        <p>Registration Date: ${registration.formattedDate}</p>
                                        <p>Status: ${registration.status}</p>

                                        <c:if test="${registration.paymentStatus != 'COMPLETED'}">
                                            <div class="mt-4">
                                                <a href="${pageContext.request.contextPath}/user/payment?courseCode=${courseCode}" class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-green-600 hover:bg-green-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-green-500">
                                                    Make Payment
                                                </a>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="bg-gray-50 border border-gray-200 rounded-lg p-6 text-center">
                            <i class="fas fa-search text-gray-400 text-3xl mb-2"></i>
                            <p class="text-gray-600">No registration request found for this course.</p>
                            <div class="mt-4">
                                <a href="${pageContext.request.contextPath}/user/courses/details/${courseCode}" class="inline-flex items-center px-4 py-2 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                    Register for this Course
                                </a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </c:if>
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
