<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 1:56 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Details - Student LMS</title>
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
            <h1 class="text-3xl font-bold text-gray-800">User Details</h1>
            <div class="flex space-x-2">
                <a href="${pageContext.request.contextPath}/admin/users/edit/${user.email}" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md transition flex items-center">
                    <i class="fas fa-edit mr-2"></i> Edit User
                </a>
                <a href="${pageContext.request.contextPath}/admin/users" class="bg-gray-500 hover:bg-gray-600 text-white py-2 px-4 rounded-md transition flex items-center">
                    <i class="fas fa-arrow-left mr-2"></i> Back to Users
                </a>
            </div>
        </div>

        <!-- User Profile -->
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <!-- Header -->
            <div class="bg-blue-500 text-white p-6">
                <div class="flex items-center">
                    <div class="flex-shrink-0 h-24 w-24 bg-white rounded-full flex items-center justify-center text-blue-500 text-3xl font-bold">
                        ${user.fullName.charAt(0)}
                    </div>
                    <div class="ml-6">
                        <h2 class="text-2xl font-bold">${user.fullName}</h2>
                        <p class="text-blue-100">${user.email}</p>
                        <p class="text-blue-100">Register Number: ${user.registerNumber}</p>
                    </div>
                </div>
            </div>

            <!-- User Information -->
            <div class="p-6">
                <!-- Personal Information -->
                <div class="mb-8">
                    <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Personal Information</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-y-4">
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
                        <div>
                            <p class="text-sm text-gray-500">Register Number</p>
                            <p class="text-gray-800">${user.registerNumber}</p>
                        </div>
                    </div>
                </div>

                <!-- Contact Information -->
                <div class="mb-8">
                    <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Contact Information</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-y-4">
                        <div>
                            <p class="text-sm text-gray-500">Mobile Number</p>
                            <p class="text-gray-800">${user.mobileNumber}</p>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">WhatsApp Number</p>
                            <p class="text-gray-800">${user.whatsAppNumber}</p>
                        </div>
                        <div class="md:col-span-2">
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
                <div class="mb-8">
                    <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Educational Information</h3>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-y-4">
                        <div>
                            <p class="text-sm text-gray-500">Index Number</p>
                            <p class="text-gray-800">${user.indexNumber}</p>
                        </div>
                        <div>
                            <p class="text-sm text-gray-500">Year of Completion</p>
                            <p class="text-gray-800">${user.yearOfCompletion}</p>
                        </div>
                        <div class="md:col-span-2">
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
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-y-4">
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

        <!-- User's Registrations -->
        <div class="mt-8 bg-white rounded-lg shadow-md p-6">
            <h2 class="text-xl font-semibold text-gray-800 mb-4">Course Registrations</h2>

            <c:if test="${not empty registrations}">
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Course Code</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Course Name</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">School</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Registration Date</th>
                        </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach var="reg" items="${registrations}">
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${reg.courseCode}</td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${reg.courseName}</td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${reg.schoolName}</td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                    <c:set var="regDate" value="${reg.timestamp}" />
                                    <c:set var="formattedDate" value="${regDate.toString()}" />
                                        ${formattedDate}
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

            <c:if test="${empty registrations}">
                <div class="bg-gray-50 p-4 rounded-md text-center">
                    <p class="text-gray-500">No course registrations found for this user.</p>
                </div>
            </c:if>
        </div>
    </div>
</div>
</body>
</html>

