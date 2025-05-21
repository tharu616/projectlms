<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Management - Admin Dashboard</title>
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
            <h1 class="text-3xl font-bold text-gray-800">Payment Management</h1>
            <a href="${pageContext.request.contextPath}/admin/payments/record-new" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md">
                <i class="fas fa-plus mr-2"></i> Record New Payment
            </a>
        </div>

        <!-- Stats Cards -->
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <!-- Total Revenue Card -->
            <div class="bg-white rounded-lg shadow-md p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-gray-500">Total Revenue</p>
                        <p class="text-2xl font-bold text-gray-800">₹${totalRevenue}</p>
                    </div>
                    <div class="bg-green-100 p-3 rounded-full">
                        <i class="fas fa-dollar-sign text-green-500"></i>
                    </div>
                </div>
            </div>

            <!-- Pending Payments Card -->
            <div class="bg-white rounded-lg shadow-md p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-gray-500">Pending Payments</p>
                        <p class="text-2xl font-bold text-gray-800">${pendingPayments}</p>
                    </div>
                    <div class="bg-yellow-100 p-3 rounded-full">
                        <i class="fas fa-clock text-yellow-500"></i>
                    </div>
                </div>
            </div>

            <!-- Completed Payments Card -->
            <div class="bg-white rounded-lg shadow-md p-6">
                <div class="flex items-center justify-between">
                    <div>
                        <p class="text-sm font-medium text-gray-500">Completed Payments</p>
                        <p class="text-2xl font-bold text-gray-800">${completedPayments}</p>
                    </div>
                    <div class="bg-blue-100 p-3 rounded-full">
                        <i class="fas fa-check-circle text-blue-500"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Search and Filter -->
        <div class="bg-white rounded-lg shadow-md p-6 mb-6">
            <div class="flex flex-wrap gap-4">
                <div class="flex-1">
                    <form action="${pageContext.request.contextPath}/admin/payments" method="get" class="flex gap-2">
                        <input type="text" name="search" placeholder="Search by transaction ID or student email"
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"
                               value="${param.search}">
                        <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md">
                            <i class="fas fa-search"></i>
                        </button>
                    </form>
                </div>
                <div>
                    <select id="statusFilter" onchange="filterByStatus(this.value)"
                            class="px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        <option value="">All Statuses</option>
                        <option value="PENDING" ${statusFilter == 'PENDING' ? 'selected' : ''}>Pending</option>
                        <option value="COMPLETED" ${statusFilter == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                        <option value="FAILED" ${statusFilter == 'FAILED' ? 'selected' : ''}>Failed</option>
                    </select>
                </div>
            </div>
        </div>

        <!-- Payment Listing -->
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                <tr>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Transaction ID</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Student</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Course</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Amount</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Date</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                <c:forEach var="payment" items="${payments}">
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">${payment.transactionId}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${payment.studentEmail}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${payment.description}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">₹${payment.amount}</td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">${payment.formattedDate}</td>
                        <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="px-2 py-1 inline-flex text-xs leading-5 font-semibold rounded-full
                                        ${payment.status == 'COMPLETED' ? 'bg-green-100 text-green-800' :
                                          payment.status == 'PENDING' ? 'bg-yellow-100 text-yellow-800' :
                                          'bg-red-100 text-red-800'}">
                                            ${payment.status}
                                    </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                            <a href="${pageContext.request.contextPath}/admin/payments/view/${payment.transactionId}" class="text-blue-600 hover:text-blue-900 mr-3">
                                <i class="fas fa-eye"></i>
                            </a>
                            <a href="#" onclick="showStatusModal('${payment.transactionId}', '${payment.status}')" class="text-indigo-600 hover:text-indigo-900">
                                <i class="fas fa-edit"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty payments}">
                    <tr>
                        <td colspan="7" class="px-6 py-4 text-center text-gray-500">No payments found</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Status Update Modal -->
<div id="statusModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden">
    <div class="bg-white rounded-lg p-8 max-w-md">
        <h2 class="text-xl font-bold mb-4">Update Payment Status</h2>
        <form id="updateStatusForm" action="${pageContext.request.contextPath}/admin/payments" method="post">
            <input type="hidden" name="action" value="updateStatus">
            <input type="hidden" id="transactionIdInput" name="transactionId" value="">

            <div class="mb-4">
                <label for="statusSelect" class="block text-sm font-medium text-gray-700 mb-1">Status</label>
                <select id="statusSelect" name="status" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                    <option value="PENDING">Pending</option>
                    <option value="COMPLETED">Completed</option>
                    <option value="FAILED">Failed</option>
                </select>
            </div>

            <div class="flex justify-end space-x-4">
                <button type="button" onclick="closeStatusModal()" class="bg-gray-300 hover:bg-gray-400 text-gray-800 py-2 px-4 rounded">
                    Cancel
                </button>
                <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded">
                    Update
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    function filterByStatus(status) {
        if (status === '') {
            window.location.href = '${pageContext.request.contextPath}/admin/payments';
        } else {
            window.location.href = '${pageContext.request.contextPath}/admin/payments/' + status.toLowerCase();
        }
    }

    function showStatusModal(transactionId, currentStatus) {
        document.getElementById('transactionIdInput').value = transactionId;
        document.getElementById('statusSelect').value = currentStatus;
        document.getElementById('statusModal').classList.remove('hidden');
    }

    function closeStatusModal() {
        document.getElementById('statusModal').classList.add('hidden');
    }
</script>
</body>
</html>
