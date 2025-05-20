<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:48 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="bg-white shadow-inner mt-auto">
  <div class="container mx-auto px-4 py-6">
    <div class="flex flex-col md:flex-row justify-between items-center">
      <div class="mb-4 md:mb-0">
        <p class="text-gray-600 text-sm">
          &copy; 2025 Student Learning Management System. All rights reserved.
        </p>
      </div>
      <div class="flex space-x-4">
        <a href="${pageContext.request.contextPath}/about" class="text-gray-600 hover:text-gray-900 text-sm">About</a>
        <a href="${pageContext.request.contextPath}/contact" class="text-gray-600 hover:text-gray-900 text-sm">Contact</a>
        <a href="${pageContext.request.contextPath}/privacy" class="text-gray-600 hover:text-gray-900 text-sm">Privacy Policy</a>
        <a href="${pageContext.request.contextPath}/terms" class="text-gray-600 hover:text-gray-900 text-sm">Terms of Service</a>
      </div>
    </div>
  </div>
</footer>
