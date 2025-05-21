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
  <title>${course.courseName} - Course Details</title>
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
      <a href="${pageContext.request.contextPath}/admin/courses" class="text-blue-500 hover:underline">
        <i class="fas fa-arrow-left mr-2"></i> Back to Courses
      </a>
    </div>

    <div class="bg-white rounded-lg shadow-md overflow-hidden">
      <!-- Course Header -->
      <div class="bg-blue-600 text-white p-6">
        <h1 class="text-3xl font-bold">${course.courseName}</h1>
        <p class="text-blue-100 mt-2">Course Code: ${course.courseCode}</p>
      </div>

      <!-- Course Details -->
      <div class="p-6">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
          <div class="bg-gray-50 p-4 rounded-lg">
            <h3 class="text-sm font-medium text-gray-500">Duration</h3>
            <p class="text-lg font-semibold text-gray-800">${course.duration}</p>
          </div>
          <div class="bg-gray-50 p-4 rounded-lg">
            <h3 class="text-sm font-medium text-gray-500">School</h3>
            <p class="text-lg font-semibold text-gray-800">${course.school}</p>
          </div>
          <div class="bg-gray-50 p-4 rounded-lg">
            <h3 class="text-sm font-medium text-gray-500">Fee</h3>
            <p class="text-lg font-semibold text-gray-800">₹${course.fee}</p>
          </div>
        </div>

        <div class="mb-6">
          <h2 class="text-xl font-semibold text-gray-800 mb-2">Description</h2>
          <p class="text-gray-600">${course.description}</p>
        </div>

        <div class="mb-6">
          <h2 class="text-xl font-semibold text-gray-800 mb-2">Prerequisites</h2>
          <p class="text-gray-600">${course.prerequisites}</p>
        </div>

        <div class="mb-6">
          <h2 class="text-xl font-semibold text-gray-800 mb-2">Learning Outcomes</h2>
          <p class="text-gray-600">${course.learningOutcomes}</p>
        </div>

        <!-- Enrollment Statistics -->
        <div class="mt-8 border-t pt-6">
          <h2 class="text-xl font-semibold text-gray-800 mb-4">Enrollment Statistics</h2>
          <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div class="bg-blue-50 p-4 rounded-lg">
              <h3 class="text-sm font-medium text-gray-500">Total Enrollments</h3>
              <p class="text-lg font-semibold text-gray-800">${enrollmentStats.total != null ? enrollmentStats.total : 0}</p>
            </div>
            <div class="bg-green-50 p-4 rounded-lg">
              <h3 class="text-sm font-medium text-gray-500">Completed</h3>
              <p class="text-lg font-semibold text-gray-800">${enrollmentStats.completed != null ? enrollmentStats.completed : 0}</p>
            </div>
            <div class="bg-yellow-50 p-4 rounded-lg">
              <h3 class="text-sm font-medium text-gray-500">In Progress</h3>
              <p class="text-lg font-semibold text-gray-800">${enrollmentStats.inProgress != null ? enrollmentStats.inProgress : 0}</p>
            </div>
          </div>
        </div>

        <!-- Enrolled Students -->
        <div class="mt-8 border-t pt-6">
          <h2 class="text-xl font-semibold text-gray-800 mb-4">Enrolled Students</h2>

          <c:choose>
            <c:when test="${not empty enrollments}">
              <div class="overflow-x-auto">
                <table class="min-w-full divide-y divide-gray-200">
                  <thead class="bg-gray-50">
                  <tr>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Student</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Registration Date</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                  </tr>
                  </thead>
                  <tbody class="bg-white divide-y divide-gray-200">
                  <c:forEach var="enrollment" items="${enrollments}">
                    <tr>
                      <td class="px-6 py-4 whitespace-nowrap">
                        <div class="flex items-center">
                          <div class="flex-shrink-0 h-10 w-10 bg-blue-100 rounded-full flex items-center justify-center">
                            <span class="text-blue-800 font-medium">${enrollment.studentName.charAt(0)}</span>
                          </div>
                          <div class="ml-4">
                            <div class="text-sm font-medium text-gray-900">${enrollment.studentName}</div>
                            <div class="text-sm text-gray-500">${enrollment.studentEmail}</div>
                          </div>
                        </div>
                      </td>
                      <td class="px-6 py-4 whitespace-nowrap">
                        <div class="text-sm text-gray-900">${enrollment.formattedDate}</div>
                      </td>
                      <td class="px-6 py-4 whitespace-nowrap">
                                                        <span class="px-2 py-1 inline-flex text-xs leading-5 font-semibold rounded-full
                                                            ${enrollment.status == 'COMPLETED' ? 'bg-green-100 text-green-800' :
                                                              enrollment.status == 'IN_PROGRESS' ? 'bg-yellow-100 text-yellow-800' :
                                                              'bg-gray-100 text-gray-800'}">
                                                            ${enrollment.status}
                                                        </span>
                      </td>
                      <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                        <a href="${pageContext.request.contextPath}/admin/students/view/${enrollment.studentEmail}" class="text-blue-600 hover:text-blue-900">
                          View Profile
                        </a>
                      </td>
                    </tr>
                  </c:forEach>
                  </tbody>
                </table>
              </div>
            </c:when>
            <c:otherwise>
              <p class="text-gray-500 text-center py-4">No students enrolled in this course yet.</p>
            </c:otherwise>
          </c:choose>
        </div>

        <!-- Edit Button -->
        <div class="mt-8 flex justify-end">
          <a href="${pageContext.request.contextPath}/admin/courses/edit/${course.courseCode}" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md">
            <i class="fas fa-edit mr-2"></i> Edit Course
          </a>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
