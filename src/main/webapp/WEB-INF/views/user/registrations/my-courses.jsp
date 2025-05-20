<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:39 AM
  To change this template use File | Settings | File Templates.
--%>
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
      <h1 class="text-3xl font-bold text-gray-800">My Courses</h1>
      <a href="${pageContext.request.contextPath}/user/dashboard" class="bg-gray-500 hover:bg-gray-600 text-white py-2 px-4 rounded-md transition flex items-center">
        <i class="fas fa-arrow-left mr-2"></i> Back to Dashboard
      </a>
    </div>

    <!-- Courses List -->
    <div class="bg-white rounded-lg shadow-md overflow-hidden">
      <div class="overflow-x-auto">
        <table class="min-w-full divide-y divide-gray-200">
          <thead class="bg-gray-50">
          <tr>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Course</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">School</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Registration Date</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Payment</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
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
                <div class="text-sm text-gray-900">${registration.formattedDate}</div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full
                                            ${registration.status == 'PENDING' ? 'bg-yellow-100 text-yellow-800' :
                                              registration.status == 'APPROVED' ? 'bg-green-100 text-green-800' :
                                              registration.status == 'COMPLETED' ? 'bg-blue-100 text-blue-800' :
                                              'bg-gray-100 text-gray-800'}">
                                            ${registration.status}
                                        </span>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <c:choose>
                  <c:when test="${registration.paymentStatus == 'COMPLETED'}">
                                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                                    Paid
                                                </span>
                  </c:when>
                  <c:when test="${registration.paymentStatus == 'PENDING'}">
                                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">
                                                    Pending
                                                </span>
                  </c:when>
                  <c:otherwise>
                    <a href="${pageContext.request.contextPath}/user/payment?courseCode=${registration.courseCode}" class="text-blue-600 hover:text-blue-900">
                      Make Payment
                    </a>
                  </c:otherwise>
                </c:choose>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                <a href="${pageContext.request.contextPath}/user/courses/details/${registration.courseCode}" class="text-blue-600 hover:text-blue-900">
                  View Details
                </a>
              </td>
            </tr>
          </c:forEach>

          <c:if test="${empty registrations}">
            <tr>
              <td colspan="6" class="px-6 py-4 text-center text-gray-500">
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
