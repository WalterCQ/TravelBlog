<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="Edit Booking - Admin Panel" />
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
                       class="list-group-item list-group-item-action active">
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
                            <i class="fas fa-edit me-2 text-primary"></i>
                            <span data-i18n="admin.editBooking.title">Edit Booking</span>
                        </h1>
                        <p class="text-muted" data-i18n="admin.editBooking.subtitle">Modify booking information</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/bookings" class="btn btn-secondary">
                        <i class="fas fa-arrow-left me-2"></i><span data-i18n="admin.common.backToList">Back to List</span>
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
                        <form method="post" action="${pageContext.request.contextPath}/admin/bookings/update">
                            <input type="hidden" name="id" value="${booking.id}">
                            
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="customerName" class="form-label" data-i18n="admin.editBooking.customerName">Customer Name <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="customerName" name="customerName" 
                                           value="${booking.customerName}" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="customerEmail" class="form-label" data-i18n="admin.editBooking.customerEmail">Customer Email <span class="text-danger">*</span></label>
                                    <input type="email" class="form-control" id="customerEmail" name="customerEmail" 
                                           value="${booking.customerEmail}" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="customerPhone" class="form-label" data-i18n="admin.editBooking.customerPhone">Customer Phone <span class="text-danger">*</span></label>
                                    <input type="tel" class="form-control" id="customerPhone" name="customerPhone" 
                                           value="${booking.customerPhone}" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="numberOfParticipants" class="form-label" data-i18n="admin.editBooking.participants">Number of Participants <span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="numberOfParticipants" name="numberOfParticipants" 
                                           value="${booking.numberOfParticipants}" min="1" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="travelDate" class="form-label" data-i18n="admin.editBooking.travelDate">Travel Date <span class="text-danger">*</span></label>
                                    <input type="date" class="form-control" id="travelDate" name="travelDate" 
                                           value="${booking.travelDate}" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="totalPrice" class="form-label" data-i18n="admin.editBooking.totalPrice">Total Price <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text">RM</span>
                                        <input type="number" class="form-control" id="totalPrice" name="totalPrice" 
                                               value="${booking.totalPrice}" min="0" step="0.01" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="status" class="form-label" data-i18n="admin.editBooking.status">Booking Status <span class="text-danger">*</span></label>
                                    <select class="form-select" id="status" name="status" required>
                                        <option value="" data-i18n="admin.common.chooseStatus">Choose status...</option>
                                        <option value="PENDING" ${booking.status == 'PENDING' ? 'selected' : ''} data-i18n="admin.status.pending">Pending</option>
                                        <option value="CONFIRMED" ${booking.status == 'CONFIRMED' ? 'selected' : ''} data-i18n="admin.status.confirmed">Confirmed</option>
                                        <option value="CANCELLED" ${booking.status == 'CANCELLED' ? 'selected' : ''} data-i18n="admin.status.cancelled">Cancelled</option>
                                        <option value="COMPLETED" ${booking.status == 'COMPLETED' ? 'selected' : ''} data-i18n="admin.status.completed">Completed</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="paymentStatus" class="form-label" data-i18n="admin.editBooking.paymentStatus">Payment Status <span class="text-danger">*</span></label>
                                    <select class="form-select" id="paymentStatus" name="paymentStatus" required>
                                        <option value="" data-i18n="admin.common.choosePayment">Choose payment status...</option>
                                        <option value="PENDING" ${booking.paymentStatus == 'PENDING' ? 'selected' : ''} data-i18n="admin.payment.pending">Pending</option>
                                        <option value="PAID" ${booking.paymentStatus == 'PAID' ? 'selected' : ''} data-i18n="admin.payment.paid">Paid</option>
                                        <option value="REFUNDED" ${booking.paymentStatus == 'REFUNDED' ? 'selected' : ''} data-i18n="admin.payment.refunded">Refunded</option>
                                    </select>
                                </div>
                                <div class="col-12">
                                    <label for="notes" class="form-label" data-i18n="admin.bookings.form.notes">Notes</label>
                                    <textarea class="form-control" id="notes" name="notes" rows="3" 
                                              placeholder="Additional notes or comments..." data-i18n-attr='{"placeholder":"admin.bookings.form.notesPlaceholder"}'>${booking.notes}</textarea>
                                </div>
                                <div class="col-12">
                                    <hr>
                                    <div class="d-flex gap-2">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save me-2"></i><span data-i18n="admin.editBooking.update">Update Booking</span>
                                        </button>
                                        <a href="${pageContext.request.contextPath}/admin/bookings" class="btn btn-secondary">
                                            <i class="fas fa-times me-2"></i><span data-i18n="admin.common.cancel">Cancel</span>
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