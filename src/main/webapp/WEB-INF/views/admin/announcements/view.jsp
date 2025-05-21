<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:25 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Announcement Details</title>
    <link rel="stylesheet" href="https://cdn.tailwindcss.com">
</head>
<body class="bg-gray-100">
<div class="min-h-screen flex flex-col items-center justify-center">
    <div class="bg-white rounded-lg shadow-md p-8 max-w-xl w-full mt-10">
        <h1 class="text-2xl font-bold mb-4">${announcement.title}</h1>
        <div class="mb-2"><strong>Status:</strong> ${announcement.active ? 'Active' : 'Inactive'}</div>
        <div class="mb-2"><strong>Published by:</strong> ${announcement.publishedBy}</div>
        <div class="mb-2"><strong>Content:</strong> ${announcement.content}</div>
        <div class="mb-2"><strong>Publish Date:</strong> ${announcement.formattedPublishDate}</div>
        <div class="mb-2"><strong>Expiry Date:</strong> ${announcement.formattedExpiryDate}</div>
        <c:if test="${not empty announcement.targetAudience}">
            <div class="mb-2"><strong>Target Audience:</strong> ${announcement.targetAudience}</div>
        </c:if>
        <c:if test="${not empty announcement.formattedCreateDate}">
            <div class="mb-2"><strong>Created On:</strong> ${announcement.formattedCreateDate}</div>
        </c:if>
        <c:if test="${not empty announcement.formattedLastModified}">
            <div class="mb-2"><strong>Last Modified:</strong> ${announcement.formattedLastModified}</div>
        </c:if>
        <div class="mt-6 flex space-x-4">
            <a href="${pageContext.request.contextPath}/admin/announcements/edit/${announcement.id}" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Edit</a>
            <a href="${pageContext.request.contextPath}/admin/announcements" class="bg-gray-300 px-4 py-2 rounded hover:bg-gray-400">Back to List</a>
        </div>
    </div>
</div>
</body>
</html>
