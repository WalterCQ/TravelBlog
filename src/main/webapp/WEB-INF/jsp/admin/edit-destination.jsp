<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="Edit Destination - Admin Panel" />
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
                       class="list-group-item list-group-item-action active">
                        <i class="fas fa-map-marker-alt me-2"></i>Destinations
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/packages" 
                       class="list-group-item list-group-item-action">
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
                            Edit Destination
                        </h1>
                        <p class="text-muted">Modify destination information</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/destinations" class="btn btn-secondary">
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
                        <form method="post" action="${pageContext.request.contextPath}/admin/destinations/update">
                            <input type="hidden" name="id" value="${destination.id}">
                            
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="destinationName" class="form-label">Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="destinationName" name="name" 
                                           value="${destination.name}" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="city" class="form-label">City <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="city" name="city" 
                                           value="${destination.city}" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="country" class="form-label">Country <span class="text-danger">*</span></label>
                                    <select class="form-select" id="country" name="country" required>
                                        <option value="">Choose country...</option>
                                        <option value="United States" ${destination.country == 'United States' ? 'selected' : ''}>United States</option>
                                        <option value="Canada" ${destination.country == 'Canada' ? 'selected' : ''}>Canada</option>
                                        <option value="Brazil" ${destination.country == 'Brazil' ? 'selected' : ''}>Brazil</option>
                                        <option value="Argentina" ${destination.country == 'Argentina' ? 'selected' : ''}>Argentina</option>
                                        <option value="Peru" ${destination.country == 'Peru' ? 'selected' : ''}>Peru</option>
                                        <option value="China" ${destination.country == 'China' ? 'selected' : ''}>China</option>
                                        <option value="Japan" ${destination.country == 'Japan' ? 'selected' : ''}>Japan</option>
                                        <option value="India" ${destination.country == 'India' ? 'selected' : ''}>India</option>
                                        <option value="Indonesia" ${destination.country == 'Indonesia' ? 'selected' : ''}>Indonesia</option>
                                        <option value="Maldives" ${destination.country == 'Maldives' ? 'selected' : ''}>Maldives</option>
                                        <option value="Norway" ${destination.country == 'Norway' ? 'selected' : ''}>Norway</option>
                                        <option value="Switzerland" ${destination.country == 'Switzerland' ? 'selected' : ''}>Switzerland</option>
                                        <option value="France" ${destination.country == 'France' ? 'selected' : ''}>France</option>
                                        <option value="Italy" ${destination.country == 'Italy' ? 'selected' : ''}>Italy</option>
                                        <option value="Spain" ${destination.country == 'Spain' ? 'selected' : ''}>Spain</option>
                                        <option value="Croatia" ${destination.country == 'Croatia' ? 'selected' : ''}>Croatia</option>
                                        <option value="Egypt" ${destination.country == 'Egypt' ? 'selected' : ''}>Egypt</option>
                                        <option value="Tanzania" ${destination.country == 'Tanzania' ? 'selected' : ''}>Tanzania</option>
                                        <option value="Zambia" ${destination.country == 'Zambia' ? 'selected' : ''}>Zambia</option>
                                        <option value="Australia" ${destination.country == 'Australia' ? 'selected' : ''}>Australia</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="category" class="form-label">Category <span class="text-danger">*</span></label>
                                    <select class="form-select" id="category" name="category" required>
                                        <option value="">Choose category...</option>
                                        <option value="BEACH" ${destination.category == 'BEACH' ? 'selected' : ''}>Beach</option>
                                        <option value="MOUNTAIN" ${destination.category == 'MOUNTAIN' ? 'selected' : ''}>Mountain</option>
                                        <option value="CITY" ${destination.category == 'CITY' ? 'selected' : ''}>City</option>
                                        <option value="CULTURAL" ${destination.category == 'CULTURAL' ? 'selected' : ''}>Cultural</option>
                                        <option value="ADVENTURE" ${destination.category == 'ADVENTURE' ? 'selected' : ''}>Adventure</option>
                                        <option value="HERITAGE" ${destination.category == 'HERITAGE' ? 'selected' : ''}>Heritage</option>
                                        <option value="NATURE" ${destination.category == 'NATURE' ? 'selected' : ''}>Nature</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="basePrice" class="form-label">Base Price (USD) <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text">$</span>
                                        <input type="number" class="form-control" id="basePrice" name="basePrice" 
                                               value="${destination.basePrice}" min="0" step="0.01" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="rating" class="form-label">Rating <span class="text-danger">*</span></label>
                                    <select class="form-select" id="rating" name="rating" required>
                                        <option value="">Choose rating...</option>
                                        <option value="1" ${destination.rating == 1 ? 'selected' : ''}>1 Star</option>
                                        <option value="2" ${destination.rating == 2 ? 'selected' : ''}>2 Stars</option>
                                        <option value="3" ${destination.rating == 3 ? 'selected' : ''}>3 Stars</option>
                                        <option value="4" ${destination.rating == 4 ? 'selected' : ''}>4 Stars</option>
                                        <option value="5" ${destination.rating == 5 ? 'selected' : ''}>5 Stars</option>
                                    </select>
                                </div>
                                <div class="col-12">
                                    <label for="description" class="form-label">Description <span class="text-danger">*</span></label>
                                    <textarea class="form-control" id="description" name="description" rows="4" required>${destination.description}</textarea>
                                </div>
                                <div class="col-md-6">
                                    <label for="imagePath" class="form-label">Image Path <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="imagePath" name="imagePath" 
                                           value="${destination.imagePath}" required>
                                    <div class="form-text">Enter path like: images/destination-name.jpg</div>
                                </div>
                                <div class="col-md-6">
                                    <label for="highlights" class="form-label">Highlights</label>
                                    <input type="text" class="form-control" id="highlights" name="highlights" 
                                           value="${destination.highlights}">
                                    <div class="form-text">Comma-separated highlights</div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="featured" name="featured" 
                                               value="true" ${destination.featured ? 'checked' : ''}>
                                        <label class="form-check-label" for="featured">
                                            Recommended Destination
                                        </label>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-check">
                                        <input class="form-check-input" type="checkbox" id="active" name="active" 
                                               value="true" ${destination.active ? 'checked' : ''}>
                                        <label class="form-check-label" for="active">
                                            Active
                                        </label>
                                    </div>
                                </div>
                                <div class="col-12">
                                    <hr>
                                    <div class="d-flex gap-2">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save me-2"></i>Update Destination
                                        </button>
                                        <a href="${pageContext.request.contextPath}/admin/destinations" class="btn btn-secondary">
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