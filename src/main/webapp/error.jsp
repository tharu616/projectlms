<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 3:15 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Student LMS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">
<div class="min-h-screen flex flex-col">
    <!-- Simple Header -->
    <header class="bg-blue-600 text-white shadow-md">
        <div class="container mx-auto px-4 py-4">
            <a href="${pageContext.request.contextPath}/" class="text-2xl font-bold">Student LMS</a>
        </div>
    </header>

    <!-- Error Content -->
    <div class="flex-grow flex items-center justify-center">
        <div class="container mx-auto px-4 py-16 text-center">
            <div class="mb-8">
                <i class="fas fa-exclamation-triangle text-red-500 text-6xl"></i>
            </div>

            <h1 class="text-4xl font-bold text-gray-800 mb-4">
                <c:choose>
                    <c:when test="${pageContext.errorData.statusCode == 404}">
                        Page Not Found
                    </c:when>
                    <c:when test="${pageContext.errorData.statusCode == 403}">
                        Access Denied
                    </c:when>
                    <c:when test="${pageContext.errorData.statusCode == 500}">
                        Internal Server Error
                    </c:when>
                    <c:otherwise>
                        Error Occurred
                    </c:otherwise>
                </c:choose>
            </h1>

            <p class="text-xl text-gray-600 mb-8 max-w-2xl mx-auto">
                <c:choose>
                    <c:when test="${pageContext.errorData.statusCode == 404}">
                        The page you are looking for might have been removed, had its name changed, or is temporarily unavailable.
                    </c:when>
                    <c:when test="${pageContext.errorData.statusCode == 403}">
                        You don't have permission to access this resource.
                    </c:when>
                    <c:when test="${pageContext.errorData.statusCode == 500}">
                        Something went wrong on our end. We're working to fix the issue.
                    </c:when>
                    <c:otherwise>
                        An unexpected error occurred. Please try again later.
                    </c:otherwise>
                </c:choose>
            </p>

            <div class="flex flex-wrap justify-center gap-4">
                <a href="${pageContext.request.contextPath}/" class="bg-blue-500 hover:bg-blue-600 text-white px-6 py-3 rounded-md font-medium transition">
                    <i class="fas fa-home mr-2"></i> Go to Home
                </a>
                <button onclick="history.back()" class="bg-gray-500 hover:bg-gray-600 text-white px-6 py-3 rounded-md font-medium transition">
                    <i class="fas fa-arrow-left mr-2"></i> Go Back
                </button>
            </div>
        </div>
    </div>

    <!-- Simple Footer -->
    <footer class="bg-white shadow-inner">
        <div class="container mx-auto px-4 py-6">
            <p class="text-center text-gray-600 text-sm">
                &copy; 2025 Student Learning Management System. All rights reserved.
            </p>
        </div>
    </footer>
</div>
</body>
</html>
