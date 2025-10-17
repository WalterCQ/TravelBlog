<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="${pageContext.request.locale.language}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - MyTour Global</title>
    <meta name="contextPath" content="${pageContext.request.contextPath}">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link href="${pageContext.request.contextPath}/css/includes/navigation.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/includes/footer.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/pages/profile.css" rel="stylesheet">
    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest"></script>
</head>
<body>
    <!-- Navigation -->
    <jsp:include page="../includes/navigation.jsp">
        <jsp:param name="currentPage" value="profile" />
    </jsp:include>

    <!-- Main Content -->
    <div class="profile-page-wrapper">
        <section class="page-header">
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <h1 class="page-title" data-i18n="profile.title">My Profile</h1>
                        <p class="page-subtitle" data-i18n="profile.subtitle">Manage your account settings and personal information.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="profile-section">
            <div class="container">
        <!-- Alert Messages -->
        <c:if test="${not empty successMessage or not empty message}">
            <div class="alert alert-success alert-dismissible fade show modern-alert" role="alert">
                <i data-lucide="check-circle" class="me-2"></i> ${not empty successMessage ? successMessage : message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        <c:if test="${not empty errorMessage or not empty error}">
            <div class="alert alert-danger alert-dismissible fade show modern-alert" role="alert">
                <i data-lucide="alert-triangle" class="me-2"></i> ${not empty errorMessage ? errorMessage : error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

                <div class="row">
                    <!-- Left Sidebar - Profile Card -->
                    <div class="col-lg-4 mb-4">
                        <div class="profile-card">
                            <div class="profile-header">
                                <div class="avatar-wrapper">
                                    <div class="avatar-circle">
                                        ${user.firstName.substring(0,1).toUpperCase()}${user.lastName.substring(0,1).toUpperCase()}
                                    </div>
                                </div>
                                <h4 class="profile-name">${user.firstName} ${user.lastName}</h4>
                                <p class="profile-username">@${user.username}</p>
                                <span class="role-badge ${user.role == 'ADMIN' ? 'role-admin' : 'role-user'}">
                                    <i data-lucide="${user.role == 'ADMIN' ? 'shield-check' : 'user'}"></i>
                                    ${user.role}
                                </span>
                            </div>
                            <div class="member-info">
                                <i data-lucide="calendar"></i>
                                <span data-i18n="profile.memberSince.prefix">Member since</span> <fmt:formatDate value="${user.createdAtAsDate}" pattern="MMMM yyyy"/>
                            </div>
                        </div>

                        <!-- Quick Actions Card -->
                        <div class="quick-actions mt-3">
                            <h5 class="quick-actions-title">
                                <i data-lucide="zap"></i> <span data-i18n="profile.quick.title">Quick Actions</span>
                            </h5>
                            <div class="action-buttons">
                                <a href="${pageContext.request.contextPath}/my-bookings" class="action-btn">
                                    <i data-lucide="calendar-check"></i>
                                    <span data-i18n="profile.quick.myAdventures">My Bookings</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/packages" class="action-btn">
                                    <i data-lucide="search"></i>
                                    <span data-i18n="profile.quick.findNext">Browse Packages</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/contact" class="action-btn">
                                    <i data-lucide="headphones"></i>
                                    <span data-i18n="profile.quick.support">Support</span>
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Right Content - Tabs -->
                    <div class="col-lg-8">
                        <div class="profile-content">
                    <!-- Tabs Navigation -->
                    <ul class="nav nav-tabs modern-tabs" id="profileTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="info-tab" data-bs-toggle="tab" data-bs-target="#info" type="button" role="tab">
                                <i data-lucide="user-cog"></i> <span data-i18n="profile.tabs.info">Your Explorer ID</span>
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="security-tab" data-bs-toggle="tab" data-bs-target="#security" type="button" role="tab">
                                <i data-lucide="shield"></i> <span data-i18n="profile.tabs.security">Fortify Your Account</span>
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="preferences-tab" data-bs-toggle="tab" data-bs-target="#preferences" type="button" role="tab">
                                <i data-lucide="sliders"></i> <span data-i18n="profile.tabs.preferences">Tune Your Experience</span>
                            </button>
                        </li>
                    </ul>

                    <!-- Tabs Content -->
                    <div class="tab-content" id="profileTabsContent">
                        <!-- Personal Information Tab -->
                        <div class="tab-pane fade show active" id="info" role="tabpanel">
                            <h5 class="content-title">
                                <i data-lucide="user"></i> <span data-i18n="profile.info.title">Your Explorer ID</span>
                            </h5>
                            <p class="content-subtitle" data-i18n="profile.info.subtitle">Keep your info up-to-date so we know who's doing all this awesome traveling.</p>

                            <form method="post" action="${pageContext.request.contextPath}/account/update-profile" id="profileForm" class="modern-form">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label for="firstName" class="form-label">
                                            <i data-lucide="user"></i> <span data-i18n="form.firstName">First Name</span>
                                        </label>
                                        <input type="text" class="form-control modern-input" id="firstName" name="firstName" value="${user.firstName}" required>
                                        <div class="invalid-feedback" data-i18n="profile.validation.firstName">Please enter your first name.</div>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="lastName" class="form-label">
                                            <i data-lucide="user"></i> <span data-i18n="form.lastName">Last Name</span>
                                        </label>
                                        <input type="text" class="form-control modern-input" id="lastName" name="lastName" value="${user.lastName}" required>
                                        <div class="invalid-feedback" data-i18n="profile.validation.lastName">Please enter your last name.</div>
                                    </div>
                                    <div class="col-12">
                                        <label for="email" class="form-label">
                                            <i data-lucide="mail"></i> <span data-i18n="form.email">Email Address</span>
                                        </label>
                                        <input type="email" class="form-control modern-input" id="email" name="email" value="${user.email}" required>
                                        <div class="invalid-feedback" data-i18n="profile.validation.email">Please enter a valid email address.</div>
                                    </div>
                                    <div class="col-12">
                                        <label for="phone" class="form-label">
                                            <i data-lucide="phone"></i> <span data-i18n="form.phone">Phone Number</span>
                                        </label>
                                        <input type="tel" class="form-control modern-input" id="phone" name="phone" value="${user.phone}" placeholder="+1 (555) 123-4567">
                                        <small class="form-text text-muted" data-i18n="profile.info.phone.helper">Optional, but handy for sending smoke signals (or booking alerts).</small>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label">
                                            <i data-lucide="badge"></i> <span data-i18n="form.username">Username</span>
                                        </label>
                                        <input type="text" class="form-control modern-input" value="${user.username}" disabled readonly>
                                        <small class="form-text text-muted" data-i18n="profile.info.username.helper">Your cool codename. For security reasons, this one's permanent!</small>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label">
                                            <i data-lucide="shield-check"></i> <span data-i18n="profile.info.role">Account Role</span>
                                        </label>
                                        <div>
                                            <span class="role-badge-large ${user.role == 'ADMIN' ? 'role-admin' : 'role-user'}">
                                                <i data-lucide="${user.role == 'ADMIN' ? 'shield-check' : 'user'}"></i>
                                                ${user.role}
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-12 mt-4">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <button type="reset" class="btn btn-outline-secondary">
                                                <i data-lucide="x-circle"></i> <span data-i18n="common.reset">Reset</span>
                                            </button>
                                            <button type="submit" class="btn btn-gradient-blue">
                                                <i data-lucide="check-circle" class="me-2"></i> <span data-i18n="profile.info.save">Lock It In</span>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <!-- Security Tab -->
                        <div class="tab-pane fade" id="security" role="tabpanel">
                            <h5 class="content-title">
                                <i data-lucide="shield"></i> <span data-i18n="profile.security.title">Fortify Your Account</span>
                            </h5>
                            <p class="content-subtitle" data-i18n="profile.security.subtitle">A strong password is the best force field for your account.</p>

                            <!-- Password Strength Info -->
                            <div class="security-tips glass-effect mb-4">
                                <h6><i data-lucide="info"></i> <span data-i18n="profile.security.tips.title">Fortress-Worthy Password Tips</span></h6>
                                <ul>
                                    <li><i data-lucide="check"></i> <span data-i18n="profile.security.tips.rule1">At least 6 characters long</span></li>
                                    <li><i data-lucide="check"></i> <span data-i18n="profile.security.tips.rule2">Use a mix of letters, numbers, and symbols</span></li>
                                    <li><i data-lucide="check"></i> <span data-i18n="profile.security.tips.rule3">Don't use common words or patterns</span></li>
                                    <li><i data-lucide="check"></i> <span data-i18n="profile.security.tips.rule4">Change regularly for better security</span></li>
                                </ul>
                            </div>

                            <form method="post" action="${pageContext.request.contextPath}/account/change-password" id="passwordForm" class="modern-form">
                                <div class="mb-3">
                                        <label for="currentPassword" class="form-label">
                                        <i data-lucide="key"></i> <span data-i18n="form.currentPassword">Current Password</span>
                                    </label>
                                    <div class="input-group">
                                        <input type="password" class="form-control modern-input" id="currentPassword" name="currentPassword" required>
                                        <button type="button" class="btn btn-outline-secondary password-toggle" data-target="currentPassword">
                                            <i data-lucide="eye"></i>
                                        </button>
                                    </div>
                                </div>
                                <div class="mb-3">
                                        <label for="newPassword" class="form-label">
                                        <i data-lucide="key"></i> <span data-i18n="form.newPassword">New Password</span>
                                    </label>
                                    <div class="input-group">
                                        <input type="password" class="form-control modern-input" id="newPassword" name="newPassword" minlength="6" required>
                                        <button type="button" class="btn btn-outline-secondary password-toggle" data-target="newPassword">
                                            <i data-lucide="eye"></i>
                                        </button>
                                    </div>
                                    <div id="passwordStrength" class="password-strength mt-2"></div>
                                </div>
                                <div class="mb-3">
                                        <label for="confirmPassword" class="form-label">
                                        <i data-lucide="check-circle-2"></i> <span data-i18n="form.confirmPassword">Confirm New Password</span>
                                    </label>
                                    <div class="input-group">
                                        <input type="password" class="form-control modern-input" id="confirmPassword" name="confirmPassword" minlength="6" required>
                                        <button type="button" class="btn btn-outline-secondary password-toggle" data-target="confirmPassword">
                                            <i data-lucide="eye"></i>
                                        </button>
                                    </div>
                                    <div class="invalid-feedback">Passwords do not match.</div>
                                </div>
                                <div class="mt-4">
                                    <button type="submit" class="btn btn-gradient-orange w-100">
                                        <i data-lucide="shield-check" class="me-2"></i> <span data-i18n="profile.security.save">Lock It Down</span>
                                    </button>
                                </div>
                            </form>
                        </div>

                        <!-- Preferences Tab -->
                        <div class="tab-pane fade" id="preferences" role="tabpanel">
                            <h5 class="content-title">
                                <i data-lucide="sliders"></i> <span data-i18n="profile.prefs.title">Tune Your Experience</span>
                            </h5>
                            <p class="content-subtitle" data-i18n="profile.prefs.subtitle">Make our site feel like home. Your home.</p>

                            <div class="modern-form">
                                <!-- Theme Preference -->
                                <div class="preference-item">
                                    <div class="preference-icon">
                                        <i data-lucide="palette"></i>
                                    </div>
                                    <div class="preference-content">
                                        <h6 data-i18n="profile.prefs.theme.title">Choose Your Vibe</h6>
                                        <p data-i18n="profile.prefs.theme.desc">Choose your preferred color scheme</p>
                                        <div class="btn-group" role="group">
                                            <input type="radio" class="btn-check" name="theme" id="lightTheme" autocomplete="off" checked>
                                            <label class="btn btn-outline-primary" for="lightTheme">
                                                <i data-lucide="sun"></i> <span data-i18n="profile.prefs.theme.light">Light</span>
                                            </label>
                                            <input type="radio" class="btn-check" name="theme" id="darkTheme" autocomplete="off">
                                            <label class="btn btn-outline-primary" for="darkTheme">
                                                <i data-lucide="moon"></i> <span data-i18n="profile.prefs.theme.dark">Dark</span>
                                            </label>
                                            <input type="radio" class="btn-check" name="theme" id="autoTheme" autocomplete="off">
                                            <label class="btn btn-outline-primary" for="autoTheme">
                                                <i data-lucide="circle"></i> <span data-i18n="profile.prefs.theme.auto">Auto</span>
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <!-- Email Notifications -->
                                <div class="preference-item">
                                    <div class="preference-icon">
                                        <i data-lucide="mail"></i>
                                    </div>
                                    <div class="preference-content">
                                        <h6 data-i18n="profile.prefs.mail.title">Control Your Inbox</h6>
                                        <p data-i18n="profile.prefs.mail.desc">Manage your email preferences</p>
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" id="emailBooking" checked>
                                            <label class="form-check-label" for="emailBooking" data-i18n="profile.prefs.mail.booking">
                                                Booking confirmations and updates
                                            </label>
                                        </div>
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" id="emailPromo" checked>
                                            <label class="form-check-label" for="emailPromo" data-i18n="profile.prefs.mail.promo">
                                                Special offers and promotions
                                            </label>
                                        </div>
                                        <div class="form-check form-switch">
                                            <input class="form-check-input" type="checkbox" id="emailNewsletter">
                                            <label class="form-check-label" for="emailNewsletter" data-i18n="profile.prefs.mail.newsletter">
                                                Travel tips and newsletter
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <!-- Language Preference -->
                                <div class="preference-item">
                                    <div class="preference-icon">
                                        <i data-lucide="globe"></i>
                                    </div>
                                    <div class="preference-content">
                                        <h6 data-i18n="profile.prefs.lang.title">Speak Your Language</h6>
                                        <p data-i18n="profile.prefs.lang.desc">Select your preferred language</p>
                                        <select class="form-select modern-input" id="language">
                                            <option selected>English (US)</option>
                                            <option>Español</option>
                                            <option>Français</option>
                                            <option>Deutsch</option>
                                            <option>中文</option>
                                            <option>日本語</option>
                                        </select>
                                    </div>
                                </div>

                                <!-- Currency Preference -->
                                <div class="preference-item">
                                    <div class="preference-icon">
                                        <i data-lucide="coins"></i>
                                    </div>
                                    <div class="preference-content">
                                        <h6 data-i18n="profile.prefs.currency.title">Choose Your Treasure</h6>
                                        <p data-i18n="profile.prefs.currency.desc">Display prices in your preferred currency</p>
                                        <select class="form-select modern-input" id="currency">
                                            <option selected>MYR - Malaysian Ringgit (RM)</option>
                                            <option>USD - US Dollar</option>
                                            <option>EUR - Euro</option>
                                            <option>GBP - British Pound</option>
                                            <option>SGD - Singapore Dollar</option>
                                            <option>CNY - Chinese Yuan</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="mt-4">
                                    <button type="button" class="btn btn-gradient-blue w-100" onclick="savePreferences()">
                                        <i data-lucide="check-circle" class="me-2"></i> <span data-i18n="profile.prefs.save">Save My Vibe</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <!-- Footer -->
    <footer class="modern-footer">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <p>&copy; 2025 <span data-i18n="brand.name">MyTour Global</span>. <span data-i18n="footer.rights">All rights reserved.</span></p>
                </div>
                <div class="col-md-6 text-md-end">
                    <a href="${pageContext.request.contextPath}/privacy" data-i18n="footer.privacy">Privacy Policy</a>
                    <span class="mx-2">|</span>
                    <a href="${pageContext.request.contextPath}/terms" data-i18n="footer.terms">Terms of Service</a>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/includes/navigation.js"></script>
    <script src="${pageContext.request.contextPath}/js/includes/footer.js"></script>
    <script src="${pageContext.request.contextPath}/js/core/i18n.js"></script>
    <script src="${pageContext.request.contextPath}/js/pages/profile.js"></script>
    <script>
      document.addEventListener('DOMContentLoaded', function() {
        if (typeof lucide !== 'undefined') {
          lucide.createIcons();
        }
      });
    </script>
</body>
</html>
