<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:29 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Register - Student LMS</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">
<div class="min-h-screen py-12 px-4 sm:px-6 lg:px-8">
  <div class="max-w-3xl mx-auto bg-white rounded-lg shadow-md overflow-hidden">
    <div class="bg-blue-500 text-white py-4 px-6">
      <h2 class="text-2xl font-bold">Student LMS</h2>
      <p class="text-blue-100">Create a new account</p>
    </div>

    <div class="p-6">
      <!-- Error Messages -->
      <c:if test="${not empty errors}">
        <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4" role="alert">
          <ul class="list-disc list-inside">
            <c:forEach var="error" items="${errors}">
              <li>${error}</li>
            </c:forEach>
          </ul>
        </div>
      </c:if>

      <form action="${pageContext.request.contextPath}/register" method="post" class="space-y-6">
        <!-- Personal Information -->
        <div>
          <h3 class="text-lg font-medium text-gray-900 mb-4">Personal Information</h3>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label for="fullName" class="block text-sm font-medium text-gray-700 mb-1">Full Name *</label>
              <input type="text" id="fullName" name="fullName" value="${param.fullName}" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label for="nic" class="block text-sm font-medium text-gray-700 mb-1">NIC Number *</label>
              <input type="text" id="nic" name="nic" value="${param.nic}" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email Address *</label>
              <input type="email" id="email" name="email" value="${param.email}" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label for="dateOfBirth" class="block text-sm font-medium text-gray-700 mb-1">Date of Birth *</label>
              <input type="date" id="dateOfBirth" name="dateOfBirth" value="${param.dateOfBirth}" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label for="gender" class="block text-sm font-medium text-gray-700 mb-1">Gender *</label>
              <select id="gender" name="gender" required
                      class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                <option value="">Select Gender</option>
                <option value="Male" ${param.gender == 'Male' ? 'selected' : ''}>Male</option>
                <option value="Female" ${param.gender == 'Female' ? 'selected' : ''}>Female</option>
                <option value="Other" ${param.gender == 'Other' ? 'selected' : ''}>Other</option>
              </select>
            </div>
          </div>
        </div>

        <!-- Contact Information -->
        <div>
          <h3 class="text-lg font-medium text-gray-900 mb-4">Contact Information</h3>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label for="mobileNumber" class="block text-sm font-medium text-gray-700 mb-1">Mobile Number *</label>
              <input type="tel" id="mobileNumber" name="mobileNumber" value="${param.mobileNumber}" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label for="whatsAppNumber" class="block text-sm font-medium text-gray-700 mb-1">WhatsApp Number</label>
              <input type="tel" id="whatsAppNumber" name="whatsAppNumber" value="${param.whatsAppNumber}"
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div class="md:col-span-2">
              <label for="permanentAddress" class="block text-sm font-medium text-gray-700 mb-1">Permanent Address *</label>
              <textarea id="permanentAddress" name="permanentAddress" rows="3" required
                        class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">${param.permanentAddress}</textarea>
            </div>
            <div>
              <label for="districtOrProvince" class="block text-sm font-medium text-gray-700 mb-1">District/Province *</label>
              <input type="text" id="districtOrProvince" name="districtOrProvince" value="${param.districtOrProvince}" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label for="postalCode" class="block text-sm font-medium text-gray-700 mb-1">Postal Code *</label>
              <input type="text" id="postalCode" name="postalCode" value="${param.postalCode}" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
          </div>
        </div>

        <!-- Educational Information -->
        <div>
          <h3 class="text-lg font-medium text-gray-900 mb-4">Educational Information</h3>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label for="indexNumber" class="block text-sm font-medium text-gray-700 mb-1">Index Number</label>
              <input type="text" id="indexNumber" name="indexNumber" value="${param.indexNumber}"
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label for="yearOfCompletion" class="block text-sm font-medium text-gray-700 mb-1">Year of Completion</label>
              <input type="text" id="yearOfCompletion" name="yearOfCompletion" value="${param.yearOfCompletion}"
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
          </div>
        </div>

        <!-- Parent/Guardian Information -->
        <div>
          <h3 class="text-lg font-medium text-gray-900 mb-4">Parent/Guardian Information</h3>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label for="parentFullName" class="block text-sm font-medium text-gray-700 mb-1">Parent/Guardian Full Name</label>
              <input type="text" id="parentFullName" name="parentFullName" value="${param.parentFullName}"
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label for="parentContactNumber" class="block text-sm font-medium text-gray-700 mb-1">Parent/Guardian Contact Number</label>
              <input type="tel" id="parentContactNumber" name="parentContactNumber" value="${param.parentContactNumber}"
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
            <div>
              <label for="parentEmail" class="block text-sm font-medium text-gray-700 mb-1">Parent/Guardian Email</label>
              <input type="email" id="parentEmail" name="parentEmail" value="${param.parentEmail}"
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
          </div>
        </div>

        <!-- Account Credentials -->
        <div>
          <h3 class="text-lg font-medium text-gray-900 mb-4">Account Credentials</h3>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Password *</label>
              <input type="password" id="password" name="password" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
              <p class="text-xs text-gray-500 mt-1">Password must be at least 6 characters long</p>
            </div>
            <div>
              <label for="confirmPassword" class="block text-sm font-medium text-gray-700 mb-1">Confirm Password *</label>
              <input type="password" id="confirmPassword" name="confirmPassword" required
                     class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            </div>
          </div>
        </div>

        <!-- Terms and Conditions -->
        <div class="flex items-start">
          <div class="flex items-center h-5">
            <input id="terms" name="terms" type="checkbox" required
                   class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded">
          </div>
          <div class="ml-3 text-sm">
            <label for="terms" class="font-medium text-gray-700">I agree to the terms and conditions *</label>
            <p class="text-gray-500">By registering, you agree to our <a href="#" class="text-blue-600 hover:text-blue-500">Terms of Service</a> and <a href="#" class="text-blue-600 hover:text-blue-500">Privacy Policy</a>.</p>
          </div>
        </div>

        <div>
          <button type="submit" class="w-full bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md transition">
            Register
          </button>
        </div>
      </form>

      <div class="mt-4 text-center">
        <p class="text-sm text-gray-600">
          Already have an account?
          <a href="${pageContext.request.contextPath}/login" class="text-blue-600 hover:text-blue-500">
            Login here
          </a>
        </p>
      </div>
    </div>
  </div>
</div>
</body>
</html>
