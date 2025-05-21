<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/22/2025
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
    <title>Make Payment - Student LMS</title>
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
            <a href="${pageContext.request.contextPath}/courses" class="text-blue-500 hover:underline">
                <i class="fas fa-arrow-left mr-2"></i> Back to Courses
            </a>
        </div>

        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <h1 class="text-2xl font-bold text-gray-800 mb-4">Course Payment</h1>

            <!-- Course Details -->
            <div class="grid grid-cols-2 gap-4 mb-6">
                <div>
                    <p class="text-sm text-gray-500">Course Code</p>
                    <p class="font-medium">${courseCode}</p>
                </div>
                <div>
                    <p class="text-sm text-gray-500">Course Name</p>
                    <p class="font-medium">${courseName}</p>
                </div>
                <div>
                    <p class="text-sm text-gray-500">School</p>
                    <p class="font-medium">${schoolName}</p>
                </div>
                <div>
                    <p class="text-sm text-gray-500">Fee</p>
                    <p class="font-medium">₹${courseFee}</p>
                </div>
            </div>
        </div>

        <div class="bg-white rounded-lg shadow-md p-6">
            <h2 class="text-xl font-bold text-gray-800 mb-4">Payment Details</h2>

            <form action="${pageContext.request.contextPath}/user/payment" method="post">
                <!-- Payment Method Selection -->
                <div class="mb-6">
                    <label class="block text-sm font-medium text-gray-700 mb-2">Select Payment Method</label>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <div class="relative">
                            <input type="radio" id="creditCard" name="paymentMethod" value="CREDIT_CARD" class="hidden peer" checked>
                            <label for="creditCard" class="block p-4 border rounded-lg peer-checked:border-blue-500 peer-checked:bg-blue-50 cursor-pointer">
                                <div class="flex items-center">
                                    <i class="fas fa-credit-card text-gray-500 mr-3"></i>
                                    <div>
                                        <p class="font-medium">Credit Card</p>
                                        <p class="text-xs text-gray-500">Visa, Mastercard, Amex</p>
                                    </div>
                                </div>
                            </label>
                        </div>

                        <div class="relative">
                            <input type="radio" id="bankTransfer" name="paymentMethod" value="BANK_TRANSFER" class="hidden peer">
                            <label for="bankTransfer" class="block p-4 border rounded-lg peer-checked:border-blue-500 peer-checked:bg-blue-50 cursor-pointer">
                                <div class="flex items-center">
                                    <i class="fas fa-university text-gray-500 mr-3"></i>
                                    <div>
                                        <p class="font-medium">Bank Transfer</p>
                                        <p class="text-xs text-gray-500">Direct bank transfer</p>
                                    </div>
                                </div>
                            </label>
                        </div>

                        <div class="relative">
                            <input type="radio" id="other" name="paymentMethod" value="OTHER" class="hidden peer">
                            <label for="other" class="block p-4 border rounded-lg peer-checked:border-blue-500 peer-checked:bg-blue-50 cursor-pointer">
                                <div class="flex items-center">
                                    <i class="fas fa-money-bill text-gray-500 mr-3"></i>
                                    <div>
                                        <p class="font-medium">Other</p>
                                        <p class="text-xs text-gray-500">Alternative payment methods</p>
                                    </div>
                                </div>
                            </label>
                        </div>
                    </div>
                </div>

                <!-- Credit Card Details (show only when credit card is selected) -->
                <div id="creditCardDetails" class="mb-6">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 mb-4">
                        <div>
                            <label for="cardName" class="block text-sm font-medium text-gray-700 mb-1">Name on Card</label>
                            <input type="text" id="cardName" name="cardName" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="cardNumber" class="block text-sm font-medium text-gray-700 mb-1">Card Number</label>
                            <input type="text" id="cardNumber" name="cardNumber" placeholder="XXXX XXXX XXXX XXXX" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                    </div>

                    <div class="grid grid-cols-2 md:grid-cols-3 gap-4">
                        <div>
                            <label for="expiryDate" class="block text-sm font-medium text-gray-700 mb-1">Expiry Date</label>
                            <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YY" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div>
                            <label for="cvv" class="block text-sm font-medium text-gray-700 mb-1">CVV</label>
                            <input type="text" id="cvv" name="cvv" placeholder="XXX" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                    </div>
                </div>

                <!-- Payment Summary -->
                <div class="mb-6 bg-gray-50 p-4 rounded-lg">
                    <h3 class="font-medium text-gray-800 mb-2">Payment Summary</h3>
                    <div class="flex justify-between mb-2">
                        <span>Course Fee</span>
                        <span>₹${courseFee}</span>
                    </div>
                    <div class="flex justify-between mb-2">
                        <span>Processing Fee</span>
                        <span>₹0.00</span>
                    </div>
                    <div class="flex justify-between font-bold border-t pt-2 mt-2">
                        <span>Total</span>
                        <span>₹${courseFee}</span>
                    </div>
                </div>

                <!-- Terms and Conditions -->
                <div class="mb-6">
                    <div class="flex items-start">
                        <div class="flex items-center h-5">
                            <input id="terms" name="terms" type="checkbox" required class="focus:ring-blue-500 h-4 w-4 text-blue-600 border-gray-300 rounded">
                        </div>
                        <div class="ml-3 text-sm">
                            <label for="terms" class="font-medium text-gray-700">I agree to the payment terms and conditions</label>
                            <p class="text-gray-500">By proceeding with this payment, you agree to our Payment Terms and Refund Policy.</p>
                        </div>
                    </div>
                </div>

                <!-- Submit Button -->
                <div class="flex justify-end">
                    <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md">
                        Complete Payment
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    // Show/hide credit card details based on payment method selection
    document.addEventListener('DOMContentLoaded', function() {
        const creditCardRadio = document.getElementById('creditCard');
        const bankTransferRadio = document.getElementById('bankTransfer');
        const otherRadio = document.getElementById('other');
        const creditCardDetails = document.getElementById('creditCardDetails');

        function toggleCreditCardDetails() {
            if (creditCardRadio.checked) {
                creditCardDetails.style.display = 'block';
            } else {
                creditCardDetails.style.display = 'none';
            }
        }

        creditCardRadio.addEventListener('change', toggleCreditCardDetails);
        bankTransferRadio.addEventListener('change', toggleCreditCardDetails);
        otherRadio.addEventListener('change', toggleCreditCardDetails);

        // Initial check
        toggleCreditCardDetails();
    });
</script>
</body>
</html>
