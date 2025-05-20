<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 1:55 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Edit User - Student LMS</title>
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
      <h1 class="text-3xl font-bold text-gray-800">Edit User</h1>
      <a href="${pageContext.request.contextPath}/admin/users" class="bg-gray-500 hover:bg-gray-600 text-white py-2 px-4 rounded-md transition flex items-center">
        <i class="fas fa-arrow-left mr-2"></i> Back to Users
      </a>
    </div>

    <!-- Error Messages -->
    <c:if test="${not empty error}">
      <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4" role="alert">
        <p>${error}</p>
      </div>
    </c:if>

    <c:if test="${not empty errors}">
      <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4" role="alert">
        <ul class="list-disc list-inside">
          <c:forEach var="err" items="${errors}">
            <li>${err}</li>
          </c:forEach>
        </ul>
      </div>
    </c:if>

    <!-- User Form -->
    <div class="bg-white rounded-lg shadow-md p-6">
      <form action="${pageContext.request.contextPath}/admin/users" method="post" class="space-y-6">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="email" value="${user.email}">

        <!-- Personal Information -->
        <div>
          <h2 class="text-xl font-semibold text-gray-800 mb-4">Personal Information</h2>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label for="fullName" class="block text-sm font-medium text-gray-700 mb-1">Full Name *</label>
              <input type="text" id="fullName" name="fullName" value="${user.fullName}" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label for="nic" class="block text-sm font-medium text-gray-700 mb-1">NIC Number *</label>
              <input type="text" id="nic" name="nic" value="${user.nic}" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email Address *</label>
              <input type="email" id="email" value="${user.email}" readonly disabled
                     class="w-full px-3 py-2 bg-gray-100 border border-gray-300 rounded-md">
              <p class="text-xs text-gray-500 mt-1">Email cannot be changed</p>
            </div>
            <div>
              <label for="newPassword" class="block text-sm font-medium text-gray-700 mb-1">New Password</label>
              <input type="password" id="newPassword" name="newPassword"
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
              <p class="text-xs text-gray-500 mt-1">Leave blank to keep current password</p>
            </div>
            <div>
              <label for="dateOfBirth" class="block text-sm font-medium text-gray-700 mb-1">Date of Birth *</label>
              <input type="date" id="dateOfBirth" name="dateOfBirth" value="${user.dateOfBirth}" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label for="gender" class="block text-sm font-medium text-gray-700 mb-1">Gender *</label>
              <select id="gender" name="gender" required
                      class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                <option value="">Select Gender</option>
                <option value="Male" ${user.gender == 'Male' ? 'selected' : ''}>Male</option>
                <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
                <option value="Other" ${user.gender == 'Other' ? 'selected' : ''}>Other</option>
              </select>
            </div>
          </div>
        </div>

        <!-- Contact Information -->
        <div>
          <h2 class="text-xl font-semibold text-gray-800 mb-4">Contact Information</h2>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label for="mobileNumber" class="block text-sm font-medium text-gray-700 mb-1">Mobile Number *</label>
              <input type="tel" id="mobileNumber" name="mobileNumber" value="${user.mobileNumber}" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label for="whatsAppNumber" class="block text-sm font-medium text-gray-700 mb-1">WhatsApp Number</label>
              <input type="tel" id="whatsAppNumber" name="whatsAppNumber" value="${user.whatsAppNumber}"
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div class="md:col-span-2">
              <label for="permanentAddress" class="block text-sm font-medium text-gray-700 mb-1">Permanent Address *</label>
              <textarea id="permanentAddress" name="permanentAddress" rows="3" required
                        class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">${user.permanentAddress}</textarea>
            </div>
            <div>
              <label for="districtOrProvince" class="block text-sm font-medium text-gray-700 mb-1">District/Province *</label>
              <input type="text" id="districtOrProvince" name="districtOrProvince" value="${user.districtOrProvince}" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label for="postalCode" class="block text-sm font-medium text-gray-700 mb-1">Postal Code *</label>
              <input type="text" id="postalCode" name="postalCode" value="${user.postalCode}" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
          </div>
        </div>

        <!-- Educational Information -->
        <div>
          <h2 class="text-xl font-semibold text-gray-800 mb-4">Educational Information</h2>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label for="indexNumber" class="block text-sm font-medium text-gray-700 mb-1">Index Number</label>
              <input type="text" id="indexNumber" name="indexNumber" value="${user.indexNumber}"
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label for="yearOfCompletion" class="block text-sm font-medium text-gray-700 mb-1">Year of Completion</label>
              <input type="text" id="yearOfCompletion" name="yearOfCompletion" value="${user.yearOfCompletion}"
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label for="registerNumber" class="block text-sm font-medium text-gray-700 mb-1">Register Number</label>
              <input type="text" id="registerNumber" name="registerNumber" value="${user.registerNumber}" readonly disabled
                     class="w-full px-3 py-2 bg-gray-100 border border-gray-300 rounded-md">
              <p class="text-xs text-gray-500 mt-1">Register number cannot be changed</p>
            </div>
          </div>
        </div>

        <!-- Parent/Guardian Information -->
        <div>
          <h2 class="text-xl font-semibold text-gray-800 mb-4">Parent/Guardian Information</h2>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label for="parentFullName" class="block text-sm font-medium text-gray-700 mb-1">Parent/Guardian Full Name</label>
              <input type="text" id="parentFullName" name="parentFullName" value="${user.parentFullName}"
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label for="parentContactNumber" class="block text-sm font-medium text-gray-700 mb-1">Parent/Guardian Contact Number</label>
              <input type="tel" id="parentContactNumber" name="parentContactNumber" value="${user.parentContactNumber}"
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label for="parentEmail" class="block text-sm font-medium text-gray-700 mb-1">Parent/Guardian Email</label>
              <input type="email" id="parentEmail" name="parentEmail" value="${user.parentEmail}"
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
          </div>
        </div>

        <div class="flex justify-end space-x-3">
          <a href="${pageContext.request.contextPath}/admin/users" class="px-4 py-2 bg-gray-200 text-gray-800 rounded-md hover:bg-gray-300 transition">
            Cancel
          </a>
          <button type="submit" class="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600 transition">
            Update User
          </button>
        </div>
      </form>
    </div>
  </div>
</div>
</body>
</html>

