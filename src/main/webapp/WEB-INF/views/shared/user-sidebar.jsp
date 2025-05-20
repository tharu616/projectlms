<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:49 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="bg-white shadow-md w-64 flex-shrink-0 hidden md:block">
    <div class="p-6 border-b">
        <div class="flex items-center space-x-3">
            <div class="h-10 w-10 bg-blue-500 rounded-full flex items-center justify-center text-white">
                ${sessionScope.userName.charAt(0)}
            </div>
            <div>
                <p class="font-medium text-gray-800">${sessionScope.userName}</p>
                <p class="text-xs text-gray-500">${sessionScope.userRegisterNumber}</p>
            </div>
        </div>
    </div>

    <nav class="p-4">
        <a href="${pageContext.request.contextPath}/user/dashboard"
           class="${currentPage == 'dashboard' ? 'bg-blue-50 text-blue-700' : 'text-gray-700 hover:bg-gray-100'} flex items-center px-4 py-2 rounded-md transition mb-1">
            <i class="fas fa-tachometer-alt w-5 mr-3"></i>
            <span>Dashboard</span>
        </a>

        <a href="${pageContext.request.contextPath}/user/profile"
           class="${currentPage == 'profile' ? 'bg-blue-50 text-blue-700' : 'text-gray-700 hover:bg-gray-100'} flex items-center px-4 py-2 rounded-md transition mb-1">
            <i class="fas fa-user-circle w-5 mr-3"></i>
            <span>My Profile</span>
        </a>

        <div class="mt-4 mb-2 px-4 text-xs font-medium text-gray-500 uppercase tracking-wider">
            Courses
        </div>

        <a href="${pageContext.request.contextPath}/user/courses"
           class="${currentPage == 'courses' ? 'bg-blue-50 text-blue-700' : 'text-gray-700 hover:bg-gray-100'} flex items-center px-4 py-2 rounded-md transition mb-1">
            <i class="fas fa-book w-5 mr-3"></i>
            <span>Browse Courses</span>
        </a>

        <a href="${pageContext.request.contextPath}/user/registrations/my-courses"
           class="${currentPage == 'my-courses' ? 'bg-blue-50 text-blue-700' : 'text-gray-700 hover:bg-gray-100'} flex items-center px-4 py-2 rounded-md transition mb-1">
            <i class="fas fa-clipboard-list w-5 mr-3"></i>
            <span>My Courses</span>
        </a>

        <a href="${pageContext.request.contextPath}/user/registration-status"
           class="${currentPage == 'registration-status' ? 'bg-blue-50 text-blue-700' : 'text-gray-700 hover:bg-gray-100'} flex items-center px-4 py-2 rounded-md transition mb-1">
            <i class="fas fa-hourglass-half w-5 mr-3"></i>
            <span>Registration Status</span>
        </a>

        <div class="mt-4 mb-2 px-4 text-xs font-medium text-gray-500 uppercase tracking-wider">
            Payments
        </div>

        <a href="${pageContext.request.contextPath}/user/payment"
           class="${currentPage == 'payment' ? 'bg-blue-50 text-blue-700' : 'text-gray-700 hover:bg-gray-100'} flex items-center px-4 py-2 rounded-md transition mb-1">
            <i class="fas fa-credit-card w-5 mr-3"></i>
            <span>Make Payment</span>
        </a>

        <a href="${pageContext.request.contextPath}/user/payment/history"
           class="${currentPage == 'payment-history' ? 'bg-blue-50 text-blue-700' : 'text-gray-700 hover:bg-gray-100'} flex items-center px-4 py-2 rounded-md transition mb-1">
            <i class="fas fa-history w-5 mr-3"></i>
            <span>Payment History</span>
        </a>

        <div class="mt-4 mb-2 px-4 text-xs font-medium text-gray-500 uppercase tracking-wider">
            Other
        </div>

        <a href="${pageContext.request.contextPath}/user/announcements"
           class="${currentPage == 'announcements' ? 'bg-blue-50 text-blue-700' : 'text-gray-700 hover:bg-gray-100'} flex items-center px-4 py-2 rounded-md transition mb-1">
            <i class="fas fa-bullhorn w-5 mr-3"></i>
            <span>Announcements</span>
        </a>

        <a href="${pageContext.request.contextPath}/logout"
           class="text-gray-700 hover:bg-gray-100 flex items-center px-4 py-2 rounded-md transition mt-6">
            <i class="fas fa-sign-out-alt w-5 mr-3"></i>
            <span>Logout</span>
        </a>
    </nav>
</div>

