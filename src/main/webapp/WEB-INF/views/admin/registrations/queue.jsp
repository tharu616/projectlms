<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/22/2025
  Time: 1:25 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Queue - Admin Dashboard</title>
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
            <h1 class="text-3xl font-bold text-gray-800">Registration Queue</h1>
            <a href="${pageContext.request.contextPath}/admin/registrations" class="bg-gray-500 hover:bg-gray-600 text-white py-2 px-4 rounded-md">
                <i class="fas fa-arrow-left mr-2"></i> Back to Registrations
            </a>
        </div>

        <!-- Success Messages -->
        <c:if test="${not empty param.processed}">
            <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-6" role="alert">
                <p>Successfully processed ${param.processed} registrations!</p>
            </div>
        </c:if>

        <c:if test="${not empty param.cleared}">
            <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-6" role="alert">
                <p>Successfully cleared ${param.cleared} registrations from the queue!</p>
            </div>
        </c:if>

        <!-- Queue Status -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <div class="flex justify-between items-center">
                <div>
                    <h2 class="text-xl font-semibold text-gray-800 mb-2">Queue Status</h2>
                    <p class="text-gray-600">There are currently ${queueSize} registrations in the queue.</p>
                </div>
                <form action="${pageContext.request.contextPath}/admin/registration-queue" method="post">
                    <input type="hidden" name="action" value="clearQueue">
                    <button type="submit" class="bg-red-500 hover:bg-red-600 text-white py-2 px-4 rounded-md">
                        <i class="fas fa-trash mr-2"></i> Clear Queue
                    </button>
                </form>
            </div>
        </div>

        <!-- Process Queue -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <div class="flex justify-between items-center">
                <div>
                    <h2 class="text-xl font-semibold text-gray-800 mb-2">Process Queue</h2>
                    <p class="text-gray-600">Process all pending registrations in the queue.</p>
                </div>
                <form action="${pageContext.request.contextPath}/admin/registration-queue" method="post">
                    <input type="hidden" name="action" value="processQueue">
                    <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md">
                        <i class="fas fa-play mr-2"></i> Start Processing
                    </button>
                </form>
            </div>
        </div>

        <!-- Pending Registrations -->
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <div class="p-6 border-b border-gray-200">
                <h2 class="text-xl font-semibold text-gray-800">Pending Registrations</h2>
            </div>
            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Position</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Student</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Course</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">School</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                    </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                    <c:forEach var="registration" items="${pendingRegistrations}" varStatus="status">
                        <tr>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">${status.index + 1}</td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="flex items-center">
                                    <div class="flex-shrink-0 h-10 w-10 bg-blue-100 rounded-full flex items-center justify-center">
                                        <span class="text-blue-800 font-medium">${registration.studentName.charAt(0)}</span>
                                    </div>
                                    <div class="ml-4">
                                        <div class="text-sm font-medium text-gray-900">${registration.studentName}</div>
                                        <div class="text-sm text-gray-500">${registration.studentEmail}</div>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm font-medium text-gray-900">${registration.courseCode}</div>
                                <div class="text-sm text-gray-500">${registration.courseName}</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${registration.schoolName}</td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                <form action="${pageContext.request.contextPath}/admin/registration-queue" method="post" class="inline">
                                    <input type="hidden" name="action" value="approveRegistration">
                                    <input type="hidden" name="studentEmail" value="${registration.studentEmail}">
                                    <input type="hidden" name="courseCode" value="${registration.courseCode}">
                                    <button type="submit" class="text-green-600 hover:text-green-900 mr-3">
                                        <i class="fas fa-check"></i>
                                    </button>
                                </form>
                                <form action="${pageContext.request.contextPath}/admin/registration-queue" method="post" class="inline">
                                    <input type="hidden" name="action" value="rejectRegistration">
                                    <input type="hidden" name="studentEmail" value="${registration.studentEmail}">
                                    <input type="hidden" name="courseCode" value="${registration.courseCode}">
                                    <button type="submit" class="text-red-600 hover:text-red-900">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty pendingRegistrations}">
                        <tr>
                            <td colspan="5" class="px-6 py-4 text-center text-gray-500">No pending registrations in the queue</td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>
