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
    <link href="${pageContext.request.contextPath}/css/confirmation.css" rel="stylesheet">
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
                    
                    <h1 class="confirmation-title mb-3" data-i18n="bookingConf.title">
                        Booking Confirmed!
                    </h1>
                    <p class="confirmation-subtitle mb-4" data-i18n="bookingConf.subtitle">
                        Thank you for choosing MyTour Global, your Malaysia journey is about to begin!
                    </p>
                    
                    <div class="booking-reference">
                        <span class="reference-label" data-i18n="bookingConf.reference">Booking Number</span>
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
                        <i class="data-lucide="check-circle" me-2"></i>
                        ${successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <div class="row">
                    <div class="col-lg-8">
                        <div class="card booking-summary-card mb-4">
                            <div class="card-header">
                                <h4 class="mb-0">
                                    <i class="data-lucide="file-text" me-2"></i>
                                    <span data-i18n="bookingConf.details">Booking Details</span>
                                </h4>
                            </div>
                            <div class="card-body">
                                <div class="booking-section mb-4">
                                    <h6 class="section-title" data-i18n="bookingConf.travelInfo">Travel Information</h6>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="info-item">
                                                <strong data-i18n="bookingConf.packageName">Package Name:</strong>
                                                <span>${travelPackage.name}</span>
                                            </div>
                                            <div class="info-item">
                                                <strong data-i18n="bookingConf.destination">Destination:</strong>
                                                <span>${destination.name}, ${destination.country}</span>
                                            </div>
                                            <div class="info-item">
                                                <strong data-i18n="bookingConf.departure">Departure Date:</strong>
                                                <span>${booking.departureDateAsDate}</span>
                                            </div>
                                            <c:if test="${not empty booking.returnDate}">
                                                <div class="info-item">
                                                    <strong data-i18n="bookingConf.return">Return Date:</strong>
                                                    <span>${booking.returnDateAsDate}</span>
                                                </div>
                                            </c:if>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="info-item">
                                                <strong data-i18n="bookingConf.bookingStatus">Booking Status:</strong>
                                                <span class="badge bg-success">${booking.status}</span>
                                            </div>
                                            <div class="info-item">
                                                <strong data-i18n="bookingConf.paymentStatus">Payment Status:</strong>
                                                <span class="badge bg-success">${booking.paymentStatus}</span>
                                            </div>
                                            <div class="info-item">
                                                <strong data-i18n="bookingConf.participants">Number of Participants:</strong>
                                                <span>${booking.numberOfParticipants} persons</span>
                                            </div>
                                            <div class="info-item">
                                                <strong data-i18n="bookingConf.total">Total Amount:</strong>
                                                <span class="text-primary fw-bold">$${booking.totalPrice}</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="booking-section mb-4">
                                    <h6 class="section-title" data-i18n="bookingConf.contactInfo">Contact Information</h6>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="info-item">
                                                <strong data-i18n="bookingConf.contactPerson">Contact Person:</strong>
                                                <span>${booking.customerName}</span>
                                            </div>
                                            <div class="info-item">
                                                <strong data-i18n="bookingConf.email">Email:</strong>
                                                <span>${booking.customerEmail}</span>
                                            </div>
                                            <div class="info-item">
                                                <strong data-i18n="bookingConf.phone">Phone:</strong>
                                                <span>${booking.customerPhone}</span>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <c:if test="${not empty booking.emergencyContact}">
                                                <div class="info-item">
                                                    <strong data-i18n="bookingConf.emergencyContact">Emergency Contact:</strong>
                                                    <span>${booking.emergencyContact}</span>
                                                </div>
                                                <div class="info-item">
                                                    <strong data-i18n="bookingConf.emergencyPhone">Emergency Phone:</strong>
                                                    <span>${booking.emergencyPhone}</span>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>

                                <c:if test="${not empty booking.specialRequests}">
                                    <div class="booking-section mb-4">
                                        <h6 class="section-title" data-i18n="bookingConf.special">Special Requests</h6>
                                        <div class="special-requests-box">
                                            <p class="mb-0">${booking.specialRequests}</p>
                                        </div>
                                    </div>
                                </c:if>

                                <div class="booking-section">
                                    <h6 class="section-title" data-i18n="bookingConf.paymentInfo">Payment Information</h6>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="info-item">
                                                <strong data-i18n="bookingConf.paymentMethod">Payment Method:</strong>
                                                <span class="text-capitalize">${booking.paymentMethod}</span>
                                            </div>
                                            <div class="info-item">
                                                <strong data-i18n="bookingConf.paymentStatus">Payment Status:</strong>
                                                <span class="badge bg-success">${booking.paymentStatus}</span>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="info-item">
                                                <strong data-i18n="bookingConf.bookingTime">Booking Time:</strong>
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
                                    <i class="data-lucide="list-checks" me-2"></i>
                                    <span data-i18n="bookingConf.nextSteps">Next Steps</span>
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="timeline">
                                    <div class="timeline-item">
                                        <div class="timeline-marker completed">
                                            <i class="data-lucide="check""></i>
                                        </div>
                                        <div class="timeline-content">
                                            <h6 data-i18n="bookingConf.next1.title">Booking Confirmation</h6>
                                            <p class="text-muted" data-i18n="bookingConf.next1.desc">Your booking has been confirmed and recorded</p>
                                        </div>
                                    </div>
                                    <div class="timeline-item">
                                        <div class="timeline-marker">
                                            <i class="data-lucide="mail""></i>
                                        </div>
                                        <div class="timeline-content">
                                            <h6 data-i18n="bookingConf.next2.title">Confirmation Email</h6>
                                            <p class="text-muted" data-i18n="bookingConf.next2.desc">A confirmation email will be sent to your inbox</p>
                                        </div>
                                    </div>
                                    <div class="timeline-item">
                                        <div class="timeline-marker">
                                            <i class="data-lucide="phone""></i>
                                        </div>
                                        <div class="timeline-content">
                                            <h6 data-i18n="bookingConf.next3.title">Itinerary Confirmation</h6>
                                            <p class="text-muted" data-i18n="bookingConf.next3.desc">We will contact you 3 days before departure</p>
                                        </div>
                                    </div>
                                    <div class="timeline-item">
                                        <div class="timeline-marker">
                                            <i class="data-lucide="plane""></i>
                                        </div>
                                        <div class="timeline-content">
                                            <h6 data-i18n="bookingConf.next4.title">Start Your Journey</h6>
                                            <p class="text-muted" data-i18n="bookingConf.next4.desc">Enjoy your trip to Malaysia</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="card important-info-card">
                            <div class="card-header">
                                <h5 class="mb-0">
                                    <i class="data-lucide="info" me-2"></i>
                                    <span data-i18n="bookingConf.info.title">Important Information</span>
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="info-list">
                                    <div class="info-item">
                                        <i class="data-lucide="id-card" text-primary"></i>
                                        <span data-i18n="bookingConf.info.tip1">Please ensure your passport is valid</span>
                                    </div>
                                    <div class="info-item">
                                        <i class="data-lucide="luggage" text-primary"></i>
                                        <span data-i18n="bookingConf.info.tip2">We recommend starting to pack a week before departure</span>
                                    </div>
                                    <div class="info-item">
                                        <i class="data-lucide="phone" text-primary"></i>
                                        <span data-i18n="bookingConf.info.tip3">If you have any questions, please call our customer service hotline</span>
                                    </div>
                                    <div class="info-item">
                                        <i class="data-lucide="heart" text-primary"></i>
                                        <span data-i18n="bookingConf.info.tip4">Travel insurance is recommended</span>
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
                                <i class="data-lucide="printer" me-2"></i><span data-i18n="bookingConf.actions.print">Print Confirmation</span>
                            </button>
                        </div>
                        <div class="col-auto">
                            <button onclick="shareBooking()" class="btn btn-outline-success me-2">
                                <i class="data-lucide="share-2" me-2"></i><span data-i18n="bookingConf.actions.share">Share Booking</span>
                            </button>
                        </div>
                        <div class="col-auto">
                            <a href="${pageContext.request.contextPath}/my-bookings" class="btn btn-primary me-2">
                                <i class="data-lucide="list" me-2"></i><span data-i18n="bookingConf.actions.view">View All Bookings</span>
                            </a>
                        </div>
                        <div class="col-auto">
                            <a href="${pageContext.request.contextPath}/packages" class="btn btn-success">
                                <i class="data-lucide="plus" me-2"></i><span data-i18n="bookingConf.actions.more">Book More Journeys</span>
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
                    <h3 class="mb-4" data-i18n="bookingConf.support.title">Need Help?</h3>
                    <p class="mb-4" data-i18n="bookingConf.support.subtitle">Our customer service team is available 24/7</p>
                    
                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <div class="support-contact-card">
                                <div class="contact-icon">
                                    <i class="data-lucide="phone""></i>
                                </div>
                                <h6 data-i18n="bookingConf.support.phone">Phone Support</h6>
                                <p><strong>+60 3-1234 5678</strong><br>
                                <span data-i18n="bookingConf.support.phoneDesc">24-hour customer service hotline</span></p>
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="support-contact-card">
                                <div class="contact-icon">
                                    <i class="data-lucide="mail""></i>
                                </div>
                                <h6 data-i18n="bookingConf.support.email">Email Support</h6>
                                <p><strong>support@mytour.my</strong><br>
                                <span data-i18n="bookingConf.support.emailDesc">Usually replies within 24 hours</span></p>
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="support-contact-card">
                                <div class="contact-icon">
                                    <i class="data-lucide="message-circle""></i>
                                </div>
                                <h6 data-i18n="bookingConf.support.chat">Online Chat</h6>
                                <p><strong data-i18n="bookingConf.support.chatInstant">Instant Chat</strong><br>
                                <span data-i18n="bookingConf.support.chatHours">Mon-Sun 9:00-21:00</span></p>
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
        /* ========================================
           LIQUID GLASS DESIGN SYSTEM - 2025
           Booking Confirmation Page Enhancement
           Based on Apple Liquid Glass & Glassmorphism Best Practices
        ======================================== */

        :root {
            /* Liquid Glass Variables */
            --glass-blur-sm: 12px;
            --glass-blur-md: 20px;
            --glass-blur-lg: 28px;
            --glass-blur-xl: 36px;
            
            --glass-saturate: 180%;
            --glass-brightness: 1.1;
            --glass-contrast: 1.05;
            
            /* Glass Background Colors */
            --glass-bg-light: rgba(255, 255, 255, 0.15);
            --glass-bg-medium: rgba(255, 255, 255, 0.25);
            --glass-bg-strong: rgba(255, 255, 255, 0.35);
            
            /* Glass Border Colors */
            --glass-border-light: rgba(255, 255, 255, 0.3);
            --glass-border-strong: rgba(255, 255, 255, 0.5);
            
            /* Gradient Colors - Ocean & Sunset Theme */
            --gradient-ocean-start: #1e3c72;
            --gradient-ocean-mid: #2a5298;
            --gradient-ocean-end: #4a90e2;
            
            --gradient-sunset-start: #f64f59;
            --gradient-sunset-mid: #ff6b6b;
            --gradient-sunset-end: #feca57;
            
            --gradient-success-start: #11998e;
            --gradient-success-end: #38ef7d;
            
            --gradient-gold-start: #DAA520;
            --gradient-gold-end: #FFD700;
            
            /* Shadow System */
            --shadow-sm: 0 4px 12px rgba(0, 0, 0, 0.08);
            --shadow-md: 0 8px 24px rgba(0, 0, 0, 0.12);
            --shadow-lg: 0 16px 40px rgba(0, 0, 0, 0.16);
            --shadow-xl: 0 24px 60px rgba(0, 0, 0, 0.20);
            
            /* Inner Glow */
            --inner-glow: inset 0 1px 0 rgba(255, 255, 255, 0.4),
                          inset 0 -1px 0 rgba(0, 0, 0, 0.05);
            
            /* Border Radius */
            --radius-sm: 12px;
            --radius-md: 20px;
            --radius-lg: 28px;
            --radius-xl: 36px;
            
            /* Transitions */
            --transition-smooth: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            --transition-bounce: all 0.6s cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        /* ========================================
           GLOBAL ENHANCEMENTS
        ======================================== */
        
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            background-attachment: fixed;
        }

        /* ========================================
           HERO SECTION - Liquid Glass Enhancement
        ======================================== */
        
        .confirmation-hero-section {
            position: relative;
            padding: 80px 0;
            margin-bottom: 40px;
            overflow: hidden;
            background: linear-gradient(135deg, 
                var(--gradient-ocean-start) 0%, 
                var(--gradient-ocean-mid) 50%, 
                var(--gradient-ocean-end) 100%);
        }
        
        .confirmation-hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: 
                radial-gradient(circle at 20% 50%, rgba(255, 107, 53, 0.3) 0%, transparent 50%),
                radial-gradient(circle at 80% 80%, rgba(254, 202, 87, 0.3) 0%, transparent 50%),
                radial-gradient(circle at 40% 20%, rgba(74, 144, 226, 0.3) 0%, transparent 50%);
            animation: hero-glow 15s ease-in-out infinite;
        }
        
        @keyframes hero-glow {
            0%, 100% { opacity: 0.6; transform: scale(1); }
            50% { opacity: 0.8; transform: scale(1.1); }
        }
        
        .confirmation-title {
            color: white;
            font-size: 3rem;
            font-weight: 700;
            text-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            animation: slide-down 0.8s ease-out;
        }
        
        .confirmation-subtitle {
            color: rgba(255, 255, 255, 0.95);
            font-size: 1.2rem;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            animation: fade-in 1s ease-out 0.3s both;
        }
        
        .booking-reference {
            display: inline-block;
            padding: 20px 40px;
            background: var(--glass-bg-medium);
            backdrop-filter: blur(var(--glass-blur-md)) saturate(var(--glass-saturate));
            -webkit-backdrop-filter: blur(var(--glass-blur-md)) saturate(var(--glass-saturate));
            border-radius: var(--radius-lg);
            border: 1px solid var(--glass-border-light);
            box-shadow: var(--shadow-lg), var(--inner-glow);
            animation: scale-in 0.6s ease-out 0.5s both;
        }
        
        .reference-label {
            display: block;
            color: rgba(255, 255, 255, 0.9);
            font-size: 0.9rem;
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .reference-number {
            color: white;
            font-size: 1.8rem;
            font-weight: 700;
            font-family: 'Courier New', monospace;
            letter-spacing: 2px;
        }

        /* ========================================
           SUCCESS ANIMATION - Enhanced Liquid Glass
        ======================================== */
        
        .success-animation {
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            z-index: 10;
        }

        .checkmark-circle {
            width: 100px;
            height: 100px;
            position: relative;
            display: inline-block;
            vertical-align: top;
            filter: drop-shadow(0 8px 24px rgba(17, 153, 142, 0.4));
        }

        .checkmark-circle::before {
            content: '';
            width: 100px;
            height: 100px;
            position: absolute;
            left: 0;
            top: 0;
            background: linear-gradient(135deg, 
                var(--gradient-success-start) 0%, 
                var(--gradient-success-end) 100%);
            border-radius: 50%;
            animation: circle-animate 0.6s ease-in-out forwards,
                       pulse-glow 2s ease-in-out 1s infinite;
            box-shadow: 
                0 0 0 8px rgba(17, 153, 142, 0.1),
                0 0 0 16px rgba(17, 153, 142, 0.05),
                inset 0 4px 8px rgba(255, 255, 255, 0.3);
        }

        .checkmark {
            width: 40px;
            height: 25px;
            position: absolute;
            left: 30px;
            top: 37px;
            transform: rotate(45deg);
        }

        .checkmark::before {
            content: '';
            position: absolute;
            width: 4px;
            height: 11px;
            background-color: white;
            left: 10px;
            top: 8px;
            border-radius: 2px;
        }

        .checkmark::after {
            content: '';
            position: absolute;
            width: 4px;
            height: 20px;
            background-color: white;
            left: 16px;
            top: 0px;
            border-radius: 2px;
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
                transform: scale(0) rotate(-180deg);
            }
            50% {
                transform: scale(1.1) rotate(0deg);
            }
            100% {
                opacity: 1;
                transform: scale(1) rotate(0deg);
            }
        }
        
        @keyframes pulse-glow {
            0%, 100% {
                box-shadow: 
                    0 0 0 8px rgba(17, 153, 142, 0.1),
                    0 0 0 16px rgba(17, 153, 142, 0.05),
                    inset 0 4px 8px rgba(255, 255, 255, 0.3);
            }
            50% {
                box-shadow: 
                    0 0 0 12px rgba(17, 153, 142, 0.15),
                    0 0 0 24px rgba(17, 153, 142, 0.08),
                    inset 0 4px 8px rgba(255, 255, 255, 0.4);
            }
        }

        @keyframes checkmark-short {
            0% { height: 0; }
            100% { height: 11px; }
        }

        @keyframes checkmark-long {
            0% { height: 0; }
            100% { height: 20px; }
        }
        
        @keyframes slide-down {
            0% {
                opacity: 0;
                transform: translateY(-30px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        @keyframes fade-in {
            0% { opacity: 0; }
            100% { opacity: 1; }
        }
        
        @keyframes scale-in {
            0% {
                opacity: 0;
                transform: scale(0.8);
            }
            100% {
                opacity: 1;
                transform: scale(1);
            }
        }

        /* ========================================
           CARD SYSTEM - Premium Liquid Glass
        ======================================== */
        
        .booking-summary-card,
        .next-steps-card,
        .important-info-card {
            border: none;
            border-radius: var(--radius-lg);
            background: var(--glass-bg-light);
            backdrop-filter: blur(var(--glass-blur-lg)) saturate(var(--glass-saturate)) brightness(var(--glass-brightness));
            -webkit-backdrop-filter: blur(var(--glass-blur-lg)) saturate(var(--glass-saturate)) brightness(var(--glass-brightness));
            border: 1px solid var(--glass-border-light);
            box-shadow: var(--shadow-lg), var(--inner-glow);
            transition: var(--transition-smooth);
            animation: fade-in-up 0.6s ease-out both;
            will-change: transform, box-shadow;
            transform: translateZ(0);
            backface-visibility: hidden;
        }
        
        .booking-summary-card {
            animation-delay: 0.1s;
        }
        
        .important-info-card {
            animation-delay: 0.2s;
        }
        
        .next-steps-card {
            animation-delay: 0.3s;
        }
        
        @keyframes fade-in-up {
            0% {
                opacity: 0;
                transform: translateY(30px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .booking-summary-card:hover,
        .next-steps-card:hover,
        .important-info-card:hover {
            transform: translateY(-8px) scale(1.01);
            box-shadow: var(--shadow-xl), var(--inner-glow);
            border-color: var(--glass-border-strong);
        }

        .card-header {
            background: linear-gradient(135deg, 
                rgba(255, 255, 255, 0.3) 0%, 
                rgba(255, 255, 255, 0.15) 100%);
            backdrop-filter: blur(var(--glass-blur-sm));
            -webkit-backdrop-filter: blur(var(--glass-blur-sm));
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: var(--radius-lg) var(--radius-lg) 0 0 !important;
            padding: 1.5rem;
        }
        
        .card-header h4,
        .card-header h5 {
            color: var(--gradient-ocean-start);
            font-weight: 700;
            margin: 0;
            display: flex;
            align-items: center;
        }
        
        .card-header i {
            background: linear-gradient(135deg, 
                var(--gradient-ocean-start) 0%, 
                var(--gradient-ocean-end) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-size: 1.3rem;
        }
        
        .card-body {
            padding: 2rem;
            background: rgba(255, 255, 255, 0.05);
        }

        /* ========================================
           TIMELINE - Liquid Glass Enhancement
        ======================================== */
        
        .timeline {
            position: relative;
            padding-left: 3rem;
        }

        .timeline::before {
            content: '';
            position: absolute;
            left: 1.25rem;
            top: 0;
            bottom: 0;
            width: 3px;
            background: linear-gradient(180deg, 
                var(--gradient-ocean-start) 0%, 
                var(--gradient-ocean-mid) 50%, 
                var(--gradient-ocean-end) 100%);
            border-radius: 2px;
            box-shadow: 0 0 10px rgba(74, 144, 226, 0.3);
        }

        .timeline-item {
            position: relative;
            margin-bottom: 2.5rem;
            animation: slide-in-left 0.6s ease-out both;
        }
        
        .timeline-item:nth-child(1) { animation-delay: 0.1s; }
        .timeline-item:nth-child(2) { animation-delay: 0.2s; }
        .timeline-item:nth-child(3) { animation-delay: 0.3s; }
        .timeline-item:nth-child(4) { animation-delay: 0.4s; }
        
        @keyframes slide-in-left {
            0% {
                opacity: 0;
                transform: translateX(-20px);
            }
            100% {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .timeline-marker {
            position: absolute;
            left: -2.5rem;
            top: 0;
            width: 2.5rem;
            height: 2.5rem;
            background: linear-gradient(135deg, 
                rgba(255, 255, 255, 0.3) 0%, 
                rgba(255, 255, 255, 0.1) 100%);
            backdrop-filter: blur(var(--glass-blur-sm));
            -webkit-backdrop-filter: blur(var(--glass-blur-sm));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--gradient-ocean-start);
            font-size: 0.9rem;
            font-weight: 700;
            border: 2px solid var(--glass-border-light);
            box-shadow: var(--shadow-sm);
            transition: var(--transition-smooth);
        }
        
        .timeline-marker:hover {
            transform: scale(1.15) rotate(5deg);
            box-shadow: var(--shadow-md);
        }

        .timeline-marker.completed {
            background: linear-gradient(135deg, 
                var(--gradient-success-start) 0%, 
                var(--gradient-success-end) 100%);
            color: white;
            border-color: rgba(255, 255, 255, 0.5);
            box-shadow: 0 0 20px rgba(17, 153, 142, 0.4);
        }
        
        .timeline-marker.completed:hover {
            box-shadow: 0 0 30px rgba(17, 153, 142, 0.6);
        }

        .timeline-content {
            padding: 1.5rem;
            background: var(--glass-bg-light);
            backdrop-filter: blur(var(--glass-blur-md));
            -webkit-backdrop-filter: blur(var(--glass-blur-md));
            border-radius: var(--radius-md);
            border: 1px solid var(--glass-border-light);
            box-shadow: var(--shadow-sm);
            transition: var(--transition-smooth);
        }
        
        .timeline-content:hover {
            transform: translateX(5px);
            box-shadow: var(--shadow-md);
            border-color: var(--glass-border-strong);
        }
        
        .timeline-content h6 {
            margin-bottom: 0.75rem;
            color: var(--gradient-ocean-start);
            font-weight: 700;
            font-size: 1.1rem;
        }
        
        .timeline-content p {
            color: #495057;
            margin: 0;
            line-height: 1.6;
        }

        /* ========================================
           INFO ITEMS & SECTIONS - Liquid Glass
        ======================================== */
        
        .section-title {
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--gradient-ocean-start);
            margin-bottom: 1.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 2px solid;
            border-image: linear-gradient(90deg, 
                var(--gradient-ocean-start) 0%, 
                var(--gradient-ocean-end) 100%) 1;
            position: relative;
        }
        
        .section-title::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 60px;
            height: 2px;
            background: linear-gradient(90deg, 
                var(--gradient-sunset-start) 0%, 
                var(--gradient-sunset-end) 100%);
            border-radius: 2px;
        }
        
        .info-list {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .info-list .info-item {
            display: flex;
            align-items: flex-start;
            padding: 1rem 1.25rem;
            background: var(--glass-bg-light);
            backdrop-filter: blur(var(--glass-blur-sm));
            -webkit-backdrop-filter: blur(var(--glass-blur-sm));
            border-radius: var(--radius-md);
            border: 1px solid var(--glass-border-light);
            box-shadow: var(--shadow-sm);
            text-align: left;
            transition: var(--transition-smooth);
            animation: fade-in-up 0.5s ease-out both;
        }
        
        .info-list .info-item:nth-child(1) { animation-delay: 0.1s; }
        .info-list .info-item:nth-child(2) { animation-delay: 0.2s; }
        .info-list .info-item:nth-child(3) { animation-delay: 0.3s; }
        .info-list .info-item:nth-child(4) { animation-delay: 0.4s; }
        
        .info-list .info-item:hover {
            transform: translateX(5px);
            box-shadow: var(--shadow-md);
            border-color: var(--glass-border-strong);
            background: var(--glass-bg-medium);
        }
        
        .info-list .info-item i {
            font-size: 1.3rem;
            background: linear-gradient(135deg, 
                var(--gradient-ocean-start) 0%, 
                var(--gradient-ocean-end) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-right: 1rem;
            margin-top: 0.125rem;
            flex-shrink: 0;
        }
        
        .info-list .info-item span {
            flex: 1;
            color: #2c3e50;
            font-size: 1rem;
            line-height: 1.6;
            font-weight: 500;
        }

        .info-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 0.75rem;
            padding: 0.5rem 0;
            text-align: left;
        }
        
        .info-item strong {
            color: var(--gradient-ocean-start);
            font-weight: 700;
            min-width: 150px;
            margin-right: 1rem;
        }
        
        .info-item span {
            flex: 1;
            color: #495057;
            line-height: 1.6;
        }
        
        .info-item .badge {
            padding: 0.5rem 1rem;
            border-radius: var(--radius-sm);
            font-weight: 600;
            font-size: 0.85rem;
            background: linear-gradient(135deg, 
                var(--gradient-success-start) 0%, 
                var(--gradient-success-end) 100%);
            border: none;
            box-shadow: 0 4px 12px rgba(17, 153, 142, 0.3);
        }
        
        /* 确保整个重要信息卡片内容左对齐 */
        .important-info-card .card-body {
            text-align: left;
        }
        
        .important-info-card .info-list {
            text-align: left;
        }

        .special-requests-box {
            background: var(--glass-bg-light);
            backdrop-filter: blur(var(--glass-blur-md));
            -webkit-backdrop-filter: blur(var(--glass-blur-md));
            border-radius: var(--radius-md);
            padding: 1.5rem;
            border: 1px solid var(--glass-border-light);
            box-shadow: var(--shadow-sm);
        }
        
        .special-requests-box h6 {
            color: var(--gradient-ocean-start);
            font-weight: 700;
            margin-bottom: 1rem;
        }
        
        .special-requests-box p {
            color: #495057;
            line-height: 1.6;
            margin: 0;
        }

        /* ========================================
           BUTTONS & ACTIONS - Liquid Glass
        ======================================== */
        
        .confirmation-actions {
            background: var(--glass-bg-light);
            backdrop-filter: blur(var(--glass-blur-md));
            -webkit-backdrop-filter: blur(var(--glass-blur-md));
            border-radius: var(--radius-lg);
            padding: 2.5rem;
            border: 1px solid var(--glass-border-light);
            box-shadow: var(--shadow-md);
            margin-top: 3rem;
        }
        
        .confirmation-actions .btn {
            padding: 0.875rem 2rem;
            border-radius: var(--radius-md);
            font-weight: 600;
            font-size: 1rem;
            transition: var(--transition-smooth);
            border: none;
            position: relative;
            overflow: hidden;
        }
        
        .confirmation-actions .btn::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.3);
            transform: translate(-50%, -50%);
            transition: width 0.6s, height 0.6s;
        }
        
        .confirmation-actions .btn:hover::before {
            width: 300px;
            height: 300px;
        }
        
        .confirmation-actions .btn-outline-primary {
            background: var(--glass-bg-medium);
            backdrop-filter: blur(var(--glass-blur-sm));
            -webkit-backdrop-filter: blur(var(--glass-blur-sm));
            border: 2px solid var(--gradient-ocean-end);
            color: var(--gradient-ocean-start);
        }
        
        .confirmation-actions .btn-outline-primary:hover {
            background: linear-gradient(135deg, 
                var(--gradient-ocean-start) 0%, 
                var(--gradient-ocean-end) 100%);
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(74, 144, 226, 0.4);
        }
        
        .confirmation-actions .btn-outline-success {
            background: var(--glass-bg-medium);
            backdrop-filter: blur(var(--glass-blur-sm));
            -webkit-backdrop-filter: blur(var(--glass-blur-sm));
            border: 2px solid var(--gradient-success-end);
            color: var(--gradient-success-start);
        }
        
        .confirmation-actions .btn-outline-success:hover {
            background: linear-gradient(135deg, 
                var(--gradient-success-start) 0%, 
                var(--gradient-success-end) 100%);
            color: white;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(17, 153, 142, 0.4);
        }
        
        .confirmation-actions .btn-primary {
            background: linear-gradient(135deg, 
                var(--gradient-ocean-start) 0%, 
                var(--gradient-ocean-end) 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(74, 144, 226, 0.3);
        }
        
        .confirmation-actions .btn-primary:hover {
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 8px 25px rgba(74, 144, 226, 0.5);
        }

        /* ========================================
           SUPPORT SECTION - Liquid Glass
        ======================================== */
        
        .support-section {
            position: relative;
            padding: 4rem 0;
            margin-top: 4rem;
            background: linear-gradient(135deg, 
                rgba(30, 60, 114, 0.05) 0%, 
                rgba(74, 144, 226, 0.05) 100%);
        }
        
        .support-section h3 {
            color: var(--gradient-ocean-start);
            font-weight: 700;
            margin-bottom: 2.5rem;
            text-align: center;
            font-size: 2rem;
        }

        .support-contact-card {
            background: var(--glass-bg-medium);
            backdrop-filter: blur(var(--glass-blur-lg));
            -webkit-backdrop-filter: blur(var(--glass-blur-lg));
            padding: 2.5rem 2rem;
            border-radius: var(--radius-lg);
            text-align: center;
            box-shadow: var(--shadow-lg);
            border: 1px solid var(--glass-border-light);
            transition: var(--transition-smooth);
            height: 100%;
            position: relative;
            overflow: hidden;
        }
        
        .support-contact-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, 
                rgba(255, 255, 255, 0.1) 0%, 
                transparent 100%);
            opacity: 0;
            transition: var(--transition-smooth);
        }
        
        .support-contact-card:hover::before {
            opacity: 1;
        }

        .support-contact-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: var(--shadow-xl);
            border-color: var(--glass-border-strong);
        }

        .contact-icon {
            font-size: 3rem;
            margin-bottom: 1.5rem;
            background: linear-gradient(135deg, 
                var(--gradient-success-start) 0%, 
                var(--gradient-success-end) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            display: inline-block;
            transition: var(--transition-smooth);
        }
        
        .support-contact-card:hover .contact-icon {
            transform: scale(1.15) rotate(5deg);
        }
        
        .support-contact-card h6 {
            color: var(--gradient-ocean-start);
            font-weight: 700;
            font-size: 1.2rem;
            margin-bottom: 1rem;
        }
        
        .support-contact-card p {
            color: #495057;
            line-height: 1.6;
            margin: 0;
        }
        
        .support-contact-card strong {
            color: var(--gradient-ocean-start);
            font-weight: 700;
            font-size: 1.1rem;
        }

        /* ========================================
           RESPONSIVE DESIGN & PERFORMANCE
        ======================================== */
        
        @media (max-width: 992px) {
            :root {
                --glass-blur-sm: 10px;
                --glass-blur-md: 16px;
                --glass-blur-lg: 22px;
                --glass-blur-xl: 28px;
            }
            
            .confirmation-title {
                font-size: 2.5rem;
            }
            
            .timeline {
                padding-left: 2.5rem;
            }
        }
        
        @media (max-width: 768px) {
            :root {
                --glass-blur-sm: 8px;
                --glass-blur-md: 12px;
                --glass-blur-lg: 16px;
                --glass-blur-xl: 20px;
            }
            
            .confirmation-hero-section {
                padding: 60px 0;
            }
            
            .confirmation-title {
                font-size: 2rem;
            }
            
            .confirmation-subtitle {
                font-size: 1rem;
            }
            
            .booking-reference {
                padding: 15px 30px;
            }
            
            .reference-number {
                font-size: 1.4rem;
            }
            
            .checkmark-circle {
                width: 80px;
                height: 80px;
            }
            
            .checkmark-circle::before {
                width: 80px;
                height: 80px;
            }
            
            .card-body {
                padding: 1.5rem;
            }
            
            .timeline {
                padding-left: 2rem;
            }
            
            .timeline-marker {
                width: 2rem;
                height: 2rem;
                left: -2rem;
            }
            
            .info-item strong {
                min-width: 120px;
            }
            
            .info-list .info-item {
                padding: 0.875rem 1rem;
            }
            
            .info-list .info-item i {
                margin-right: 0.75rem;
            }
            
            .info-list .info-item span {
                font-size: 0.9rem;
            }
            
            .support-section h3 {
                font-size: 1.5rem;
            }
            
            .support-contact-card {
                margin-bottom: 1.5rem;
            }
            
            .confirmation-actions {
                padding: 1.5rem;
            }
            
            .confirmation-actions .btn {
                width: 100%;
                margin-bottom: 0.75rem;
            }
        }
        
        @media (max-width: 480px) {
            .confirmation-title {
                font-size: 1.75rem;
            }
            
            .reference-number {
                font-size: 1.2rem;
                letter-spacing: 1px;
            }
            
            .section-title {
                font-size: 1.1rem;
            }
            
            .info-item {
                flex-direction: column;
            }
            
            .info-item strong {
                min-width: auto;
                margin-bottom: 0.5rem;
            }
        }
        
        /* ========================================
           DARK MODE SUPPORT
        ======================================== */
        
        @media (prefers-color-scheme: dark) {
            body {
                background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            }
            
            .card-body {
                background: rgba(0, 0, 0, 0.1);
            }
            
            .timeline-content p,
            .info-item span,
            .special-requests-box p,
            .support-contact-card p {
                color: rgba(255, 255, 255, 0.85);
            }
            
            .info-list .info-item span {
                color: rgba(255, 255, 255, 0.9);
            }
        }
        
        /* ========================================
           ACCESSIBILITY & PERFORMANCE
        ======================================== */
        
        @media (prefers-reduced-motion: reduce) {
            *,
            *::before,
            *::after {
                animation-duration: 0.01ms !important;
                animation-iteration-count: 1 !important;
                transition-duration: 0.01ms !important;
            }
        }
        
        /* GPU Acceleration for Smooth Performance */
        .booking-summary-card,
        .next-steps-card,
        .important-info-card,
        .support-contact-card,
        .timeline-marker,
        .info-list .info-item {
            will-change: transform;
            transform: translateZ(0);
            backface-visibility: hidden;
        }
    </style>

    <jsp:include page="../includes/footer.jsp" />
</body>
</html>