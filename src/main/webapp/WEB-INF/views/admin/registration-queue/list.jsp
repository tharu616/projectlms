<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:11 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Queue - Student LMS</title>
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
            <div class="flex space-x-2">
                <a href="${pageContext.request.contextPath}/admin/registrations" class="bg-gray-500 hover:bg-gray-600 text-white py-2 px-4 rounded-md transition flex items-center">
                    <i class="fas fa-arrow-left mr-2"></i> Back to Registrations
                </a>
            </div>
        </div>

        <!-- Queue Status -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <div class="flex items-center justify-between">
                <div>
                    <h2 class="text-xl font-semibold text-gray-800">Queue Status</h2>
                    <p class="text-gray-600 mt-1">There are currently <span class="font-bold text-blue-600">${queueSize}</span> registrations in the queue.</p>
                </div>
                <div class="flex space-x-2">
                    <form action="${pageContext.request.contextPath}/admin/registration-queue" method="post">
                        <input type="hidden" name="action" value="clearQueue">
                        <button type="submit" class="bg-red-500 hover:bg-red-600 text-white py-2 px-4 rounded-md transition flex items-center">
                            <i class="fas fa-trash mr-2"></i> Clear Queue
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <!-- Queue Processing -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <h2 class="text-xl font-semibold text-gray-800 mb-4">Process Queue</h2>

            <c:if test="${not empty nextRegistration}">
                <div class="bg-blue-50 border border-blue-200 rounded-lg p-4 mb-4">
                    <div class="flex justify-between">
                        <div>
                            <h3 class="font-medium text-blue-800">Next in Queue:</h3>
                            <p class="text-blue-700 mt-1">
                                <span class="font-semibold">${nextRegistration.studentName}</span> (${nextRegistration.studentEmail})
                                for course <span class="font-semibold">${nextRegistration.courseCode}</span> - ${nextRegistration.courseName}
                            </p>
                        </div>
                        <div class="flex items-start space-x-2">
                            <form action="${pageContext.request.contextPath}/admin/registration-queue" method="post">
                                <input type="hidden" name="action" value="approveRegistration">
                                <button type="submit" class="bg-green-500 hover:bg-green-600 text-white py-1 px-3 rounded-md transition flex items-center text-sm">
                                    <i class="fas fa-check mr-1"></i> Approve
                                </button>
                            </form>
                            <form action="${pageContext.request.contextPath}/admin/registration-queue" method="post">
                                <input type="hidden" name="action" value="rejectRegistration">
                                <button type="submit" class="bg-red-500 hover:bg-red-600 text-white py-1 px-3 rounded-md transition flex items-center text-sm">
                                    <i class="fas fa-times mr-1"></i> Reject
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:if>

            <c:if test="${empty nextRegistration && queueSize > 0}">
                <div class="flex justify-center">
                    <form action="${pageContext.request.contextPath}/admin/registration-queue/process" method="get">
                        <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md transition flex items-center">
                            <i class="fas fa-play mr-2"></i> Start Processing
                        </button>
                    </form>
                </div>
            </c:if>

            <c:if test="${empty nextRegistration && queueSize == 0}">
                <div class="bg-gray-50 p-4 rounded-md text-center">
                    <p class="text-gray-500">Queue is empty. No registrations to process.</p>
                </div>
            </c:if>
        </div>

        <!-- Pending Registrations Table -->
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <div class="px-6 py-4 border-b border-gray-200">
                <h2 class="text-xl font-semibold text-gray-800">Pending Registrations</h2>
            </div>

            <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                    <tr>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Position</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Student</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Course</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">School</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Timestamp</th>
                        <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                    </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                    <c:forEach var="registration" items="${pendingRegistrations}" varStatus="status">
                        <tr>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm font-medium text-gray-900">${status.index + 1}</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="flex items-center">
                                    <div class="flex-shrink-0 h-10 w-10 bg-gray-200 rounded-full flex items-center justify-center">
                                        <span class="text-gray-500 font-medium">${registration.studentName.charAt(0)}</span>
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
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-900">${registration.schoolName}</div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <div class="text-sm text-gray-900">
                                    <c:set var="date" value="${registration.timestamp}" />
                                    <c:set var="formattedDate" value="${date.toString()}" />
                                        ${formattedDate}
                                </div>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                <a href="${pageContext.request.contextPath}/admin/registration-queue/view/${status.index}" class="text-blue-600 hover:text-blue-900">
                                    <i class="fas fa-eye"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty pendingRegistrations}">
                        <tr>
                            <td colspan="6" class="px-6 py-4 text-center text-gray-500">
                                No pending registrations in the queue
                            </td>
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
