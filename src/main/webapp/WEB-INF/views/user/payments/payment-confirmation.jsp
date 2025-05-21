<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/22/2025
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
    <title>Payment Confirmation - Student LMS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">
<div class="min-h-screen flex">
    <!-- Sidebar -->
    <jsp:include page="../../shared/user-sidebar.jsp" />

    <!-- Main Content -->
    <div class="flex-1 p-10">
        <div class="mb-6">
            <a href="${pageContext.request.contextPath}/user/dashboard" class="text-blue-500 hover:underline">
                <i class="fas fa-arrow-left mr-2"></i> Back to Dashboard
            </a>
        </div>

        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <div class="text-center mb-6">
                <div class="inline-flex items-center justify-center h-24 w-24 rounded-full bg-green-100 mb-4">
                    <i class="fas fa-check-circle text-5xl text-green-500"></i>
                </div>
                <h1 class="text-2xl font-bold text-gray-800">Payment Successful!</h1>
                <p class="text-gray-600">Your payment has been processed successfully.</p>
            </div>

            <div class="border-t border-b border-gray-200 py-6 mb-6">
                <h2 class="text-lg font-semibold text-gray-800 mb-4">Payment Details</h2>
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <p class="text-sm text-gray-500">Transaction ID</p>
                        <p class="font-medium">${payment.transactionId}</p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-500">Date</p>
                        <p class="font-medium">${paymentRecord.formattedDate}</p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-500">Payment Method</p>
                        <p class="font-medium">${payment.paymentMethod}</p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-500">Status</p>
                        <p class="font-medium text-green-600">Completed</p>
                    </div>
                </div>
            </div>

            <div class="mb-6">
                <h2 class="text-lg font-semibold text-gray-800 mb-4">Course Details</h2>
                <div class="grid grid-cols-2 gap-4">
                    <div>
                        <p class="text-sm text-gray-500">Course Code</p>
                        <p class="font-medium">${payment.courseCode}</p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-500">Course Name</p>
                        <p class="font-medium">${payment.courseName}</p>
                    </div>
                    <div>
                        <p class="text-sm text-gray-500">Amount Paid</p>
                        <p class="font-medium">₹${payment.courseFee}</p>
                    </div>
                </div>
            </div>

            <div class="text-center">
                <a href="${pageContext.request.contextPath}/user/courses" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md inline-block">
                    Go to My Courses
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
