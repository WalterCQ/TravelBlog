<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="User Management - Admin Panel" />
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
    min-width: 150px;
}

.avatar-circle {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background-color: #f8f9fa;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #6c757d;
}

.user-row:hover {
    background-color: #f8f9fa;
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
                       class="list-group-item list-group-item-action">
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
                       class="list-group-item list-group-item-action active">
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
                            <i class="fas fa-users me-2 text-primary"></i>
                            <span data-i18n="admin.users.title">User Management</span>
                        </h1>
                        <p class="text-muted" data-i18n="admin.users.subtitle">Manage user accounts and permissions</p>
                    </div>
                    <div class="d-flex gap-2">
                        <button class="btn btn-outline-success" onclick="exportUsers()">
                            <i class="fas fa-download me-2"></i><span data-i18n="admin.users.export">Export Users</span>
                        </button>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
                            <i class="fas fa-plus me-2"></i><span data-i18n="admin.users.add">Add User</span>
                        </button>
                    </div>
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
                            <div class="col-md-4">
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i class="fas fa-search"></i>
                                    </span>
                                    <input type="text" class="form-control" id="searchInput" placeholder="Search users..." data-i18n-attr='{"placeholder":"admin.users.search"}'>
                                </div>
                            </div>
                            <div class="col-md-2">
                                <select class="form-select" id="roleFilter">
                                    <option value="" data-i18n="admin.users.filter.allRoles">All Roles</option>
                                    <option value="ADMIN" data-i18n="admin.users.role.admin">Admin</option>
                                    <option value="USER" data-i18n="admin.users.role.user">User</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <select class="form-select" id="statusFilter">
                                    <option value="" data-i18n="admin.common.allStatus">All Status</option>
                                    <option value="true" data-i18n="admin.common.active">Active</option>
                                    <option value="false" data-i18n="admin.common.inactive">Inactive</option>
                                </select>
                            </div>
                            <div class="col-md-4">
                                <button class="btn btn-outline-secondary w-100" onclick="resetFilters()">
                                    <i class="fas fa-undo me-2"></i><span data-i18n="admin.common.resetFilters">Reset Filters</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead class="table-light">
                            <tr>
                                <th data-i18n="admin.users.th.user">User</th>
                                <th data-i18n="admin.users.th.email">Email</th>
                                <th data-i18n="admin.users.th.phone">Phone</th>
                                <th data-i18n="admin.users.th.role">Role</th>
                                <th data-i18n="admin.users.th.status">Status</th>
                                <th data-i18n="admin.users.th.created">Created</th>
                                <th data-i18n="admin.users.th.lastLogin">Last Login</th>
                                <th data-i18n="admin.users.th.actions">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr class="user-row" 
                                    data-role="${user.role}" 
                                    data-status="${user.active}">
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-circle me-3">
                                                <i class="fas fa-user"></i>
                                            </div>
                                            <div>
                                                <strong>${user.fullName}</strong>
                                                <small class="text-muted d-block">@${user.username}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <span class="text-muted">${user.email}</span>
                                    </td>
                                    <td>
                                        <span class="text-muted">${user.phone != null ? user.phone : 'Not provided'}</span>
                                    </td>
                                    <td>
                                        <span class="badge bg-${user.role == 'ADMIN' ? 'primary' : 'secondary'}">
                                            ${user.role}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge bg-${user.active ? 'success' : 'danger'}" data-i18n="${user.active ? 'admin.common.active' : 'admin.common.inactive'}">
                                            ${user.active ? 'Active' : 'Inactive'}
                                        </span>
                                    </td>
                                    <td>
                                        <small class="text-muted">
                                            <c:choose>
                                                <c:when test="${user.createdAt != null}">
                                                    <c:out value="${user.createdAt.toString().substring(0, 10)}" />
                                                </c:when>
                                                <c:otherwise>
                                                    Not available
                                                </c:otherwise>
                                            </c:choose>
                                        </small>
                                    </td>
                                    <td>
                                        <small class="text-muted">
                                            <c:choose>
                                                <c:when test="${user.lastLoginAt != null}">
                                                    <c:out value="${user.lastLoginAt.toString().substring(0, 10)}" />
                                                </c:when>
                                                <c:otherwise>
                                                    Never
                                                </c:otherwise>
                                            </c:choose>
                                        </small>
                                    </td>
                                    <td>
                                        <div class="d-flex gap-1 justify-content-start">
                                            <button type="button" class="btn btn-sm btn-outline-info" 
                                                    onclick="editUser(${user.id})"
                                                    title="Edit User" data-i18n-attr='{"title":"admin.common.edit"}'>
                                                <i class="fas fa-edit"></i>
                                            </button> 
                                            <c:if test="${user.role != 'ADMIN'}">
                                                <button type="button" class="btn btn-sm btn-outline-danger" 
                                                        onclick="deleteUser(${user.id})"
                                                        title="Delete User" data-i18n-attr='{"title":"admin.common.delete"}'>
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </c:if>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="addUserModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-plus me-2"></i>Add New User
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="post" action="${pageContext.request.contextPath}/admin/users/add" id="addUserForm">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="firstName" class="form-label">First Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="firstName" name="firstName" required>
                        </div>
                        <div class="col-md-6">
                            <label for="lastName" class="form-label">Last Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="lastName" name="lastName" required>
                        </div>
                        <div class="col-md-6">
                            <label for="username" class="form-label">Username <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="col-md-6">
                            <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" id="email" name="email" required>
                        </div>
                        <div class="col-md-6">
                            <label for="phone" class="form-label">Phone</label>
                            <input type="tel" class="form-control" id="phone" name="phone">
                        </div>
                        <div class="col-md-6">
                            <label for="role" class="form-label">Role <span class="text-danger">*</span></label>
                            <select class="form-select" id="role" name="role" required>
                                <option value="">Choose role...</option>
                                <option value="USER">User</option>
                                <option value="ADMIN">Admin</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="password" class="form-label">Password <span class="text-danger">*</span></label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <div class="col-md-6">
                            <label for="confirmPassword" class="form-label">Confirm Password <span class="text-danger">*</span></label>
                            <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                        </div>
                        <div class="col-12">
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
                        <i class="fas fa-save me-2"></i>Save User
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
const contextPath = '${pageContext.request.contextPath}';

document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('searchInput').addEventListener('input', filterUsers);
    document.getElementById('roleFilter').addEventListener('change', filterUsers);
    document.getElementById('statusFilter').addEventListener('change', filterUsers);
    
    const selectAllCheckbox = document.getElementById('selectAll');
    if (selectAllCheckbox) {
        selectAllCheckbox.addEventListener('change', function() {
            const checkboxes = document.querySelectorAll('.row-select');
            checkboxes.forEach(checkbox => {
                checkbox.checked = this.checked;
            });
        });
    }
});

function filterUsers() {
    const searchTerm = document.getElementById('searchInput').value.toLowerCase();
    const role = document.getElementById('roleFilter').value;
    const status = document.getElementById('statusFilter').value;
    const rows = document.querySelectorAll('.user-row');
    
    rows.forEach(row => {
        const text = row.textContent.toLowerCase();
        const userRole = row.getAttribute('data-role');
        const userStatus = row.getAttribute('data-status');
        
        const matchesSearch = !searchTerm || text.includes(searchTerm);
        const matchesRole = !role || userRole == role;
        const matchesStatus = !status || userStatus == status;
        
        row.style.display = (matchesSearch && matchesRole && matchesStatus) ? 
            'table-row' : 'none';
    });
}

function resetFilters() {
    document.getElementById('searchInput').value = '';
    document.getElementById('roleFilter').value = '';
    document.getElementById('statusFilter').value = '';
    filterUsers();
}

function editUser(id) {
    window.location.href = contextPath + '/admin/users/edit/' + id;
}



function deleteUser(id) {
    if (confirm('Are you sure you want to delete this user? This action cannot be undone.')) {
        console.log('删除用户:', id);
        alert('删除功能即将推出！');
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