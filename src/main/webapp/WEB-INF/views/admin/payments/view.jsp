<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:20 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Payment Details - Student LMS</title>
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
      <h1 class="text-3xl font-bold text-gray-800">Payment Details</h1>
      <div class="flex space-x-2">
        <a href="${pageContext.request.contextPath}/admin/payments/edit/${payment.transactionId}" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md transition flex items-center">
          <i class="fas fa-edit mr-2"></i> Edit Payment
        </a>
        <a href="${pageContext.request.contextPath}/admin/payments" class="bg-gray-500 hover:bg-gray-600 text-white py-2 px-4 rounded-md transition flex items-center">
          <i class="fas fa-arrow-left mr-2"></i> Back to Payments
        </a>
      </div>
    </div>

    <!-- Payment Details -->
    <div class="bg-white rounded-lg shadow-md overflow-hidden">
      <!-- Header -->
      <div class="bg-blue-500 text-white p-6">
        <div class="flex items-center">
          <div class="flex-shrink-0 h-24 w-24 bg-white rounded-full flex items-center justify-center text-blue-500 text-3xl font-bold">
            <i class="fas fa-receipt"></i>
          </div>
          <div class="ml-6">
            <h2 class="text-2xl font-bold">Transaction ID: ${payment.transactionId}</h2>
            <p class="text-blue-100">Amount: $${payment.amount}</p>
            <p class="text-blue-100">Status: ${payment.status}</p>
          </div>
        </div>
      </div>

      <!-- Payment Information -->
      <div class="p-6">
        <!-- Transaction Details -->
        <div class="mb-8">
          <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Transaction Details</h3>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-y-4">
            <div>
              <p class="text-sm text-gray-500">Transaction ID</p>
              <p class="text-gray-800">${payment.transactionId}</p>
            </div>
            <div>
              <p class="text-sm text-gray-500">Payment Date</p>
              <p class="text-gray-800">${payment.formattedDate}</p>
            </div>
            <div>
              <p class="text-sm text-gray-500">Amount</p>
              <p class="text-gray-800">$${payment.amount}</p>
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
              <p class="text-sm text-gray-500">Payment Method</p>
              <p class="text-gray-800">${payment.paymentMethod}</p>
            </div>
          </div>
        </div>

        <!-- Student Information -->
        <div class="mb-8">
          <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Student Information</h3>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-y-4">
            <div>
              <p class="text-sm text-gray-500">Student Name</p>
              <p class="text-gray-800">${payment.studentName}</p>
            </div>
            <div>
              <p class="text-sm text-gray-500">Student Email</p>
              <p class="text-gray-800">${payment.studentEmail}</p>
            </div>
            <div>
              <p class="text-sm text-gray-500">Student Profile</p>
              <a href="${pageContext.request.contextPath}/admin/users/view/${payment.studentEmail}" class="text-blue-500 hover:text-blue-700">
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
              <p class="text-gray-800">${payment.courseCode}</p>
            </div>
            <div>
              <p class="text-sm text-gray-500">Course Name</p>
              <p class="text-gray-800">${payment.courseName}</p>
            </div>
            <div>
              <p class="text-sm text-gray-500">Course Details</p>
              <a href="${pageContext.request.contextPath}/admin/courses/view/${payment.courseCode}" class="text-blue-500 hover:text-blue-700">
                View Course Details
              </a>
            </div>
            <div>
              <p class="text-sm text-gray-500">Registration</p>
              <a href="${pageContext.request.contextPath}/admin/registrations/view/${payment.studentEmail}/${payment.courseCode}" class="text-blue-500 hover:text-blue-700">
                View Registration
              </a>
            </div>
          </div>
        </div>

        <!-- Additional Information -->
        <div>
          <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Additional Information</h3>
          <div class="grid grid-cols-1 gap-y-4">
            <div>
              <p class="text-sm text-gray-500">Description</p>
              <p class="text-gray-800">${payment.description}</p>
            </div>
            <div>
              <p class="text-sm text-gray-500">Admin Notes</p>
              <p class="text-gray-800">${payment.notes}</p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Payment History -->
    <div class="mt-8 bg-white rounded-lg shadow-md p-6">
      <h2 class="text-xl font-semibold text-gray-800 mb-4">Payment History</h2>

      <c:if test="${not empty paymentHistory}">
        <div class="space-y-4">
          <c:forEach var="history" items="${paymentHistory}">
            <div class="border-l-4
                                ${history.action == 'CREATED' ? 'border-blue-500' :
                                  history.action == 'UPDATED' ? 'border-yellow-500' :
                                  history.action == 'COMPLETED' ? 'border-green-500' :
                                  history.action == 'FAILED' ? 'border-red-500' :
                                  'border-gray-500'}
                                pl-4 py-2">
              <div class="flex justify-between">
                <p class="text-sm font-medium text-gray-800">${history.action}</p>
                <p class="text-xs text-gray-500">${history.formattedTimestamp}</p>
              </div>
              <p class="text-sm text-gray-600 mt-1">${history.description}</p>
              <p class="text-xs text-gray-500 mt-1">By: ${history.adminEmail}</p>
            </div>
          </c:forEach>
        </div>
      </c:if>

      <c:if test="${empty paymentHistory}">
        <div class="bg-gray-50 p-4 rounded-md text-center">
          <p class="text-gray-500">No payment history available.</p>
        </div>
      </c:if>
    </div>
  </div>
</div>
</body>
</html>

