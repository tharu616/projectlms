<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 5/21/2025
  Time: 2:49 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Success Alert -->
<c:if test="${not empty success}">
  <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-4" role="alert">
    <div class="flex">
      <div class="flex-shrink-0">
        <i class="fas fa-check-circle"></i>
      </div>
      <div class="ml-3">
        <p class="text-sm">${success}</p>
      </div>
      <div class="ml-auto pl-3">
        <div class="-mx-1.5 -my-1.5">
          <button type="button" onclick="this.parentElement.parentElement.parentElement.remove()"
                  class="inline-flex rounded-md p-1.5 text-green-500 hover:bg-green-100 focus:outline-none focus:ring-2 focus:ring-green-600 focus:ring-offset-2">
            <span class="sr-only">Dismiss</span>
            <i class="fas fa-times"></i>
          </button>
        </div>
      </div>
    </div>
  </div>
</c:if>

<!-- Error Alert -->
<c:if test="${not empty error}">
  <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4" role="alert">
    <div class="flex">
      <div class="flex-shrink-0">
        <i class="fas fa-exclamation-circle"></i>
      </div>
      <div class="ml-3">
        <p class="text-sm">${error}</p>
      </div>
      <div class="ml-auto pl-3">
        <div class="-mx-1.5 -my-1.5">
          <button type="button" onclick="this.parentElement.parentElement.parentElement.remove()"
                  class="inline-flex rounded-md p-1.5 text-red-500 hover:bg-red-100 focus:outline-none focus:ring-2 focus:ring-red-600 focus:ring-offset-2">
            <span class="sr-only">Dismiss</span>
            <i class="fas fa-times"></i>
          </button>
        </div>
      </div>
    </div>
  </div>
</c:if>

<!-- Warning Alert -->
<c:if test="${not empty warning}">
  <div class="bg-yellow-100 border-l-4 border-yellow-500 text-yellow-700 p-4 mb-4" role="alert">
    <div class="flex">
      <div class="flex-shrink-0">
        <i class="fas fa-exclamation-triangle"></i>
      </div>
      <div class="ml-3">
        <p class="text-sm">${warning}</p>
      </div>
      <div class="ml-auto pl-3">
        <div class="-mx-1.5 -my-1.5">
          <button type="button" onclick="this.parentElement.parentElement.parentElement.remove()"
                  class="inline-flex rounded-md p-1.5 text-yellow-500 hover:bg-yellow-100 focus:outline-none focus:ring-2 focus:ring-yellow-600 focus:ring-offset-2">
            <span class="sr-only">Dismiss</span>
            <i class="fas fa-times"></i>
          </button>
        </div>
      </div>
    </div>
  </div>
</c:if>

<!-- Info Alert -->
<c:if test="${not empty info}">
  <div class="bg-blue-100 border-l-4 border-blue-500 text-blue-700 p-4 mb-4" role="alert">
    <div class="flex">
      <div class="flex-shrink-0">
        <i class="fas fa-info-circle"></i>
      </div>
      <div class="ml-3">
        <p class="text-sm">${info}</p>
      </div>
      <div class="ml-auto pl-3">
        <div class="-mx-1.5 -my-1.5">
          <button type="button" onclick="this.parentElement.parentElement.parentElement.remove()"
                  class="inline-flex rounded-md p-1.5 text-blue-500 hover:bg-blue-100 focus:outline-none focus:ring-2 focus:ring-blue-600 focus:ring-offset-2">
            <span class="sr-only">Dismiss</span>
            <i class="fas fa-times"></i>
          </button>
        </div>
      </div>
    </div>
  </div>
</c:if>

<!-- Multiple Errors -->
<c:if test="${not empty errors}">
  <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-4" role="alert">
    <div class="flex">
      <div class="flex-shrink-0">
        <i class="fas fa-exclamation-circle"></i>
      </div>
      <div class="ml-3">
        <ul class="list-disc list-inside">
          <c:forEach var="err" items="${errors}">
            <li class="text-sm">${err}</li>
          </c:forEach>
        </ul>
      </div>
      <div class="ml-auto pl-3">
        <div class="-mx-1.5 -my-1.5">
          <button type="button" onclick="this.parentElement.parentElement.parentElement.remove()"
                  class="inline-flex rounded-md p-1.5 text-red-500 hover:bg-red-100 focus:outline-none focus:ring-2 focus:ring-red-600 focus:ring-offset-2">
            <span class="sr-only">Dismiss</span>
            <i class="fas fa-times"></i>
          </button>
        </div>
      </div>
    </div>
  </div>
</c:if>
