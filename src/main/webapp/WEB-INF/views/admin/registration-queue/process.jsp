<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:12 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Process Registration - Student LMS</title>
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
            <h1 class="text-3xl font-bold text-gray-800">Process Registration</h1>
            <a href="${pageContext.request.contextPath}/admin/registration-queue" class="bg-gray-500 hover:bg-gray-600 text-white py-2 px-4 rounded-md transition flex items-center">
                <i class="fas fa-arrow-left mr-2"></i> Back to Queue
            </a>
        </div>

        <c:if test="${not empty registration}">
            <!-- Registration Details -->
            <div class="bg-white rounded-lg shadow-md overflow-hidden mb-6">
                <div class="bg-blue-500 text-white p-6">
                    <div class="flex items-center">
                        <div class="flex-shrink-0 h-20 w-20 bg-white rounded-full flex items-center justify-center text-blue-500 text-2xl font-bold">
                                ${registration.studentName.charAt(0)}
                        </div>
                        <div class="ml-6">
                            <h2 class="text-xl font-bold">${registration.studentName}</h2>
                            <p class="text-blue-100">${registration.studentEmail}</p>
                            <p class="text-blue-100">Course: ${registration.courseCode} - ${registration.courseName}</p>
                        </div>
                    </div>
                </div>

                <div class="p-6">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <!-- Student Information -->
                        <div>
                            <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Student Information</h3>
                            <div class="space-y-3">
                                <div>
                                    <p class="text-sm text-gray-500">Full Name</p>
                                    <p class="text-gray-800">${registration.studentName}</p>
                                </div>
                                <div>
                                    <p class="text-sm text-gray-500">Email Address</p>
                                    <p class="text-gray-800">${registration.studentEmail}</p>
                                </div>
                                <div>
                                    <p class="text-sm text-gray-500">Student Profile</p>
                                    <a href="${pageContext.request.contextPath}/admin/users/view/${registration.studentEmail}" class="text-blue-500 hover:text-blue-700">
                                        View Student Profile
                                    </a>
                                </div>
                            </div>
                        </div>

                        <!-- Course Information -->
                        <div>
                            <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Course Information</h3>
                            <div class="space-y-3">
                                <div>
                                    <p class="text-sm text-gray-500">Course Code</p>
                                    <p class="text-gray-800">${registration.courseCode}</p>
                                </div>
                                <div>
                                    <p class="text-sm text-gray-500">Course Name</p>
                                    <p class="text-gray-800">${registration.courseName}</p>
                                </div>
                                <div>
                                    <p class="text-sm text-gray-500">School</p>
                                    <p class="text-gray-800">${registration.schoolName}</p>
                                </div>
                                <div>
                                    <p class="text-sm text-gray-500">Course Fee</p>
                                    <p class="text-gray-800">${registration.courseFee}</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Registration Details -->
                    <div class="mt-6">
                        <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Registration Details</h3>
                        <div class="space-y-3">
                            <div>
                                <p class="text-sm text-gray-500">Registration Date</p>
                                <p class="text-gray-800">
                                    <c:set var="date" value="${registration.timestamp}" />
                                    <c:set var="formattedDate" value="${date.toString()}" />
                                        ${formattedDate}
                                </p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Queue Position</p>
                                <p class="text-gray-800">${queuePosition}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Decision Form -->
            <div class="bg-white rounded-lg shadow-md p-6">
                <h2 class="text-xl font-semibold text-gray-800 mb-4">Registration Decision</h2>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Approve Form -->
                    <div class="bg-green-50 rounded-lg p-6 border border-green-200">
                        <h3 class="text-lg font-medium text-green-800 mb-4">Approve Registration</h3>
                        <p class="text-green-700 mb-4">Approving this registration will move it from the queue to confirmed registrations.</p>

                        <form action="${pageContext.request.contextPath}/admin/registration-queue" method="post">
                            <input type="hidden" name="action" value="approveRegistration">
                            <input type="hidden" name="position" value="${queuePosition}">

                            <div class="mb-4">
                                <label for="approveNotes" class="block text-sm font-medium text-green-700 mb-1">Notes (Optional)</label>
                                <textarea id="approveNotes" name="approveNotes" rows="3"
                                          class="w-full px-3 py-2 border border-green-300 rounded-md focus:outline-none focus:ring-2 focus:ring-green-500"></textarea>
                            </div>

                            <button type="submit" class="w-full bg-green-500 hover:bg-green-600 text-white py-2 px-4 rounded-md transition">
                                <i class="fas fa-check mr-2"></i> Approve Registration
                            </button>
                        </form>
                    </div>

                    <!-- Reject Form -->
                    <div class="bg-red-50 rounded-lg p-6 border border-red-200">
                        <h3 class="text-lg font-medium text-red-800 mb-4">Reject Registration</h3>
                        <p class="text-red-700 mb-4">Rejecting this registration will remove it from the queue without creating a confirmed registration.</p>

                        <form action="${pageContext.request.contextPath}/admin/registration-queue" method="post">
                            <input type="hidden" name="action" value="rejectRegistration">
                            <input type="hidden" name="position" value="${queuePosition}">

                            <div class="mb-4">
                                <label for="rejectReason" class="block text-sm font-medium text-red-700 mb-1">Reason for Rejection</label>
                                <select id="rejectReason" name="rejectReason" required
                                        class="w-full px-3 py-2 border border-red-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500">
                                    <option value="">Select a reason</option>
                                    <option value="Duplicate Registration">Duplicate Registration</option>
                                    <option value="Course Full">Course Full</option>
                                    <option value="Prerequisites Not Met">Prerequisites Not Met</option>
                                    <option value="Payment Issues">Payment Issues</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>

                            <div class="mb-4">
                                <label for="rejectNotes" class="block text-sm font-medium text-red-700 mb-1">Additional Notes</label>
                                <textarea id="rejectNotes" name="rejectNotes" rows="3"
                                          class="w-full px-3 py-2 border border-red-300 rounded-md focus:outline-none focus:ring-2 focus:ring-red-500"></textarea>
                            </div>

                            <button type="submit" class="w-full bg-red-500 hover:bg-red-600 text-white py-2 px-4 rounded-md transition">
                                <i class="fas fa-times mr-2"></i> Reject Registration
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </c:if>

        <c:if test="${empty registration}">
            <div class="bg-white rounded-lg shadow-md p-6 text-center">
                <div class="text-gray-500 mb-4">
                    <i class="fas fa-exclamation-circle text-4xl"></i>
                </div>
                <h2 class="text-xl font-semibold text-gray-800 mb-2">No Registration to Process</h2>
                <p class="text-gray-600 mb-4">The registration queue is currently empty or the requested registration was not found.</p>
                <a href="${pageContext.request.contextPath}/admin/registration-queue" class="inline-block bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md transition">
                    Return to Queue
                </a>
            </div>
        </c:if>
    </div>
</div>
</body>
</html>
