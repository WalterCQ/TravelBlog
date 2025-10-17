<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="${pageContext.request.locale.language}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Confirmation - MyTour Global</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/main.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/pages/confirmation.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../includes/header.jsp" />

    <div class="confirmation-hero-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8 text-center">
                    <div class="success-animation mb-4">
                        <div class="checkmark-circle">
                            <div class="checkmark"></div>
                        </div>
                    </div>
                    
                    <h1 class="confirmation-title mb-3">
                        Pack Your Bags!
                    </h1>
                    <p class="confirmation-subtitle mb-4">
                        Your next great story is officially in the works. We're so excited for you!
                    </p>
                    
                    <div class="booking-reference">
                        <span class="reference-label">Your Magic Booking Code</span>
                        <div class="reference-number">${booking.bookingNumber}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container my-5">
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>
                        ${successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="row">
                    <div class="col-lg-8">
                        <div class="card booking-summary-card mb-4">
                            <div class="card-header">
                                <h4 class="mb-0">
                                    <i class="fas fa-file-alt me-2"></i>
                                    Your Adventure Blueprint
                                </h4>
                            </div>
                            <div class="card-body">
                                <div class="booking-section mb-4">
                                    <h6 class="section-title">Travel Information</h6>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="info-item">
                                                <strong>Package Name:</strong>
                                                <span>${travelPackage.name}</span>
                                            </div>
                                            <div class="info-item">
                                                <strong>Destination:</strong>
                                                <span>${destination.name}, ${destination.country}</span>
                                            </div>
                                            <div class="info-item">
                                                <strong>Departure Date:</strong>
                                                <span>${booking.departureDateAsDate}</span>
                                            </div>
                                            <c:if test="${not empty booking.returnDate}">
                                                <div class="info-item">
                                                    <strong>Return Date:</strong>
                                                    <span>${booking.returnDateAsDate}</span>
                                                </div>
                                            </c:if>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="info-item">
                                                <strong>Booking Status:</strong>
                                                <span class="badge bg-success">${booking.status}</span>
                                            </div>
                                            <div class="info-item">
                                                <strong>Payment Status:</strong>
                                                <span class="badge bg-success">${booking.paymentStatus}</span>
                                            </div>
                                            <div class="info-item">
                                                <strong>Number of Participants:</strong>
                                                <span>${booking.numberOfParticipants} people</span>
                                            </div>
                                            <div class="info-item">
                                                <strong>Total Amount:</strong>
                                                <span class="text-primary fw-bold">$${booking.totalPrice}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="booking-section mb-4">
                                    <h6 class="section-title">Lead Explorer's Info</h6>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="info-item">
                                                <strong>Contact Person:</strong>
                                                <span>${booking.customerName}</span>
                                            </div>
                                            <div class="info-item">
                                                <strong>Email:</strong>
                                                <span>${booking.customerEmail}</span>
                                            </div>
                                            <div class="info-item">
                                                <strong>Phone:</strong>
                                                <span>${booking.customerPhone}</span>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <c:if test="${not empty booking.emergencyContact}">
                                                <div class="info-item">
                                                    <strong>Emergency Contact:</strong>
                                                    <span>${booking.emergencyContact}</span>
                                                </div>
                                                <div class="info-item">
                                                    <strong>Emergency Phone:</strong>
                                                    <span>${booking.emergencyPhone}</span>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>

                                <c:if test="${not empty booking.specialRequests}">
                                    <div class="booking-section mb-4">
                                        <h6 class="section-title">Your Special Quests</h6>
                                        <div class="special-requests-box">
                                            <p class="mb-0">${booking.specialRequests}</p>
                                        </div>
                                    </div>
                                </c:if>

                                <div class="booking-section">
                                    <h6 class="section-title">Payment Mission Control</h6>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="info-item">
                                                <strong>Payment Method:</strong>
                                                <span class="text-capitalize">${booking.paymentMethod}</span>
                                            </div>
                                            <div class="info-item">
                                                <strong>Payment Status:</strong>
                                                <span class="badge bg-success">${booking.paymentStatus}</span>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="info-item">
                                                <strong>Booking Time:</strong>
                                                <span><fmt:formatDate value="${booking.createdAtAsDate}" pattern="yyyy-MM-dd HH:mm" /></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="card next-steps-card mb-4">
                            <div class="card-header">
                                <h5 class="mb-0">
                                    <i class="fas fa-list-check me-2"></i>
                                    The Countdown Begins
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="timeline">
                                    <div class="timeline-item">
                                        <div class="timeline-marker completed">
                                            <i class="fas fa-check"></i>
                                        </div>
                                        <div class="timeline-content">
                                            <h6>Confirmation Secured!</h6>
                                            <p class="text-muted">Your spot is locked in. High-five!</p>
                                        </div>
                                    </div>
                                    <div class="timeline-item">
                                        <div class="timeline-marker">
                                            <i class="fas fa-envelope"></i>
                                        </div>
                                        <div class="timeline-content">
                                            <h6>Email Is On Its Way</h6>
                                            <p class="text-muted">A detailed confirmation is flying to your inbox as we speak.</p>
                                        </div>
                                    </div>
                                    <div class="timeline-item">
                                        <div class="timeline-marker">
                                            <i class="fas fa-phone"></i>
                                        </div>
                                        <div class="timeline-content">
                                            <h6>Pre-Trip Check-In</h6>
                                            <p class="text-muted">We'll buzz you 3 days before departure to make sure you're all set.</p>
                                        </div>
                                    </div>
                                    <div class="timeline-item">
                                        <div class="timeline-marker">
                                            <i class="fas fa-plane"></i>
                                        </div>
                                        <div class="timeline-content">
                                            <h6>Adventure Time!</h6>
                                            <p class="text-muted">Time to make some memories. We've got your back 24/7.</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="card important-info-card">
                            <div class="card-header">
                                <h5 class="mb-0">
                                    <i class="fas fa-info-circle me-2"></i>
                                    A Few Pro Tips
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="info-list">
                                    <div class="info-item">
                                        <i class="fas fa-passport text-primary me-2"></i>
                                        <span>Double-check that your passport is ready for adventure.</span>
                                    </div>
                                    <div class="info-item">
                                        <i class="fas fa-suitcase text-primary me-2"></i>
                                        <span>Pro-Tip: Start thinking about packing a week out. No last-minute sock scrambles!</span>
                                    </div>
                                    <div class="info-item">
                                        <i class="fas fa-phone text-primary me-2"></i>
                                        <span>Got a question? Our 24/7 support squad is always on standby.</span>
                                    </div>
                                    <div class="info-item">
                                        <i class="fas fa-heart text-primary me-2"></i>
                                        <span>Don't forget your adventure's superhero cape: travel insurance. We recommend it!</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="confirmation-actions text-center mt-5">
                    <div class="row justify-content-center">
                        <div class="col-auto">
                            <button onclick="window.print()" class="btn btn-outline-primary me-2">
                                <i class="fas fa-print me-2"></i>Print Your Bragging Rights
                            </button>
                        </div>
                        <div class="col-auto">
                            <button onclick="shareBooking()" class="btn btn-outline-success me-2">
                                <i class="fas fa-share me-2"></i>Make Friends Jealous
                            </button>
                        </div>
                        <div class="col-auto">
                            <a href="${pageContext.request.contextPath}/my-bookings" class="btn btn-primary me-2">
                                <i class="fas fa-list me-2"></i>My Adventure Log
                            </a>
                        </div>
                        <div class="col-auto">
                            <a href="${pageContext.request.contextPath}/packages" class="btn btn-success">
                                <i class="fas fa-plus me-2"></i>Plan Another Escape
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="support-section py-5">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8 text-center">
                    <h3 class="mb-4">Still Have Questions?</h3>
                    <p class="mb-4">No worries! Our globetrotting support team is here for you 24/7.</p>
                    
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <div class="support-contact-card">
                                <div class="contact-icon">
                                    <i class="fas fa-phone"></i>
                                </div>
                                <h6>Phone Support</h6>
                                <p><strong>+60 3-1234 5678</strong><br>
                                24-hour Customer Hotline</p>
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="support-contact-card">
                                <div class="contact-icon">
                                    <i class="fas fa-envelope"></i>
                                </div>
                                <h6>Email Support</h6>
                                <p><strong>support@mytour.my</strong><br>
                                Usually replies within 24 hours</p>
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="support-contact-card">
                                <div class="contact-icon">
                                    <i class="fas fa-comments"></i>
                                </div>
                                <h6>Online Chat</h6>
                                <p><strong>Instant Chat</strong><br>
                                Monday to Sunday 9:00-21:00</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        async function shareBooking() {
            const shareData = {
                title: 'My Travel Booking',
                text: 'Check out my upcoming trip to Malaysia!',
                url: window.location.href
            };

            try {
                if (navigator.share) {
                    await navigator.share(shareData);
                } else {
                    navigator.clipboard.writeText(window.location.href);
                    alert('Booking link copied to clipboard!');
                }
            } catch (error) {
                console.log('Share failed:', error);
            }
        }

        document.addEventListener('DOMContentLoaded', function() {
            const checkmark = document.querySelector('.checkmark');
            if (checkmark) {
                setTimeout(() => {
                    checkmark.classList.add('draw');
                }, 500);
            }
        });
    </script>

    <style>
        .success-animation {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .checkmark-circle {
            width: 80px;
            height: 80px;
            position: relative;
            display: inline-block;
            vertical-align: top;
        }

        .checkmark-circle::before {
            content: '';
            width: 80px;
            height: 80px;
            position: absolute;
            left: 0;
            top: 0;
            background-color: #28a745;
            border-radius: 50%;
            animation: circle-animate 0.6s ease-in-out forwards;
        }

        .checkmark {
            width: 32px;
            height: 20px;
            position: absolute;
            left: 24px;
            top: 30px;
            transform: rotate(45deg);
        }

        .checkmark::before {
            content: '';
            position: absolute;
            width: 3px;
            height: 9px;
            background-color: white;
            left: 8px;
            top: 6px;
        }

        .checkmark::after {
            content: '';
            position: absolute;
            width: 3px;
            height: 16px;
            background-color: white;
            left: 13px;
            top: 0px;
        }

        .checkmark.draw::before {
            animation: checkmark-short 0.3s ease-in-out 0.6s forwards;
        }

        .checkmark.draw::after {
            animation: checkmark-long 0.3s ease-in-out 0.9s forwards;
        }

        @keyframes circle-animate {
            0% {
                opacity: 0;
                transform: scale(0);
            }
            100% {
                opacity: 1;
                transform: scale(1);
            }
        }

        @keyframes checkmark-short {
            0% {
                height: 0;
            }
            100% {
                height: 9px;
            }
        }

        @keyframes checkmark-long {
            0% {
                height: 0;
            }
            100% {
                height: 16px;
            }
        }

        .timeline {
            position: relative;
            padding-left: 2rem;
        }

        .timeline::before {
            content: '';
            position: absolute;
            left: 1rem;
            top: 0;
            bottom: 0;
            width: 2px;
            background: #e9ecef;
        }

        .timeline-item {
            position: relative;
            margin-bottom: 2rem;
        }

        .timeline-marker {
            position: absolute;
            left: -2rem;
            top: 0;
            width: 2rem;
            height: 2rem;
            background: #e9ecef;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #6c757d;
            font-size: 0.8rem;
        }

        .timeline-marker.completed {
            background: #28a745;
            color: white;
        }

        .timeline-content h6 {
            margin-bottom: 0.5rem;
            color: #495057;
        }

        .info-list .info-item {
            display: flex;
            align-items: center;
            margin-bottom: 1rem;
            padding: 0.75rem;
            background: rgba(248, 249, 250, 0.5);
            border-radius: 8px;
        }

        .section-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: #495057;
            margin-bottom: 1rem;
            padding-bottom: 0.5rem;
            border-bottom: 2px solid rgba(102, 126, 234, 0.2);
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.75rem;
            padding: 0.5rem 0;
        }

        .special-requests-box {
            background: rgba(248, 249, 250, 0.8);
            border-radius: 8px;
            padding: 1rem;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        .booking-summary-card,
        .next-steps-card,
        .important-info-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
            border-radius: 15px 15px 0 0 !important;
        }

        .confirmation-actions {
            background: rgba(248, 249, 250, 0.5);
            border-radius: 15px;
            padding: 2rem;
        }

        .support-section {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        }

        .support-contact-card {
            background: white;
            padding: 2rem 1.5rem;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            height: 100%;
        }

        .support-contact-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.15);
        }

        .contact-icon {
            font-size: 2.5rem;
            color: #28a745;
            margin-bottom: 1rem;
        }
    </style>

    <jsp:include page="../includes/footer.jsp" />
</body>
</html>