<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Learning Management System</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gray-100">
<div class="min-h-screen flex flex-col">
    <!-- Header -->
    <jsp:include page="WEB-INF/views/shared/header.jsp">
        <jsp:param name="pageTitle" value="Home" />
    </jsp:include>

    <!-- Hero Section -->
    <section class="bg-blue-600 text-white py-16">
        <div class="container mx-auto px-4">
            <div class="flex flex-col md:flex-row items-center">
                <div class="md:w-1/2 mb-8 md:mb-0">
                    <h1 class="text-4xl md:text-5xl font-bold mb-4">Advance Your Education with Our Courses</h1>
                    <p class="text-xl text-blue-100 mb-6">Discover a wide range of courses designed to help you achieve your academic and career goals.</p>
                    <div class="flex flex-wrap gap-4">
                        <a href="${pageContext.request.contextPath}/register" class="bg-white text-blue-600 hover:bg-blue-100 px-6 py-3 rounded-md font-medium transition">
                            Get Started
                        </a>
                        <a href="#courses" class="bg-transparent border border-white text-white hover:bg-white hover:text-blue-600 px-6 py-3 rounded-md font-medium transition">
                            Explore Courses
                        </a>
                    </div>
                </div>
                <div class="md:w-1/2">
                    <img src="${pageContext.request.contextPath}/assets/images/hero-image.svg" alt="Education Illustration" class="w-full">
                </div>
            </div>
        </div>
    </section>

    <!-- Featured Courses Section -->
    <section id="courses" class="py-16">
        <div class="container mx-auto px-4">
            <div class="text-center mb-12">
                <h2 class="text-3xl font-bold text-gray-800 mb-4">Featured Courses</h2>
                <p class="text-gray-600 max-w-2xl mx-auto">Explore our most popular courses and start your learning journey today.</p>
            </div>

            <!-- Course Grid -->
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                <c:forEach var="course" items="${featuredCourses}">
                    <div class="bg-white rounded-lg shadow-md overflow-hidden">
                        <div class="bg-blue-500 text-white p-4">
                            <h3 class="text-xl font-bold">${course.courseCode}</h3>
                        </div>
                        <div class="p-6">
                            <div class="mb-4">
                                <p class="text-gray-600 text-sm">School</p>
                                <p class="font-medium">${course.school}</p>
                            </div>
                            <div class="mb-4">
                                <p class="text-gray-600 text-sm">Duration</p>
                                <p class="font-medium">${course.duration}</p>
                            </div>
                            <div class="mb-4">
                                <p class="text-gray-600 text-sm">Fee</p>
                                <p class="font-medium">$${course.fee}</p>
                            </div>
                            <a href="${pageContext.request.contextPath}/login" class="block w-full bg-blue-500 hover:bg-blue-600 text-white text-center py-2 px-4 rounded-md transition">
                                View Details
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <c:if test="${empty featuredCourses}">
                <div class="bg-white rounded-lg shadow-md p-6 text-center">
                    <p class="text-gray-500">No courses found matching your criteria.</p>
                </div>
            </c:if>

            <div class="text-center mt-8">
                <a href="${pageContext.request.contextPath}/login" class="inline-block bg-blue-500 hover:bg-blue-600 text-white py-2 px-6 rounded-md transition">
                    View All Courses
                </a>
            </div>
        </div>
    </section>

    <!-- Why Choose Us Section -->
    <section class="py-16 bg-gray-50">
        <div class="container mx-auto px-4">
            <div class="text-center mb-12">
                <h2 class="text-3xl font-bold text-gray-800 mb-4">Why Choose Us</h2>
                <p class="text-gray-600 max-w-2xl mx-auto">We provide a comprehensive learning experience with numerous benefits for our students.</p>
            </div>

            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <div class="bg-white rounded-lg shadow-md p-6">
                    <div class="bg-blue-100 text-blue-600 w-12 h-12 rounded-full flex items-center justify-center mb-4">
                        <i class="fas fa-graduation-cap text-xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold text-gray-800 mb-2">Quality Education</h3>
                    <p class="text-gray-600">Our courses are designed by industry experts to provide you with the highest quality education.</p>
                </div>

                <div class="bg-white rounded-lg shadow-md p-6">
                    <div class="bg-green-100 text-green-600 w-12 h-12 rounded-full flex items-center justify-center mb-4">
                        <i class="fas fa-clock text-xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold text-gray-800 mb-2">Flexible Learning</h3>
                    <p class="text-gray-600">Learn at your own pace with our flexible course schedules and online learning options.</p>
                </div>

                <div class="bg-white rounded-lg shadow-md p-6">
                    <div class="bg-purple-100 text-purple-600 w-12 h-12 rounded-full flex items-center justify-center mb-4">
                        <i class="fas fa-users text-xl"></i>
                    </div>
                    <h3 class="text-xl font-semibold text-gray-800 mb-2">Supportive Community</h3>
                    <p class="text-gray-600">Join a community of learners and educators who are dedicated to helping you succeed.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <jsp:include page="WEB-INF/views/shared/footer.jsp" />
</div>
</body>
</html>
