<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:07 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Edit Registration - Student LMS</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">
<div class="min-h-screen flex">
  <!-- Sidebar -->
  <jsp:include page="../../shared/admin-sidebar.jsp" />

  <!-- Main Content -->
  <div class="flex-1 p-10">
    <div class="flex justify-between items-center mb-6">
      <h1 class="text-3xl font-bold text-gray-800">Edit Registration</h1>
      <a href="${pageContext.request.contextPath}/admin/registrations" class="bg-gray-500 hover:bg-gray-600 text-white py-2 px-4 rounded-md transition flex items-center">
        <i class="fas fa-arrow-left mr-2"></i> Back to Registrations
      </a>
    </div>

    <!-- Error Messages -->
    <c:if test="${not empty error}">
      <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4" role="alert">
        <p>${error}</p>
      </div>
    </c:if>

    <!-- Registration Form -->
    <div class="bg-white rounded-lg shadow-md p-6">
      <form action="${pageContext.request.contextPath}/admin/registrations" method="post" class="space-y-6">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="originalStudentEmail" value="${registration.studentEmail}">
        <input type="hidden" name="originalCourseCode" value="${registration.courseCode}">

        <!-- Student Information -->
        <div>
          <h2 class="text-xl font-semibold text-gray-800 mb-4">Student Information</h2>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label for="studentEmail" class="block text-sm font-medium text-gray-700 mb-1">Student Email</label>
              <input type="email" id="studentEmail" value="${registration.studentEmail}" readonly disabled
                     class="w-full px-3 py-2 bg-gray-100 border border-gray-300 rounded-md">
              <p class="text-xs text-gray-500 mt-1">Email cannot be changed</p>
            </div>
            <div>
              <label for="studentName" class="block text-sm font-medium text-gray-700 mb-1">Student Name *</label>
              <input type="text" id="studentName" name="studentName" value="${registration.studentName}" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
          </div>
        </div>

        <!-- Course Information -->
        <div>
          <h2 class="text-xl font-semibold text-gray-800 mb-4">Course Information</h2>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label for="courseCode" class="block text-sm font-medium text-gray-700 mb-1">Course Code</label>
              <input type="text" id="courseCode" value="${registration.courseCode}" readonly disabled
                     class="w-full px-3 py-2 bg-gray-100 border border-gray-300 rounded-md">
              <p class="text-xs text-gray-500 mt-1">Course code cannot be changed</p>
            </div>
            <div>
              <label for="courseName" class="block text-sm font-medium text-gray-700 mb-1">Course Name *</label>
              <input type="text" id="courseName" name="courseName" value="${registration.courseName}" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label for="courseFee" class="block text-sm font-medium text-gray-700 mb-1">Course Fee *</label>
              <input type="text" id="courseFee" name="courseFee" value="${registration.courseFee}" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label for="schoolName" class="block text-sm font-medium text-gray-700 mb-1">School *</label>
              <input type="text" id="schoolName" name="schoolName" value="${registration.schoolName}" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
          </div>
        </div>

        <!-- Registration Details -->
        <div>
          <h2 class="text-xl font-semibold text-gray-800 mb-4">Registration Details</h2>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label for="status" class="block text-sm font-medium text-gray-700 mb-1">Status *</label>
              <select id="status" name="status" required
                      class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                <option value="PENDING" ${registration.status == 'PENDING' ? 'selected' : ''}>Pending</option>
                <option value="APPROVED" ${registration.status == 'APPROVED' ? 'selected' : ''}>Approved</option>
                <option value="COMPLETED" ${registration.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
              </select>
            </div>
            <div>
              <label for="registrationDate" class="block text-sm font-medium text-gray-700 mb-1">Registration Date</label>
              <input type="text" id="registrationDate" value="${registration.formattedDate}" readonly disabled
                     class="w-full px-3 py-2 bg-gray-100 border border-gray-300 rounded-md">
              <p class="text-xs text-gray-500 mt-1">Registration date cannot be changed</p>
            </div>
            <div class="md:col-span-2">
              <label for="notes" class="block text-sm font-medium text-gray-700 mb-1">Notes</label>
              <textarea id="notes" name="notes" rows="3"
                        class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">${registration.notes}</textarea>
            </div>
          </div>
        </div>

        <div class="flex justify-end space-x-3">
          <a href="${pageContext.request.contextPath}/admin/registrations" class="px-4 py-2 bg-gray-200 text-gray-800 rounded-md hover:bg-gray-300 transition">
            Cancel
          </a>
          <button type="submit" class="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600 transition">
            Update Registration
          </button>
        </div>
      </form>
    </div>
  </div>
</div>
</body>
</html>

