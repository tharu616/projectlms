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
    <title>Edit Payment - Student LMS</title>
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
            <h1 class="text-3xl font-bold text-gray-800">Edit Payment</h1>
            <a href="${pageContext.request.contextPath}/admin/payments" class="bg-gray-500 hover:bg-gray-600 text-white py-2 px-4 rounded-md transition flex items-center">
                <i class="fas fa-arrow-left mr-2"></i> Back to Payments
            </a>
        </div>

        <!-- Error Messages -->
        <c:if test="${not empty error}">
            <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4" role="alert">
                <p>${error}</p>
            </div>
        </c:if>

        <!-- Payment Form -->
        <div class="bg-white rounded-lg shadow-md p-6">
            <form action="${pageContext.request.contextPath}/admin/payments" method="post" class="space-y-6">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="transactionId" value="${payment.transactionId}">

                <!-- Transaction Information -->
                <div>
                    <h2 class="text-xl font-semibold text-gray-800 mb-4">Transaction Information</h2>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label for="transactionId" class="block text-sm font-medium text-gray-700 mb-1">Transaction ID</label>
                            <input type="text" id="transactionId" value="${payment.transactionId}" readonly disabled
                                   class="w-full px-3 py-2 bg-gray-100 border border-gray-300 rounded-md">
                            <p class="text-xs text-gray-500 mt-1">Transaction ID cannot be changed</p>
                        </div>
                        <div>
                            <label for="paymentDate" class="block text-sm font-medium text-gray-700 mb-1">Payment Date</label>
                            <input type="text" id="paymentDate" value="${payment.formattedDate}" readonly disabled
                                   class="w-full px-3 py-2 bg-gray-100 border border-gray-300 rounded-md">
                            <p class="text-xs text-gray-500 mt-1">Payment date cannot be changed</p>
                        </div>
                    </div>
                </div>

                <!-- Student Information -->
                <div>
                    <h2 class="text-xl font-semibold text-gray-800 mb-4">Student Information</h2>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label for="studentEmail" class="block text-sm font-medium text-gray-700 mb-1">Student Email</label>
                            <input type="email" id="studentEmail" value="${payment.studentEmail}" readonly disabled
                                   class="w-full px-3 py-2 bg-gray-100 border border-gray-300 rounded-md">
                            <p class="text-xs text-gray-500 mt-1">Student email cannot be changed</p>
                        </div>
                        <div>
                            <label for="studentName" class="block text-sm font-medium text-gray-700 mb-1">Student Name</label>
                            <input type="text" id="studentName" value="${payment.studentName}" readonly disabled
                                   class="w-full px-3 py-2 bg-gray-100 border border-gray-300 rounded-md">
                            <p class="text-xs text-gray-500 mt-1">Student name cannot be changed</p>
                        </div>
                    </div>
                </div>

                <!-- Course Information -->
                <div>
                    <h2 class="text-xl font-semibold text-gray-800 mb-4">Course Information</h2>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label for="courseCode" class="block text-sm font-medium text-gray-700 mb-1">Course Code</label>
                            <input type="text" id="courseCode" value="${payment.courseCode}" readonly disabled
                                   class="w-full px-3 py-2 bg-gray-100 border border-gray-300 rounded-md">
                            <p class="text-xs text-gray-500 mt-1">Course code cannot be changed</p>
                        </div>
                        <div>
                            <label for="courseName" class="block text-sm font-medium text-gray-700 mb-1">Course Name</label>
                            <input type="text" id="courseName" value="${payment.courseName}" readonly disabled
                                   class="w-full px-3 py-2 bg-gray-100 border border-gray-300 rounded-md">
                            <p class="text-xs text-gray-500 mt-1">Course name cannot be changed</p>
                        </div>
                    </div>
                </div>

                <!-- Payment Details -->
                <div>
                    <h2 class="text-xl font-semibold text-gray-800 mb-4">Payment Details</h2>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <div>
                            <label for="amount" class="block text-sm font-medium text-gray-700 mb-1">Amount *</label>
                            <div class="relative">
                                <div class="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                                    <span class="text-gray-500">$</span>
                                </div>
                                <input type="number" step="0.01" id="amount" name="amount" value="${payment.amount}" required
                                       class="w-full pl-7 px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                            </div>
                        </div>
                        <div>
                            <label for="paymentMethod" class="block text-sm font-medium text-gray-700 mb-1">Payment Method *</label>
                            <select id="paymentMethod" name="paymentMethod" required
                                    class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="CREDIT_CARD" ${payment.paymentMethod == 'CREDIT_CARD' ? 'selected' : ''}>Credit Card</option>
                                <option value="DEBIT_CARD" ${payment.paymentMethod == 'DEBIT_CARD' ? 'selected' : ''}>Debit Card</option>
                                <option value="BANK_TRANSFER" ${payment.paymentMethod == 'BANK_TRANSFER' ? 'selected' : ''}>Bank Transfer</option>
                                <option value="CASH" ${payment.paymentMethod == 'CASH' ? 'selected' : ''}>Cash</option>
                                <option value="OTHER" ${payment.paymentMethod == 'OTHER' ? 'selected' : ''}>Other</option>
                            </select>
                        </div>
                        <div>
                            <label for="status" class="block text-sm font-medium text-gray-700 mb-1">Status *</label>
                            <select id="status" name="status" required
                                    class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                                <option value="PENDING" ${payment.status == 'PENDING' ? 'selected' : ''}>Pending</option>
                                <option value="COMPLETED" ${payment.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                                <option value="FAILED" ${payment.status == 'FAILED' ? 'selected' : ''}>Failed</option>
                            </select>
                        </div>
                        <div class="md:col-span-2">
                            <label for="description" class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                            <textarea id="description" name="description" rows="3"
                                      class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">${payment.description}</textarea>
                        </div>
                    </div>
                </div>

                <!-- Admin Notes -->
                <div>
                    <h2 class="text-xl font-semibold text-gray-800 mb-4">Admin Notes</h2>
                    <div>
                        <label for="notes" class="block text-sm font-medium text-gray-700 mb-1">Notes</label>
                        <textarea id="notes" name="notes" rows="3"
                                  class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">${payment.notes}</textarea>
                    </div>
                </div>

                <div class="flex justify-end space-x-3">
                    <a href="${pageContext.request.contextPath}/admin/payments" class="px-4 py-2 bg-gray-200 text-gray-800 rounded-md hover:bg-gray-300 transition">
                        Cancel
                    </a>
                    <button type="submit" class="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600 transition">
                        Update Payment
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
