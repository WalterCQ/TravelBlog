/**
 * Modern Travel Blog Application - Core Module (2025)
 * ES6+ JavaScript with modular architecture
 */

class TravelBlogApp {
    constructor() {
        this.config = {
            apiBaseUrl: '/api/v1',
            version: '2.0.0',
            debug: true
        };
        this.modules = new Map();
        this.initialized = false;
    }

    /**
     * Initialize the application
     */
    async init() {
        if (this.initialized) {
            console.warn('Application already initialized');
            return;
        }

        console.log(`%c🌍 MyTour Travel Blog v${this.config.version}`, 
            'color: #0066cc; font-size: 16px; font-weight: bold;');
        console.log('%cModern Architecture - 2025', 
            'color: #666; font-style: italic;');

        try {
            await this.loadModules();
            this.setupEventListeners();
            this.initializeTheme();
            this.initialized = true;
            console.log('✅ Application initialized successfully');
        } catch (error) {
            console.error('❌ Application initialization failed:', error);
        }
    }

    /**
     * Load application modules
     */
    async loadModules() {
        // Modules will be loaded dynamically
        console.log('Loading application modules...');
    }

    /**
     * Setup global event listeners
     */
    setupEventListeners() {
        // Handle page load
        document.addEventListener('DOMContentLoaded', () => {
            this.onDOMReady();
        });

        // Handle page visibility changes
        document.addEventListener('visibilitychange', () => {
            this.onVisibilityChange();
        });

        // Handle online/offline status
        window.addEventListener('online', () => this.onOnline());
        window.addEventListener('offline', () => this.onOffline());
    }

    /**
     * DOM Ready handler
     */
    onDOMReady() {
        console.log('DOM is ready');
        this.initializeComponents();
    }

    /**
     * Initialize UI components
     */
    initializeComponents() {
        // Initialize tooltips if Bootstrap is available
        if (typeof bootstrap !== 'undefined' && bootstrap.Tooltip) {
            const tooltips = document.querySelectorAll('[data-bs-toggle="tooltip"]');
            tooltips.forEach(el => new bootstrap.Tooltip(el));
        }

        // Initialize popovers
        if (typeof bootstrap !== 'undefined' && bootstrap.Popover) {
            const popovers = document.querySelectorAll('[data-bs-toggle="popover"]');
            popovers.forEach(el => new bootstrap.Popover(el));
        }

        // Lazy load images
        this.initializeLazyLoading();
    }

    /**
     * Initialize lazy loading for images
     */
    initializeLazyLoading() {
        if ('IntersectionObserver' in window) {
            const imageObserver = new IntersectionObserver((entries, observer) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        const img = entry.target;
                        if (img.dataset.src) {
                            img.src = img.dataset.src;
                            img.classList.add('loaded');
                            observer.unobserve(img);
                        }
                    }
                });
            });

            document.querySelectorAll('img[data-src]').forEach(img => {
                imageObserver.observe(img);
            });
        }
    }

    /**
     * Initialize theme
     */
    initializeTheme() {
        const savedTheme = localStorage.getItem('theme') || 'light';
        document.documentElement.setAttribute('data-theme', savedTheme);
    }

    /**
     * Toggle theme
     */
    toggleTheme() {
        const currentTheme = document.documentElement.getAttribute('data-theme') || 'light';
        const newTheme = currentTheme === 'light' ? 'dark' : 'light';
        document.documentElement.setAttribute('data-theme', newTheme);
        localStorage.setItem('theme', newTheme);
        this.dispatchEvent('themeChanged', { theme: newTheme });
    }

    /**
     * Visibility change handler
     */
    onVisibilityChange() {
        if (document.hidden) {
            console.log('Page is hidden');
        } else {
            console.log('Page is visible');
        }
    }

    /**
     * Online handler
     */
    onOnline() {
        console.log('Connection restored');
        this.showNotification('Connection restored', 'success');
    }

    /**
     * Offline handler
     */
    onOffline() {
        console.log('Connection lost');
        this.showNotification('No internet connection', 'warning');
    }

    /**
     * Show notification
     */
    showNotification(message, type = 'info') {
        // Modern toast notification
        const toast = document.createElement('div');
        toast.className = `toast-notification toast-${type}`;
        toast.textContent = message;
        toast.style.cssText = `
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 20px;
            background: ${type === 'success' ? '#28a745' : type === 'warning' ? '#ffc107' : '#17a2b8'};
            color: white;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            z-index: 10000;
            animation: slideIn 0.3s ease-out;
        `;
        
        document.body.appendChild(toast);
        
        setTimeout(() => {
            toast.style.animation = 'slideOut 0.3s ease-in';
            setTimeout(() => toast.remove(), 300);
        }, 3000);
    }

    /**
     * Dispatch custom event
     */
    dispatchEvent(eventName, detail = {}) {
        window.dispatchEvent(new CustomEvent(eventName, { detail }));
    }

    /**
     * Register a module
     */
    registerModule(name, module) {
        this.modules.set(name, module);
        console.log(`📦 Module registered: ${name}`);
    }

    /**
     * Get a module
     */
    getModule(name) {
        return this.modules.get(name);
    }
}

// Create and export global app instance
window.TravelBlogApp = new TravelBlogApp();

// Auto-initialize
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
        window.TravelBlogApp.init();
    });
} else {
    window.TravelBlogApp.init();
}

export default window.TravelBlogApp;



