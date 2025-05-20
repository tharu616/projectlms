<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:34 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - Student LMS</title>
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
            <h1 class="text-3xl font-bold text-gray-800">My Profile</h1>
            <a href="${pageContext.request.contextPath}/user/dashboard" class="bg-gray-500 hover:bg-gray-600 text-white py-2 px-4 rounded-md transition flex items-center">
                <i class="fas fa-arrow-left mr-2"></i> Back to Dashboard
            </a>
        </div>

        <!-- Success/Error Messages -->
        <c:if test="${not empty success}">
            <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-4" role="alert">
                <p>${success}</p>
            </div>
        </c:if>

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

        <!-- Profile Information -->
        <div class="bg-white rounded-lg shadow-md overflow-hidden mb-6">
            <div class="bg-blue-500 text-white p-6">
                <div class="flex items-center">
                    <div class="flex-shrink-0 h-24 w-24 bg-white rounded-full flex items-center justify-center text-blue-500 text-3xl font-bold">
                        ${user.fullName.charAt(0)}
                    </div>
                    <div class="ml-6">
                        <h2 class="text-2xl font-bold">${user.fullName}</h2>
                        <p class="text-blue-100">Student ID: ${user.registerNumber}</p>
                        <p class="text-blue-100">Email: ${user.email}</p>
                    </div>
                </div>
            </div>

            <div class="p-6">
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    <!-- Personal Information -->
                    <div>
                        <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Personal Information</h3>
                        <div class="space-y-3">
                            <div>
                                <p class="text-sm text-gray-500">Full Name</p>
                                <p class="text-gray-800">${user.fullName}</p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">NIC Number</p>
                                <p class="text-gray-800">${user.nic}</p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Email Address</p>
                                <p class="text-gray-800">${user.email}</p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Date of Birth</p>
                                <p class="text-gray-800">${user.dateOfBirth}</p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Gender</p>
                                <p class="text-gray-800">${user.gender}</p>
                            </div>
                        </div>
                    </div>

                    <!-- Contact Information -->
                    <div>
                        <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Contact Information</h3>
                        <div class="space-y-3">
                            <div>
                                <p class="text-sm text-gray-500">Mobile Number</p>
                                <p class="text-gray-800">${user.mobileNumber}</p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">WhatsApp Number</p>
                                <p class="text-gray-800">${user.whatsAppNumber}</p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Permanent Address</p>
                                <p class="text-gray-800">${user.permanentAddress}</p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">District/Province</p>
                                <p class="text-gray-800">${user.districtOrProvince}</p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Postal Code</p>
                                <p class="text-gray-800">${user.postalCode}</p>
                            </div>
                        </div>
                    </div>

                    <!-- Educational Information -->
                    <div>
                        <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Educational Information</h3>
                        <div class="space-y-3">
                            <div>
                                <p class="text-sm text-gray-500">Index Number</p>
                                <p class="text-gray-800">${user.indexNumber}</p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Year of Completion</p>
                                <p class="text-gray-800">${user.yearOfCompletion}</p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Certificates</p>
                                <c:if test="${not empty user.certificates}">
                                    <ul class="list-disc list-inside text-gray-800">
                                        <c:forEach var="cert" items="${user.certificates}">
                                            <li>${cert}</li>
                                        </c:forEach>
                                    </ul>
                                </c:if>
                                <c:if test="${empty user.certificates}">
                                    <p class="text-gray-800">No certificates uploaded</p>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <!-- Parent/Guardian Information -->
                    <div>
                        <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Parent/Guardian Information</h3>
                        <div class="space-y-3">
                            <div>
                                <p class="text-sm text-gray-500">Parent/Guardian Full Name</p>
                                <p class="text-gray-800">${user.parentFullName}</p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Parent/Guardian Contact Number</p>
                                <p class="text-gray-800">${user.parentContactNumber}</p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Parent/Guardian Email</p>
                                <p class="text-gray-800">${user.parentEmail}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Edit Profile Form -->
        <div class="bg-white rounded-lg shadow-md p-6">
            <h2 class="text-xl font-semibold text-gray-800 mb-4">Edit Profile</h2>

            <form action="${pageContext.request.contextPath}/user/profile" method="post" class="space-y-6">
                <!-- Contact Information -->
                <div>
                    <h3 class="text-lg font-medium text-gray-900 mb-4">Contact Information</h3>
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

                <!-- Parent/Guardian Information -->
                <div>
                    <h3 class="text-lg font-medium text-gray-900 mb-4">Parent/Guardian Information</h3>
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

                <!-- Change Password -->
                <div>
                    <h3 class="text-lg font-medium text-gray-900 mb-4">Change Password</h3>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                        <div>
                            <label for="currentPassword" class="block text-sm font-medium text-gray-700 mb-1">Current Password</label>
                            <input type="password" id="currentPassword" name="currentPassword"
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="newPassword" class="block text-sm font-medium text-gray-700 mb-1">New Password</label>
                            <input type="password" id="newPassword" name="newPassword"
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="confirmPassword" class="block text-sm font-medium text-gray-700 mb-1">Confirm New Password</label>
                            <input type="password" id="confirmPassword" name="confirmPassword"
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                    </div>
                    <p class="text-xs text-gray-500 mt-2">Leave password fields empty if you don't want to change your password</p>
                </div>

                <div>
                    <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md transition">
                        Save Changes
                    </button>
                </div>
            </form>
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

