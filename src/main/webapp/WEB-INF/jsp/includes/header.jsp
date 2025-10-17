<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="contextPath" content="${pageContext.request.contextPath}">
  <title>${param.title} - MyTour Global</title>
  <meta name="currentPage" content="${param.currentPage}">
  <!-- Core CSS Variables - Must load first -->
  <link href="${pageContext.request.contextPath}/css/core/variables.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/core/fonts.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/core/rtl.css" rel="stylesheet">
  
  <!-- Container Spacing System - Airbnb/Booking.com standard (2025) -->
  <link href="${pageContext.request.contextPath}/css/core/container-spacing.css" rel="stylesheet">

  <link href="${pageContext.request.contextPath}/css/vendor/bootstrap.min.css" rel="stylesheet">
  
  <script src="${pageContext.request.contextPath}/js/vendor/bootstrap.bundle.min.js"></script>
  
  <link rel="preload" href="${pageContext.request.contextPath}/css/vendor/bootstrap.min.css" as="style">
  <link rel="preload" href="${pageContext.request.contextPath}/js/vendor/bootstrap.bundle.min.js" as="script">
  
  <!-- Icon library: Lucide (inline via script). Removed FA/BI CSS to standardize icons. -->
  
  <!-- Lucide Icons - Modern, Lightweight Icon Library -->
  <script src="https://unpkg.com/lucide@latest"></script>
  <script>
    // Fallback loader: if unpkg is blocked, try jsdelivr
    (function() {
      function initLucide() {
        if (typeof lucide !== 'undefined') {
          try { lucide.createIcons(); } catch (e) {}
        }
      }
      if (typeof lucide === 'undefined') {
        var s = document.createElement('script');
        s.src = 'https://cdn.jsdelivr.net/npm/lucide@latest';
        s.onload = initLucide;
        document.head.appendChild(s);
      }
    })();
  </script>
  <script>
    // Early initialization for Lucide icons
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
    });
  </script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/vanilla-tilt/1.8.1/vanilla-tilt.min.js" integrity="sha512-wC/cunGGDjXSl9OHUH0RuqSyW4YNLlsPwhcLxwWW1CR4OeC2E1xpcdZz2DeQkEmums41laI+eGMw95IJ15SS3g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <script src="${pageContext.request.contextPath}/js/core/i18n.js"></script>


  <link rel="dns-prefetch" href="//fonts.googleapis.com">
  <link rel="dns-prefetch" href="//cdnjs.cloudflare.com">
  
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/includes/navigation.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/pages/homepage.css" rel="stylesheet">
  
  <link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico">
  <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/favicon.ico">

  <!-- Fixed: Add condition to check if pageStyle is not empty -->
  <c:if test="${not empty param.pageStyle and param.pageStyle ne ''}">
    <link href="${pageContext.request.contextPath}/css/pages/${param.pageStyle}.css" rel="stylesheet">
  </c:if>
  

  <script>
    document.addEventListener("DOMContentLoaded", function() {
      const savedLanguage = localStorage.getItem('preferredLanguage') || 'en';
      
      if (window.TravelBlog && window.TravelBlog.Language) {
        window.TravelBlog.Language.setLanguage(savedLanguage);
      } else {
        document.documentElement.lang = savedLanguage;
      }
    });
  </script>
  
  

  <c:if test="${param.currentPage eq 'booking'}">
    <link href="${pageContext.request.contextPath}/css/pages/booking-refactored.css" rel="stylesheet">
  </c:if>

  <c:if test="${param.currentPage eq 'login' or param.currentPage eq 'register'}">
    <link href="${pageContext.request.contextPath}/css/pages/auth.css" rel="stylesheet">
  </c:if>
  
  <!-- Add destination-detail specific CSS -->
  <c:if test="${param.currentPage eq 'destinations' or param.currentPage eq 'destination-detail'}">
    <link href="${pageContext.request.contextPath}/css/pages/destination-detail.css" rel="stylesheet">
  </c:if>

</head>
<body class="${param.currentPage eq 'home' ? 'homepage' : (param.currentPage eq 'destinations' ? 'destinations-page' : (param.currentPage eq 'packages' ? 'packages-page' : (param.currentPage eq 'help' ? 'help-page' : '')))}">

<!-- Project Modal - Group Assignment (Only close via button) -->
<div id="projectModalOverlay" class="project-modal-overlay" aria-hidden="true">
  <div id="projectModal" class="project-modal" role="dialog" aria-modal="true" aria-labelledby="projectModalTitle" aria-describedby="projectModalDescription" tabindex="-1">
    
    <!-- Modal Header -->
    <div class="project-modal-header">
      <div class="project-modal-icon-wrapper" aria-hidden="true">
        <div class="project-modal-icon">
          <!-- Feather Pen Icon - 羽毛笔代表学术作业 -->
          <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
            <path d="M20.24 12.24a6 6 0 0 0-8.49-8.49L5 10.5V19h8.5z"></path>
            <line x1="16" x2="2" y1="8" y2="22"></line>
            <line x1="17.5" x2="9" y1="15" y2="15"></line>
          </svg>
        </div>
      </div>
      <h2 id="projectModalTitle" class="project-modal-title" data-i18n="project.modal.title">Group Project Showcase</h2>
      <p class="project-modal-subtitle" data-i18n="project.modal.subtitle">University Course Assignment</p>
    </div>

    <!-- Modal Body -->
    <div class="project-modal-body">
      
      <!-- Academic Project Notice - Prominent Warning -->
      <div class="project-academic-notice">
        <p class="academic-notice-text" data-i18n="project.modal.academic.notice" data-i18n-type="html">
          ⚠️ <strong>Non-Commercial Educational Project</strong> - This website is created solely for university course demonstration and learning purposes. It is not a real commercial service and does not provide actual booking or travel services.
        </p>
      </div>
      
      <p id="projectModalDescription" class="project-modal-description" data-i18n="project.modal.desc">
        This is a student group assignment for course presentation. Below are the team member contact information for academic communication.
      </p>

      <!-- Team Members Cards with Avatars -->
      <div class="project-modal-team-section">
        <h3 class="project-modal-team-title" data-i18n="project.modal.team.title">Development Team</h3>
        <div class="project-modal-team-grid" role="group" aria-label="Team members">
          
          <!-- Member 1: Osamah Labeed -->
          <a href="mailto:SWE2309200@xmu.edu.my" class="project-modal-member-card">
            <div class="member-avatar">
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"></path>
                <circle cx="12" cy="7" r="4"></circle>
              </svg>
            </div>
            <div class="member-info">
              <h4 class="member-name" data-i18n="project.modal.members.osamah">Osamah Labeed</h4>
              <div class="member-email">
                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <rect x="2" y="4" width="20" height="16" rx="2"></rect>
                  <path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7"></path>
                </svg>
                <span>SWE2309200@xmu.edu.my</span>
              </div>
            </div>
          </a>

          <!-- Member 2: Rahmonov Fayzirahmon -->
          <a href="mailto:SWE2309439@xmu.edu.my" class="project-modal-member-card">
            <div class="member-avatar">
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"></path>
                <circle cx="12" cy="7" r="4"></circle>
              </svg>
            </div>
            <div class="member-info">
              <h4 class="member-name" data-i18n="project.modal.members.rahmonov">Rahmonov Fayzirahmon</h4>
              <div class="member-email">
                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <rect x="2" y="4" width="20" height="16" rx="2"></rect>
                  <path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7"></path>
                </svg>
                <span>SWE2309439@xmu.edu.my</span>
              </div>
            </div>
          </a>

          <!-- Member 3: Liu Zhenyu -->
          <a href="mailto:SWE2309527@xmu.edu.my" class="project-modal-member-card">
            <div class="member-avatar">
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"></path>
                <circle cx="12" cy="7" r="4"></circle>
              </svg>
            </div>
            <div class="member-info">
              <h4 class="member-name" data-i18n="project.modal.members.liu">Liu Zhenyu</h4>
              <div class="member-email">
                <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <rect x="2" y="4" width="20" height="16" rx="2"></rect>
                  <path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7"></path>
                </svg>
                <span>SWE2309527@xmu.edu.my</span>
              </div>
            </div>
          </a>

        </div>
      </div>
    </div>

    <!-- Modal Footer -->
    <div class="project-modal-footer">
      <!-- Don't Show Again Option -->
      <div class="project-modal-checkbox-wrapper">
        <label class="project-modal-checkbox-label">
          <input type="checkbox" id="projectModalCheckbox" class="project-modal-checkbox-input">
          <span class="project-modal-checkbox-custom"></span>
          <span class="project-modal-checkbox-text" data-i18n="project.modal.button.dontShowAgain">Don't show again</span>
        </label>
      </div>
      
      <button type="button" id="projectModalButton" class="project-modal-button" data-i18n="project.modal.button.gotIt">Got it</button>
    </div>

  </div>
  <!-- Clicking overlay should do nothing (blocked in JS) -->
</div>
<!-- End Project Modal -->

<!-- Modal CSS/JS -->
<link href="${pageContext.request.contextPath}/css/includes/project-modal.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/includes/project-modal.js" defer></script>
