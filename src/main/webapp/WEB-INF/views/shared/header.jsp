<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:47 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>${param.pageTitle} - Student LMS</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">
<header class="bg-blue-600 text-white shadow-md">
  <div class="container mx-auto px-4 py-4 flex justify-between items-center">
    <a href="${pageContext.request.contextPath}/" class="text-2xl font-bold">Student LMS</a>

    <c:choose>
      <c:when test="${not empty sessionScope.userEmail}">
        <!-- User is logged in -->
        <div class="flex items-center space-x-4">
          <div class="relative group">
            <button class="flex items-center space-x-1">
              <span>${sessionScope.userName}</span>
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
      </c:when>
      <c:when test="${not empty sessionScope.adminEmail}">
        <!-- Admin is logged in -->
        <div class="flex items-center space-x-4">
          <div class="relative group">
            <button class="flex items-center space-x-1">
              <span>${sessionScope.adminName}</span>
              <i class="fas fa-chevron-down text-sm"></i>
            </button>
            <div class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 z-10 hidden group-hover:block">
              <a href="${pageContext.request.contextPath}/admin/dashboard" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">
                <i class="fas fa-tachometer-alt mr-2"></i> Dashboard
              </a>
              <a href="${pageContext.request.contextPath}/logout" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">
                <i class="fas fa-sign-out-alt mr-2"></i> Logout
              </a>
            </div>
          </div>
        </div>
      </c:when>
      <c:otherwise>
        <!-- No user logged in -->
        <div class="flex items-center space-x-4">
          <a href="${pageContext.request.contextPath}/login" class="text-white hover:text-blue-200 transition">Login</a>
          <a href="${pageContext.request.contextPath}/register" class="bg-white text-blue-600 hover:bg-blue-100 px-4 py-2 rounded-md transition">Register</a>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</header>
</body>
</html>
