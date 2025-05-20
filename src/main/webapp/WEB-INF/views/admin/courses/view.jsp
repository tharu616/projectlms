<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:03 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Course Details - Student LMS</title>
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
      <h1 class="text-3xl font-bold text-gray-800">Course Details</h1>
      <div class="flex space-x-2">
        <a href="${pageContext.request.contextPath}/admin/courses/edit/${course.courseCode}" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md transition flex items-center">
          <i class="fas fa-edit mr-2"></i> Edit Course
        </a>
        <a href="${pageContext.request.contextPath}/admin/courses" class="bg-gray-500 hover:bg-gray-600 text-white py-2 px-4 rounded-md transition flex items-center">
          <i class="fas fa-arrow-left mr-2"></i> Back to Courses
        </a>
      </div>
    </div>

    <!-- Course Profile -->
    <div class="bg-white rounded-lg shadow-md overflow-hidden">
      <!-- Header -->
      <div class="bg-blue-500 text-white p-6">
        <div class="flex items-center">
          <div class="flex-shrink-0 h-24 w-24 bg-white rounded-full flex items-center justify-center text-blue-500 text-3xl font-bold">
            ${course.courseCode.charAt(0)}
          </div>
          <div class="ml-6">
            <h2 class="text-2xl font-bold">${course.courseCode}</h2>
            <p class="text-blue-100">Duration: ${course.duration}</p>
            <p class="text-blue-100">School: ${course.school}</p>
          </div>
        </div>
      </div>

      <!-- Course Information -->
      <div class="p-6">
        <!-- Basic Information -->
        <div class="mb-8">
          <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Basic Information</h3>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-y-4">
            <div>
              <p class="text-sm text-gray-500">Course Code</p>
              <p class="text-gray-800">${course.courseCode}</p>
            </div>
            <div>
              <p class="text-sm text-gray-500">Duration</p>
              <p class="text-gray-800">${course.duration}</p>
            </div>
            <div>
              <p class="text-sm text-gray-500">School</p>
              <p class="text-gray-800">${course.school}</p>
            </div>
            <div>
              <p class="text-sm text-gray-500">Fee</p>
              <p class="text-gray-800">${course.fee}</p>
            </div>
          </div>
        </div>

        <!-- Course Details -->
        <div class="mb-8">
          <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Course Details</h3>

          <div class="mb-4">
            <p class="text-sm text-gray-500">Description</p>
            <p class="text-gray-800 mt-1">${course.description}</p>
          </div>

          <div class="mb-4">
            <p class="text-sm text-gray-500">Prerequisites</p>
            <p class="text-gray-800 mt-1">${course.prerequisites}</p>
          </div>

          <div>
            <p class="text-sm text-gray-500">Learning Objectives</p>
            <p class="text-gray-800 mt-1">${course.objectives}</p>
          </div>
        </div>

        <!-- Enrollment Statistics -->
        <div>
          <h3 class="text-lg font-semibold text-gray-800 mb-4 border-b pb-2">Enrollment Statistics</h3>
          <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
            <div class="bg-blue-50 p-4 rounded-lg">
              <p class="text-sm text-gray-500">Total Enrollments</p>
              <p class="text-2xl font-bold text-blue-600">${enrollmentStats.total}</p>
            </div>
            <div class="bg-green-50 p-4 rounded-lg">
              <p class="text-sm text-gray-500">Completed</p>
              <p class="text-2xl font-bold text-green-600">${enrollmentStats.completed}</p>
            </div>
            <div class="bg-yellow-50 p-4 rounded-lg">
              <p class="text-sm text-gray-500">In Progress</p>
              <p class="text-2xl font-bold text-yellow-600">${enrollmentStats.inProgress}</p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Enrolled Students -->
    <div class="mt-8 bg-white rounded-lg shadow-md p-6">
      <h2 class="text-xl font-semibold text-gray-800 mb-4">Enrolled Students</h2>

      <c:if test="${not empty enrolledStudents}">
        <div class="overflow-x-auto">
          <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-50">
            <tr>
              <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Student</th>
              <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Email</th>
              <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Registration Date</th>
              <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
              <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
            </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
            <c:forEach var="enrollment" items="${enrolledStudents}">
              <tr>
                <td class="px-6 py-4 whitespace-nowrap">
                  <div class="flex items-center">
                    <div class="flex-shrink-0 h-10 w-10 bg-gray-200 rounded-full flex items-center justify-center">
                      <span class="text-gray-500 font-medium">${enrollment.studentName.charAt(0)}</span>
                    </div>
                    <div class="ml-4">
                      <div class="text-sm font-medium text-gray-900">${enrollment.studentName}</div>
                    </div>
                  </div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                  <div class="text-sm text-gray-900">${enrollment.studentEmail}</div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                  <div class="text-sm text-gray-900">${enrollment.formattedDate}</div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                                ${enrollment.status}
                                            </span>
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                  <a href="${pageContext.request.contextPath}/admin/users/view/${enrollment.studentEmail}" class="text-blue-600 hover:text-blue-900">
                    View Profile
                  </a>
                </td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </div>
      </c:if>

      <c:if test="${empty enrolledStudents}">
        <div class="bg-gray-50 p-4 rounded-md text-center">
          <p class="text-gray-500">No students enrolled in this course yet.</p>
        </div>
      </c:if>
    </div>
  </div>
</div>
</body>
</html>
