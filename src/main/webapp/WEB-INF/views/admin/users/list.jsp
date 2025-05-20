<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 1:49 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>User Management - Student LMS</title>
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
      <h1 class="text-3xl font-bold text-gray-800">User Management</h1>
      <a href="${pageContext.request.contextPath}/admin/users/create" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md transition flex items-center">
        <i class="fas fa-plus mr-2"></i> Add New User
      </a>
    </div>

    <!-- Success/Error Messages -->
    <c:if test="${param.created == 'true'}">
      <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-4" role="alert">
        <p>User created successfully!</p>
      </div>
    </c:if>
    <c:if test="${param.updated == 'true'}">
      <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-4" role="alert">
        <p>User updated successfully!</p>
      </div>
    </c:if>

    <!-- Search and Filter -->
    <div class="bg-white rounded-lg shadow-md p-6 mb-6">
      <form action="${pageContext.request.contextPath}/admin/users" method="get" class="flex flex-wrap gap-4">
        <div class="flex-1 min-w-[200px]">
          <label for="search" class="block text-sm font-medium text-gray-700 mb-1">Search</label>
          <input type="text" id="search" name="search" value="${param.search}" placeholder="Search by name, email, or NIC"
                 class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
        </div>
        <div class="w-40">
          <label for="filter" class="block text-sm font-medium text-gray-700 mb-1">Filter</label>
          <select id="filter" name="filter" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
            <option value="">All Users</option>
            <option value="recent" ${param.filter == 'recent' ? 'selected' : ''}>Recently Added</option>
            <option value="active" ${param.filter == 'active' ? 'selected' : ''}>Active Users</option>
          </select>
        </div>
        <div class="flex items-end">
          <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md transition">
            <i class="fas fa-search mr-2"></i> Search
          </button>
        </div>
      </form>
    </div>

    <!-- Users Table -->
    <div class="bg-white rounded-lg shadow-md overflow-hidden">
      <div class="overflow-x-auto">
        <table class="min-w-full divide-y divide-gray-200">
          <thead class="bg-gray-50">
          <tr>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Email</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Register Number</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Mobile</th>
            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
          </tr>
          </thead>
          <tbody class="bg-white divide-y divide-gray-200">
          <c:forEach var="user" items="${users}">
            <tr>
              <td class="px-6 py-4 whitespace-nowrap">
                <div class="flex items-center">
                  <div class="flex-shrink-0 h-10 w-10 bg-gray-200 rounded-full flex items-center justify-center">
                    <span class="text-gray-500 font-medium">${user.fullName.charAt(0)}</span>
                  </div>
                  <div class="ml-4">
                    <div class="text-sm font-medium text-gray-900">${user.fullName}</div>
                  </div>
                </div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <div class="text-sm text-gray-900">${user.email}</div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <div class="text-sm text-gray-900">${user.registerNumber}</div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap">
                <div class="text-sm text-gray-900">${user.mobileNumber}</div>
              </td>
              <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                <div class="flex space-x-2">
                  <a href="${pageContext.request.contextPath}/admin/users/view/${user.email}" class="text-blue-600 hover:text-blue-900">
                    <i class="fas fa-eye"></i>
                  </a>
                  <a href="${pageContext.request.contextPath}/admin/users/edit/${user.email}" class="text-indigo-600 hover:text-indigo-900">
                    <i class="fas fa-edit"></i>
                  </a>
                  <a href="#" onclick="confirmDelete('${user.email}', '${user.fullName}')" class="text-red-600 hover:text-red-900">
                    <i class="fas fa-trash"></i>
                  </a>
                </div>
              </td>
            </tr>
          </c:forEach>
          <c:if test="${empty users}">
            <tr>
              <td colspan="5" class="px-6 py-4 text-center text-gray-500">
                No users found
              </td>
            </tr>
          </c:if>
          </tbody>
        </table>
      </div>

      <!-- Pagination -->
      <div class="bg-white px-4 py-3 border-t border-gray-200 sm:px-6">
        <div class="flex items-center justify-between">
          <div class="flex-1 flex justify-between sm:hidden">
            <a href="#" class="relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
              Previous
            </a>
            <a href="#" class="ml-3 relative inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50">
              Next
            </a>
          </div>
          <div class="hidden sm:flex-1 sm:flex sm:items-center sm:justify-between">
            <div>
              <p class="text-sm text-gray-700">
                Showing <span class="font-medium">1</span> to <span class="font-medium">10</span> of <span class="font-medium">${users.size()}</span> results
              </p>
            </div>
            <div>
              <nav class="relative z-0 inline-flex rounded-md shadow-sm -space-x-px" aria-label="Pagination">
                <a href="#" class="relative inline-flex items-center px-2 py-2 rounded-l-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                  <span class="sr-only">Previous</span>
                  <i class="fas fa-chevron-left"></i>
                </a>
                <a href="#" aria-current="page" class="z-10 bg-blue-50 border-blue-500 text-blue-600 relative inline-flex items-center px-4 py-2 border text-sm font-medium">
                  1
                </a>
                <a href="#" class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium">
                  2
                </a>
                <a href="#" class="bg-white border-gray-300 text-gray-500 hover:bg-gray-50 relative inline-flex items-center px-4 py-2 border text-sm font-medium">
                  3
                </a>
                <a href="#" class="relative inline-flex items-center px-2 py-2 rounded-r-md border border-gray-300 bg-white text-sm font-medium text-gray-500 hover:bg-gray-50">
                  <span class="sr-only">Next</span>
                  <i class="fas fa-chevron-right"></i>
                </a>
              </nav>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="hidden fixed inset-0 bg-gray-500 bg-opacity-75 flex items-center justify-center">
  <div class="bg-white rounded-lg p-6 max-w-sm mx-auto">
    <h3 class="text-lg font-medium text-gray-900 mb-4">Confirm Deletion</h3>
    <p class="text-sm text-gray-500 mb-4">Are you sure you want to delete user <span id="userName" class="font-medium"></span>? This action cannot be undone.</p>
    <div class="flex justify-end space-x-3">
      <button onclick="closeModal()" class="px-4 py-2 bg-gray-200 text-gray-800 rounded-md hover:bg-gray-300 transition">
        Cancel
      </button>
      <a id="deleteLink" href="#" class="px-4 py-2 bg-red-500 text-white rounded-md hover:bg-red-600 transition">
        Delete
      </a>
    </div>
  </div>
</div>

<script>
  function confirmDelete(email, name) {
    document.getElementById('userName').textContent = name;
    document.getElementById('deleteLink').href = '${pageContext.request.contextPath}/admin/users/delete/' + email;
    document.getElementById('deleteModal').classList.remove('hidden');
  }

  function closeModal() {
    document.getElementById('deleteModal').classList.add('hidden');
  }
</script>
</body>
</html>

