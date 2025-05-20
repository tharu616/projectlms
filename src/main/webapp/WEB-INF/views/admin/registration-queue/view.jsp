<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:13 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Registration Request - Student LMS</title>
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
            <h1 class="text-3xl font-bold text-gray-800">Registration Request Details</h1>
            <div class="flex space-x-2">
                <a href="${pageContext.request.contextPath}/admin/registration-queue/process/${queuePosition}" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md transition flex items-center">
                    <i class="fas fa-check-circle mr-2"></i> Process Request
                </a>
                <a href="${pageContext.request.contextPath}/admin/registration-queue" class="bg-gray-500 hover:bg-gray-600 text-white py-2 px-4 rounded-md transition flex items-center">
                    <i class="fas fa-arrow-left mr-2"></i> Back to Queue
                </a>
            </div>
        </div>

        <c:if test="${not empty registration}">
            <!-- Registration Details -->
            <div class="bg-white rounded-lg shadow-md overflow-hidden">
                <div class="bg-blue-500 text-white p-6">
                    <div class="flex items-center">
                        <div class="flex-shrink-0 h-24 w-24 bg-white rounded-full flex items-center justify-center text-blue-500 text-3xl font-bold">
                                ${registration.studentName.charAt(0)}
                        </div>
                        <div class="ml-6">
                            <h2 class="text-2xl font-bold">${registration.studentName}</h2>
                            <p class="text-blue-100">${registration.studentEmail}</p>
                            <p class="text-blue-100">Course: ${registration.courseCode} - ${registration.courseName}</p>
                        </div>
                    </div>
                </div>

                <div class="p-6">
                    <!-- Queue Information -->
                    <div class="mb-8">
                        <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Queue Information</h3>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-y-4">
                            <div>
                                <p class="text-sm text-gray-500">Queue Position</p>
                                <p class="text-gray-800">${queuePosition}</p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Request Time</p>
                                <p class="text-gray-800">
                                    <c:set var="date" value="${registration.timestamp}" />
                                    <c:set var="formattedDate" value="${date.toString()}" />
                                        ${formattedDate}
                                </p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Time in Queue</p>
                                <p class="text-gray-800">${timeInQueue}</p>
                            </div>
                        </div>
                    </div>

                    <!-- Student Information -->
                    <div class="mb-8">
                        <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Student Information</h3>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-y-4">
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
                    <div class="mb-8">
                        <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Course Information</h3>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-y-4">
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
                            <div>
                                <p class="text-sm text-gray-500">Course Details</p>
                                <a href="${pageContext.request.contextPath}/admin/courses/view/${registration.courseCode}" class="text-blue-500 hover:text-blue-700">
                                    View Course Details
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Additional Information -->
                    <div>
                        <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Additional Information</h3>
                        <div class="grid grid-cols-1 gap-y-4">
                            <div>
                                <p class="text-sm text-gray-500">Previous Registrations</p>
                                <c:if test="${not empty previousRegistrations}">
                                    <ul class="list-disc list-inside text-gray-800 mt-1">
                                        <c:forEach var="prevReg" items="${previousRegistrations}">
                                            <li>${prevReg.courseCode} - ${prevReg.courseName} (${prevReg.status})</li>
                                        </c:forEach>
                                    </ul>
                                </c:if>
                                <c:if test="${empty previousRegistrations}">
                                    <p class="text-gray-800">No previous registrations found for this student.</p>
                                </c:if>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Payment History</p>
                                <c:if test="${not empty paymentHistory}">
                                    <ul class="list-disc list-inside text-gray-800 mt-1">
                                        <c:forEach var="payment" items="${paymentHistory}">
                                            <li>${payment.transactionId} - ${payment.amount} (${payment.status})</li>
                                        </c:forEach>
                                    </ul>
                                </c:if>
                                <c:if test="${empty paymentHistory}">
                                    <p class="text-gray-800">No payment history found for this student.</p>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="mt-6 flex justify-end space-x-3">
                <form action="${pageContext.request.contextPath}/admin/registration-queue" method="post" class="inline-block">
                    <input type="hidden" name="action" value="rejectRegistration">
                    <input type="hidden" name="position" value="${queuePosition}">
                    <button type="submit" class="bg-red-500 hover:bg-red-600 text-white py-2 px-4 rounded-md transition">
                        <i class="fas fa-times mr-2"></i> Reject
                    </button>
                </form>
                <form action="${pageContext.request.contextPath}/admin/registration-queue" method="post" class="inline-block">
                    <input type="hidden" name="action" value="approveRegistration">
                    <input type="hidden" name="position" value="${queuePosition}">
                    <button type="submit" class="bg-green-500 hover:bg-green-600 text-white py-2 px-4 rounded-md transition">
                        <i class="fas fa-check mr-2"></i> Approve
                    </button>
                </form>
            </div>
        </c:if>

        <c:if test="${empty registration}">
            <div class="bg-white rounded-lg shadow-md p-6 text-center">
                <div class="text-gray-500 mb-4">
                    <i class="fas fa-exclamation-circle text-4xl"></i>
                </div>
                <h2 class="text-xl font-semibold text-gray-800 mb-2">Registration Not Found</h2>
                <p class="text-gray-600 mb-4">The requested registration could not be found in the queue.</p>
                <a href="${pageContext.request.contextPath}/admin/registration-queue" class="inline-block bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md transition">
                    Return to Queue
                </a>
            </div>
        </c:if>
    </div>
</div>
</body>
</html>

