<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Student LMS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">
<div class="min-h-screen flex">
    <!-- Sidebar -->
    <jsp:include page="../shared/admin-sidebar.jsp" />

    <!-- Main Content -->
    <div class="flex-1 p-10">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">Admin Dashboard</h1>

        <!-- Stats Cards -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
            <!-- Total Users Card -->
            <div class="bg-white rounded-lg shadow-md p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-gray-500">Total Users</p>
                        <p class="text-2xl font-bold text-gray-800">${stats.totalUsers}</p>
                    </div>
                    <div class="bg-blue-100 p-3 rounded-full">
                        <i class="fas fa-users text-blue-500"></i>
                    </div>
                </div>
                <p class="text-xs text-gray-500 mt-2">
                    <span class="text-green-500"><i class="fas fa-arrow-up"></i> 12%</span> from last month
                </p>
            </div>

            <!-- Total Courses Card -->
            <div class="bg-white rounded-lg shadow-md p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-gray-500">Total Courses</p>
                        <p class="text-2xl font-bold text-gray-800">${stats.totalCourses}</p>
                    </div>
                    <div class="bg-green-100 p-3 rounded-full">
                        <i class="fas fa-book text-green-500"></i>
                    </div>
                </div>
                <p class="text-xs text-gray-500 mt-2">
                    <span class="text-green-500"><i class="fas fa-arrow-up"></i> 5%</span> from last month
                </p>
            </div>

            <!-- Total Registrations Card -->
            <div class="bg-white rounded-lg shadow-md p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-gray-500">Total Registrations</p>
                        <p class="text-2xl font-bold text-gray-800">${stats.totalRegistrations}</p>
                    </div>
                    <div class="bg-purple-100 p-3 rounded-full">
                        <i class="fas fa-clipboard-list text-purple-500"></i>
                    </div>
                </div>
                <p class="text-xs text-gray-500 mt-2">
                    <span class="text-green-500"><i class="fas fa-arrow-up"></i> 8%</span> from last month
                </p>
            </div>

            <!-- Total Revenue Card -->
            <div class="bg-white rounded-lg shadow-md p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-gray-500">Total Revenue</p>
                        <p class="text-2xl font-bold text-gray-800">$${stats.totalRevenue}</p>
                    </div>
                    <div class="bg-yellow-100 p-3 rounded-full">
                        <i class="fas fa-dollar-sign text-yellow-500"></i>
                    </div>
                </div>
                <p class="text-xs text-gray-500 mt-2">
                    <span class="text-green-500"><i class="fas fa-arrow-up"></i> 15%</span> from last month
                </p>
            </div>
        </div>

        <!-- Recent Activity and Pending Registrations -->
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <!-- Recent Activity -->
            <div class="bg-white rounded-lg shadow-md p-6">
                <div class="flex justify-between items-center mb-4">
                    <h2 class="text-xl font-bold text-gray-800">Recent Activity</h2>
                    <a href="${pageContext.request.contextPath}/admin/system/logs" class="text-sm text-blue-500 hover:underline">View All</a>
                </div>
                <div class="overflow-y-auto max-h-80">
                    <c:forEach var="log" items="${recentLogs}">
                        <div class="border-b border-gray-100 py-3">
                            <div class="flex justify-between">
                                <p class="text-sm font-medium text-gray-800">${log.actionType}</p>
                                <p class="text-xs text-gray-500">${log.formattedTimestamp}</p>
                            </div>
                            <p class="text-sm text-gray-600 mt-1">${log.description}</p>
                            <p class="text-xs text-gray-500 mt-1">By: ${log.adminEmail}</p>
                        </div>
                    </c:forEach>
                    <c:if test="${empty recentLogs}">
                        <p class="text-gray-500 text-center py-4">No recent activity</p>
                    </c:if>
                </div>
            </div>

            <!-- Pending Registrations -->
            <div class="bg-white rounded-lg shadow-md p-6">
                <div class="flex justify-between items-center mb-4">
                    <h2 class="text-xl font-bold text-gray-800">Pending Registrations</h2>
                    <a href="${pageContext.request.contextPath}/admin/registration-queue" class="text-sm text-blue-500 hover:underline">View All</a>
                </div>
                <div class="bg-yellow-50 text-yellow-800 p-3 rounded-lg mb-4">
                    <div class="flex">
                        <div class="flex-shrink-0">
                            <i class="fas fa-exclamation-circle"></i>
                        </div>
                        <div class="ml-3">
                            <p class="text-sm font-medium">
                                ${stats.pendingRegistrations} registrations waiting for approval
                            </p>
                        </div>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/admin/registration-queue" class="block w-full py-2 px-4 bg-blue-500 hover:bg-blue-600 text-white text-center rounded-md transition">
                    Process Queue
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
