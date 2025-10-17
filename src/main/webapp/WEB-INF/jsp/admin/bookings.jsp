<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="Booking Management - Admin Panel" />
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
    min-width: 180px;
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
                        <i data-lucide="map-pin" class="me-2"></i><span data-i18n="admin.menu.destinations">Destinations</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/packages" 
                       class="list-group-item list-group-item-action">
                        <i data-lucide="box" class="me-2"></i><span data-i18n="admin.menu.packages">Packages</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/bookings" 
                       class="list-group-item list-group-item-action active">
                        <i data-lucide="calendar-check" class="me-2"></i><span data-i18n="admin.menu.bookings">Bookings</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/users" 
                       class="list-group-item list-group-item-action">
                        <i data-lucide="users" class="me-2"></i><span data-i18n="admin.menu.users">Users</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/messages" 
                       class="list-group-item list-group-item-action">
                        <i data-lucide="mail" class="me-2"></i><span data-i18n="admin.menu.messages">Messages</span>
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-9 col-lg-10">
            <div class="admin-content">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h1 class="h3 mb-0">
                            <i data-lucide="calendar-check" class="me-2 text-primary"></i>
                            <span data-i18n="admin.bookings.title">Booking Management</span>
                        </h1>
                        <p class="text-muted" data-i18n="admin.bookings.subtitle">Manage customer bookings and reservations</p>
                    </div>
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addBookingModal">
                        <i data-lucide="plus" class="me-2"></i><span data-i18n="admin.bookings.add">Add Booking</span>
                    </button>
                </div>

                <c:if test="${not empty message}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i data-lucide="check-circle" class="me-2"></i>${message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i data-lucide="alert-triangle" class="me-2"></i>${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="card border-0 shadow-sm">
                    <div class="card-body">
                        <div class="row g-3 mb-4">
                            <div class="col-md-3">
                                <div class="input-group">
                                    <span class="input-group-text">
                                        <i data-lucide="search"></i>
                                    </span>
                                    <input type="text" class="form-control" id="searchInput" data-i18n-attr='{"placeholder":"admin.bookings.search"}' placeholder="Search bookings...">
                                </div>
                            </div>
                            <div class="col-md-2">
                                <select class="form-select" id="statusFilter">
                                    <option value="" data-i18n="admin.common.allStatus">All Status</option>
                                    <option value="PENDING" data-i18n="admin.status.pending">Pending</option>
                                    <option value="CONFIRMED" data-i18n="admin.status.confirmed">Confirmed</option>
                                    <option value="CANCELLED" data-i18n="admin.status.cancelled">Cancelled</option>
                                    <option value="COMPLETED" data-i18n="admin.status.completed">Completed</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <select class="form-select" id="paymentStatusFilter">
                                    <option value="" data-i18n="admin.common.allPayment">All Payment</option>
                                    <option value="PENDING" data-i18n="admin.payment.pending">Pending</option>
                                    <option value="PAID" data-i18n="admin.payment.paid">Paid</option>
                                    <option value="REFUNDED" data-i18n="admin.payment.refunded">Refunded</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <input type="date" class="form-control" id="dateFromFilter" data-i18n-attr='{"placeholder":"admin.common.fromDate"}' placeholder="From Date">
                            </div>
                            <div class="col-md-2">
                                <input type="date" class="form-control" id="dateToFilter" data-i18n-attr='{"placeholder":"admin.common.toDate"}' placeholder="To Date">
                            </div>
                            <div class="col-md-1">
                                <button class="btn btn-outline-secondary w-100" onclick="resetFilters()" title="Reset" data-i18n-attr='{"title":"common.reset"}'>
                                    <i data-lucide="rotate-ccw"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th data-i18n="admin.bookings.th.id">Booking ID</th>
                                <th data-i18n="admin.bookings.th.customer">Customer</th>
                                <th data-i18n="admin.bookings.th.package">Package</th>
                                <th data-i18n="admin.bookings.th.travelDate">Travel Date</th>
                                <th data-i18n="admin.bookings.th.totalPrice">Total Price</th>
                                <th data-i18n="admin.bookings.th.status">Status</th>
                                <th data-i18n="admin.bookings.th.paymentStatus">Payment Status</th>
                                <th data-i18n="admin.bookings.th.actions">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty bookings}">
                                    <tr>
                                        <td colspan="8" class="text-center py-5">
                                            <i data-lucide="calendar-check" class="text-muted mb-3" style="width:64px;height:64px;"></i>
                                            <h4 class="text-muted" data-i18n="admin.bookings.empty.title">No bookings found</h4>
                                            <p class="text-muted" data-i18n="admin.bookings.empty.desc">Customer bookings will appear here</p>
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="booking" items="${bookings}">
                                        <tr class="booking-row" data-booking-id="${booking.id}">
                                            <td>
                                                <strong>#${booking.id}</strong>
                                                <small class="text-muted d-block">
                                                    <c:choose>
                                                        <c:when test="${booking.bookingDate != null}">
                                                            <c:out value="${booking.bookingDate.toString()}" />
                                                        </c:when>
                                                        <c:otherwise>
                                                            Not available
                                                        </c:otherwise>
                                                    </c:choose>
                                                </small>
                                            </td>
                                            <td>
                                                <div class="customer-info">
                                                    <strong>${booking.customerName}</strong>
                                                    <small class="text-muted d-block">${booking.customerEmail}</small>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="package-info">
                                                    <strong>${booking.packageName}</strong>
                                                    <small class="text-muted d-block">${booking.destinationName}</small>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="travel-dates">
                                                    <strong>
                                                        <c:choose>
                                                            <c:when test="${booking.travelDate != null}">
                                                                <c:out value="${booking.travelDate.toString()}" />
                                                            </c:when>
                                                            <c:otherwise>
                                                                Not set
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </strong>
                                                    <small class="text-muted d-block">
                                                        <c:choose>
                                                            <c:when test="${booking.numberOfParticipants != null}">
                                                                <c:out value="${booking.numberOfParticipants}" /> travelers
                                                            </c:when>
                                                            <c:otherwise>
                                                                - travelers
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </small>
                                                </div>
                                            </td>
                                            <td>
                                                <strong class="text-success">RM ${booking.totalPrice}</strong>
                                            </td>
                                            <td>
                                                <select class="form-select form-select-sm" 
                                                        data-id="${booking.id}" 
                                                        data-field="status"
                                                        data-original="${booking.status}">
                                                    <option value="PENDING" ${booking.status == 'PENDING' ? 'selected' : ''} data-i18n="admin.status.pending">Pending</option>
                                                    <option value="CONFIRMED" ${booking.status == 'CONFIRMED' ? 'selected' : ''} data-i18n="admin.status.confirmed">Confirmed</option>
                                                    <option value="CANCELLED" ${booking.status == 'CANCELLED' ? 'selected' : ''} data-i18n="admin.status.cancelled">Cancelled</option>
                                                    <option value="COMPLETED" ${booking.status == 'COMPLETED' ? 'selected' : ''} data-i18n="admin.status.completed">Completed</option>
                                                </select>
                                            </td>
                                            <td>
                                                <select class="form-select form-select-sm" 
                                                        data-id="${booking.id}" 
                                                        data-field="paymentStatus"
                                                        data-original="${booking.paymentStatus}">
                                                    <option value="PENDING" ${booking.paymentStatus == 'PENDING' ? 'selected' : ''} data-i18n="admin.payment.pending">Pending</option>
                                                    <option value="PAID" ${booking.paymentStatus == 'PAID' ? 'selected' : ''} data-i18n="admin.payment.paid">Paid</option>
                                                    <option value="REFUNDED" ${booking.paymentStatus == 'REFUNDED' ? 'selected' : ''} data-i18n="admin.payment.refunded">Refunded</option>
                                                </select>
                                            </td>
                                            <td>
                                                <div class="d-flex gap-1 justify-content-start">
                                                    <button type="button" class="btn btn-sm btn-outline-primary" 
                                                            onclick="editBooking(${booking.id})"
                                                            title="Edit" data-i18n-attr='{"title":"admin.common.edit"}'>
                                                        <i data-lucide="edit"></i>
                                                    </button>
                                                    <button type="button" class="btn btn-sm btn-outline-danger" 
                                                            onclick="deleteBooking(${booking.id})"
                                                            title="Delete" data-i18n-attr='{"title":"admin.common.delete"}'>
                                                        <i data-lucide="trash-2"></i>
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

<div class="modal fade" id="addBookingModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i data-lucide="plus" class="me-2"></i><span data-i18n="admin.bookings.addNew">Add New Booking</span>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form method="post" action="${pageContext.request.contextPath}/admin/bookings/add" id="addBookingForm">
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="customerName" class="form-label"><span data-i18n="admin.bookings.form.customerName">Customer Name</span> <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="customerName" name="customerName" required>
                        </div>
                        <div class="col-md-6">
                            <label for="customerEmail" class="form-label"><span data-i18n="admin.bookings.form.customerEmail">Customer Email</span> <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" id="customerEmail" name="customerEmail" required>
                        </div>
                        <div class="col-md-6">
                            <label for="packageName" class="form-label"><span data-i18n="admin.bookings.form.packageName">Package Name</span> <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="packageName" name="packageName" required>
                        </div>
                        <div class="col-md-6">
                            <label for="numberOfParticipants" class="form-label"><span data-i18n="admin.bookings.form.participants">Number of Participants</span> <span class="text-danger">*</span></label>
                            <input type="number" class="form-control" id="numberOfParticipants" name="numberOfParticipants" min="1" required>
                        </div>
                        <div class="col-md-6">
                            <label for="travelDate" class="form-label"><span data-i18n="admin.bookings.form.travelDate">Travel Date</span> <span class="text-danger">*</span></label>
                            <input type="date" class="form-control" id="travelDate" name="travelDate" required>
                        </div>
                        <div class="col-md-6">
                            <label for="totalPrice" class="form-label"><span data-i18n="admin.bookings.form.totalPrice">Total Price</span> <span class="text-danger">*</span></label>
                            <div class="input-group">
                                <span class="input-group-text">RM</span>
                                <input type="number" class="form-control" id="totalPrice" name="totalPrice" min="0" step="0.01" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="status" class="form-label"><span data-i18n="admin.bookings.form.status">Status</span> <span class="text-danger">*</span></label>
                            <select class="form-select" id="status" name="status" required>
                                <option value="" data-i18n="admin.common.chooseStatus">Choose status...</option>
                                <option value="PENDING">Pending</option>
                                <option value="CONFIRMED">Confirmed</option>
                                <option value="CANCELLED">Cancelled</option>
                                <option value="COMPLETED">Completed</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label for="paymentStatus" class="form-label"><span data-i18n="admin.bookings.form.paymentStatus">Payment Status</span> <span class="text-danger">*</span></label>
                            <select class="form-select" id="paymentStatus" name="paymentStatus" required>
                                <option value="" data-i18n="admin.common.choosePayment">Choose payment status...</option>
                                <option value="PENDING">Pending</option>
                                <option value="PAID">Paid</option>
                                <option value="REFUNDED">Refunded</option>
                            </select>
                        </div>
                        <div class="col-12">
                            <label for="notes" class="form-label" data-i18n="admin.bookings.form.notes">Notes</label>
                            <textarea class="form-control" id="notes" name="notes" rows="3" data-i18n-attr='{"placeholder":"admin.bookings.form.notesPlaceholder"}' placeholder="Additional notes or comments..."></textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" data-i18n="admin.common.cancel">Cancel</button>
                    <button type="submit" class="btn btn-primary">
                        <i data-lucide="save" class="me-2"></i><span data-i18n="admin.bookings.form.save">Save Booking</span>
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
const contextPath = '${pageContext.request.contextPath}';

function filterBookings() {
    const searchValue = document.getElementById('searchInput').value.toLowerCase();
    const statusValue = document.getElementById('statusFilter').value;
    const paymentStatusValue = document.getElementById('paymentStatusFilter').value;
    const dateFromValue = document.getElementById('dateFromFilter').value;
    const dateToValue = document.getElementById('dateToFilter').value;

    document.querySelectorAll('.booking-row').forEach(row => {
        const text = row.textContent.toLowerCase();
        const status = row.querySelector('select[data-field="status"]').value;
        const paymentStatus = row.querySelector('select[data-field="paymentStatus"]').value;

        const matchesSearch = text.includes(searchValue);
        const matchesStatus = !statusValue || status == statusValue;
        const matchesPaymentStatus = !paymentStatusValue || paymentStatus == paymentStatusValue;

        row.style.display = matchesSearch && matchesStatus && matchesPaymentStatus ? '' : 'none';
    });
}

function resetFilters() {
    document.getElementById('searchInput').value = '';
    document.getElementById('statusFilter').value = '';
    document.getElementById('paymentStatusFilter').value = '';
    document.getElementById('dateFromFilter').value = '';
    document.getElementById('dateToFilter').value = '';
    filterBookings();
}


function editBooking(id) {
    window.location.href = contextPath + '/admin/bookings/edit/' + id;
}

function deleteBooking(id) {
    if (confirm('Are you sure you want to delete this booking? This action cannot be undone.')) {
        fetch(contextPath + '/admin/bookings/delete/' + id, {
            method: 'DELETE'
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                showNotification('Booking deleted successfully', 'success');
                location.reload();
            } else {
                showNotification('Failed to delete booking', 'error');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            showNotification('Error deleting booking', 'error');
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

document.addEventListener('DOMContentLoaded', function() {
    document.getElementById('searchInput').addEventListener('input', filterBookings);
    document.getElementById('statusFilter').addEventListener('change', filterBookings);
    document.getElementById('paymentStatusFilter').addEventListener('change', filterBookings);
    document.getElementById('dateFromFilter').addEventListener('change', filterBookings);
    document.getElementById('dateToFilter').addEventListener('change', filterBookings);
});
</script>

</body>
</html>