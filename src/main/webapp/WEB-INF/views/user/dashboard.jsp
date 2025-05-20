<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:32 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard - Student LMS</title>
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
        <!-- Welcome Section -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <h2 class="text-xl font-semibold text-gray-800 mb-4">Welcome, ${user.fullName}!</h2>
            <p class="text-gray-600">
                Student ID: ${user.registerNumber}<br>
                Email: ${user.email}
            </p>
        </div>

        <!-- Dashboard Stats -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
            <div class="bg-white rounded-lg shadow-md p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-gray-500">Enrolled Courses</p>
                        <p class="text-2xl font-bold text-gray-800">${registrations.size()}</p>
                    </div>
                    <div class="bg-blue-100 p-3 rounded-full">
                        <i class="fas fa-book text-blue-500"></i>
                    </div>
                </div>
            </div>
            <div class="bg-white rounded-lg shadow-md p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-gray-500">Pending Payments</p>
                        <p class="text-2xl font-bold text-gray-800">${pendingPayments}</p>
                    </div>
                    <div class="bg-yellow-100 p-3 rounded-full">
                        <i class="fas fa-clock text-yellow-500"></i>
                    </div>
                </div>
            </div>
            <div class="bg-white rounded-lg shadow-md p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-gray-500">Upcoming Deadlines</p>
                        <p class="text-2xl font-bold text-gray-800">${upcomingDeadlines}</p>
                    </div>
                    <div class="bg-red-100 p-3 rounded-full">
                        <i class="fas fa-calendar-alt text-red-500"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Quick Links -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-4 mb-8">
            <a href="${pageContext.request.contextPath}/user/courses" class="bg-white rounded-lg shadow-md p-6 flex items-center justify-center hover:bg-blue-50 transition">
                <div class="text-center">
                    <div class="bg-blue-100 p-3 rounded-full mx-auto mb-2 w-12 h-12 flex items-center justify-center">
                        <i class="fas fa-book text-blue-500"></i>
                    </div>
                    <p class="font-medium text-gray-800">Browse Courses</p>
                </div>
            </a>
            <a href="${pageContext.request.contextPath}/user/registrations" class="bg-white rounded-lg shadow-md p-6 flex items-center justify-center hover:bg-blue-50 transition">
                <div class="text-center">
                    <div class="bg-green-100 p-3 rounded-full mx-auto mb-2 w-12 h-12 flex items-center justify-center">
                        <i class="fas fa-clipboard-list text-green-500"></i>
                    </div>
                    <p class="font-medium text-gray-800">My Registrations</p>
                </div>
            </a>
            <a href="${pageContext.request.contextPath}/user/payment/history" class="bg-white rounded-lg shadow-md p-6 flex items-center justify-center hover:bg-blue-50 transition">
                <div class="text-center">
                    <div class="bg-purple-100 p-3 rounded-full mx-auto mb-2 w-12 h-12 flex items-center justify-center">
                        <i class="fas fa-credit-card text-purple-500"></i>
                    </div>
                    <p class="font-medium text-gray-800">Payment History</p>
                </div>
            </a>
            <a href="${pageContext.request.contextPath}/user/announcements" class="bg-white rounded-lg shadow-md p-6 flex items-center justify-center hover:bg-blue-50 transition">
                <div class="text-center">
                    <div class="bg-yellow-100 p-3 rounded-full mx-auto mb-2 w-12 h-12 flex items-center justify-center">
                        <i class="fas fa-bullhorn text-yellow-500"></i>
                    </div>
                    <p class="font-medium text-gray-800">Announcements</p>
                </div>
            </a>
        </div>

        <!-- Recent Announcements -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <div class="flex justify-between items-center mb-4">
                <h2 class="text-xl font-semibold text-gray-800">Recent Announcements</h2>
                <a href="${pageContext.request.contextPath}/user/announcements" class="text-blue-500 hover:text-blue-700">
                    View All
                </a>
            </div>

            <div class="space-y-4">
                <c:forEach var="announcement" items="${announcements}" varStatus="status">
                    <c:if test="${status.index < 3}">
                        <div class="border-l-4 border-blue-500 pl-4 py-2">
                            <h3 class="font-medium text-gray-800">${announcement.title}</h3>
                            <p class="text-sm text-gray-600 mt-1">${announcement.content}</p>
                            <p class="text-xs text-gray-500 mt-1">${announcement.formattedPublishDate}</p>
                        </div>
                    </c:if>
                </c:forEach>

                <c:if test="${empty announcements}">
                    <p class="text-gray-500 text-center py-4">No announcements available</p>
                </c:if>
            </div>
        </div>

        <!-- My Courses -->
        <div class="bg-white rounded-lg shadow-md p-6">
            <div class="flex justify-between items-center mb-4">
                <h2 class="text-xl font-semibold text-gray-800">My Courses</h2>
                <a href="${pageContext.request.contextPath}/user/registrations" class="text-blue-500 hover:text-blue-700">
                    View All
                </a>
            </div>

            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                    <tr>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Course</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">School</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                    </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                    <c:forEach var="registration" items="${registrations}" varStatus="status">
                        <c:if test="${status.index < 5}">
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm font-medium text-gray-900">${registration.courseCode}</div>
                                    <div class="text-sm text-gray-500">${registration.courseName}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm text-gray-900">${registration.schoolName}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                                    ${registration.status}
                                            </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                    <a href="${pageContext.request.contextPath}/user/courses/details/${registration.courseCode}" class="text-blue-600 hover:text-blue-900">
                                        View Details
                                    </a>
                                </td>
                            </tr>
                        </c:if>
                    </c:forEach>

                    <c:if test="${empty registrations}">
                        <tr>
                            <td colspan="4" class="px-6 py-4 text-center text-gray-500">
                                You are not enrolled in any courses yet.
                                <a href="${pageContext.request.contextPath}/user/courses" class="text-blue-500 hover:text-blue-700">Browse courses</a>
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
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
