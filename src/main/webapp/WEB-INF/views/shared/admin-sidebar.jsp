<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:48 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="bg-gray-800 text-white w-64 flex-shrink-0 hidden md:block">
  <div class="p-4">
    <div class="flex items-center space-x-2">
      <div class="h-8 w-8 bg-blue-500 rounded-full flex items-center justify-center">
        <i class="fas fa-user-shield"></i>
      </div>
      <div>
        <p class="font-medium">${sessionScope.adminName}</p>
        <p class="text-xs text-gray-400">Administrator</p>
      </div>
    </div>
  </div>

  <nav class="mt-4">
    <div class="px-4 py-2 text-xs text-gray-400 uppercase tracking-wider">
      Dashboard
    </div>
    <a href="${pageContext.request.contextPath}/admin/dashboard"
       class="${currentPage == 'dashboard' ? 'bg-gray-900 text-white' : 'text-gray-300 hover:bg-gray-700 hover:text-white'} flex items-center px-4 py-2 transition">
      <i class="fas fa-tachometer-alt w-5 mr-3"></i>
      <span>Dashboard</span>
    </a>

    <div class="px-4 py-2 text-xs text-gray-400 uppercase tracking-wider mt-4">
      User Management
    </div>
    <a href="${pageContext.request.contextPath}/admin/users"
       class="${currentPage == 'users' ? 'bg-gray-900 text-white' : 'text-gray-300 hover:bg-gray-700 hover:text-white'} flex items-center px-4 py-2 transition">
      <i class="fas fa-users w-5 mr-3"></i>
      <span>Users</span>
    </a>

    <div class="px-4 py-2 text-xs text-gray-400 uppercase tracking-wider mt-4">
      Course Management
    </div>
    <a href="${pageContext.request.contextPath}/admin/courses"
       class="${currentPage == 'courses' ? 'bg-gray-900 text-white' : 'text-gray-300 hover:bg-gray-700 hover:text-white'} flex items-center px-4 py-2 transition">
      <i class="fas fa-book w-5 mr-3"></i>
      <span>Courses</span>
    </a>

    <div class="px-4 py-2 text-xs text-gray-400 uppercase tracking-wider mt-4">
      Registration Management
    </div>
    <a href="${pageContext.request.contextPath}/admin/registrations"
       class="${currentPage == 'registrations' ? 'bg-gray-900 text-white' : 'text-gray-300 hover:bg-gray-700 hover:text-white'} flex items-center px-4 py-2 transition">
      <i class="fas fa-clipboard-list w-5 mr-3"></i>
      <span>Registrations</span>
    </a>
    <a href="${pageContext.request.contextPath}/admin/registration-queue"
       class="${currentPage == 'queue' ? 'bg-gray-900 text-white' : 'text-gray-300 hover:bg-gray-700 hover:text-white'} flex items-center px-4 py-2 transition">
      <i class="fas fa-list-check w-5 mr-3"></i>
      <span>Queue</span>
    </a>

    <div class="px-4 py-2 text-xs text-gray-400 uppercase tracking-wider mt-4">
      Finance
    </div>
    <a href="${pageContext.request.contextPath}/admin/payments"
       class="${currentPage == 'payments' ? 'bg-gray-900 text-white' : 'text-gray-300 hover:bg-gray-700 hover:text-white'} flex items-center px-4 py-2 transition">
      <i class="fas fa-credit-card w-5 mr-3"></i>
      <span>Payments</span>
    </a>

    <div class="px-4 py-2 text-xs text-gray-400 uppercase tracking-wider mt-4">
      Communication
    </div>
    <a href="${pageContext.request.contextPath}/admin/announcements"
       class="${currentPage == 'announcements' ? 'bg-gray-900 text-white' : 'text-gray-300 hover:bg-gray-700 hover:text-white'} flex items-center px-4 py-2 transition">
      <i class="fas fa-bullhorn w-5 mr-3"></i>
      <span>Announcements</span>
    </a>

    <div class="px-4 py-2 text-xs text-gray-400 uppercase tracking-wider mt-4">
      System
    </div>
    <a href="${pageContext.request.contextPath}/admin/settings"
       class="${currentPage == 'settings' ? 'bg-gray-900 text-white' : 'text-gray-300 hover:bg-gray-700 hover:text-white'} flex items-center px-4 py-2 transition">
      <i class="fas fa-cog w-5 mr-3"></i>
      <span>Settings</span>
    </a>
    <a href="${pageContext.request.contextPath}/logout"
       class="text-gray-300 hover:bg-gray-700 hover:text-white flex items-center px-4 py-2 transition">
      <i class="fas fa-sign-out-alt w-5 mr-3"></i>
      <span>Logout</span>
    </a>
  </nav>
</div>

