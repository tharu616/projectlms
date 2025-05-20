<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:08 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Registration Details - Student LMS</title>
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
      <h1 class="text-3xl font-bold text-gray-800">Registration Details</h1>
      <div class="flex space-x-2">
        <a href="${pageContext.request.contextPath}/admin/registrations/edit/${registration.studentEmail}/${registration.courseCode}" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md transition flex items-center">
          <i class="fas fa-edit mr-2"></i> Edit Registration
        </a>
        <a href="${pageContext.request.contextPath}/admin/registrations" class="bg-gray-500 hover:bg-gray-600 text-white py-2 px-4 rounded-md transition flex items-center">
          <i class="fas fa-arrow-left mr-2"></i> Back to Registrations
        </a>
      </div>
    </div>

    <!-- Registration Details -->
    <div class="bg-white rounded-lg shadow-md overflow-hidden">
      <!-- Header -->
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

      <!-- Registration Information -->
      <div class="p-6">
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

        <!-- Registration Details -->
        <div class="mb-8">
          <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Registration Details</h3>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-y-4">
            <div>
              <p class="text-sm text-gray-500">Registration Date</p>
              <p class="text-gray-800">${registration.formattedDate}</p>
            </div>
            <div>
              <p class="text-sm text-gray-500">Status</p>
              <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full
                                    ${registration.status == 'PENDING' ? 'bg-yellow-100 text-yellow-800' :
                                      registration.status == 'APPROVED' ? 'bg-green-100 text-green-800' :
                                      registration.status == 'COMPLETED' ? 'bg-blue-100 text-blue-800' :
                                      'bg-gray-100 text-gray-800'}">
                ${registration.status}
              </span>
            </div>
            <div class="md:col-span-2">
              <p class="text-sm text-gray-500">Notes</p>
              <p class="text-gray-800">${registration.notes}</p>
            </div>
          </div>
        </div>

        <!-- Payment Information -->
        <div>
          <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Payment Information</h3>

          <c:if test="${not empty payment}">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-y-4">
              <div>
                <p class="text-sm text-gray-500">Payment ID</p>
                <p class="text-gray-800">${payment.transactionId}</p>
              </div>
              <div>
                <p class="text-sm text-gray-500">Payment Date</p>
                <p class="text-gray-800">${payment.formattedDate}</p>
              </div>
              <div>
                <p class="text-sm text-gray-500">Amount</p>
                <p class="text-gray-800">${payment.amount}</p>
              </div>
              <div>
                <p class="text-sm text-gray-500">Status</p>
                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full
                                        ${payment.status == 'PENDING' ? 'bg-yellow-100 text-yellow-800' :
                                          payment.status == 'COMPLETED' ? 'bg-green-100 text-green-800' :
                                          payment.status == 'FAILED' ? 'bg-red-100 text-red-800' :
                                          'bg-gray-100 text-gray-800'}">
                    ${payment.status}
                </span>
              </div>
              <div>
                <p class="text-sm text-gray-500">Payment Details</p>
                <a href="${pageContext.request.contextPath}/admin/payments/view/${payment.transactionId}" class="text-blue-500 hover:text-blue-700">
                  View Payment Details
                </a>
              </div>
            </div>
          </c:if>

          <c:if test="${empty payment}">
            <div class="bg-yellow-50 p-4 rounded-md">
              <div class="flex">
                <div class="flex-shrink-0">
                  <i class="fas fa-exclamation-circle text-yellow-400"></i>
                </div>
                <div class="ml-3">
                  <p class="text-sm text-yellow-700">
                    No payment record found for this registration.
                  </p>
                </div>
              </div>
            </div>
          </c:if>
        </div>
      </div>
    </div>

    <!-- Activity Log -->
    <div class="mt-8 bg-white rounded-lg shadow-md p-6">
      <h2 class="text-xl font-semibold text-gray-800 mb-4">Activity Log</h2>

      <c:if test="${not empty activityLogs}">
        <div class="space-y-4">
          <c:forEach var="log" items="${activityLogs}">
            <div class="border-l-4 border-blue-500 pl-4 py-2">
              <div class="flex justify-between">
                <p class="text-sm font-medium text-gray-800">${log.action}</p>
                <p class="text-xs text-gray-500">${log.formattedTimestamp}</p>
              </div>
              <p class="text-sm text-gray-600 mt-1">${log.description}</p>
              <p class="text-xs text-gray-500 mt-1">By: ${log.adminEmail}</p>
            </div>
          </c:forEach>
        </div>
      </c:if>

      <c:if test="${empty activityLogs}">
        <div class="bg-gray-50 p-4 rounded-md text-center">
          <p class="text-gray-500">No activity logs found for this registration.</p>
        </div>
      </c:if>
    </div>
  </div>
</div>
</body>
</html>
