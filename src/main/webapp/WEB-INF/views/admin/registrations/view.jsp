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
  <title>Registration Details - Admin Dashboard</title>
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
      <a href="${pageContext.request.contextPath}/admin/registrations" class="text-blue-500 hover:underline">
        <i class="fas fa-arrow-left mr-2"></i> Back to Registrations
      </a>
    </div>

    <div class="bg-white rounded-lg shadow-md overflow-hidden">
      <!-- Registration Header -->
      <div class="bg-blue-600 text-white p-6">
        <h1 class="text-3xl font-bold">Registration Details</h1>
        <p class="text-blue-100 mt-2">Student: ${registration.studentEmail}</p>
        <p class="text-blue-100 mt-1">Course: ${registration.courseCode} - ${registration.courseName}</p>
      </div>

      <!-- Registration Details -->
      <div class="p-6">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
          <div>
            <h2 class="text-xl font-semibold text-gray-800 mb-4">Student Information</h2>
            <div class="bg-gray-50 rounded-lg p-4">
              <div class="mb-4">
                <h3 class="text-sm font-medium text-gray-500">Full Name</h3>
                <p class="text-lg font-semibold text-gray-800">${registration.studentName}</p>
              </div>
              <div class="mb-4">
                <h3 class="text-sm font-medium text-gray-500">Email Address</h3>
                <p class="text-lg font-semibold text-gray-800">${registration.studentEmail}</p>
              </div>
            </div>
          </div>

          <div>
            <h2 class="text-xl font-semibold text-gray-800 mb-4">Course Information</h2>
            <div class="bg-gray-50 rounded-lg p-4">
              <div class="mb-4">
                <h3 class="text-sm font-medium text-gray-500">Course Code</h3>
                <p class="text-lg font-semibold text-gray-800">${registration.courseCode}</p>
              </div>
              <div class="mb-4">
                <h3 class="text-sm font-medium text-gray-500">Course Name</h3>
                <p class="text-lg font-semibold text-gray-800">${registration.courseName}</p>
              </div>
              <div class="mb-4">
                <h3 class="text-sm font-medium text-gray-500">School</h3>
                <p class="text-lg font-semibold text-gray-800">${registration.schoolName}</p>
              </div>
              <div class="mb-4">
                <h3 class="text-sm font-medium text-gray-500">Course Fee</h3>
                <p class="text-lg font-semibold text-gray-800">₹${registration.courseFee}</p>
              </div>
            </div>
          </div>
        </div>

        <div class="mb-6">
          <h2 class="text-xl font-semibold text-gray-800 mb-4">Registration Details</h2>
          <div class="bg-gray-50 rounded-lg p-4">
            <div class="mb-4">
              <h3 class="text-sm font-medium text-gray-500">Registration Date</h3>
              <p class="text-lg font-semibold text-gray-800">${registration.formattedDate}</p>
            </div>
            <div class="mb-4">
              <h3 class="text-sm font-medium text-gray-500">Status</h3>
              <span class="px-2 py-1 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                    Active
                                </span>
            </div>
          </div>
        </div>

        <!-- Action Buttons -->
        <div class="mt-8 flex justify-end space-x-4">
          <a href="#" onclick="confirmDelete('${registration.studentEmail}', '${registration.courseCode}', '${registration.studentName}')" class="bg-red-500 hover:bg-red-600 text-white py-2 px-4 rounded-md">
            <i class="fas fa-trash mr-2"></i> Delete Registration
          </a>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Delete Confirmation Modal -->
<div id="deleteModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden">
  <div class="bg-white rounded-lg p-8 max-w-md">
    <h2 class="text-xl font-bold mb-4">Confirm Deletion</h2>
    <p class="mb-6">Are you sure you want to delete the registration for <span id="studentToDelete" class="font-semibold"></span>? This action cannot be undone.</p>
    <div class="flex justify-end space-x-4">
      <button onclick="closeModal()" class="bg-gray-300 hover:bg-gray-400 text-gray-800 py-2 px-4 rounded">
        Cancel
      </button>
      <a id="deleteLink" href="#" class="bg-red-500 hover:bg-red-600 text-white py-2 px-4 rounded">
        Delete
      </a>
    </div>
  </div>
</div>

<script>
  function confirmDelete(email, courseCode, studentName) {
    document.getElementById('studentToDelete').textContent = studentName;
    document.getElementById('deleteLink').href = "${pageContext.request.contextPath}/admin/registrations/delete/" + email + "/" + courseCode;
    document.getElementById('deleteModal').classList.remove('hidden');
  }

  function closeModal() {
    document.getElementById('deleteModal').classList.add('hidden');
  }
</script>
</body>
</html>
