<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="Admin - Package Management" />
</jsp:include>

<jsp:include page="../includes/navigation.jsp">
    <jsp:param name="currentPage" value="admin" />
</jsp:include>

<style>
.d-flex.gap-1 {
    gap: 0.25rem !important;
}

.btn-sm {
    padding: 0.25rem 0.5rem !important;
    font-size: 0.775rem !important;
    line-height: 1.35 !important;
    border-radius: 0.375rem !important;
    min-width: 32px !important;
    height: 32px !important;
    display: inline-flex !important;
    align-items: center !important;
    justify-content: center !important;
}

.btn-sm i {
    font-size: 0.875rem !important;
    margin: 0 !important;
}

.btn-outline-primary:hover {
    background-color: #0d6efd !important;
    border-color: #0d6efd !important;
    color: white !important;
}

.btn-outline-info:hover {
    background-color: #0dcaf0 !important;
    border-color: #0dcaf0 !important;
    color: #000 !important;
}

.btn-outline-success:hover {
    background-color: #198754 !important;
    border-color: #198754 !important;
    color: white !important;
}

.btn-outline-warning:hover {
    background-color: #ffc107 !important;
    border-color: #ffc107 !important;
    color: #000 !important;
}

.btn-outline-danger:hover {
    background-color: #dc3545 !important;
    border-color: #dc3545 !important;
    color: white !important;
}

.table td .d-flex {
    white-space: nowrap;
}

.table-responsive {
    overflow-x: auto !important;
}

td:last-child {
    min-width: 200px;
}
</style>

<div class="container-fluid my-4">
    <div class="row">
        <div class="col-md-3 col-lg-2">
            <div class="card border-0 shadow-sm">
                <div class="card-header">
                    <h6 class="mb-0" data-i18n="admin.panel">Admin Panel</h6>
                </div>
                <div class="list-group list-group-flush">
                    <a href="${pageContext.request.contextPath}/admin/destinations" 
                       class="list-group-item list-group-item-action">
                        <i class="fas fa-map-marker-alt me-2"></i><span data-i18n="admin.menu.destinations">Destinations</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/packages" 
                       class="list-group-item list-group-item-action active">
                        <i class="fas fa-box me-2"></i><span data-i18n="admin.menu.packages">Packages</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/bookings" 
                       class="list-group-item list-group-item-action">
                        <i class="fas fa-calendar-check me-2"></i><span data-i18n="admin.menu.bookings">Bookings</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/users" 
                       class="list-group-item list-group-item-action">
                        <i class="fas fa-users me-2"></i><span data-i18n="admin.menu.users">Users</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/messages" 
                       class="list-group-item list-group-item-action">
                        <i class="fas fa-envelope me-2"></i><span data-i18n="admin.menu.messages">Messages</span>
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-9 col-lg-10">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                        <h1 class="h3 mb-0">
                            <i class="fas fa-box me-2 text-primary"></i>
                            <span data-i18n="admin.packages.title">Package Management</span>
                        </h1>
                        <p class="text-muted" data-i18n="admin.packages.subtitle">Manage travel packages and offerings</p>
                </div>
                <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addPackageModal">
                    <i class="fas fa-plus me-2"></i><span data-i18n="admin.packages.add">Add Package</span>
                </button>
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
                <div class="card-header bg-white">
                    <h6 class="mb-0">
                        <i class="fas fa-box me-2"></i>
                        <i class="fas fa-box me-2"></i><span data-i18n="admin.packages.tableTitle">Travel Packages</span> (<c:out value="${travelPackages.size()}" />)
                    </h6>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th data-i18n="admin.packages.th.package">Package</th>
                                    <th data-i18n="admin.packages.th.destination">Destination</th>
                                    <th data-i18n="admin.packages.th.price">Price</th>
                                    <th data-i18n="admin.packages.th.duration">Duration</th>
                                    <th data-i18n="admin.packages.th.type">Type</th>
                                    <th data-i18n="admin.packages.th.status">Status</th>
                                    <th data-i18n="admin.packages.th.actions">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <c:when test="${empty travelPackages}">
                                        <tr>
                                            <td colspan="7" class="text-center py-5">
                                                <i class="fas fa-box fa-4x text-muted mb-3"></i>
                                                <h4 class="text-muted" data-i18n="admin.packages.empty.title">No packages found</h4>
                                                <p class="text-muted" data-i18n="admin.packages.empty.desc">Start by adding your first package</p>
                                            </td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="travelPackage" items="${travelPackages}">
                                            <tr class="package-row" data-package-id="${travelPackage.id}">
                                                <td>
                                                    <div class="package-info">
                                                        <strong>${travelPackage.name}</strong>
                                                        <small class="text-muted d-block">${fn:substring(travelPackage.description, 0, 50)}...</small>
                                                    </div>
                                                </td>
                                                <td>
                                                    <span class="destination-name">${travelPackage.destinationName}</span>
                                                </td>
                                                <td>
                                                    <strong class="text-success">RM ${travelPackage.price}</strong>
                                                </td>
                                                <td>
                                                    <span class="badge bg-light text-dark">${travelPackage.durationDays} days</span>
                                                </td>
                                                <td>
                                                    <span class="badge bg-${travelPackage.type == 'BUDGET' ? 'secondary' : (travelPackage.type == 'STANDARD' ? 'warning' : (travelPackage.type == 'PREMIUM' ? 'primary' : 'secondary'))}">
                                                        ${travelPackage.type}
                                                    </span>
                                                </td>
                                                <td>
                                                    <span class="badge bg-${travelPackage.active ? 'success' : 'danger'}" data-i18n="${travelPackage.active ? 'admin.common.active' : 'admin.common.inactive'}">
                                                        ${travelPackage.active ? 'Active' : 'Inactive'}
                                                    </span>
                                                </td>
                                                <td>
                                                    <div class="d-flex gap-1 justify-content-start">
                                                        <button type="button" class="btn btn-sm btn-outline-primary" 
                                                                onclick="editPackage(${travelPackage.id})"
                                                                title="Edit Package" data-i18n-attr='{"title":"admin.common.edit"}'>
                                                            <i class="fas fa-edit"></i>
                                                        </button>
                                                        <button type="button" class="btn btn-sm btn-outline-danger" 
                                                                onclick="deletePackage(${travelPackage.id})"
                                                                title="Delete Package" data-i18n-attr='{"title":"admin.common.delete"}'>
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="addPackageModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-plus me-2"></i>Add New Package
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="post" action="${pageContext.request.contextPath}/admin/packages/add" id="addPackageForm">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="packageName" class="form-label">Package Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="packageName" name="name" required>
                        </div>
                        <div class="col-md-6">
                            <label for="destinationId" class="form-label">Destination <span class="text-danger">*</span></label>
                            <select class="form-select" id="destinationId" name="destinationId" required>
                                <option value="">Choose destination...</option>
                                <c:forEach var="destination" items="${destinations}">
                                    <option value="${destination.id}">${destination.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-12">
                            <label for="packageDescription" class="form-label">Description <span class="text-danger">*</span></label>
                            <textarea class="form-control" id="packageDescription" name="description" rows="4" required></textarea>
                        </div>
                        <div class="col-md-4">
                            <label for="price" class="form-label">Price (RM) <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text">RM</span>
                                <input type="number" class="form-control" id="price" name="price" min="0" step="0.01" required>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <label for="durationDays" class="form-label">Duration (days) <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" id="durationDays" name="durationDays" min="1" required>
                        </div>
                        <div class="col-md-4">
                            <label for="packageType" class="form-label">Type <span class="text-danger">*</span></label>
                            <select class="form-select" id="packageType" name="type" required>
                                <option value="">Choose type...</option>
                                <option value="BUDGET">Budget</option>
                                <option value="STANDARD">Standard</option>
                                <option value="PREMIUM">Premium</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save me-2"></i>Save Package
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
const contextPath = '${pageContext.request.contextPath}';

function deletePackage(id) {
    if (confirm('Are you sure you want to delete this package? This action cannot be undone.')) {
        fetch(contextPath + '/admin/packages/delete/' + id, {
            method: 'DELETE'
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                showNotification('Package deleted successfully', 'success');
                location.reload();
            } else {
                showNotification('Failed to delete package', 'error');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            showNotification('Error deleting package', 'error');
        });
    }
}

function editPackage(id) {
    window.location.href = contextPath + '/admin/packages/edit/' + id;
}

function showNotification(message, type) {
    const notification = document.createElement('div');
    notification.className = `alert alert-${type == 'success' ? 'success' : 'danger'} alert-dismissible fade show position-fixed`;
    notification.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';
    notification.innerHTML = `
        <i class="fas fa-${type == 'success' ? 'check-circle' : 'exclamation-circle'} me-2"></i>
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `;
    
    document.body.appendChild(notification);
    
    setTimeout(() => {
        if (notification.parentNode) {
            notification.remove();
        }
    }, 5000);
}
</script>

</body>
</html>