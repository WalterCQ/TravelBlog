<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="${destination.name} - MyTour Global" />
    <jsp:param name="currentPage" value="destination-detail" />
</jsp:include>

<jsp:include page="../includes/navigation.jsp">
    <jsp:param name="currentPage" value="destinations" />
</jsp:include>

<!-- Destination Detail Main Content -->
<main class="destination-detail-content" role="main">
    
    <!-- Hero Section with 16:9 Aspect Ratio -->
    <section class="destination-hero">
        <div class="hero-container">
            <div class="hero-media">
                <!-- Use video if available, fallback to image -->
                <c:choose>
                    <c:when test="${destination.videoPath != null and !empty destination.videoPath}">
                        <video class="hero-video" autoplay muted loop playsinline>
                            <source src="${pageContext.request.contextPath}/${destination.videoPath}" type="video/mp4">
                            <!-- Fallback to image if video fails -->
                            <img src="${pageContext.request.contextPath}/${destination.imagePath}" 
                                 alt="${destination.name}" class="hero-image"
                                 onerror="this.src='${pageContext.request.contextPath}/images/Norway.jpg'">
                        </video>
                    </c:when>
                    <c:otherwise>
                        <img src="${pageContext.request.contextPath}/${destination.imagePath}" 
                             alt="${destination.name}" class="hero-image"
                             onerror="this.src='${pageContext.request.contextPath}/images/Norway.jpg'">
                    </c:otherwise>
                </c:choose>
                
                <!-- Gallery Button -->
                <div class="position-absolute top-0 end-0 m-3">
                    <button class="btn btn-light btn-sm rounded-circle" data-bs-toggle="modal" data-bs-target="#galleryModal">
                        <i data-lucide="images"></i>
                    </button>
                </div>
                
                <!-- Hero Overlay Content -->
                <div class="hero-overlay">
                    <div class="container">
                        <div class="hero-content">
                            <div class="destination-header">
                                <div class="destination-badges">
                                    <c:if test="${destination.featured}">
                                        <span class="badge badge-featured">
                                            <i data-lucide="badge-check"></i> <span data-i18n="dest.recommended">Recommended</span>
                                        </span>
                                    </c:if>
                                    <span class="badge badge-category">
                                        ${destination.displayCategory}
                                    </span>
                                </div>
                                
                                <h1 class="destination-title" data-i18n="dest.name.${destination.id}">${destination.name}</h1>
                                
                                <div class="destination-location">
                                    <i data-lucide="map-pin"></i>
                                    <span>
                                        <c:if test="${not empty destination.city}">
                                            ${destination.city}, 
                                        </c:if>
                                        ${destination.country}
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Destination Information -->
    <section class="destination-info py-5">
        <div class="container">
            <div class="row">
                <!-- Main Content -->
                <div class="col-lg-8">
                    <!-- Quick Facts with colorful icons -->
                    <div class="content-section mb-4">
                        <h2 class="section-title" data-i18n="dest.detail.quickfacts">Quick Facts</h2>
                        <div class="row g-3">
                            <div class="col-12 col-md-4">
                                <div class="detail-item">
                                    <i data-lucide="calendar" class="icon-duration me-2"></i>
                                    <span>
                                        <c:choose>
                                            <c:when test="${destination.averageDuration != null && destination.averageDuration > 0}">
                                                ${destination.averageDuration} days trip
                                            </c:when>
                                            <c:otherwise>
                                                Flexible
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </div>
                            <div class="col-12 col-md-4">
                                <div class="detail-item">
                                    <i data-lucide="thermometer" class="icon-season me-2"></i>
                                    <span data-i18n="dest.bestTime.${destination.id}">
                                        <c:choose>
                                            <c:when test="${not empty destination.bestTimeToVisit}">
                                                ${destination.bestTimeToVisit}
                                            </c:when>
                                            <c:otherwise>
                                                Year-round
                                            </c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </div>
                            <div class="col-12 col-md-4">
                                <div class="detail-item">
                                    <i data-lucide="mountain" class="icon-difficulty me-2 ${destination.difficultyLevel == 'EASY' ? 'difficulty-easy' : destination.difficultyLevel == 'MODERATE' ? 'difficulty-moderate' : 'difficulty-hard'}"></i>
                                    <span>
                                        ${destination.difficultyLevel == 'EASY' ? 'Easy' : destination.difficultyLevel == 'MODERATE' ? 'Moderate' : 'Challenging'}
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Description -->
                    <div class="content-section mb-5">
                        <h2 class="section-title"><span data-i18n="dest.detail.story">The Story of</span> <span data-i18n="dest.name.${destination.id}">${destination.name}</span></h2>
                        <div class="destination-description">
                            <p data-i18n="dest.desc.${destination.id}">${destination.description}</p>
                        </div>
                    </div>
                    
                    <!-- Key Features Section -->
                    <div class="content-section mb-5">
                        <h2 class="section-title" data-i18n="dest.detail.why">Why You'll Love It Here</h2>
                        <div class="row">
                            <div class="col-md-6">
                                <ul class="list-unstyled">
                                    <li class="mb-3 d-flex align-items-center">
                                        <div class="feature-icon me-3">
                                            <i data-lucide="check-circle" class="text-success fs-5"></i>
                                        </div>
                                        <span data-i18n="dest.detail.feature.culture">Once-in-a-lifetime cultural experiences</span>
                                    </li>
                                    <li class="mb-3 d-flex align-items-center">
                                        <div class="feature-icon me-3">
                                            <i data-lucide="user-check" class="text-success fs-5"></i>
                                        </div>
                                        <span data-i18n="dest.detail.feature.guided">Professional guided tours</span>
                                    </li>
                                    <li class="mb-3 d-flex align-items-center">
                                        <div class="feature-icon me-3">
                                            <i data-lucide="camera" class="text-success fs-5"></i>
                                        </div>
                                        <span data-i18n="dest.detail.feature.photos">Insta-worthy photo ops everywhere</span>
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <ul class="list-unstyled">
                                    <li class="mb-3 d-flex align-items-center">
                                        <div class="feature-icon me-3">
                                            <i data-lucide="shield" class="text-success fs-5"></i>
                                        </div>
                                        <span data-i18n="dest.detail.feature.safe">Safe and secure environment</span>
                                    </li>
                                    <li class="mb-3 d-flex align-items-center">
                                        <div class="feature-icon me-3">
                                            <i data-lucide="users" class="text-success fs-5"></i>
                                        </div>
                                        <span data-i18n="dest.detail.feature.audience">Perfect for rookies and pros alike</span>
                                    </li>
                                    <li class="mb-3 d-flex align-items-center">
                                        <div class="feature-icon me-3">
                                            <i data-lucide="heart" class="text-success fs-5"></i>
                                        </div>
                                        <span data-i18n="dest.detail.feature.memories">Unforgettable memories</span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Travel Packages -->
					<div class="content-section mb-5">
                                           <h2 class="section-title">
                                               <i data-lucide="suitcase" class="me-2"></i>
                                               <span data-i18n="dest.detail.packages">Ready-Made Adventures Here</span>
                                           </h2>
					                       <c:choose>
					                           <c:when test="${not empty travelPackages}">
					                               <div class="row g-4">
					                                   <c:forEach var="travelPackage" items="${travelPackages}">
					                                       <div class="col-lg-12">
					                                           <div class="package-card">
					                                               <div class="package-header">
					                                                   <div class="package-title">
					                                                       <h3 data-i18n="pkg.name.${travelPackage.id}">${travelPackage.name}</h3>
					                                                       <c:if test="${travelPackage.featured}">
                                                           <span class="badge bg-warning text-dark ms-2">
                                                               <i data-lucide="star" class="me-1"></i><span data-i18n="dest.recommended">Recommended</span>
                                                           </span>
					                                                       </c:if>
					                                                       <span class="badge bg-${travelPackage.typeColorClass} ms-2">
					                                                           ${travelPackage.displayType}
					                                                       </span>
					                                                   </div>
					                                                   <div class="package-price">
                                                      <span class="currency">RM <fmt:formatNumber value="${travelPackage.price}" pattern="#,,##0.00" /></span>
                                                       <span class="duration-text" data-i18n="dest.detail.perperson">per person</span>
					                                                       <c:if test="${not empty travelPackage.durationDisplay}">
					                                                           <small class="text-muted d-block">${travelPackage.durationDisplay}</small>
					                                                       </c:if>
					                                                   </div>
					                                               </div>
					                                               
					                                               <div class="package-description">
					                                                   <p data-i18n="pkg.desc.${travelPackage.id}">${travelPackage.description}</p>
					                                               </div>
					                                               
					                                               <div class="package-details">
					                                                   <div class="row">
					                                                       <div class="col-md-6">
                                                            <div class="detail-item">
                                                                <i data-lucide="users"></i>
                                                               <span data-i18n="dest.detail.groupsize">Group Size:</span> ${travelPackage.participantsDisplay}
					                                                           </div>
					                                                           <c:if test="${not empty travelPackage.maxParticipants}">
                                                                <div class="detail-item">
                                                                    <i data-lucide="user-check"></i>
                                                                   <span data-i18n="dest.detail.max">Max participants:</span> ${travelPackage.maxParticipants}
					                                                               </div>
					                                                           </c:if>
					                                                       </div>
					                                                   </div>
					                                               </div>
					                                               
					                                               <c:if test="${not empty travelPackage.inclusions}">
					                                                   <div class="package-inclusions mb-3">
                                                       <h6><i data-lucide="check-circle" class="text-success me-2"></i><span data-i18n="dest.detail.inclusions">Inclusions:</span></h6>
					                                                       <p class="text-muted" data-i18n="pkg.inclusions.${travelPackage.id}">${travelPackage.inclusions}</p>
					                                                   </div>
					                                               </c:if>
					                                               <div class="package-actions">
					                                                   <a href="${pageContext.request.contextPath}/booking?package=${travelPackage.id}" 
					                                                      class="btn btn-primary">
                                                       <i data-lucide="calendar-check" class="me-2"></i><span data-i18n="common.bookNow">Book Now</span>
					                                                   </a>
					                                                   <a href="${pageContext.request.contextPath}/packages/${travelPackage.id}" 
					                                                      class="btn btn-outline-secondary">
                                                       <i data-lucide="info" class="me-2"></i><span data-i18n="common.viewDetails">View Details</span>
					                                                   </a>
					                                               </div>
					                                           </div>
					                                       </div>
					                                   </c:forEach>
					                               </div>
					                           </c:when>
					                           <c:otherwise>
					                               <div class="empty-state text-center py-5">
					                                   <i class="fas fa-suitcase display-4 text-muted mb-3"></i>
                                   <h4 class="mb-3" data-i18n="dest.detail.empty.title">No adventures cooked up... yet!</h4>
                                   <p class="text-muted" data-i18n="dest.detail.empty.desc">We're busy scouting the best experiences for this spot. Check back soon or browse other amazing places.</p>
					                                   <a href="${pageContext.request.contextPath}/packages" class="btn btn-outline-primary">
					                                       <i class="fas fa-search me-2"></i>Find Other Adventures
					                                   </a>
					                               </div>
					                           </c:otherwise>
					                       </c:choose>
					                   </div>
                    
                    <!-- Planning Section -->
                    <div class="planning-section bg-light rounded p-4 mb-5">
                        <h3 class="mb-3">Ready to Start Scheming?</h3>
                        <p>The best trips start with a spark of an idea. Let our travel nerds help you build the perfect getaway. We'll handle the boring stuff so you can focus on the fun part.</p>
                        
                        <div class="mt-4 d-flex flex-wrap gap-3">
                            <a href="${pageContext.request.contextPath}/destinations" class="btn btn-outline-secondary btn-lg">
                                <i data-lucide="arrow-left" class="me-2"></i>
                                <span data-i18n="dest.detail.back">See More Places</span>
                            </a>
                        </div>
                    </div>
                    
                    <!-- Reviews Section -->
                    <div class="reviews-section mb-5">
                        <h3 class="mb-4" data-i18n="dest.detail.reviews">Tales from Fellow Travelers</h3>
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <div class="review-card bg-white border rounded p-3 h-100">
                                    <div class="d-flex mb-2">
                                        <div class="me-3">
                                            <div class="review-avatar bg-primary text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                                <span class="fw-bold">JS</span>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h6 class="mb-0">John Smith</h6>
                                            <div class="text-warning mb-1">
                                                <i data-lucide="star"></i>
                                                <i data-lucide="star"></i>
                                                <i data-lucide="star"></i>
                                                <i data-lucide="star"></i>
                                                <i data-lucide="star"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <p class="mb-0 small" data-i18n="dest.detail.review1">Amazing experience! The scenery was breathtaking and our guide was very knowledgeable.</p>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="review-card bg-white border rounded p-3 h-100">
                                    <div class="d-flex mb-2">
                                        <div class="me-3">
                                            <div class="review-avatar bg-success text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                                <span class="fw-bold">MJ</span>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h6 class="mb-0">Maria Johnson</h6>
                                            <div class="text-warning mb-1">
                                                <i data-lucide="star"></i>
                                                <i data-lucide="star"></i>
                                                <i data-lucide="star"></i>
                                                <i data-lucide="star"></i>
                                                <i data-lucide="star" style="opacity:0.5"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <p class="mb-0 small" data-i18n="dest.detail.review2">Perfect for families! Well organized and safe. Would definitely recommend to others.</p>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="review-card bg-white border rounded p-3 h-100">
                                    <div class="d-flex mb-2">
                                        <div class="me-3">
                                            <div class="review-avatar bg-info text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                                <span class="fw-bold">DL</span>
                                            </div>
                                        </div>
                                        <div class="flex-grow-1">
                                            <h6 class="mb-0">David Lee</h6>
                                            <div class="text-warning mb-1">
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="fas fa-star"></i>
                                                <i class="far fa-star"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <p class="mb-0 small" data-i18n="dest.detail.review3">Great value for money. The experience exceeded our expectations in every way.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Sidebar -->
                <div class="col-lg-4">
                    <div class="destination-sidebar">
                        <!-- Quick Info Card -->
                        <div class="info-card mb-4">
                            <h4 class="card-title">
                                <i class="fas fa-info-circle me-2"></i>
                                <span data-i18n="dest.detail.gist">The Gist</span>
                            </h4>
                            <div class="info-list">
                                <div class="info-item">
                                    <span class="info-label" data-i18n="dest.detail.besttime">Best Time to Go:</span>
                                    <span class="info-value" data-i18n="dest.detail.besttime.value">Year-round fun</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label" data-i18n="dest.detail.length">How Long to Stay:</span>
                                    <span class="info-value" data-i18n="dest.detail.length.value">3-7 days is the sweet spot</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label" data-i18n="dest.detail.level">Adventure Level:</span>
                                    <span class="badge bg-success" data-i18n="dest.detail.level.value">Pretty Chill</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label" data-i18n="dest.detail.quota">Explorer Quota:</span>
                                    <span class="info-value" data-i18n="dest.detail.quota.value">2-15 people</span>
                                </div>
                                <div class="info-item">
                                    <span class="info-label" data-i18n="dest.detail.wallet">Wallet Damage:</span>
                                    <div>
                                        <span class="text-success fw-bold">$299 - $899</span>
                                    <small class="text-muted d-block" data-i18n="dest.detail.wallet.per">per adventurer</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Weather Widget -->
					<div class="weather-card mb-4" data-country="${destination.country}" data-city="${destination.city}">
                    <h4 class="card-title">
                        <i data-lucide="cloud-sun" class="me-2"></i>
					        Current Weather
					        <c:if test="${not empty destination.city}">
					            <small class="text-muted d-block" style="font-size: 0.8rem; font-weight: normal;">
					                ${destination.city}
					            </small>
					        </c:if>
					    </h4>
					    <div class="text-center weather-content">
                        <div class="weather-icon mb-2">
                            <i data-lucide="loader" class="fs-1 text-muted"></i>
					        </div>
					        <h4 class="weather-temp mb-1">Loading...</h4>
					        <p class="weather-desc mb-0 text-muted">Getting weather data...</p>
					        <small class="weather-message text-muted">Fetching latest weather information</small>
					    </div>
					</div>
                        
                        <!-- Related Destinations -->
                        <c:if test="${not empty relatedDestinations}">
                            <div class="related-destinations">
                                <h4 class="card-title">
                                    <i data-lucide="compass" class="me-2"></i>
                                    <span data-i18n="dest.detail.related">You Might Also Like...</span>
                                </h4>
                                <div class="related-list">
                                    <c:forEach var="related" items="${relatedDestinations}">
                                        <a href="${pageContext.request.contextPath}/destinations/${related.id}" 
                                           class="related-item">
                                            <div class="related-image">
                                                <img src="${pageContext.request.contextPath}/${related.imagePath}" 
                                                     alt="${related.name}"
                                                     onerror="this.src='${pageContext.request.contextPath}/images/Colosseum.jpg'">
                                            </div>
                                            <div class="related-content">
                                                <h6 class="related-title">${related.name}</h6>
                                                <p class="related-location">
                                                    <i data-lucide="map-pin"></i>
                                                    ${related.country}
                                                </p>
                                                <small class="text-muted" data-i18n="dest.detail.related.cta">Check it out!</small>
                                            </div>
                                        </a>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
</main>

<!-- Gallery Modal -->
<div class="modal fade" id="galleryModal" tabindex="-1" aria-labelledby="galleryModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="galleryModalLabel">The "Wish You Were Here" Gallery</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="galleryCarousel" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img src="${pageContext.request.contextPath}/${destination.imagePath}" 
                                 class="d-block w-100 rounded" alt="${destination.name}">
                        </div>
                        <!-- Additional gallery images would go here -->
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#galleryCarousel" data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden" data-i18n="carousel.prev">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#galleryCarousel" data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden" data-i18n="carousel.next">Next</span>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Share Modal -->
<div class="modal fade" id="shareModal" tabindex="-1" aria-labelledby="shareModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="shareModalLabel">Share This Awesome Spot</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center">
                <div class="d-flex justify-content-center gap-3">
                    <a href="#" class="btn btn-primary btn-lg rounded-circle">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a href="#" class="btn btn-info btn-lg rounded-circle">
                        <i class="fab fa-twitter"></i>
                    </a>
                    <a href="#" class="btn btn-success btn-lg rounded-circle">
                        <i class="fab fa-whatsapp"></i>
                    </a>
                    <a href="#" class="btn btn-secondary btn-lg rounded-circle">
                        <i class="fas fa-envelope"></i>
                    </a>
                </div>
                <hr>
                <div class="input-group">
                    <input type="text" class="form-control" id="shareUrl" value="${pageContext.request.requestURL}" readonly>
                    <button class="btn btn-outline-secondary" type="button" onclick="copyToClipboard()">
                        <i class="fas fa-clipboard"></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Include footer -->
<jsp:include page="../includes/footer.jsp" />

<!-- Page-specific CSS -->
<link href="${pageContext.request.contextPath}/css/pages/destination-detail.css" rel="stylesheet">

<!-- Page-specific JavaScript -->
<script src="${pageContext.request.contextPath}/js/pages/destination-detail.js"></script>