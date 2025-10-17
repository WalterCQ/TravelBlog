<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="${pageContext.request.locale.language}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=yes">
    <meta name="description" content="Book your dream travel package with MyTour Global. Secure booking, best prices, trusted by thousands of travelers.">
    <title>Book Your Dream Trip - MyTour Global | Secure & Easy Booking</title>
    
    <!-- Preconnect for performance -->
    <link rel="preconnect" href="https://cdn.jsdelivr.net">
    <link rel="preconnect" href="https://cdnjs.cloudflare.com">
    
    <!-- Stylesheets -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/pages/booking-refactored.css" rel="stylesheet">
    
    <!-- Open Graph for social sharing -->
    <meta property="og:title" content="Book Your Dream Trip - MyTour Global">
    <meta property="og:description" content="Secure and easy booking for travel packages. Best prices guaranteed.">
    <meta property="og:type" content="website">
    
    <!-- Schema.org structured data -->
    <script type="application/ld+json">
    {
        "@context": "https://schema.org",
        "@type": "TravelAgency",
        "name": "MyTour Global",
        "offers": {
            "@type": "Offer",
            "availability": "https://schema.org/InStock"
        }
    }
    </script>
</head>
<body>
    <jsp:include page="../includes/header.jsp" />

    <jsp:include page="../includes/navigation.jsp">
        <jsp:param name="currentPage" value="booking" />
    </jsp:include>

    <main class="booking-page" role="main">
        <div class="booking-container">

            <!-- Alert Messages -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success" role="alert">
                    <i data-lucide="check-circle"></i>
                    <div>
                        <strong data-i18n="booking.alert.success">Success!</strong>
                        <p>${successMessage}</p>
                    </div>
                </div>
            </c:if>

            <c:if test="${not empty errorMessage}">
                <div class="alert alert-error" role="alert">
                    <i data-lucide="alert-triangle"></i>
                    <div>
                        <strong data-i18n="booking.alert.error">Error</strong>
                        <p>${errorMessage}</p>
                    </div>
                </div>
            </c:if>

            <!-- Progress Indicator -->
            <div class="progress-container">
                <div class="progress-steps" role="progressbar" aria-valuenow="1" aria-valuemin="1" aria-valuemax="4">
                    <div class="progress-line" id="progressLine"></div>
                    <div class="step active" data-step="1">
                        <div class="step-circle">
                            <i class="step-icon data-lucide="luggage""></i>
                        </div>
                        <div class="step-label" data-i18n="booking.steps.1">1. Your Adventure</div>
                    </div>
                    <div class="step" data-step="2">
                        <div class="step-circle">
                            <i class="step-icon data-lucide="user""></i>
                        </div>
                        <div class="step-label" data-i18n="booking.steps.2">2. The Explorers</div>
                    </div>
                    <div class="step" data-step="3">
                        <div class="step-circle">
                            <i class="step-icon data-lucide="credit-card""></i>
                        </div>
                        <div class="step-label" data-i18n="booking.steps.3">3. Secure Your Spot</div>
                    </div>
                    <div class="step" data-step="4">
                        <div class="step-circle">
                            <i class="step-icon data-lucide="check""></i>
                        </div>
                        <div class="step-label" data-i18n="booking.steps.4">4. All Set!</div>
                    </div>
                </div>
            </div>

            <!-- Main Layout -->
            <div class="booking-layout">
                <!-- Main Form Area -->
                <div class="booking-main">
                    <form id="bookingForm" action="${pageContext.request.contextPath}/booking/submit-with-payment" method="post" novalidate>
                        <input type="hidden" name="totalPrice" id="totalPriceHidden" value="0.00">
                        
                        <!-- Step 1: Package Selection & Details -->
                        <div class="step-content" id="stepContent1">
                            <section class="section-card" aria-labelledby="packageSectionTitle">
                                <div class="section-header">
                                    <div class="section-header-title">
                                        <i data-lucide="map-pin"></i>
                                        <h3 id="packageSectionTitle" data-i18n="booking.step1.title">Confirm Your Adventure</h3>
                                    </div>
                                    <c:if test="${not empty selectedTravelPackage}">
                                        <span class="section-badge">
                                            <i data-lucide="check-circle" class="me-1"></i>
                                            <span data-i18n="booking.confirmed">Confirmed</span>
                                        </span>
                                    </c:if>
                                </div>
                                <div class="section-body">
                                    <c:choose>
                                        <c:when test="${not empty selectedTravelPackage}">
                                            <!-- Selected Package Card -->
                                            <div class="selected-package-card">
                                                <div class="package-image-container">
                                                    <img src="${pageContext.request.contextPath}/${selectedTravelPackage.imagePath}" 
                                                         alt="${selectedTravelPackage.name}" 
                                                         class="package-image"
                                                         loading="lazy">
                                                    <span class="package-type-badge">${selectedTravelPackage.type}</span>
                                                </div>
                                                <div class="package-info">
                                                    <h4 class="package-name" data-i18n="pkg.name.${selectedTravelPackage.id}">${selectedTravelPackage.name}</h4>
                                                    <p class="package-description" data-i18n="pkg.desc.${selectedTravelPackage.id}">${selectedTravelPackage.description}</p>
                                                    <div class="package-features">
                                                        <span class="feature-badge">
                                                            <i data-lucide="calendar"></i>
                                                            ${selectedTravelPackage.durationDays} Days / ${selectedTravelPackage.durationNights} Nights
                                                        </span>
                                                        <c:if test="${not empty selectedTravelPackage.inclusions}">
                                                            <span class="feature-badge">
                                                                <i data-lucide="check-circle"></i>
                                                                Meals & Hotels Included
                                                            </span>
                                                        </c:if>
                                                        <span class="feature-badge">
                                                            <i data-lucide="users"></i>
                                                            Max ${selectedTravelPackage.maxParticipants} Travelers
                                                        </span>
                                                    </div>
                                                </div>
                                                <div class="package-price-tag">
                                                    <div class="price-label" data-i18n="booking.price.perPerson">Price per person</div>
                                                    <div class="price-amount">
                                                        <span class="price-currency">RM</span>
                                                        <fmt:formatNumber value="${selectedTravelPackage.price}" pattern="#,##0.00"/>
                                                    </div>
                                                    <span class="price-per" data-i18n="booking.price.per">per person</span>
                                                </div>
                                                <input type="hidden" name="packageId" value="${selectedTravelPackage.id}" id="packageId" data-price="${selectedTravelPackage.price}">
                                            </div>
                                            <button type="button" class="change-package-btn" onclick="window.location.href='${pageContext.request.contextPath}/packages'">
                                                <i data-lucide="refresh-cw" class="me-2"></i>
                                                <span data-i18n="booking.changePackage">Change Package</span>
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <!-- Package Selection (if not pre-selected) -->
                                            <div class="alert alert-warning">
                                                <i data-lucide="alert-circle"></i>
                                                <div>
                                                    <strong data-i18n="booking.noPackage.title">Whoops! No adventure selected.</strong>
                                                    <p data-i18n="booking.noPackage.desc">You need to pick a package before we can get you on your way.</p>
                                                    <a href="${pageContext.request.contextPath}/packages" class="btn btn-primary mt-2">
                                                        <i data-lucide="search" class="me-2"></i>
                                                        <span data-i18n="booking.noPackage.browse">Browse Packages</span>
                                                    </a>
                                                </div>
                                            </div>
                                            <!-- Hidden packageId field for form submission -->
                                            <input type="hidden" name="packageId" value="" id="packageId">
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </section>

                            <!-- Travel Dates -->
                            <section class="section-card" aria-labelledby="datesSectionTitle">
                                <div class="section-header">
                                    <div class="section-header-title">
                                        <i data-lucide="calendar"></i>
                                        <h3 id="datesSectionTitle" data-i18n="booking.dates.title">When Are We Going?</h3>
                                    </div>
                                </div>
                                <div class="section-body">
                                    <div class="form-grid">
                                        <div class="form-group">
                                            <label for="departureDate" class="form-label">
                                                <span data-i18n="booking.departureDate">Departure Date</span><span class="required">*</span>
                                            </label>
                                            <div class="input-with-icon">
                                                <i class="input-icon" data-lucide="calendar"></i>
                                                <input type="date" 
                                                       class="form-input" 
                                                       id="departureDate" 
                                                       name="departureDate" 
                                                       required
                                                       min="${minDate}"
                                                       data-validation="required|futureDate">
                                            </div>
                                            <small class="form-helper" data-i18n="booking.departure.helper">Pick the day your adventure begins!</small>
                                            <span class="form-error" data-i18n="booking.departure.error">Please select a valid future date</span>
                                        </div>
                                        <div class="form-group">
                                            <label for="numberOfParticipants" class="form-label">
                                                <span data-i18n="booking.travelers.label">Number of Travelers</span><span class="required">*</span>
                                            </label>
                                            <div class="input-with-icon">
                                                <i class="input-icon" data-lucide="users"></i>
                                                <select class="form-select" id="numberOfParticipants" name="numberOfParticipants" required data-validation="required">
                                                    <option value="" data-i18n="booking.travelers.select">Select travelers</option>
                                                    <c:forEach var="i" begin="1" end="10">
                                                        <option value="${i}">${i} ${i == 1 ? 'Person' : 'People'}</option>
                                                    </c:forEach>
                                                </select>
                                                <i class="select-arrow" data-lucide="chevron-down"></i>
                                            </div>
                                            <small class="form-helper" data-i18n="booking.travelers.helper">Who's on the dream team?</small>
                                            <span class="form-error" data-i18n="booking.travelers.error">Please select number of travelers</span>
                                        </div>
                                    </div>
                                </div>
                            </section>
                        </div>

                        <!-- Step 2: Traveler Information -->
                        <div class="step-content" id="stepContent2" style="display: none;">
                            <section class="section-card" aria-labelledby="contactSectionTitle">
                                <div class="section-header">
                                    <div class="section-header-title">
                                        <i data-lucide="user-circle"></i>
                                        <h3 id="contactSectionTitle" data-i18n="booking.lead.title">Who's The Lead Explorer?</h3>
                                    </div>
                                </div>
                                <div class="section-body">
                                    <div class="form-grid">
                                        <div class="form-group">
                                            <label for="customerName" class="form-label">
                                                <span data-i18n="booking.fullName">Full Name</span><span class="required">*</span>
                                            </label>
                                            <div class="input-with-icon">
                                                <i class="input-icon" data-lucide="user"></i>
                                                <input type="text" 
                                                       class="form-input" 
                                                       id="customerName" 
                                                       name="customerName" 
                                                       required
                                                       placeholder="John Doe" data-i18n="booking.fullName.placeholder" data-i18n-attr="placeholder"
                                                       data-validation="required|minLength:3">
                                            </div>
                                            <small class="form-helper" data-i18n="booking.fullName.helper">Make sure this matches your ID or passport, just to be safe!</small>
                                            <span class="form-error" data-i18n="booking.fullName.error">Please enter your full name (min 3 characters)</span>
                                        </div>
                                        <div class="form-group">
                                            <label for="customerEmail" class="form-label">
                                                <span data-i18n="booking.email">Email Address</span><span class="required">*</span>
                                            </label>
                                            <div class="input-with-icon">
                                                <i class="input-icon" data-lucide="mail"></i>
                                                <input type="email" 
                                                       class="form-input" 
                                                       id="customerEmail" 
                                                       name="customerEmail" 
                                                       required
                                                       placeholder="john@example.com" data-i18n="booking.email.placeholder" data-i18n-attr="placeholder"
                                                       data-validation="required|email">
                                            </div>
                                            <small class="form-helper" data-i18n="booking.email.helper">Your golden ticket (a.k.a. confirmation) will land here.</small>
                                            <span class="form-error" data-i18n="booking.email.error">Please enter a valid email address</span>
                                        </div>
                                        <div class="form-group">
                                            <label for="customerPhone" class="form-label">
                                                <span data-i18n="booking.phone">Phone Number</span><span class="required">*</span>
                                            </label>
                                            <div class="input-with-icon">
                                                <i class="input-icon" data-lucide="phone"></i>
                                                <input type="tel" 
                                                       class="form-input" 
                                                       id="customerPhone" 
                                                       name="customerPhone" 
                                                       required
                                                       placeholder="+60 12-345-6789" data-i18n="booking.phone.placeholder" data-i18n-attr="placeholder"
                                                       data-validation="required|phone">
                                            </div>
                                            <small class="form-helper" data-i18n="booking.phone.helper">Just in case we need to send a carrier pigeon (or a text).</small>
                                            <span class="form-error" data-i18n="booking.phone.error">Please enter a valid phone number</span>
                                        </div>
                                        <div class="form-group">
                                            <label for="nationality" class="form-label" data-i18n="booking.nationality">Nationality</label>
                                            <div class="input-with-icon">
                                                <i class="input-icon" data-lucide="globe"></i>
                                                <select class="form-select" id="nationality" name="nationality">
                                                    <option value="" data-i18n="booking.nationality.select">Select nationality</option>
                                                    <option value="MY">Malaysia</option>
                                                    <option value="SG">Singapore</option>
                                                    <option value="ID">Indonesia</option>
                                                    <option value="TH">Thailand</option>
                                                    <option value="US">United States</option>
                                                    <option value="GB">United Kingdom</option>
                                                    <option value="CN">China</option>
                                                    <option value="OTHER">Other</option>
                                                </select>
                                                <i class="select-arrow" data-lucide="chevron-down"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </section>

                            <!-- Emergency Contact -->
                            <section class="section-card" aria-labelledby="emergencySectionTitle">
                                <div class="section-header">
                                    <div class="section-header-title">
                                        <i data-lucide="heart-pulse"></i>
                                        <h3 id="emergencySectionTitle" data-i18n="booking.emergency.title">Your 'In-Case-of-Dragons' Contact (Optional)</h3>
                                    </div>
                                </div>
                                <div class="section-body">
                                    <div class="form-grid">
                                        <div class="form-group">
                                            <label for="emergencyContact" class="form-label" data-i18n="booking.emergency.name">Emergency Contact Name</label>
                                            <div class="input-with-icon">
                                                <i class="input-icon" data-lucide="user-shield"></i>
                                                <input type="text" 
                                                       class="form-input" 
                                                       id="emergencyContact" 
                                                       name="emergencyContact"
                                                       placeholder="Jane Doe">
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="emergencyPhone" class="form-label" data-i18n="booking.emergency.phone">Emergency Contact Phone</label>
                                            <div class="input-with-icon">
                                                <i class="input-icon" data-lucide="phone-call"></i>
                                                <input type="tel" 
                                                       class="form-input" 
                                                       id="emergencyPhone" 
                                                       name="emergencyPhone"
                                                       placeholder="+60 12-345-6789">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </section>

                            <!-- Special Requests -->
                            <section class="section-card" aria-labelledby="requestsSectionTitle">
                                <div class="section-header">
                                    <div class="section-header-title">
                                        <i data-lucide="message-circle"></i>
                                        <h3 id="requestsSectionTitle" data-i18n="booking.requests.title">Any Special Quests?</h3>
                                    </div>
                                </div>
                                <div class="section-body">
                                    <div class="form-group full-width">
                                        <label for="specialRequests" class="form-label" data-i18n="booking.requests.label">Any special requirements or requests?</label>
                                        <div class="input-with-icon">
                                            <i class="input-icon" data-lucide="message-circle"></i>
                                            <textarea class="form-textarea" 
                                                      id="specialRequests" 
                                                      name="specialRequests" 
                                                      rows="4"
                                                      maxlength="500"
                                                      placeholder="e.g., I'm allergic to cilantro, need a room on the ground floor, hoping to see a unicorn..." data-i18n="booking.requests.placeholder" data-i18n-attr="placeholder"></textarea>
                                        </div>
                                        <small class="form-helper">
                                            <span id="charCount">0</span>/500 characters
                                        </small>
                                    </div>
                                </div>
                            </section>
                        </div>

                        <!-- Step 3: Payment -->
                        <div class="step-content" id="stepContent3" style="display: none;">
                            <section class="section-card" aria-labelledby="paymentSectionTitle">
                                <div class="section-header">
                                    <div class="section-header-title">
                                        <i data-lucide="credit-card"></i>
                                        <h3 id="paymentSectionTitle" data-i18n="booking.payment.title">Secure Your Spot</h3>
                                    </div>
                                    <span class="section-badge">
                                        <i data-lucide="shield" class="me-1"></i>
                                        <span data-i18n="booking.payment.secureBadge">Secure</span>
                                    </span>
                                </div>
                                <div class="section-body">
                                    <div class="payment-methods-grid">
                                        <div class="payment-method">
                                            <input type="radio" name="paymentMethod" value="FPX" id="fpx" class="payment-radio" checked>
                                            <label for="fpx" class="payment-label">
                                                <i class="payment-icon data-lucide="building-2""></i>
                                                <span class="payment-name" data-i18n="booking.payment.fpxName">FPX Online Banking</span>
                                                <small class="payment-details" data-i18n="booking.payment.fpxDetail">All Malaysian banks</small>
                                            </label>
                                        </div>
                                        <div class="payment-method">
                                            <input type="radio" name="paymentMethod" value="Credit Card" id="creditcard" class="payment-radio">
                                            <label for="creditcard" class="payment-label">
                                                <i class="payment-icon data-lucide="credit-card""></i>
                                                <span class="payment-name" data-i18n="booking.payment.cardName">Credit / Debit Card</span>
                                                <small class="payment-details" data-i18n="booking.payment.cardDetail">Visa, Mastercard, Amex</small>
                                            </label>
                                        </div>
                                        <div class="payment-method">
                                            <input type="radio" name="paymentMethod" value="GrabPay" id="grabpay" class="payment-radio">
                                            <label for="grabpay" class="payment-label">
                                                <i class="payment-icon data-lucide="wallet""></i>
                                                <span class="payment-name" data-i18n="booking.payment.grabpayName">GrabPay</span>
                                                <small class="payment-details" data-i18n="booking.payment.ewallet">e-Wallet</small>
                                            </label>
                                        </div>
                                        <div class="payment-method">
                                            <input type="radio" name="paymentMethod" value="Touch n Go" id="touchngo" class="payment-radio">
                                            <label for="touchngo" class="payment-label">
                                                <i class="payment-icon data-lucide="smartphone""></i>
                                                <span class="payment-name" data-i18n="booking.payment.tngName">Touch 'n Go</span>
                                                <small class="payment-details" data-i18n="booking.payment.ewallet">e-Wallet</small>
                                            </label>
                                        </div>
                                    </div>

                                    <!-- Payment Information Alert -->
                                    <div class="payment-info-alert" id="paymentInfoAlert">
                                        <i data-lucide="info"></i>
                                        <p data-i18n="booking.payment.info">You're heading to our secure payment partner to finalize your booking. All your info is encrypted and safe with us.</p>
                                    </div>
                                </div>
                            </section>

                            <!-- Terms & Conditions -->
                            <section class="section-card" aria-labelledby="termsSectionTitle">
                                <div class="section-header">
                                    <div class="section-header-title">
                                        <i data-lucide="file-text"></i>
                                        <h3 id="termsSectionTitle" data-i18n="booking.terms.title">The Fine Print (Made Less Fine)</h3>
                                    </div>
                                </div>
                                <div class="section-body">
                                    <div class="alert alert-info">
                                        <i data-lucide="info"></i>
                                        <div>
                                            <strong data-i18n="booking.terms.policyTitle">Life Happens: Our Cancellation Policy</strong>
                                            <ul style="margin: 0.5rem 0 0 1rem; padding: 0;">
                                                <li data-i18n="booking.terms.rule1">Free cancellation up to 7 days before departure</li>
                                                <li data-i18n="booking.terms.rule2">50% refund for cancellations 3-7 days before departure</li>
                                                <li data-i18n="booking.terms.rule3">No refund for cancellations within 72 hours of departure</li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="form-group mt-3">
                                        <label class="form-check-label" style="display: flex; align-items: start; gap: 0.75rem; cursor: pointer;">
                                            <input type="checkbox" 
                                                   id="agreeTerms" 
                                                   name="agreeTerms" 
                                                   required
                                                   style="margin-top: 4px;">
                                            <span style="flex: 1;">
                                                <span data-i18n="booking.terms.agreePrefix">I've read and agree to the boring-but-important stuff:</span> the <a href="${pageContext.request.contextPath}/terms" target="_blank" data-i18n="booking.terms.terms">Terms & Conditions</a> 
                                                <span data-i18n="booking.terms.and">and</span> <a href="${pageContext.request.contextPath}/privacy" target="_blank" data-i18n="booking.terms.privacy">Privacy Policy</a>
                                                <span class="required">*</span>
                                            </span>
                                        </label>
                                        <span class="form-error" data-i18n="booking.terms.error">You must agree to the terms and conditions</span>
                                    </div>
                                </div>
                            </section>
                        </div>

                        <!-- Step 4: Confirmation Summary -->
                        <div class="step-content" id="stepContent4" style="display: none;">
                            <section class="section-card confirmation-card" aria-labelledby="confirmationSectionTitle">
                                <div class="confirmation-icon">
                                    <i data-lucide="check"></i>
                                </div>
                                <h2 class="confirmation-title" data-i18n="booking.confirm.title">One Last Look!</h2>
                                <p class="confirmation-message" data-i18n="booking.confirm.message">
                                    Everything look good? Give it a final check before we make it official.
                                </p>

                                <!-- Booking Summary Details -->
                                <div class="booking-summary-detail">
                                    <h4 style="margin-bottom: 1rem; color: var(--text-primary);" data-i18n="booking.confirm.detailsTitle">Booking Details</h4>
                                    <div class="summary-detail-item">
                                        <span class="summary-detail-label"><i data-lucide="luggage" class="me-2"></i><span data-i18n="booking.confirm.package">Package</span></span>
                                        <span class="summary-detail-value" id="summaryPackageName">-</span>
                                    </div>
                                    <div class="summary-detail-item">
                                        <span class="summary-detail-label"><i data-lucide="calendar-check" class="me-2"></i><span data-i18n="booking.confirm.departure">Departure Date</span></span>
                                        <span class="summary-detail-value" id="summaryDepartureDate">-</span>
                                    </div>
                                    <div class="summary-detail-item">
                                        <span class="summary-detail-label"><i data-lucide="users" class="me-2"></i><span data-i18n="booking.confirm.travelers">Travelers</span></span>
                                        <span class="summary-detail-value" id="summaryTravelers">-</span>
                                    </div>
                                    <div class="summary-detail-item">
                                        <span class="summary-detail-label"><i data-lucide="user" class="me-2"></i><span data-i18n="booking.confirm.contactName">Contact Name</span></span>
                                        <span class="summary-detail-value" id="summaryContactName">-</span>
                                    </div>
                                    <div class="summary-detail-item">
                                        <span class="summary-detail-label"><i data-lucide="mail" class="me-2"></i><span data-i18n="booking.confirm.email">Email</span></span>
                                        <span class="summary-detail-value" id="summaryEmail">-</span>
                                    </div>
                                    <div class="summary-detail-item">
                                        <span class="summary-detail-label"><i data-lucide="phone" class="me-2"></i><span data-i18n="booking.confirm.phone">Phone</span></span>
                                        <span class="summary-detail-value" id="summaryPhone">-</span>
                                    </div>
                                    <div class="summary-detail-item">
                                        <span class="summary-detail-label"><i data-lucide="credit-card" class="me-2"></i><span data-i18n="booking.confirm.paymentMethod">Payment Method</span></span>
                                        <span class="summary-detail-value" id="summaryPaymentMethod">-</span>
                                    </div>
                                </div>

                                <!-- Next Steps -->
                                <div class="next-steps">
                                    <h4 class="next-steps-title">
                                        <i data-lucide="list-checks" class="me-2"></i>
                                        <span data-i18n="booking.confirm.nextTitle">What's Next on the Agenda?</span>
                                    </h4>
                                    <ul class="next-steps-list">
                                        <li>
                                            <i data-lucide="check-circle"></i>
                                            <span data-i18n="booking.confirm.nextEmail">You'll get a confirmation email faster than you can pack a suitcase.</span>
                                        </li>
                                        <li>
                                            <i data-lucide="file-text"></i>
                                            <span data-i18n="booking.confirm.nextItinerary">Your e-ticket and full itinerary will arrive within 24 hours.</span>
                                        </li>
                                        <li>
                                            <i data-lucide="phone-call"></i>
                                            <span data-i18n="booking.confirm.nextCheckin">We'll check in with you 48 hours before your trip starts.</span>
                                        </li>
                                        <li>
                                            <i data-lucide="headphones"></i>
                                            <span data-i18n="booking.confirm.nextSupport">Our 24/7 support squad has your back for the whole journey.</span>
                                        </li>
                                    </ul>
                                </div>
                            </section>
                        </div>

                        <!-- Navigation Buttons -->
                        <nav class="step-navigation" aria-label="Booking form navigation">
                            <button type="button" 
                                    class="btn btn-secondary" 
                                    id="prevBtn" 
                                    style="display: none;"
                                    aria-label="Go to previous step">
                                <i data-lucide="arrow-left"></i>
                                <span data-i18n="booking.btn.prev">Previous</span>
                            </button>
                            
                            <div style="flex: 1;"></div>
                            
                            <button type="button" 
                                    class="btn btn-primary" 
                                    id="nextBtn"
                                    aria-label="Go to next step">
                                <span data-i18n="booking.btn.next">Onward!</span>
                                <i data-lucide="arrow-right"></i>
                            </button>
                            
                            <button type="submit" 
                                    class="btn btn-success" 
                                    id="submitBtn" 
                                    style="display: none;"
                                    aria-label="Confirm booking and proceed to payment">
                                <i data-lucide="lock" class="me-2"></i>
                                <span data-i18n="booking.btn.submit">Book My Adventure!</span>
                            </button>
                        </nav>
                    </form>
                </div>

                <!-- Sidebar: Price Summary -->
                <aside class="booking-sidebar" aria-labelledby="priceSummaryTitle">
                    <div class="price-summary">
                        <div class="summary-header">
                            <h4 id="priceSummaryTitle">
                                <i data-lucide="receipt" class="me-2"></i>
                                <span data-i18n="booking.sidebar.title">The Damage Report</span>
                            </h4>
                        </div>
                        <div class="summary-body">
                            <div class="summary-item">
                                <span class="summary-label" data-i18n="booking.sidebar.costPer">Adventure Cost (per explorer)</span>
                                <span class="summary-value">RM <span id="basePackagePrice">0.00</span></span>
                            </div>
                            <div class="summary-item">
                                <span class="summary-label" data-i18n="booking.sidebar.squad">Your Explorer Squad</span>
                                <span class="summary-value"><span id="travelersCount">0</span> person(s)</span>
                            </div>
                            <div class="summary-item">
                                <span class="summary-label" data-i18n="booking.sidebar.subtotal">Subtotal</span>
                                <span class="summary-value">RM <span id="subtotalPrice">0.00</span></span>
                            </div>
                            <div class="summary-item">
                                <span class="summary-label" data-i18n="booking.sidebar.tax">Tax & Service (6%)</span>
                                <span class="summary-value">RM <span id="taxPrice">0.00</span></span>
                            </div>
                            <div class="summary-item" id="discountRow" style="display: none;">
                                <span class="summary-label" style="color: var(--success-color);">
                                    <i data-lucide="tag" class="me-1"></i><span data-i18n="booking.sidebar.discount">Discount</span>
                                </span>
                                <span class="summary-value" style="color: var(--success-color);">
                                    - RM <span id="discountAmount">0.00</span>
                                </span>
                            </div>
                            
                            <div class="summary-total">
                                <div class="total-row">
                                    <span class="total-label" data-i18n="booking.sidebar.total">Total Amount</span>
                                    <span class="total-amount">RM <span id="totalAmount">0.00</span></span>
                                </div>
                            </div>
                            
                            <!-- Promo Code Section -->
                            <div class="promo-section">
                                <label for="promoCode" class="form-label">
                                    <i data-lucide="tag" class="me-1"></i>
                                    <span data-i18n="booking.promo.label">Got a Magic Word? (Promo Code)</span>
                                </label>
                                <div class="promo-input-group">
                                    <input type="text" 
                                           class="form-input" 
                                           id="promoCode" 
                                           name="promoCode"
                                           placeholder="Enter code" data-i18n="booking.promo.placeholder" data-i18n-attr="placeholder"
                                           style="text-transform: uppercase;">
                                    <button type="button" class="apply-promo-btn" id="applyPromoBtn">
                                        <span data-i18n="booking.promo.apply">Apply</span>
                                    </button>
                                </div>
                                <div id="promoMessage" style="margin-top: 0.5rem; font-size: 0.75rem;"></div>
                            </div>
                            
                            <!-- Trust Badges -->
                            <div class="sidebar-trust-badges">
                                <div class="trust-item">
                                    <i data-lucide="shield-check"></i>
                                    <span data-i18n="booking.trust.ssl">Secure SSL Payment</span>
                                </div>
                                <div class="trust-item">
                                    <i data-lucide="undo-2"></i>
                                    <span data-i18n="booking.trust.freeCancel">Free Cancellation</span>
                                </div>
                                <div class="trust-item">
                                    <i data-lucide="headphones"></i>
                                    <span data-i18n="booking.badge.support">24/7 Support</span>
                                </div>
                                <div class="trust-item">
                                    <i data-lucide="badge-check"></i>
                                    <span data-i18n="booking.trust.bestPrice">Best Price Guarantee</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Help Section -->
                    <div class="section-card mt-3" style="margin-bottom: 0;">
                        <div class="section-body" style="padding: var(--spacing-md); text-align: center;">
                            <i data-lucide="headphones" style="font-size: 2rem; color: var(--primary-color); margin-bottom: var(--spacing-sm);"></i>
                            <h5 style="font-size: 0.875rem; font-weight: 700; margin-bottom: var(--spacing-xs);" data-i18n="booking.stuck.title">Stuck?</h5>
                            <p style="font-size: 0.75rem; color: var(--text-secondary); margin-bottom: var(--spacing-md);" data-i18n="booking.stuck.desc">
                                Our support squad is always ready to help.
                            </p>
                            <a href="${pageContext.request.contextPath}/contact" class="btn btn-primary" style="width: 100%; padding: var(--spacing-sm) var(--spacing-md); font-size: 0.875rem;">
                                <i data-lucide="phone" class="me-2"></i>
                                <span data-i18n="booking.stuck.cta">Contact Support</span>
                            </a>
                        </div>
                    </div>
                </aside>
            </div>
        </div>
    </main>

    <!-- Loading Overlay -->
    <div class="loading-overlay" id="loadingOverlay" style="display: none;">
        <div class="loading-content">
            <div class="spinner"></div>
            <h4 class="loading-text" data-i18n="booking.loading.title">Processing Your Booking...</h4>
            <p class="loading-subtext" data-i18n="booking.loading.subtitle">Please wait while we confirm your reservation</p>
        </div>
    </div>

    <jsp:include page="../includes/footer.jsp" />

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/pages/booking-enhanced.js"></script>
    
    <!-- Initialize Lucide Icons -->
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            console.log('DOM loaded, initializing Lucide icons...');
            
            // Initialize Lucide icons
            if (typeof lucide !== 'undefined') {
                console.log('Lucide is available, creating icons...');
                lucide.createIcons();
                
                // Check if icons were created
                setTimeout(function() {
                    const icons = document.querySelectorAll('[data-lucide]');
                    console.log('Found', icons.length, 'Lucide icon elements');
                    
                    icons.forEach(function(icon, index) {
                        const svg = icon.querySelector('svg');
                        if (svg) {
                            console.log('Icon', index, 'rendered successfully:', icon.getAttribute('data-lucide'));
                        } else {
                            console.log('Icon', index, 'NOT rendered:', icon.getAttribute('data-lucide'));
                        }
                    });
                }, 500);
            } else {
                console.log('Lucide not available, loading...');
                // Fallback: try to load Lucide if not available
                const script = document.createElement('script');
                script.src = 'https://unpkg.com/lucide@latest';
                script.onload = function() {
                    console.log('Lucide loaded from fallback');
                    if (typeof lucide !== 'undefined') {
                        lucide.createIcons();
                    }
                };
                document.head.appendChild(script);
            }
            
            // Re-initialize icons after any dynamic content changes
            setTimeout(function() {
                if (typeof lucide !== 'undefined') {
                    console.log('Re-initializing Lucide icons...');
                    lucide.createIcons();
                }
            }, 1000);
        });
    </script>
</body>
</html>

