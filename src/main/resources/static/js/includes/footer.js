class FooterModule {
    constructor() {
        this.footer = document.querySelector('.footer');
        this.backToTopBtn = document.querySelector('.back-to-top');
        this.newsletterForm = document.querySelector('.newsletter-form');
        this.footerSections = document.querySelectorAll('.footer-section');
        this.socialLinks = document.querySelectorAll('.social-link');
        
        this.init();
    }

    init() {
        this.setupScrollEffects();
        this.setupNewsletterForm();
        this.setupSocialTracking();
        this.setupFooterAnimation();
        this.setupAccessibility();
        
        console.log('Footer Module initialized successfully');
    }

    setupScrollEffects() {
        let ticking = false;
        
        const handleScroll = () => {
            if (!ticking) {
                requestAnimationFrame(() => {
                    this.updateBackToTopButton();
                    this.animateFooterSections();
                    ticking = false;
                });
                ticking = true;
            }
        };

        window.addEventListener('scroll', handleScroll);
        
        if (this.backToTopBtn) {
            this.backToTopBtn.addEventListener('click', this.scrollToTop);
        }
    }

    updateBackToTopButton() {
        if (!this.backToTopBtn) return;
        
        const scrollTop = window.pageYOffset;
        const shouldShow = scrollTop > 300;
        
        this.backToTopBtn.classList.toggle('visible', shouldShow);
    }

    animateFooterSections() {
        if (!this.footerSections.length) return;
        
        const observer = new IntersectionObserver((entries) => {
            entries.forEach((entry, index) => {
                if (entry.isIntersecting) {
                    setTimeout(() => {
                        entry.target.classList.add('animate-in');
                    }, index * 150);
                }
            });
        }, {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        });

        this.footerSections.forEach(section => {
            observer.observe(section);
        });
    }

    setupNewsletterForm() {
        if (!this.newsletterForm) return;
        
        this.newsletterForm.addEventListener('submit', async (e) => {
            e.preventDefault();
            
            const emailInput = this.newsletterForm.querySelector('.newsletter-input');
            const submitBtn = this.newsletterForm.querySelector('.newsletter-btn');
            const email = emailInput.value.trim();
            
            if (!this.isValidEmail(email)) {
                this.showMessage('Please enter a valid email address', 'error');
                return;
            }
            
            const originalText = submitBtn.textContent;
            submitBtn.textContent = 'Subscribing...';
            submitBtn.disabled = true;
            
            try {
                await this.simulateAPICall();
                
                this.showMessage('Thank you for subscribing!', 'success');
                emailInput.value = '';
                
                this.trackEvent('newsletter_subscribe', { email: email });
                
            } catch (error) {
                this.showMessage('Subscription failed. Please try again.', 'error');
            } finally {
                submitBtn.textContent = originalText;
                submitBtn.disabled = false;
            }
        });
    }

    setupSocialTracking() {
        this.socialLinks.forEach(link => {
            link.addEventListener('click', (e) => {
                const platform = this.getSocialPlatform(link.href || link.getAttribute('aria-label'));
                this.trackEvent('social_click', { platform, location: 'footer' });
            });
        });
    }

    setupFooterAnimation() {
        const waves = document.querySelectorAll('.footer-waves');
        
        waves.forEach(wave => {
            wave.addEventListener('mouseenter', () => {
                wave.style.animationPlayState = 'paused';
            });
            
            wave.addEventListener('mouseleave', () => {
                wave.style.animationPlayState = 'running';
            });
        });
        
        if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
            waves.forEach(wave => {
                wave.style.animation = 'none';
            });
        }
    }

    setupAccessibility() {
        this.socialLinks.forEach(link => {
            link.addEventListener('keydown', (e) => {
                if (e.key == 'Enter' || e.key == ' ') {
                    e.preventDefault();
                    link.click();
                }
            });
        });
        
        const newsletterInput = this.newsletterForm?.querySelector('.newsletter-input');
        if (newsletterInput) {
            newsletterInput.addEventListener('focus', () => {
                this.newsletterForm.classList.add('focused');
            });
            
            newsletterInput.addEventListener('blur', () => {
                this.newsletterForm.classList.remove('focused');
            });
        }
    }

    scrollToTop() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    }

    isValidEmail(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    }

    showMessage(message, type = 'info') {
        const existingMessage = document.querySelector('.footer-message');
        if (existingMessage) {
            existingMessage.remove();
        }
        
        const messageEl = document.createElement('div');
        messageEl.className = `footer-message footer-message--${type}`;
        messageEl.textContent = message;
        
        Object.assign(messageEl.style, {
            position: 'fixed',
            bottom: '100px',
            right: '30px',
            padding: '12px 20px',
            borderRadius: '8px',
            color: 'white',
            fontSize: '14px',
            fontWeight: '500',
            zIndex: '1001',
            animation: 'slideIn 0.3s ease',
            backgroundColor: type == 'error' ? '#e74c3c' : '#27ae60'
        });
        
        document.body.appendChild(messageEl);
        
        setTimeout(() => {
            if (messageEl.parentNode) {
                messageEl.style.animation = 'slideOut 0.3s ease';
                setTimeout(() => messageEl.remove(), 300);
            }
        }, 4000);
    }

    getSocialPlatform(identifier) {
        if (!identifier) return 'unknown';
        
        const lower = identifier.toLowerCase();
        if (lower.includes('facebook')) return 'facebook';
        if (lower.includes('twitter') || lower.includes('x.com')) return 'twitter';
        if (lower.includes('instagram')) return 'instagram';
        if (lower.includes('youtube')) return 'youtube';
        if (lower.includes('linkedin')) return 'linkedin';
        return 'unknown';
    }

    trackEvent(eventName, parameters = {}) {
        if (typeof gtag != 'undefined') {
            gtag('event', eventName, parameters);
        }
        
        console.log('Track Event:', eventName, parameters);
    }

    simulateAPICall() {
        return new Promise((resolve, reject) => {
            setTimeout(() => {
                Math.random() > 0.1 ? resolve() : reject(new Error('API Error'));
            }, 1500);
        });
    }
}

const messageStyles = `
    @keyframes slideIn {
        from { transform: translateX(100%); opacity: 0; }
        to { transform: translateX(0); opacity: 1; }
    }
    
    @keyframes slideOut {
        from { transform: translateX(0); opacity: 1; }
        to { transform: translateX(100%); opacity: 0; }
    }
`;

const styleSheet = document.createElement('style');
styleSheet.textContent = messageStyles;
document.head.appendChild(styleSheet);

if (document.readyState == 'loading') {
    document.addEventListener('DOMContentLoaded', () => new FooterModule());
} else {
    new FooterModule();
}

if (typeof module != 'undefined' && module.exports) {
    module.exports = FooterModule;
}