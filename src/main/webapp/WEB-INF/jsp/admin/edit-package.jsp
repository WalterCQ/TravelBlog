<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="Edit Package - Admin Panel" />
</jsp:include>

<meta name="context-path" content="${pageContext.request.contextPath}">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">

<jsp:include page="../includes/navigation.jsp">
    <jsp:param name="currentPage" value="admin" />
</jsp:include>

<div class="container-fluid my-4">
    <div class="row">
        <div class="col-md-3 col-lg-2">
            <div class="card border-0 shadow-sm">
                <div class="card-header">
                    <h6 class="mb-0">
                        Admin Panel
                    </h6>
                </div>
                <div class="list-group list-group-flush">
                    <a href="${pageContext.request.contextPath}/admin/destinations" 
                       class="list-group-item list-group-item-action">
                        <i class="fas fa-map-marker-alt me-2"></i>Destinations
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/packages" 
                       class="list-group-item list-group-item-action active">
                        <i class="fas fa-box me-2"></i>Packages
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/bookings" 
                       class="list-group-item list-group-item-action">
                        <i class="fas fa-calendar-check me-2"></i>Bookings
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/users" 
                       class="list-group-item list-group-item-action">
                        <i class="fas fa-users me-2"></i>Users
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/messages" 
                       class="list-group-item list-group-item-action">
                        <i class="fas fa-envelope me-2"></i>Messages
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-9 col-lg-10">
            <div class="admin-content">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h1 class="h3 mb-0">
                            <i class="fas fa-edit me-2 text-primary"></i>
                            Edit Package
                        </h1>
                        <p class="text-muted">Modify package information</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/packages" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i>Back to List
                    </a>
                </div>

                <c:if test="${not empty message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="card border-0 shadow-sm">
                    <div class="card-body">
                        <form method="post" action="${pageContext.request.contextPath}/admin/packages/update">
                            <input type="hidden" name="id" value="${travelPackage.id}">
                            
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="packageName" class="form-label">Package Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="packageName" name="name" 
                                           value="${travelPackage.name}" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="destinationId" class="form-label">Destination <span class="text-danger">*</span></label>
                                    <select class="form-select" id="destinationId" name="destinationId" required>
                                        <option value="">Choose destination...</option>
                                        <c:forEach var="destination" items="${destinations}">
                                            <option value="${destination.id}" 
                                                    ${travelPackage.destinationId == destination.id ? 'selected' : ''}>
                                                ${destination.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-12">
                                    <label for="packageDescription" class="form-label">Description <span class="text-danger">*</span></label>
                                    <textarea class="form-control" id="packageDescription" name="description" rows="4" required>${travelPackage.description}</textarea>
                                </div>
                                <div class="col-md-4">
                                    <label for="price" class="form-label">Price (RM) <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text">RM</span>
                                        <input type="number" class="form-control" id="price" name="price" 
                                               value="${travelPackage.price}" min="0" step="0.01" required>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <label for="durationDays" class="form-label">Duration (days) <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="durationDays" name="durationDays" 
                                           value="${travelPackage.durationDays}" min="1" required>
                                </div>
                                <div class="col-md-4">
                                    <label for="durationNights" class="form-label">Duration (nights)</label>
                                    <input type="number" class="form-control" id="durationNights" name="durationNights" 
                                           value="${travelPackage.durationNights}" min="0">
                                </div>
                                <div class="col-md-6">
                                    <label for="packageType" class="form-label">Type <span class="text-danger">*</span></label>
                                    <select class="form-select" id="packageType" name="type" required>
                                        <option value="">Choose type...</option>
                                        <option value="BUDGET" ${travelPackage.packageType == 'BUDGET' ? 'selected' : ''}>Budget</option>
                                        <option value="STANDARD" ${travelPackage.packageType == 'STANDARD' ? 'selected' : ''}>Standard</option>
                                        <option value="PREMIUM" ${travelPackage.packageType == 'PREMIUM' ? 'selected' : ''}>Premium</option>
                                        <option value="LUXURY" ${travelPackage.packageType == 'LUXURY' ? 'selected' : ''}>Luxury</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="maxParticipants" class="form-label">Max Participants</label>
                                    <input type="number" class="form-control" id="maxParticipants" name="maxParticipants" 
                                           value="${travelPackage.maxParticipants}" min="1">
                                </div>
                                <div class="col-12">
                                    <label for="inclusions" class="form-label">Inclusions</label>
                                    <textarea class="form-control" id="inclusions" name="inclusions" rows="3">${travelPackage.inclusions}</textarea>
                                    <div class="form-text">What's included in this package</div>
                                </div>
                                <div class="col-12">
                                    <label for="exclusions" class="form-label">Exclusions</label>
                                    <textarea class="form-control" id="exclusions" name="exclusions" rows="3">${travelPackage.exclusions}</textarea>
                                    <div class="form-text">What's not included in this package</div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="featured" name="featured" 
                                               value="true" ${travelPackage.featured ? 'checked' : ''}>
                                        <label class="form-check-label" for="featured">
                                            Featured Package
                                        </label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="active" name="active" 
                                               value="true" ${travelPackage.active ? 'checked' : ''}>
                                        <label class="form-check-label" for="active">
                                            Active
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <hr>
                                    <div class="d-flex gap-2">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save me-2"></i>Update Package
                                        </button>
                                        <a href="${pageContext.request.contextPath}/admin/packages" class="btn btn-secondary">
                                            <i class="fas fa-times me-2"></i>Cancel
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>