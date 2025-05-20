<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:42 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Make Payment - Student LMS</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">
<div class="min-h-screen flex flex-col">
    <!-- Header -->
    <header class="bg-blue-600 text-white shadow-md">
        <div class="container mx-auto px-4 py-4 flex justify-between items-center">
            <h1 class="text-2xl font-bold">Student LMS</h1>
            <div class="flex items-center space-x-4">
                <div class="relative group">
                    <button class="flex items-center space-x-1">
                        <span>${user.fullName}</span>
                        <i class="fas fa-chevron-down text-sm"></i>
                    </button>
                    <div class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-1 z-10 hidden group-hover:block">
                        <a href="${pageContext.request.contextPath}/user/dashboard" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">
                            <i class="fas fa-tachometer-alt mr-2"></i> Dashboard
                        </a>
                        <a href="${pageContext.request.contextPath}/user/profile" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">
                            <i class="fas fa-user-circle mr-2"></i> Profile
                        </a>
                        <a href="${pageContext.request.contextPath}/logout" class="block px-4 py-2 text-gray-800 hover:bg-gray-100">
                            <i class="fas fa-sign-out-alt mr-2"></i> Logout
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <div class="flex-grow container mx-auto px-4 py-8">
        <div class="flex justify-between items-center mb-6">
            <h1 class="text-3xl font-bold text-gray-800">Make Payment</h1>
            <a href="${pageContext.request.contextPath}/user/registrations/my-courses" class="bg-gray-500 hover:bg-gray-600 text-white py-2 px-4 rounded-md transition flex items-center">
                <i class="fas fa-arrow-left mr-2"></i> Back to My Courses
            </a>
        </div>

        <!-- Error Messages -->
        <c:if test="${not empty error}">
            <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4" role="alert">
                <p>${error}</p>
            </div>
        </c:if>

        <!-- Course Information -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <h2 class="text-xl font-semibold text-gray-800 mb-4">Course Information</h2>

            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                <div>
                    <p class="text-sm text-gray-500">Course Code</p>
                    <p class="text-gray-800 font-medium">${course.courseCode}</p>
                </div>
                <div>
                    <p class="text-sm text-gray-500">Course Name</p>
                    <p class="text-gray-800 font-medium">${course.courseName}</p>
                </div>
                <div>
                    <p class="text-sm text-gray-500">School</p>
                    <p class="text-gray-800 font-medium">${course.school}</p>
                </div>
                <div>
                    <p class="text-sm text-gray-500">Fee</p>
                    <p class="text-gray-800 font-medium">$${course.fee}</p>
                </div>
            </div>
        </div>

        <!-- Payment Form -->
        <div class="bg-white rounded-lg shadow-md p-6">
            <h2 class="text-xl font-semibold text-gray-800 mb-4">Payment Details</h2>

            <form action="${pageContext.request.contextPath}/user/payment" method="post" class="space-y-6">
                <input type="hidden" name="courseCode" value="${course.courseCode}">

                <!-- Payment Method Selection -->
                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-2">Select Payment Method</label>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <div>
                            <input type="radio" id="creditCard" name="paymentMethod" value="CREDIT_CARD" class="hidden peer" required>
                            <label for="creditCard" class="flex items-center justify-between p-4 border rounded-lg cursor-pointer peer-checked:border-blue-500 peer-checked:bg-blue-50 hover:bg-gray-50">
                                <div class="flex items-center">
                                    <i class="fas fa-credit-card text-gray-600 mr-3"></i>
                                    <div>
                                        <p class="font-medium text-gray-900">Credit Card</p>
                                        <p class="text-xs text-gray-500">Visa, Mastercard, Amex</p>
                                    </div>
                                </div>
                                <div class="w-5 h-5 border border-gray-300 rounded-full flex items-center justify-center peer-checked:border-blue-500 peer-checked:bg-blue-500">
                                    <div class="w-3 h-3 bg-white rounded-full hidden peer-checked:block"></div>
                                </div>
                            </label>
                        </div>
                        <div>
                            <input type="radio" id="bankTransfer" name="paymentMethod" value="BANK_TRANSFER" class="hidden peer">
                            <label for="bankTransfer" class="flex items-center justify-between p-4 border rounded-lg cursor-pointer peer-checked:border-blue-500 peer-checked:bg-blue-50 hover:bg-gray-50">
                                <div class="flex items-center">
                                    <i class="fas fa-university text-gray-600 mr-3"></i>
                                    <div>
                                        <p class="font-medium text-gray-900">Bank Transfer</p>
                                        <p class="text-xs text-gray-500">Direct bank transfer</p>
                                    </div>
                                </div>
                                <div class="w-5 h-5 border border-gray-300 rounded-full flex items-center justify-center peer-checked:border-blue-500 peer-checked:bg-blue-500">
                                    <div class="w-3 h-3 bg-white rounded-full hidden peer-checked:block"></div>
                                </div>
                            </label>
                        </div>
                        <div>
                            <input type="radio" id="other" name="paymentMethod" value="OTHER" class="hidden peer">
                            <label for="other" class="flex items-center justify-between p-4 border rounded-lg cursor-pointer peer-checked:border-blue-500 peer-checked:bg-blue-50 hover:bg-gray-50">
                                <div class="flex items-center">
                                    <i class="fas fa-money-bill-wave text-gray-600 mr-3"></i>
                                    <div>
                                        <p class="font-medium text-gray-900">Other</p>
                                        <p class="text-xs text-gray-500">Alternative payment methods</p>
                                    </div>
                                </div>
                                <div class="w-5 h-5 border border-gray-300 rounded-full flex items-center justify-center peer-checked:border-blue-500 peer-checked:bg-blue-500">
                                    <div class="w-3 h-3 bg-white rounded-full hidden peer-checked:block"></div>
                                </div>
                            </label>
                        </div>
                    </div>
                </div>

                <!-- Credit Card Details (shown/hidden based on selection) -->
                <div id="creditCardDetails" class="hidden space-y-4">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label for="cardName" class="block text-sm font-medium text-gray-700 mb-1">Name on Card</label>
                            <input type="text" id="cardName" name="cardName"
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="cardNumber" class="block text-sm font-medium text-gray-700 mb-1">Card Number</label>
                            <input type="text" id="cardNumber" name="cardNumber" placeholder="XXXX XXXX XXXX XXXX"
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="expiryDate" class="block text-sm font-medium text-gray-700 mb-1">Expiry Date</label>
                            <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YY"
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="cvv" class="block text-sm font-medium text-gray-700 mb-1">CVV</label>
                            <input type="text" id="cvv" name="cvv" placeholder="XXX"
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                    </div>
                </div>

                <!-- Bank Transfer Details -->
                <div id="bankTransferDetails" class="hidden">
                    <div class="bg-gray-50 p-4 rounded-md">
                        <h3 class="font-medium text-gray-800 mb-2">Bank Transfer Instructions</h3>
                        <p class="text-gray-600 mb-2">Please transfer the amount to the following bank account:</p>
                        <div class="space-y-1 text-sm text-gray-600">
                            <p><span class="font-medium">Bank Name:</span> National Bank</p>
                            <p><span class="font-medium">Account Name:</span> Student LMS</p>
                            <p><span class="font-medium">Account Number:</span> 1234567890</p>
                            <p><span class="font-medium">Branch Code:</span> 001</p>
                            <p><span class="font-medium">Reference:</span> ${user.registerNumber}-${course.courseCode}</p>
                        </div>
                        <p class="text-gray-600 mt-2">After making the transfer, please upload the proof of payment below.</p>
                    </div>
                    <div class="mt-4">
                        <label for="proofOfPayment" class="block text-sm font-medium text-gray-700 mb-1">Proof of Payment</label>
                        <input type="file" id="proofOfPayment" name="proofOfPayment"
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    </div>
                </div>

                <!-- Other Payment Method Details -->
                <div id="otherDetails" class="hidden">
                    <div class="bg-gray-50 p-4 rounded-md">
                        <h3 class="font-medium text-gray-800 mb-2">Other Payment Methods</h3>
                        <p class="text-gray-600 mb-2">Please contact the administration office for alternative payment arrangements:</p>
                        <div class="space-y-1 text-sm text-gray-600">
                            <p><span class="font-medium">Phone:</span> +1 234 567 890</p>
                            <p><span class="font-medium">Email:</span> payments@studentlms.com</p>
                            <p><span class="font-medium">Office Hours:</span> Monday to Friday, 9:00 AM - 5:00 PM</p>
                        </div>
                    </div>
                    <div class="mt-4">
                        <label for="paymentNotes" class="block text-sm font-medium text-gray-700 mb-1">Additional Notes</label>
                        <textarea id="paymentNotes" name="paymentNotes" rows="3"
                                  class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"></textarea>
                    </div>
                </div>

                <!-- Payment Summary -->
                <div class="bg-gray-50 p-4 rounded-md">
                    <h3 class="font-medium text-gray-800 mb-2">Payment Summary</h3>
                    <div class="flex justify-between py-2 border-b">
                        <span class="text-gray-600">Course Fee</span>
                        <span class="font-medium">$${course.fee}</span>
                    </div>
                    <div class="flex justify-between py-2 border-b">
                        <span class="text-gray-600">Processing Fee</span>
                        <span class="font-medium">$0.00</span>
                    </div>
                    <div class="flex justify-between py-2 font-bold text-lg">
                        <span>Total</span>
                        <span>$${course.fee}</span>
                    </div>
                </div>

                <div class="flex items-start">
                    <div class="flex items-center h-5">
                        <input id="terms" name="terms" type="checkbox" required
                               class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded">
                    </div>
                    <div class="ml-3 text-sm">
                        <label for="terms" class="font-medium text-gray-700">I agree to the payment terms and conditions</label>
                        <p class="text-gray-500">By proceeding with this payment, you agree to our <a href="#" class="text-blue-600 hover:text-blue-500">Payment Terms</a> and <a href="#" class="text-blue-600 hover:text-blue-500">Refund Policy</a>.</p>
                    </div>
                </div>

                <div>
                    <button type="submit" class="w-full bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md transition">
                        Complete Payment
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-white shadow-inner mt-auto">
        <div class="container mx-auto px-4 py-6">
            <p class="text-center text-gray-600 text-sm">
                &copy; 2025 Student Learning Management System. All rights reserved.
            </p>
        </div>
    </footer>
</div>

<script>
    // Show/hide payment method details based on selection
    document.addEventListener('DOMContentLoaded', function() {
        const creditCardRadio = document.getElementById('creditCard');
        const bankTransferRadio = document.getElementById('bankTransfer');
        const otherRadio = document.getElementById('other');

        const creditCardDetails = document.getElementById('creditCardDetails');
        const bankTransferDetails = document.getElementById('bankTransferDetails');
        const otherDetails = document.getElementById('otherDetails');

        function updatePaymentDetails() {
            creditCardDetails.classList.add('hidden');
            bankTransferDetails.classList.add('hidden');
            otherDetails.classList.add('hidden');

            if (creditCardRadio.checked) {
                creditCardDetails.classList.remove('hidden');
            } else if (bankTransferRadio.checked) {
                bankTransferDetails.classList.remove('hidden');
            } else if (otherRadio.checked) {
                otherDetails.classList.remove('hidden');
            }
        }

        creditCardRadio.addEventListener('change', updatePaymentDetails);
        bankTransferRadio.addEventListener('change', updatePaymentDetails);
        otherRadio.addEventListener('change', updatePaymentDetails);

        // Initialize
        updatePaymentDetails();
    });
</script>
</body>
</html>

