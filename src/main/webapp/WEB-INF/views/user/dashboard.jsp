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
<div class="min-h-screen flex">
    <!-- Sidebar -->
    <jsp:include page="../shared/user-sidebar.jsp" />

    <!-- Main Content -->
    <div class="flex-1 p-10">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">Student Dashboard</h1>

        <!-- Student Info Card -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <h2 class="text-xl font-semibold text-gray-800 mb-4">Welcome, ${user.fullName}!</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <p class="text-sm text-gray-600">Student ID: <span class="font-medium text-gray-800">${user.registerNumber}</span></p>
                </div>
                <div>
                    <p class="text-sm text-gray-600">Email: <span class="font-medium text-gray-800">${user.email}</span></p>
                </div>
            </div>
        </div>

        <!-- Stats Cards -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
            <!-- Enrolled Courses Card -->
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

            <!-- Pending Payments Card -->
            <div class="bg-white rounded-lg shadow-md p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-gray-500">Pending Payments</p>
                        <p class="text-2xl font-bold text-gray-800">${pendingPayments}</p>
                    </div>
                    <div class="bg-yellow-100 p-3 rounded-full">
                        <i class="fas fa-dollar-sign text-yellow-500"></i>
                    </div>
                </div>
            </div>

            <!-- Upcoming Deadlines Card -->
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

        <!-- Announcements -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <h2 class="text-xl font-semibold text-gray-800 mb-4">Latest Announcement</h2>
            <c:choose>
                <c:when test="${not empty announcements && announcements.size() > 0}">
                    <div class="bg-blue-50 p-4 rounded-lg">
                        <p class="text-gray-800 mb-2">${announcements[0].content}</p>
                        <p class="text-xs text-gray-500">Published on: ${announcements[0].formattedPublishDate}</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="text-gray-500 text-center py-4">No announcements available</p>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Enrolled Courses -->
        <div class="bg-white rounded-lg shadow-md p-6">
            <h2 class="text-xl font-semibold text-gray-800 mb-4">My Courses</h2>
            <c:choose>
                <c:when test="${not empty registrations && registrations.size() > 0}">
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                            <tr>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Course</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">School</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                            </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                            <c:forEach var="registration" items="${registrations}">
                                <tr>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm font-medium text-gray-900">${registration.courseCode}</div>
                                        <div class="text-sm text-gray-500">${registration.courseName}</div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm text-gray-900">${registration.schoolName}</div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                                <span class="px-2 py-1 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                                    Active
                                                </span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                        <a href="${pageContext.request.contextPath}/user/courses/view/${registration.courseCode}" class="text-blue-600 hover:text-blue-900">View Details</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="text-gray-500 text-center py-4">You are not enrolled in any courses yet. <a href="${pageContext.request.contextPath}/courses" class="text-blue-600 hover:underline">Browse courses</a></p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
</body>
</html>
