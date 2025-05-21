<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:20 AM
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
  <title>Payment Details - Admin Dashboard</title>
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
      <a href="${pageContext.request.contextPath}/admin/payments" class="text-blue-500 hover:underline">
        <i class="fas fa-arrow-left mr-2"></i> Back to Payments
      </a>
    </div>

    <div class="bg-white rounded-lg shadow-md overflow-hidden">
      <div class="bg-blue-600 text-white p-6">
        <h1 class="text-3xl font-bold">Payment Details</h1>
        <p class="text-blue-100 mt-2">Transaction ID: ${payment.transactionId}</p>
      </div>

      <div class="p-6">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
          <div>
            <h2 class="text-xl font-semibold text-gray-800 mb-4">Payment Information</h2>
            <div class="bg-gray-50 rounded-lg p-4">
              <div class="mb-4">
                <h3 class="text-sm font-medium text-gray-500">Transaction ID</h3>
                <p class="text-lg font-semibold text-gray-800">${payment.transactionId}</p>
              </div>
              <div class="mb-4">
                <h3 class="text-sm font-medium text-gray-500">Amount</h3>
                <p class="text-lg font-semibold text-gray-800">₹${payment.amount}</p>
              </div>
              <div class="mb-4">
                <h3 class="text-sm font-medium text-gray-500">Date</h3>
                <p class="text-lg font-semibold text-gray-800">
                  <fmt:formatDate value="${payment.date}" pattern="yyyy-MM-dd HH:mm:ss" />
                </p>
              </div>
              <div class="mb-4">
                <h3 class="text-sm font-medium text-gray-500">Status</h3>
                <span class="px-2 py-1 inline-flex text-xs leading-5 font-semibold rounded-full
                                        ${payment.status == 'COMPLETED' ? 'bg-green-100 text-green-800' :
                                          payment.status == 'PENDING' ? 'bg-yellow-100 text-yellow-800' :
                                          'bg-red-100 text-red-800'}">
                  ${payment.status}
                </span>
              </div>
              <div class="mb-4">
                <h3 class="text-sm font-medium text-gray-500">Description</h3>
                <p class="text-lg font-semibold text-gray-800">${payment.description}</p>
              </div>
            </div>
          </div>

          <div>
            <h2 class="text-xl font-semibold text-gray-800 mb-4">Student Information</h2>
            <div class="bg-gray-50 rounded-lg p-4">
              <div class="mb-4">
                <h3 class="text-sm font-medium text-gray-500">Email</h3>
                <p class="text-lg font-semibold text-gray-800">${payment.studentEmail}</p>
              </div>
            </div>
          </div>
        </div>

        <!-- Update Status Form -->
        <div class="mt-8 border-t pt-6">
          <h2 class="text-xl font-semibold text-gray-800 mb-4">Update Payment Status</h2>
          <form action="${pageContext.request.contextPath}/admin/payments" method="post" class="bg-gray-50 rounded-lg p-4">
            <input type="hidden" name="action" value="updateStatus">
            <input type="hidden" name="transactionId" value="${payment.transactionId}">

            <div class="mb-4">
              <label for="status" class="block text-sm font-medium text-gray-700 mb-1">Status</label>
              <select id="status" name="status" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                <option value="PENDING" ${payment.status == 'PENDING' ? 'selected' : ''}>Pending</option>
                <option value="COMPLETED" ${payment.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                <option value="FAILED" ${payment.status == 'FAILED' ? 'selected' : ''}>Failed</option>
              </select>
            </div>

            <div class="flex justify-end">
              <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md">
                <i class="fas fa-save mr-2"></i> Update Status
              </button>
            </div>
          </form>
        </div>

        <!-- Add Note Form -->
        <div class="mt-8 border-t pt-6">
          <h2 class="text-xl font-semibold text-gray-800 mb-4">Add Note</h2>
          <form action="${pageContext.request.contextPath}/admin/payments" method="post" class="bg-gray-50 rounded-lg p-4">
            <input type="hidden" name="action" value="addNote">
            <input type="hidden" name="transactionId" value="${payment.transactionId}">

            <div class="mb-4">
              <label for="note" class="block text-sm font-medium text-gray-700 mb-1">Note</label>
              <textarea id="note" name="note" rows="3" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"></textarea>
            </div>

            <div class="flex justify-end">
              <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md">
                <i class="fas fa-plus mr-2"></i> Add Note
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
