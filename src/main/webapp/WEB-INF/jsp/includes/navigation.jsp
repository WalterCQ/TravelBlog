<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<link href="${pageContext.request.contextPath}/css/includes/navigation.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/includes/navigation.js"></script>
<script src="${pageContext.request.contextPath}/js/theme-toggle.js"></script>

<!-- Set current page meta tag for JavaScript detection -->
<meta name="currentPage" content="${param.currentPage}">
<meta name="contextPath" content="${pageContext.request.contextPath}">

<!-- Compute path to decide initial navbar style for detail pages -->
<c:set var="fullPath" value="${pageContext.request.requestURI}" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="path" value="${fn:replace(fullPath, ctx, '')}" />
<c:set var="navbarInitialSolid" value="${fn:startsWith(path, '/destinations/') or fn:startsWith(path, '/packages/') }" />

<!-- Main Navbar - CSS handles all styling based on page and state -->
<nav class="navbar navbar-expand-lg ${navbarInitialSolid ? 'navbar-initial-solid' : ''}">
    <div class="container px-4"> 
        <!-- Logo -->
        <a class="navbar-brand" href="${pageContext.request.contextPath}/">
            <img src="${pageContext.request.contextPath}/images/logo.png" alt="MyTour" height="60" class="me-2">
            <span>My</span><span>Tour</span>
        </a>
        
        <!-- Mobile Theme Toggle (always visible on mobile) -->
        <div class="theme-toggle-wrapper d-lg-none" id="mobileThemeToggle" aria-label="Theme toggle">
            <theme-button value="light" size="1.2"></theme-button>
        </div>

        <!-- Mobile Toggle -->
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar"
                aria-controls="mainNavbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <!-- Main Navigation -->
        <div class="collapse navbar-collapse" id="mainNavbar">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <!-- Home -->
                <li class="nav-item">
                    <a class="nav-link fw-bold ${param.currentPage == 'home' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/">
                        <span data-i18n="nav.home">Home</span>
                    </a>
                </li>
                
                <!-- Destinations Dropdown -->
                <li class="nav-item dropdown mega-dropdown">
                    <a class="nav-link fw-bold ${param.currentPage == 'destinations' or param.currentPage == 'attractions' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/destinations" 
                       id="destinationsDropdown" 
                       role="button" 
                       data-bs-toggle="dropdown" 
                       aria-expanded="false"
                       aria-haspopup="true">
                        <span data-i18n="nav.destinations">Destinations</span>
                        <i data-lucide="chevron-down" class="dropdown-icon"></i>
                    </a>
                    <div class="dropdown-menu mega-menu" aria-labelledby="destinationsDropdown">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mega-menu-section">
                                        <h6 class="mega-menu-header" data-i18n="nav.explore">Explore</h6>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/destinations">
                                            <i data-lucide="map-pin" class="me-2"></i>
                                            <div>
                                                <span data-i18n="nav.destinations">All Destinations</span>
                                                <small class="text-muted d-block" data-i18n="nav.attractions.desc">Discover amazing places</small>
                                            </div>
                                        </a>
									</div>
								</div>
                                <div class="col-md-6">
                                    <div class="mega-menu-section">
                                        <h6 class="mega-menu-header" data-i18n="nav.popular">Popular</h6>
										<a class="dropdown-item" href="${pageContext.request.contextPath}/attractions">
										    <i data-lucide="compass" class="me-2"></i>
										    <div>
                                            <span data-i18n="nav.attractions">Top Attractions</span>
                                            <small class="text-muted d-block" data-i18n="nav.attractions.desc">Must-see locations</small>
										    </div>
										</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                
                <!-- Book Dropdown -->
                <li class="nav-item dropdown mega-dropdown">
                    <a class="nav-link fw-bold ${param.currentPage == 'booking' or param.currentPage == 'packages' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/booking" 
                       id="bookDropdown" 
                       role="button" 
                       data-bs-toggle="dropdown" 
                       aria-expanded="false"
                       aria-haspopup="true">
                        <span data-i18n="nav.book">Booking</span>
                        <i data-lucide="chevron-down" class="dropdown-icon"></i>
                    </a>
                    <div class="dropdown-menu mega-menu" aria-labelledby="bookDropdown">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mega-menu-section">
                                        <h6 class="mega-menu-header" data-i18n="nav.manage.bookings">Travel Packages</h6>
									<a class="dropdown-item" href="${pageContext.request.contextPath}/packages">
									    <i data-lucide="package" class="me-2"></i>
									    <div>
                                            <span data-i18n="nav.packages">Travel Packages</span>
                                            <small class="text-muted d-block" data-i18n="nav.packages.desc">Curated travel experiences</small>
									    </div>
									</a>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mega-menu-section">
                                        <h6 class="mega-menu-header" data-i18n="nav.booking.services">Booking Services</h6>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/booking">
                                            <i data-lucide="calendar-check" class="me-2"></i>
                                            <div>
                                                <span data-i18n="nav.booking">Quick Booking</span>
                                                <small class="text-muted d-block" data-i18n="nav.booking.desc">Book tours and activities instantly</small>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
                
                <!-- About Dropdown -->
                <li class="nav-item dropdown mega-dropdown">
                    <a class="nav-link fw-bold ${param.currentPage == 'about' or param.currentPage == 'contact' or param.currentPage == 'feedback' ? 'active' : ''}" 
                       href="${pageContext.request.contextPath}/about" 
                       id="aboutDropdown" 
                       role="button" 
                       data-bs-toggle="dropdown" 
                       aria-expanded="false"
                       aria-haspopup="true">
                        <span data-i18n="nav.about.us">About Us</span>
                        <i data-lucide="chevron-down" class="dropdown-icon"></i>
                    </a>
                    <div class="dropdown-menu mega-menu" aria-labelledby="aboutDropdown">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mega-menu-section">
                                        <h6 class="mega-menu-header" data-i18n="nav.company.info">Company Information</h6>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/about">
                                            <i data-lucide="info" class="me-2"></i>
                                            <div>
                                                <span data-i18n="nav.about">About MyTour</span>
                                                <small class="text-muted d-block" data-i18n="nav.about.desc">Our story and mission</small>
                                            </div>
                                        </a>
										<a class="dropdown-item" href="${pageContext.request.contextPath}/help">
										    <i data-lucide="help-circle" class="me-2"></i>
										    <div>
                                            <span data-i18n="nav.help">Help Center</span>
                                            <small class="text-muted d-block" data-i18n="nav.help.desc">FAQs and support</small>
										    </div>
										</a>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mega-menu-section">
                                        <h6 class="mega-menu-header" data-i18n="nav.support">Support & Contact</h6>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/contact">
                                            <i data-lucide="mail" class="me-2"></i>
                                            <div>
                                                <span data-i18n="nav.contact">Contact Us</span>
                                                <small class="text-muted d-block" data-i18n="nav.contact.desc">Get in touch with us</small>
                                            </div>
                                        </a>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/feedback">
                                            <i data-lucide="message-square" class="me-2"></i>
                                            <div>
                                                <span data-i18n="nav.feedback">Feedback</span>
                                                <small class="text-muted d-block" data-i18n="nav.feedback.desc">Share your experience</small>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
            
            <!-- Right side elements -->
            <div class="d-flex align-items-center gap-3">
				    <!-- Theme Toggle Button -->
			    	<div class="theme-toggle-wrapper d-none d-lg-flex">
				        <theme-button value="light" size="1.2"></theme-button>
				    </div>
				    
                    <ul class="navbar-nav ms-auto">
                      <!-- Language Switcher -->
                      <li class="nav-item dropdown">
                        <a class="nav-link d-flex align-items-center" href="#" id="languageDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                          <i data-lucide="globe" class="me-1"></i>
                          <span id="currentLanguage">EN</span>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="languageDropdown">
                          <li><a class="dropdown-item lang-btn" href="#" data-lang="en">English</a></li>
                          <li><a class="dropdown-item lang-btn" href="#" data-lang="zh">中文</a></li>
                          <li><a class="dropdown-item lang-btn" href="#" data-lang="ms">Bahasa Melayu</a></li>
                          <li><a class="dropdown-item lang-btn" href="#" data-lang="ru">Русский</a></li>
                          <li><a class="dropdown-item lang-btn" href="#" data-lang="ar">العربية</a></li>
                          <li><a class="dropdown-item lang-btn" href="#" data-lang="fr">Français</a></li>
                        </ul>
                      </li>
				      <li class="nav-item dropdown">
				        <c:choose>
				          <c:when test="${sessionScope.isLoggedIn}">
				            <a class="nav-link d-flex align-items-center" href="#" id="accountDropdown" 
				               role="button" data-bs-toggle="dropdown" aria-expanded="false">
				              <i data-lucide="user-circle" class="me-1"></i>
				              <!-- Display name -->
				              <span>${sessionScope.currentUser.firstName}</span>
				            </a>
				            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="accountDropdown">
				              <li>
				                <a class="dropdown-item" href="${pageContext.request.contextPath}/account/profile">
				                  <i data-lucide="user" class="me-2"></i><span data-i18n="account.profile">My Profile</span>
				                </a>
				              </li>
				              <li>
				                <a class="dropdown-item" href="${pageContext.request.contextPath}/my-bookings">
				                  <i data-lucide="calendar-check" class="me-2"></i><span data-i18n="account.bookings">My Bookings</span>
				                </a>
				              </li>
				              <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
				                <li><hr class="dropdown-divider"></li>
				                <li>
				                  <a class="dropdown-item text-primary" href="${pageContext.request.contextPath}/admin/destinations">
				                    <i data-lucide="shield" class="me-2"></i><span data-i18n="account.admin">Admin Panel</span>
				                  </a>
				                </li>
				              </c:if>
				              <li><hr class="dropdown-divider"></li>
				              <li>
				                <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/account/logout">
				                  <i data-lucide="log-out" class="me-2"></i><span data-i18n="account.logout">Logout</span>
				                </a>
				              </li>
				            </ul>
				          </c:when>

				          <c:otherwise>
				            <a class="nav-link d-flex align-items-center" href="#" id="accountDropdown" 
				               role="button" data-bs-toggle="dropdown" aria-expanded="false">
				              <i data-lucide="user-circle" class="me-1"></i>
                              <span data-i18n="account">Account</span>
				            </a>
				            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="accountDropdown">
				              <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/account/login">
                                  <i data-lucide="log-in" class="me-2"></i><span data-i18n="account.login">Login</span>
				                </a>
				              </li>
				              <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/account/register">
                                  <i data-lucide="user-plus" class="me-2"></i><span data-i18n="account.register">Register</span>
				                </a>
				              </li>
				            </ul>
				          </c:otherwise>
				        </c:choose>
				      </li>
				    </ul>
				  </div>
				</nav>

<!-- Initialize Lucide Icons -->
<script>
  document.addEventListener('DOMContentLoaded', function() {
    if (typeof lucide !== 'undefined') {
      lucide.createIcons();
      
      // 为世界部分的图标和文字设置高级主题色
      setTimeout(function() {
        const listItems = document.querySelectorAll('.world-section ul li');
        const colors = ['#4285f4', '#B8860B', '#DAA520']; // Blue + Premium gold theme colors
        
        listItems.forEach(function(li, index) {
          if (index < colors.length) {
            // 设置文字颜色
            li.style.color = colors[index];
            
            // 设置所有SVG图标颜色
            const svgs = li.querySelectorAll('svg');
            svgs.forEach(function(svg) {
              svg.style.stroke = colors[index];
              svg.style.color = colors[index];
            });
          }
        });
      }, 200);
    }

    // 预渲染一次隐藏的 dropdown/mega，消除首帧抖动
    (window.requestIdleCallback || window.requestAnimationFrame)(function() {
      try {
        // 1) Dropdown 预热
        const warmDropdown = document.createElement('div');
        warmDropdown.className = 'dropdown-menu';
        warmDropdown.style.position = 'fixed';
        warmDropdown.style.left = '-9999px';
        warmDropdown.style.top = '-9999px';
        warmDropdown.style.display = 'block';
        warmDropdown.style.opacity = '0';
        warmDropdown.innerHTML = '<div style="height:1px;width:1px"></div>';
        document.body.appendChild(warmDropdown);

        // 2) Mega 预热
        const warmMega = document.createElement('div');
        warmMega.className = 'mega-menu';
        warmMega.style.position = 'fixed';
        warmMega.style.left = '-9999px';
        warmMega.style.top = '-9999px';
        warmMega.style.display = 'block';
        warmMega.style.opacity = '0';
        warmMega.innerHTML = '<div style="height:1px;width:1px"></div>';
        document.body.appendChild(warmMega);

        // 3) 强制读写触发样式计算
        // eslint-disable-next-line no-unused-expressions
        void warmDropdown.offsetHeight;
        void warmMega.offsetHeight;

        // 4) 清理
        setTimeout(function() {
          warmDropdown.remove();
          warmMega.remove();
        }, 100);
      } catch (e) {
        // 忽略预热失败
      }
    });
  });
</script>