<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="My Bookings - MyTour Global" />
</jsp:include>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/my-bookings.css">

<!-- Include i18n script for translations -->
<script src="${pageContext.request.contextPath}/js/core/i18n.js"></script>

<jsp:include page="../includes/navigation.jsp">
    <jsp:param name="currentPage" value="bookings" />
</jsp:include>

<div class="bookings-page-wrapper">

<section class="page-header">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <h1 class="page-title" data-i18n="bookings.title">My Bookings</h1>
                <p class="page-subtitle" data-i18n="bookings.subtitle">Manage your travel bookings and view upcoming trips.</p>
            </div>
        </div>
    </div>
</section>

<section class="bookings-section">
    <div class="container">
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i data-lucide="alert-triangle" style="width: 20px; height: 20px; margin-right: 8px;"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i data-lucide="check-circle" style="width: 20px; height: 20px; margin-right: 8px;"></i>${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        
        <c:choose>
            <c:when test="${not empty bookings}">
                <div class="row stats-container">
                    <div class="col-md-3 mb-3">
                        <div class="stat-card">
                            <div class="stat-icon total">
                                <i data-lucide="calendar-check" style="width: 24px; height: 24px;"></i>
                            </div>
                             <div class="stat-content">
                                 <p data-i18n="bookings.stats.total">Total Bookings</p>
                                 <h3>${not empty bookings ? bookings.size() : 0}</h3>
                             </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <div class="stat-card">
                            <div class="stat-icon pending">
                                <i data-lucide="clock" style="width: 24px; height: 24px;"></i>
                            </div>
                             <div class="stat-content">
                                 <p data-i18n="bookings.stats.pending">Pending</p>
                                 <h3>${pendingCount != null ? pendingCount : 0}</h3>
                             </div>
                        </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <div class="stat-card">
                            <div class="stat-icon confirmed">
                                <i data-lucide="check-circle" style="width: 24px; height: 24px;"></i>
                            </div>
                             <div class="stat-content">
                                 <p data-i18n="bookings.stats.confirmed">Confirmed</p>
                                 <h3>${confirmedCount != null ? confirmedCount : 0}</h3>
                             </div>
                        </div>
                    </div>
                     <div class="col-md-3 mb-3">
                        <div class="stat-card">
                            <div class="stat-icon completed">
                                <i data-lucide="check-square" style="width: 24px; height: 24px;"></i>
                            </div>
                             <div class="stat-content">
                                 <p data-i18n="bookings.stats.completed">Completed</p>
                                 <h3>${completedCount != null ? completedCount : 0}</h3>
                             </div>
                        </div>
                    </div>
                </div>
                
                <div class="bookings-table-card">
                    <div class="bookings-table-header">
                        <h5>
                            <i data-lucide="list" style="width: 28px; height: 28px;"></i>
                            <span data-i18n="bookings.history.title">Booking History</span>
                        </h5>
                    </div>
                    <div class="table-responsive">
                        <table class="bookings-table" id="bookingsTable">
                                        <thead>
                                            <tr>
                                                <th><span data-i18n="bookings.table.ref">Booking Ref</span></th>
                                                <th><span data-i18n="bookings.table.date">Travel Date</span></th>
                                                <th><span data-i18n="bookings.table.guests">Guests</span></th>
                                                <th><span data-i18n="bookings.table.price">Total Price</span></th>
                                                <th><span data-i18n="bookings.table.status">Status</span></th>
                                            </tr>
                                        </thead>
                                <tbody>
                                    <c:forEach var="booking" items="${bookings}">
                                        <tr data-booking-id="${booking.id}">
                                            <td>
                                                <strong class="booking-ref">${booking.bookingNumber}</strong>
                                                <br>
                                                <small class="booking-date">${booking.formattedBookingDate}</small>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${booking.departureDateAsDate}" pattern="MMM dd, yyyy" />
                                            </td>
                                            <td>
                                                <span class="participants-badge">${booking.participantsDisplay}</span>
                                            </td>
                                            <td>
                                                <strong class="booking-price">${booking.formattedTotalPrice}</strong>
                                            </td>
                                            <td>
                                                <span class="status-badge ${booking.statusBadgeClass}">${booking.statusDisplay}</span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state-card">
                    <div class="empty-state-icon">
                        <i data-lucide="luggage" style="width: 56px; height: 56px;"></i>
                    </div>
                    <h4 data-i18n="bookings.empty.title">No Bookings Yet!</h4>
                    <p data-i18n="bookings.empty.message">Your travel adventures are waiting. Let's find your next destination.</p>
                    <div class="mt-4">
                        <a href="${pageContext.request.contextPath}/packages" class="btn-browse-packages">
                            <i data-lucide="package" style="width: 20px; height: 20px; margin-right: 8px;"></i>
                            <span data-i18n="bookings.empty.action">Browse Packages</span>
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

</div><!-- End of bookings-page-wrapper -->

<div class="modal fade" id="bookingDetailsModal" tabindex="-1" aria-labelledby="bookingDetailsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="bookingDetailsModalLabel">
                    <i data-lucide="info" style="width: 24px; height: 24px; margin-right: 8px;"></i>
                    <span data-i18n="bookings.modal.title">Booking Details</span>
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="bookingDetailsContent">
                <div class="text-center py-5"><div class="spinner-border text-primary" role="status"></div></div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                    <span data-i18n="bookings.modal.close">Close</span>
                </button>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
    const bookingsTable = document.getElementById('bookingsTable');
    const bookingDetailsModal = new bootstrap.Modal(document.getElementById('bookingDetailsModal'));
    const bookingDetailsContent = document.getElementById('bookingDetailsContent');
    const contextPath = '${pageContext.request.contextPath}';

    if (bookingsTable) {
        bookingsTable.addEventListener('click', function (e) {
            const target = e.target;
            const bookingRow = target.closest('tr[data-booking-id]');
            if (!bookingRow) return;

            const bookingId = bookingRow.dataset.bookingId;
            
            if (target.classList.contains('action-view')) {
                e.preventDefault();
                viewBooking(bookingId);
            } else if (target.classList.contains('action-pay')) {
                e.preventDefault();
                payBooking(bookingId);
            } else if (target.classList.contains('action-cancel')) {
                e.preventDefault();
                cancelBooking(bookingId);
            } else if (target.classList.contains('action-review')) {
                e.preventDefault();
                reviewBooking(bookingId);
            }
        });
    }

    function viewBooking(bookingId) {
        bookingDetailsContent.innerHTML = `<div class="text-center py-5"><div class="spinner-border text-primary" role="status"></div></div>`;
        bookingDetailsModal.show();
        
        fetch(`${contextPath}/api/bookings/${bookingId}`)
            .then(response => {
                if (!response.ok) throw new Error('Network response was not ok');
                return response.json();
            })
            .then(data => {
                bookingDetailsContent.innerHTML = createBookingDetailsHTML(data);
            })
            .catch(error => {
                console.error('Error loading booking details:', error);
                bookingDetailsContent.innerHTML = `<div class="alert alert-danger">Failed to load booking details. Please try again.</div>`;
            });
    }

    function createBookingDetailsHTML(booking) {
        const departureDate = new Date(booking.departureDateAsDate).toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' });
        const returnDateHtml = booking.formattedReturnDate ? `<p><strong>Return Date:</strong> ${booking.formattedReturnDate}</p>` : '';
		
        let html = `
            <div class="booking-details">
                <div class="booking-details-section">
                    <div class="row">
                        <div class="col-md-6">
                            <p class="mb-1"><strong>Booking Number:</strong> ${booking.bookingNumber}</p>
                            <p class="mb-0"><strong>Package:</strong> ${booking.packageName}</p>
                        </div>
                        <div class="col-md-6 text-md-end">
                            <span class="status-badge ${booking.statusBadgeClass}">${booking.statusDisplay}</span>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="booking-details-section">
                            <h6>Booking Info</h6>
                            <p><strong>Payment Status:</strong> <span class="payment-badge ${booking.paymentStatusBadgeClass}">${booking.paymentStatusDisplay}</span></p>
                            <p><strong>Total Amount:</strong> ${booking.formattedTotalPrice}</p>
                            <p><strong>Participants:</strong> ${booking.participantsDisplay}</p>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="booking-details-section">
                            <h6>Travel Info</h6>
                            <p><strong>Destination:</strong> ${booking.destinationName}</p>
                            <p><strong>Departure Date:</strong> ${departureDate}</p>
                            ${returnDateHtml}
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-6">
                        <div class="booking-details-section">
                            <h6>Customer Info</h6>
                            <p><strong>Name:</strong> ${booking.customerName}</p>
                            <p><strong>Email:</strong> ${booking.customerEmail}</p>
                            <p><strong>Phone:</strong> ${booking.customerPhone || 'N/A'}</p>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="booking-details-section">
                            <h6>Emergency Contact</h6>
                            <p><strong>Name:</strong> ${booking.emergencyContact || 'Not provided'}</p>
                            <p><strong>Phone:</strong> ${booking.emergencyPhone || 'Not provided'}</p>
                        </div>
                    </div>
                </div>`;
        
        // Add special requests if available
        if (booking.specialRequests) {
            html += `
                <div class="booking-details-section">
                    <h6>Special Requests</h6>
                    <p>${booking.specialRequests}</p>
                </div>`;
        }
        
        // Add notes if available
        if (booking.notes) {
            html += `
                <div class="booking-details-section">
                    <h6>Notes</h6>
                    <p>${booking.notes}</p>
                </div>`;
        }
        
        html += `</div>`;
        return html;
    }
    
    function payBooking(bookingId) {
        // Implement SweetAlert for a nicer confirmation dialog
        if (confirm('Proceed to payment for this booking?')) {
            window.location.href = `${contextPath}/payment?booking=${bookingId}`;
        }
    }

    function cancelBooking(bookingId) {
        if (confirm('Are you sure you want to cancel this booking? This action cannot be undone.')) {
            fetch(`${contextPath}/api/bookings/${bookingId}/cancel`, { method: 'POST' })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        location.reload();
                    } else {
                        alert(`Failed to cancel booking: ${data.message || 'Unknown error'}`);
                    }
                })
                .catch(error => {
                    console.error('Error cancelling booking:', error);
                    alert('An error occurred while trying to cancel the booking.');
                });
        }
    }

    function reviewBooking(bookingId) {
        window.location.href = `${contextPath}/review?booking=${bookingId}`;
    }
});

// Initialize Lucide icons
if (typeof lucide !== 'undefined') {
    lucide.createIcons();
}
</script>

<jsp:include page="../includes/footer.jsp" />