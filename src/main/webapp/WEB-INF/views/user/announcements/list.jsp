<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:43 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Announcements - Student LMS</title>
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
            <h1 class="text-3xl font-bold text-gray-800">Announcements</h1>
            <a href="${pageContext.request.contextPath}/user/dashboard" class="bg-gray-500 hover:bg-gray-600 text-white py-2 px-4 rounded-md transition flex items-center">
                <i class="fas fa-arrow-left mr-2"></i> Back to Dashboard
            </a>
        </div>

        <!-- Announcements List -->
        <div class="space-y-6">
            <c:forEach var="announcement" items="${announcements}">
                <div class="bg-white rounded-lg shadow-md overflow-hidden">
                    <div class="bg-blue-500 text-white px-6 py-4">
                        <div class="flex justify-between items-center">
                            <h2 class="text-xl font-bold">${announcement.title}</h2>
                            <span class="text-sm text-blue-100">${announcement.formattedPublishDate}</span>
                        </div>
                    </div>
                    <div class="p-6">
                        <div class="prose max-w-none mb-4">
                            <p class="text-gray-800 whitespace-pre-line">${announcement.content}</p>
                        </div>
                        <div class="flex justify-between items-center text-sm text-gray-500">
                            <span>Published by: ${announcement.publishedBy}</span>
                            <c:if test="${not empty announcement.formattedExpiryDate}">
                                <span>Expires on: ${announcement.formattedExpiryDate}</span>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty announcements}">
                <div class="bg-white rounded-lg shadow-md p-6 text-center">
                    <div class="text-gray-500 mb-4">
                        <i class="fas fa-bullhorn text-4xl"></i>
                    </div>
                    <h2 class="text-xl font-semibold text-gray-800 mb-2">No Announcements</h2>
                    <p class="text-gray-600">There are currently no announcements to display.</p>
                </div>
            </c:if>
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
