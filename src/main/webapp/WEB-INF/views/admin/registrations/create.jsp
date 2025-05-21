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
    <title>Create Registration - Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">
<div class="min-h-screen flex">
    <!-- Sidebar -->
    <jsp:include page="../../shared/admin-sidebar.jsp" />

    <!-- Main Content -->
    <div class="flex-1 p-10">
        <div class="mb-6">
            <a href="${pageContext.request.contextPath}/admin/registrations" class="text-blue-500 hover:underline">
                <i class="fas fa-arrow-left mr-2"></i> Back to Registrations
            </a>
        </div>

        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <div class="bg-blue-600 text-white p-6">
                <h1 class="text-3xl font-bold">Create New Registration</h1>
            </div>

            <div class="p-6">
                <c:if test="${not empty error}">
                    <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-6" role="alert">
                        <p>${error}</p>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/admin/registrations" method="post">
                    <input type="hidden" name="action" value="create">

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                        <div>
                            <label for="studentEmail" class="block text-sm font-medium text-gray-700 mb-1">Student Email</label>
                            <input type="email" id="studentEmail" name="studentEmail" required
                                   value="${registration.studentEmail}"
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="studentName" class="block text-sm font-medium text-gray-700 mb-1">Student Name</label>
                            <input type="text" id="studentName" name="studentName" required
                                   value="${registration.studentName}"
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                        <div>
                            <label for="courseCode" class="block text-sm font-medium text-gray-700 mb-1">Course Code</label>
                            <input type="text" id="courseCode" name="courseCode" required
                                   value="${registration.courseCode}"
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="courseName" class="block text-sm font-medium text-gray-700 mb-1">Course Name</label>
                            <input type="text" id="courseName" name="courseName" required
                                   value="${registration.courseName}"
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
                        <div>
                            <label for="schoolName" class="block text-sm font-medium text-gray-700 mb-1">School</label>
                            <input type="text" id="schoolName" name="schoolName" required
                                   value="${registration.schoolName}"
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="courseFee" class="block text-sm font-medium text-gray-700 mb-1">Course Fee</label>
                            <input type="text" id="courseFee" name="courseFee" required
                                   value="${registration.courseFee}"
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                    </div>

                    <div class="mt-8 flex justify-end">
                        <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md">
                            <i class="fas fa-save mr-2"></i> Create Registration
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</body>
</html>

