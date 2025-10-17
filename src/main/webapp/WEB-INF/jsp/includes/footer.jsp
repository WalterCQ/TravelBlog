<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- Include footer styles and scripts -->
<link href="${pageContext.request.contextPath}/css/includes/footer.css?v=2025-10-10-2" rel="stylesheet">

<!-- Modern Footer with Wave Animation -->
<footer class="footer">
    <!-- Wave Animation -->
    <svg class="footer-waves" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"
         viewBox="0 24 150 28" preserveAspectRatio="none" shape-rendering="auto">
        <defs>
            <path id="footer-wave"
                  d="M-160 44c30 0 58-18 88-18s 58 18 88 18 58-18 88-18 58 18 88 18 v44h-352z" />
        </defs>
        <g class="parallax">
            <use xlink:href="#footer-wave" x="48" y="0" fill="rgba(255,255,255,0.1)" />
            <use xlink:href="#footer-wave" x="48" y="3" fill="rgba(255,255,255,0.2)" />
            <use xlink:href="#footer-wave" x="48" y="5" fill="rgba(255,255,255,0.3)" />
            <use xlink:href="#footer-wave" x="48" y="7" fill="rgba(255,255,255,0.4)" />
        </g>
    </svg>

    <!-- Footer Content -->
    <div class="footer-content">
        <div class="footer-grid">
            <!-- About Section -->
            <div class="footer-section">
                <h3 data-i18n="footer.about.title">About MyTour</h3>
                <p data-i18n="footer.about.desc">
                    Your gateway to exploring the world's most amazing destinations. 
                    We make travel simple, affordable, and unforgettable.
                </p>
                <div class="social-links">
                    <a href="#" class="social-link" aria-label="Facebook">
                        <i data-lucide="facebook" aria-hidden="true"></i>
                    </a>
                    <a href="#" class="social-link" aria-label="Twitter">
                        <i data-lucide="twitter" aria-hidden="true"></i>
                    </a>
                    <a href="#" class="social-link" aria-label="Instagram">
                        <i data-lucide="instagram" aria-hidden="true"></i>
                    </a>
                    <a href="#" class="social-link" aria-label="YouTube">
                        <i data-lucide="youtube" aria-hidden="true"></i>
                    </a>
                    <a href="#" class="social-link" aria-label="LinkedIn">
                        <i data-lucide="linkedin" aria-hidden="true"></i>
                    </a>
                </div>
            </div>
            
            <!-- Quick Links Section -->
            <div class="footer-section">
                <h3 data-i18n="footer.links.title">Quick Links</h3>
                <ul class="footer-links">
                    <li>
                        <a href="${pageContext.request.contextPath}/destinations" 
                           data-i18n="footer.link1">Popular Destinations</a>
                    </li>
                    <li>
                        <a href="#" data-i18n="footer.link2">Travel Guides</a>
                    </li>
                    <li>
                        <a href="#" data-i18n="footer.link3">Travel Insurance</a>
                    </li>
                    <li>
                        <a href="#" data-i18n="footer.link4">Customer Reviews</a>
                    </li>
                </ul>
            </div>
            
            <!-- Newsletter Section -->
            <div class="footer-section">
                <h3 data-i18n="footer.newsletter.title">Newsletter</h3>
                <p data-i18n="footer.newsletter.desc">
                    Subscribe to get special offers and travel tips
                </p>
                <form class="newsletter-form" id="newsletterForm" 
                      action="${pageContext.request.contextPath}/newsletter/subscribe" method="POST">
                    <div class="input-group">
                        <input type="email" class="newsletter-input" 
                               name="email" 
                               data-i18n-attr='{"placeholder":"footer.email.placeholder"}' required>
                        <button class="newsletter-btn" type="submit" 
                                data-i18n="footer.subscribe">Subscribe</button>
                    </div>
                </form>
                <small class="newsletter-disclaimer" data-i18n="footer.newsletter.privacy">
                    We respect your privacy. No spam guaranteed.
                </small>
            </div>
            
            <!-- Legal Links Section -->
            <div class="footer-section">
                <h3 data-i18n="footer.legal.title">Legal</h3>
                <ul class="footer-links">
                    <li>
                        <a href="#" 
                           data-i18n="footer.privacy">Privacy Policy</a>
                    </li>
                    <li>
                        <a href="#" 
                           data-i18n="footer.terms">Terms of Service</a>
                    </li>
                    <li>
                        <a href="#" 
                           data-i18n="footer.sitemap">Sitemap</a>
                    </li>
                    <li>
                        <a href="${pageContext.request.contextPath}/contact" 
                           data-i18n="footer.contact">Contact Us</a>
                    </li>
                </ul>
            </div>
        </div>
        
        <!-- Footer Bottom -->
        <div class="footer-bottom">
            <p data-i18n="footer.rights">© 2025 MyTour Global. All rights reserved.</p>
            <small>
                Developed by Liu Zhenyu, Osamah Labeed, Rahmonov Fayzirahmon - XMUM Tourism Project
            </small>
        </div>
    </div>
</footer>

<!-- Back to Top Button -->
<button class="back-to-top" id="backToTop" aria-label="Back to top">
    <i data-lucide="arrow-up" aria-hidden="true"></i>
</button>

<!-- Load footer JavaScript -->
<script src="${pageContext.request.contextPath}/js/includes/footer.js"></script>

<!-- Note: Page-specific scripts (navigation.js, homepage.js, etc.) are loaded in their respective JSP files -->
<!-- Only load global scripts here -->
<script src="${pageContext.request.contextPath}/js/main.js"></script>

<!-- Initialize all Lucide icons on page -->
<script>
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

</script>