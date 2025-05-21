<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:06 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Registrations - Admin Dashboard</title>
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
            <h1 class="text-3xl font-bold text-gray-800">Course Registrations</h1>
            <a href="${pageContext.request.contextPath}/admin/registrations/create" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md">
                <i class="fas fa-plus mr-2"></i> Add New Registration
            </a>
        </div>

        <!-- Success Messages -->
        <c:if test="${param.created == 'true'}">
            <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-6" role="alert">
                <p>Registration created successfully!</p>
            </div>
        </c:if>

        <c:if test="${param.deleted == 'true'}">
            <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-6" role="alert">
                <p>Registration deleted successfully!</p>
            </div>
        </c:if>

        <!-- Registration Listing -->
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                <tr>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Student</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Course</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">School</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Registration Date</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                <c:forEach var="registration" items="${registrations}">
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <div class="flex items-center">
                                <div class="flex-shrink-0 h-10 w-10 bg-blue-100 rounded-full flex items-center justify-center">
                                    <span class="text-blue-800 font-medium">${registration.studentName.charAt(0)}</span>
                                </div>
                                <div class="ml-4">
                                    <div class="text-sm font-medium text-gray-900">${registration.studentName}</div>
                                    <div class="text-sm text-gray-500">${registration.studentEmail}</div>
                                </div>
                            </div>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <div class="text-sm font-medium text-gray-900">${registration.courseCode}</div>
                            <div class="text-sm text-gray-500">${registration.courseName}</div>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <div class="text-sm text-gray-900">${registration.schoolName}</div>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <div class="text-sm text-gray-900">${registration.formattedDate}</div>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="px-2 py-1 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                        Active
                                    </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                            <a href="${pageContext.request.contextPath}/admin/registrations/view/${registration.studentEmail}/${registration.courseCode}" class="text-blue-600 hover:text-blue-900 mr-3">
                                <i class="fas fa-eye"></i>
                            </a>
                            <a href="#" onclick="confirmDelete('${registration.studentEmail}', '${registration.courseCode}', '${registration.studentName}')" class="text-red-600 hover:text-red-900">
                                <i class="fas fa-trash"></i>
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty registrations}">
                    <tr>
                        <td colspan="6" class="px-6 py-4 text-center text-gray-500">No registrations found</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
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
