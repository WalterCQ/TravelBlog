<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="Destination Management - Admin Panel" />
</jsp:include>

<meta name="context-path" content="${pageContext.request.contextPath}">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
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
    min-width: 140px;
}
</style>

<jsp:include page="../includes/navigation.jsp">
    <jsp:param name="currentPage" value="admin" />
</jsp:include>

<div class="container-fluid my-4">
    <div class="row">
        <div class="col-md-3 col-lg-2">
            <div class="card border-0 shadow-sm">
                <div class="card-header">
                    <h6 class="mb-0" data-i18n="admin.panel">Admin Panel</h6>
                </div>
                <div class="list-group list-group-flush">
                    <a href="${pageContext.request.contextPath}/admin/destinations" 
                       class="list-group-item list-group-item-action active">
                        <i class="fas fa-map-marker-alt me-2"></i><span data-i18n="admin.menu.destinations">Destinations</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/packages" 
                       class="list-group-item list-group-item-action">
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
            <div class="admin-content">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h1 class="h3 mb-0">
                            <i class="fas fa-map-marker-alt me-2 text-primary"></i>
                            <span data-i18n="admin.destinations.title">Destination Management</span>
                        </h1>
                        <p class="text-muted" data-i18n="admin.destinations.subtitle">Manage travel destinations and locations</p>
                    </div>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addDestinationModal">
                        <i class="fas fa-plus me-2"></i><span data-i18n="admin.destinations.add">Add Destination</span>
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
				                    <div class="card-body">
				                        <div class="row g-3 mb-4">
				                            <div class="col-md-3">
				                                <div class="input-group">
				                                    <span class="input-group-text">
				                                        <i class="fas fa-search"></i>
				                                    </span>
                                    <input type="text" class="form-control" id="searchInput" data-i18n-attr='{"placeholder":"admin.destinations.search"}' placeholder="Search destinations...">
				                                </div>
				                            </div>
				                            <div class="col-md-2">
                                            <select class="form-select" id="categoryFilter">
                                                <option value="" data-i18n="admin.destinations.filter.allCategories">All Categories</option>
                                                <option value="BEACH" data-i18n="destinations.category.beach">Beach</option>
                                                <option value="MOUNTAIN" data-i18n="destinations.category.mountain">Mountain</option>
                                                <option value="CITY" data-i18n="destinations.category.city">City</option>
                                                <option value="CULTURAL" data-i18n="destinations.category.cultural">Cultural</option>
                                                <option value="ADVENTURE" data-i18n="destinations.category.adventure">Adventure</option>
                                            </select>
				                            </div>
				                            <div class="col-md-2">
                                            <select class="form-select" id="continentFilter">
                                                <option value="" data-i18n="admin.destinations.filter.allContinents">All Continents</option>
                                                <option value="Asia" data-i18n="continents.asia">Asia</option>
                                                <option value="Europe" data-i18n="continents.europe">Europe</option>
                                                <option value="North America" data-i18n="continents.northAmerica">North America</option>
                                                <option value="South America" data-i18n="continents.southAmerica">South America</option>
                                                <option value="Africa" data-i18n="continents.africa">Africa</option>
                                                <option value="Oceania" data-i18n="continents.oceania">Oceania</option>
                                            </select>
				                            </div>
				                            <div class="col-md-2">
                                            <select class="form-select" id="statusFilter">
                                                <option value="" data-i18n="admin.common.allStatus">All Status</option>
                                                <option value="active" data-i18n="admin.common.active">Active</option>
                                                <option value="inactive" data-i18n="admin.common.inactive">Inactive</option>
                                            </select>
				                            </div>
				                            <div class="col-md-3">
                                            <button class="btn btn-outline-secondary w-100" onclick="resetFilters()">
                                                <i class="fas fa-undo me-2"></i><span data-i18n="admin.common.resetFilters">Reset Filters</span>
                                            </button>
				                            </div>
				                        </div>
				                    </div>
				                </div>

                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th scope="col">
                                    <input type="checkbox" class="form-check-input" id="selectAll">
                                </th>
                                <th scope="col" data-i18n="admin.destinations.th.image">Image</th>
                                <th scope="col" data-i18n="admin.destinations.th.name">Name</th>
                                <th scope="col" data-i18n="admin.destinations.th.country">Country</th>
                                <th scope="col" data-i18n="admin.destinations.th.category">Category</th>
                                <th scope="col" data-i18n="admin.destinations.th.price">Price</th>
                                <th scope="col" data-i18n="admin.destinations.th.rating">Rating</th>
                                <th scope="col" data-i18n="admin.destinations.th.recommended">Recommended</th>
                                <th scope="col" data-i18n="admin.destinations.th.status">Status</th>
                                <th scope="col" data-i18n="admin.destinations.th.actions">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty destinations}">
                                    <tr>
                                        <td colspan="10" class="text-center py-5">
                                            <i class="fas fa-map-marker-alt fa-4x text-muted mb-3"></i>
                                            <h4 class="text-muted" data-i18n="admin.destinations.empty.title">No destinations found</h4>
                                            <p class="text-muted" data-i18n="admin.destinations.empty.desc">Start by adding your first destination</p>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="destination" items="${destinations}">
                                        <tr data-destination-id="${destination.id}">
                                            <td>
                                                <input type="checkbox" class="form-check-input row-select" 
                                                       value="${destination.id}">
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${destination.imagePath != null && !empty destination.imagePath}">
                                                        <img src="${pageContext.request.contextPath}/${destination.imagePath}" 
                                                             alt="${destination.name}" 
                                                             class="img-thumbnail" 
                                                             style="width: 60px; height: 60px; object-fit: cover;"
                                                             onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="img-thumbnail d-flex align-items-center justify-content-center" 
                                                             style="width: 60px; height: 60px; background-color: #f8f9fa;">
                                                            <i class="fas fa-image text-muted"></i>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="destination-info">
                                                    <strong>${destination.name}</strong>
                                                    <small class="text-muted d-block">${fn:substring(destination.description, 0, 50)}...</small>
                                                </div>
                                            </td>
                                            <td>
                                                <select class="form-select form-select-sm country-select" 
                                                        data-id="${destination.id}" 
                                                        data-field="country"
                                                        data-original="${destination.country}">
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
                                            </td>
                                            <td>
                                                <select class="form-select form-select-sm category-select" 
                                                        data-id="${destination.id}" 
                                                        data-field="category"
                                                        data-original="${destination.category}">
                                                    <option value="BEACH" ${destination.category == 'BEACH' ? 'selected' : ''}>Beach</option>
                                                    <option value="MOUNTAIN" ${destination.category == 'MOUNTAIN' ? 'selected' : ''}>Mountain</option>
                                                    <option value="CITY" ${destination.category == 'CITY' ? 'selected' : ''}>City</option>
                                                    <option value="CULTURAL" ${destination.category == 'CULTURAL' ? 'selected' : ''}>Cultural</option>
                                                    <option value="ADVENTURE" ${destination.category == 'ADVENTURE' ? 'selected' : ''}>Adventure</option>
                                                </select>
                                            </td>
                                            <td>
                                                <strong class="text-success">RM ${destination.basePrice}</strong>
                                            </td>
                                            <td>
                                                <div class="rating-stars">
                                                    <c:forEach var="i" begin="1" end="5">
                                                        <i class="fas fa-star ${i <= destination.rating ? 'text-warning' : 'text-muted'}"></i>
                                                    </c:forEach>
                                                    <small class="text-muted ms-1">(${destination.rating})</small>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="form-check form-switch">
                                                    <input class="form-check-input" type="checkbox" 
                                                           ${destination.featured ? 'checked' : ''} 
                                                           data-id="${destination.id}" 
                                                           data-field="featured">
                                                </div>
                                            </td>
                                            <td>
                                                <select class="form-select form-select-sm status-select" 
                                                        data-id="${destination.id}" 
                                                        data-field="active"
                                                        data-original="${destination.active}">
                                                    <option value="true" ${destination.active ? 'selected' : ''}>Active</option>
                                                    <option value="false" ${!destination.active ? 'selected' : ''}>Inactive</option>
                                                </select>
                                            </td>
                                            <td>
                                                <div class="d-flex gap-1 justify-content-start">
                                                    <button type="button" class="btn btn-sm btn-outline-primary" 
                                                            onclick="editDestination(${destination.id})"
                                                            title="Edit" data-i18n-attr='{"title":"admin.common.edit"}'>
                                                        <i class="fas fa-edit"></i>
                                                    </button>
                                                    <button type="button" class="btn btn-sm btn-outline-danger" 
                                                            onclick="deleteDestination(${destination.id})"
                                                            title="Delete" data-i18n-attr='{"title":"admin.common.delete"}'>
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

<div class="modal fade" id="addDestinationModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-plus me-2"></i>Add New Destination
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="post" action="${pageContext.request.contextPath}/admin/destinations/add" id="addDestinationForm">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="destinationName" class="form-label">Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="destinationName" name="name" required>
                        </div>
                        <div class="col-md-6">
                            <label for="country" class="form-label">Country <span class="text-danger">*</span></label>
                            <select class="form-select" id="country" name="country" required>
                                <option value="">Choose country...</option>
                                <option value="United States">United States</option>
                                <option value="Canada">Canada</option>
                                <option value="Brazil">Brazil</option>
                                <option value="Argentina">Argentina</option>
                                <option value="Peru">Peru</option>
                                <option value="China">China</option>
                                <option value="Japan">Japan</option>
                                <option value="India">India</option>
                                <option value="Indonesia">Indonesia</option>
                                <option value="Maldives">Maldives</option>
                                <option value="Norway">Norway</option>
                                <option value="Switzerland">Switzerland</option>
                                <option value="France">France</option>
                                <option value="Italy">Italy</option>
                                <option value="Spain">Spain</option>
                                <option value="Croatia">Croatia</option>
                                <option value="Egypt">Egypt</option>
                                <option value="Tanzania">Tanzania</option>
                                <option value="Zambia">Zambia</option>
                                <option value="Australia">Australia</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="category" class="form-label">Category <span class="text-danger">*</span></label>
                            <select class="form-select" id="category" name="category" required>
                                <option value="">Choose category...</option>
                                <option value="BEACH">Beach</option>
                                <option value="MOUNTAIN">Mountain</option>
                                <option value="CITY">City</option>
                                <option value="CULTURAL">Cultural</option>
                                <option value="ADVENTURE">Adventure</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="basePrice" class="form-label">Price (RM) <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text">RM</span>
                                <input type="number" class="form-control" id="basePrice" name="basePrice" min="0" step="0.01" required>
                            </div>
                        </div>
                        <div class="col-12">
                            <label for="description" class="form-label">Description <span class="text-danger">*</span></label>
                            <textarea class="form-control" id="description" name="description" rows="4" required></textarea>
                        </div>
                        <div class="col-md-6">
                            <label for="rating" class="form-label">Rating <span class="text-danger">*</span></label>
                            <select class="form-select" id="rating" name="rating" required>
                                <option value="">Choose rating...</option>
                                <option value="1">1 Star</option>
                                <option value="2">2 Stars</option>
                                <option value="3">3 Stars</option>
                                <option value="4">4 Stars</option>
                                <option value="5">5 Stars</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="imagePath" class="form-label">Image Path <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="imagePath" name="imagePath" required>
                        </div>
                        <div class="col-md-6">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="featured" name="featured" value="true">
                                <label class="form-check-label" for="featured">
                                    Recommended Destination
                                </label>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="active" name="active" value="true" checked>
                                <label class="form-check-label" for="active">
                                    Active
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save me-2"></i>Save Destination
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
const contextPath = '${pageContext.request.contextPath}';

function filterDestinations() {
    const searchValue = document.getElementById('searchInput').value.toLowerCase();
    const categoryValue = document.getElementById('categoryFilter').value;
    const continentValue = document.getElementById('continentFilter').value;
    const statusValue = document.getElementById('statusFilter').value;

    document.querySelectorAll('tbody tr[data-destination-id]').forEach(row => {
        const name = row.querySelector('.destination-info strong').textContent.toLowerCase();
        const category = row.querySelector('.category-select').value;
        const continent = row.querySelector('.country-select').value;
        const status = row.querySelector('.status-select').value;

        const matchesSearch = name.includes(searchValue);
        const matchesCategory = !categoryValue || category == categoryValue;
        const matchesContinentMap = {
            'United States': 'North America', 'Canada': 'North America',
            'Brazil': 'South America', 'Argentina': 'South America', 'Peru': 'South America',
            'China': 'Asia', 'Japan': 'Asia', 'India': 'Asia', 'Indonesia': 'Asia', 'Maldives': 'Asia',
            'Norway': 'Europe', 'Switzerland': 'Europe', 'France': 'Europe', 'Italy': 'Europe', 'Spain': 'Europe', 'Croatia': 'Europe',
            'Egypt': 'Africa', 'Tanzania': 'Africa', 'Zambia': 'Africa',
            'Australia': 'Oceania'
        };
        const matchesContinent = !continentValue || matchesContinentMap[continent] == continentValue;
        const matchesStatus = !statusValue || (status == 'true' && statusValue == 'active') || (status == 'false' && statusValue == 'inactive');

        row.style.display = matchesSearch && matchesCategory && matchesContinent && matchesStatus ? '' : 'none';
    });
}

function resetFilters() {
    document.getElementById('searchInput').value = '';
    document.getElementById('categoryFilter').value = '';
    document.getElementById('continentFilter').value = '';
    document.getElementById('statusFilter').value = '';
    filterDestinations();
}

function editDestination(id) {
    window.location.href = contextPath + '/admin/destinations/edit/' + id;
}

function deleteDestination(id) {
    if (confirm('Are you sure you want to delete this destination? This action cannot be undone.')) {
        fetch(contextPath + '/admin/destinations/delete/' + id, {
            method: 'DELETE'
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                showNotification('Destination deleted successfully', 'success');
                location.reload();
            } else {
                showNotification('Failed to delete destination', 'error');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            showNotification('Error deleting destination', 'error');
        });
    }
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