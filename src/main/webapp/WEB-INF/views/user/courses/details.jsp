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
    <jsp:include page="../../shared/user-sidebar.jsp" />

    <!-- Main Content -->
    <div class="flex-1 p-10">
        <div class="mb-6">
            <a href="${pageContext.request.contextPath}/user/courses" class="text-blue-500 hover:underline">
                <i class="fas fa-arrow-left mr-2"></i> Back to My Courses
            </a>
        </div>

        <!-- Success/Error Messages -->
        <c:if test="${not empty success}">
            <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-6" role="alert">
                <p>${success}</p>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-6" role="alert">
                <p>${error}</p>
            </div>
        </c:if>

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

                <!-- Registration Status (if applicable) -->
                <c:if test="${not empty registration}">
                    <div class="mt-8 border-t pt-6">
                        <h2 class="text-xl font-semibold text-gray-800 mb-4">Registration Status</h2>
                        <div class="bg-blue-50 p-4 rounded-lg">
                            <div class="mb-2">
                                <span class="text-sm text-gray-500">Registration Date:</span>
                                <span class="ml-2 font-medium">${registration.formattedDate}</span>
                            </div>
                            <div class="mb-2">
                                <span class="text-sm text-gray-500">Status:</span>
                                <span class="ml-2 font-medium">${registration.status}</span>
                            </div>
                        </div>
                    </div>
                </c:if>

                <!-- Queue Status (if applicable) -->
                <c:if test="${queuePosition > 0}">
                    <div class="mt-8 border-t pt-6">
                        <h2 class="text-xl font-semibold text-gray-800 mb-4">Queue Status</h2>
                        <div class="bg-yellow-50 p-4 rounded-lg">
                            <div class="mb-2">
                                <span class="text-sm text-gray-500">Queue Position:</span>
                                <span class="ml-2 font-medium">${queuePosition}</span>
                            </div>
                            <div class="mb-2">
                                <span class="text-sm text-gray-500">Request Date:</span>
                                <span class="ml-2 font-medium">${queueDate}</span>
                            </div>
                        </div>
                    </div>
                </c:if>

                <!-- Enroll Button (if not already enrolled) -->
                <c:if test="${empty registration && queuePosition <= 0}">
                    <div class="mt-8 flex justify-end">
                        <form action="${pageContext.request.contextPath}/user/course-registration" method="post">
                            <input type="hidden" name="courseCode" value="${course.courseCode}">
                            <button type="submit" class="bg-blue-500 hover:bg-blue-600 text-white py-2 px-4 rounded-md">
                                Enroll in this Course
                            </button>
                        </form>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>
</body>
</html>
