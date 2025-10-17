class EnhancedNavigation {
    constructor() {
        this.navbar = document.querySelector('.navbar');
        this.dropdowns = document.querySelectorAll('.dropdown');
        this.searchForm = document.querySelector('.navbar form[role="search"]');
        this.searchInput = document.querySelector('.navbar input[type="search"]');
        this.isScrolled = false;
        this.lastScrollTop = 0;
        this.scrollThreshold = 100;
        this.currentPage = this.detectCurrentPage();
        this.availableLanguages = ['en', 'zh', 'ms', 'ru', 'ar', 'fr'];
        this.blurTimeout = null;
        
        this.init();
    }

    getCleanPath() {
        const path = window.location.pathname;
        const contextPath = document.querySelector('meta[name="contextPath"]')?.content || '';
        return path.replace(contextPath, '').replace(/^\/+|\/+$/g, '');
    }

    init() {
        if (!this.navbar) return;
        
        this.setupPageIdentification();
        this.setupScrollEffect();
        this.setupDropdowns();
        this.setupSearch();
        this.setupMobileNavigation();
        this.setupActiveStates();
        this.setupAccessibility();
        this.setupLanguageSelector();
        this.setupThemeToggle();
        this.improveFocusVisibility();
        this.setupPageBlurEffect();
        
        console.log('Enhanced Navigation with page-specific styling initialized for page:', this.currentPage);
    }

    setupPageBlurEffect() {
        if (window.innerWidth < 992) {
            return;
        }

        this.navbar.addEventListener('mouseenter', () => {
            this.enablePageBlur();
        });

        this.navbar.addEventListener('mouseleave', () => {
            const hasOpenDropdown = this.navbar.querySelector('.dropdown.show');
            if (!hasOpenDropdown) {
                this.disablePageBlur();
            }
        });

        this.dropdowns.forEach(dropdown => {
            const menu = dropdown.querySelector('.dropdown-menu');
            
            if (menu) {
                dropdown.addEventListener('shown.bs.dropdown', () => {
                    this.enablePageBlur();
                });

                dropdown.addEventListener('hidden.bs.dropdown', () => {
                    setTimeout(() => {
                        const hasOpenDropdown = this.navbar.querySelector('.dropdown.show');
                        const isHoveringNavbar = this.navbar.matches(':hover');
                        if (!hasOpenDropdown && !isHoveringNavbar) {
                            this.disablePageBlur();
                        }
                    }, 100);
                });

                menu.addEventListener('mouseenter', () => {
                    this.enablePageBlur();
                });

                menu.addEventListener('mouseleave', () => {
                    if (!dropdown.classList.contains('show')) {
                        this.disablePageBlur();
                    }
                });
            }
        });

        document.addEventListener('click', (e) => {
            if (!this.navbar.contains(e.target)) {
                this.disablePageBlur();
            }
        });

        window.addEventListener('resize', () => {
            if (window.innerWidth < 992) {
                this.disablePageBlur();
            }
        });

        document.addEventListener('keydown', (e) => {
            if (e.key == 'Escape') {
                this.disablePageBlur();
                this.closeAllDropdowns();
            }
        });
    }

    enablePageBlur() {
        if (window.innerWidth < 992) {
            return;
        }

        clearTimeout(this.blurTimeout);
        
        document.body.classList.add('page-blur-active');
        
        const contentSelectors = [
            '.main-content',
            'main',
            '.hero-section',
            '.container:not(.navbar .container)',
            '.content',
            'section:not(.navbar section)',
            'article',
            '.carousel',
            '.hero-banner'
        ];

        contentSelectors.forEach(selector => {
            const elements = document.querySelectorAll(selector);
            elements.forEach(element => {
                if (!this.navbar.contains(element)) {
                    element.classList.add('blur-background');
                }
            });
        });

        console.log('Page blur effect enabled');
    }

    disablePageBlur() {
        clearTimeout(this.blurTimeout);
        this.blurTimeout = setTimeout(() => {
            document.body.classList.remove('page-blur-active');
            
            const blurredElements = document.querySelectorAll('.blur-background');
            blurredElements.forEach(element => {
                element.classList.remove('blur-background');
            });

            console.log('Page blur effect disabled');
        }, 150);
    }

    closeAllDropdowns() {
        this.dropdowns.forEach(dropdown => {
            this.closeDropdown(dropdown);
        });
    }

    detectCurrentPage() {
        const pageParam = document.querySelector('meta[name="currentPage"]');
        if (pageParam) {
            return pageParam.content;
        }
        const cleanPath = this.getCleanPath();
        
        if (!cleanPath || cleanPath == 'index.jsp' || cleanPath == '') {
            return 'home';
        } else if (cleanPath.startsWith('packages') || cleanPath == 'packages') {
            return 'packages';
        } else if (cleanPath.includes('destination')) {
            return 'destinations';
        } else if (cleanPath.includes('booking')) {
            return 'booking';
        } else if (cleanPath.includes('about')) {
            return 'about';
        } else if (cleanPath.includes('contact')) {
            return 'contact';
        } else if (cleanPath.includes('help')) {
            return 'help';
        }
        
        return cleanPath.split('/')[0] || 'other';
    }

    setupPageIdentification() {
        document.body.classList.add(`page-${this.currentPage}`);
        
        if (this.currentPage == 'home' || this.currentPage == '' || !this.currentPage) {
            document.body.classList.add('homepage');
            console.log('Homepage detected - transparent navbar at top, white on hover/scroll, reference layout preserved');
        } else {
            document.body.classList.remove('homepage');
            console.log('Non-homepage detected - white navbar with dark text');
        }

        // Allow transparent-at-top on whitelist pages
        const cleanPath = this.getCleanPath();
        // Broaden home detection: meta currentPage, body class, and common home paths
        const bodyHasHomepage = document.body.classList.contains('homepage');
        const isHome = bodyHasHomepage 
            || !cleanPath 
            || cleanPath == '' 
            || cleanPath == 'index' 
            || cleanPath == 'index.jsp' 
            || cleanPath == 'home' 
            || cleanPath == 'homepage';
        const isDestinationsList = cleanPath == 'destinations';
        const isPackagesList = cleanPath == 'packages';
        const isHelp = cleanPath == 'help';
        const isTransparentTop = isHome || isDestinationsList || isPackagesList || isHelp;
        document.body.classList.toggle('transparent-navbar', isTransparentTop);
        document.body.classList.toggle('solid-navbar', !isTransparentTop);
        
        this.updateActiveNavStates();
    }

    updateActiveNavStates() {
        const navLinks = document.querySelectorAll('.nav-link');
        navLinks.forEach(link => link.classList.remove('active'));
        
        const currentNavLink = document.querySelector(`.nav-link[href*="${this.currentPage}"]`);
        if (currentNavLink) {
            currentNavLink.classList.add('active');
        }
        
        if (this.currentPage == 'destinations' || this.currentPage == 'attractions') {
            const destinationsNav = document.querySelector('#destinationsDropdown');
            if (destinationsNav) destinationsNav.classList.add('active');
        } else if (this.currentPage == 'booking' || this.currentPage == 'packages') {
            const bookingNav = document.querySelector('#bookingDropdown');
            if (bookingNav) bookingNav.classList.add('active');
        } else if (this.currentPage == 'about' || this.currentPage == 'contact' || this.currentPage == 'feedback' || this.currentPage == 'help') {
            const aboutNav = document.querySelector('#aboutDropdown');
            if (aboutNav) aboutNav.classList.add('active');
        }
    }

    setupScrollEffect() {
        let ticking = false;
        
        const handleScroll = () => {
            if (!ticking) {
                requestAnimationFrame(() => {
                    const currentScroll = window.scrollY;
                    const allowTransparentTop = document.body.classList.contains('transparent-navbar');
                    
                    if (allowTransparentTop) {
                        if (currentScroll > this.scrollThreshold && !this.isScrolled) {
                            this.navbar.classList.add('navbar-scrolled-visible');
                            this.isScrolled = true;
                        } else if (currentScroll <= this.scrollThreshold && this.isScrolled) {
                            this.navbar.classList.remove('navbar-scrolled-visible');
                            this.isScrolled = false;
                        }
                    }
                    
                    if (currentScroll > this.lastScrollTop && currentScroll > 200) {
                        this.navbar.classList.add('navbar-hidden');
                    } else {
                        this.navbar.classList.remove('navbar-hidden');
                    }
                    
                    this.lastScrollTop = currentScroll;
                    ticking = false;
                });
                ticking = true;
            }
        };
        
        window.addEventListener('scroll', handleScroll, { passive: true });
        
        handleScroll();
    }

    setupDropdowns() {
        // Bootstrap dropdown event listener - ensure only one dropdown is open at a time
        document.addEventListener('show.bs.dropdown', (event) => {
            // Close all other open dropdowns
            const openDropdowns = document.querySelectorAll('.dropdown.show');
            openDropdowns.forEach(dropdown => {
                if (dropdown !== event.target.closest('.dropdown')) {
                    const bsDropdown = bootstrap.Dropdown.getInstance(dropdown.querySelector('[data-bs-toggle="dropdown"]'));
                    if (bsDropdown) {
                        bsDropdown.hide();
                    }
                }
            });
        });

        this.dropdowns.forEach(dropdown => {
            // Support links with or without dropdown-toggle class
            const toggle = dropdown.querySelector('.dropdown-toggle') || 
                          dropdown.querySelector('a[data-bs-toggle="dropdown"]') ||
                          dropdown.querySelector('.nav-link');
            const menu = dropdown.querySelector('.dropdown-menu');
            
            if (!toggle || !menu) return;
            
            // Prevent dropdown from going off-screen - adjust position dynamically
            dropdown.addEventListener('shown.bs.dropdown', () => {
                this.adjustDropdownPosition(dropdown, menu);
            });
            
            toggle.addEventListener('click', (e) => {
                e.preventDefault();
                this.toggleDropdown(dropdown);
            });
            
            document.addEventListener('click', (e) => {
                if (!dropdown.contains(e.target)) {
                    this.closeDropdown(dropdown);
                }
            });
            
            toggle.addEventListener('keydown', (e) => {
                if (e.key == 'Enter' || e.key == ' ') {
                    e.preventDefault();
                    this.toggleDropdown(dropdown);
                } else if (e.key == 'Escape') {
                    this.closeDropdown(dropdown);
                }
            });
            
            // Hover effect - desktop only
            if (window.innerWidth >= 992) {
                dropdown.addEventListener('mouseenter', () => {
                    this.openDropdown(dropdown);
                });
                
                dropdown.addEventListener('mouseleave', () => {
                    setTimeout(() => {
                        if (!dropdown.querySelector(':hover')) {
                            this.closeDropdown(dropdown);
                        }
                    }, 100);
                });
            }
        });
    }

    // Adjust dropdown position to prevent going off-screen
    adjustDropdownPosition(dropdown, menu) {
        const rect = menu.getBoundingClientRect();
        const viewportWidth = window.innerWidth;
        const viewportHeight = window.innerHeight;
        
        // Check if exceeds right edge
        if (rect.right > viewportWidth) {
            menu.style.left = 'auto';
            menu.style.right = '0';
        }
        
        // Check if exceeds left edge
        if (rect.left < 0) {
            menu.style.left = '0';
            menu.style.right = 'auto';
        }
        
        // Check if exceeds bottom edge
        if (rect.bottom > viewportHeight) {
            menu.style.bottom = '100%';
            menu.style.top = 'auto';
        }
    }

    toggleDropdown(dropdown) {
        const isOpen = dropdown.classList.contains('show');
        
        this.dropdowns.forEach(d => {
            if (d != dropdown) this.closeDropdown(d);
        });
        
        if (isOpen) {
            this.closeDropdown(dropdown);
        } else {
            this.openDropdown(dropdown);
        }
    }

    openDropdown(dropdown) {
        const toggle = dropdown.querySelector('.dropdown-toggle') || 
                      dropdown.querySelector('a[data-bs-toggle="dropdown"]') ||
                      dropdown.querySelector('.nav-link');
        const menu = dropdown.querySelector('.dropdown-menu');
        
        dropdown.classList.add('show');
        menu.classList.add('show');
        if (toggle) {
            toggle.setAttribute('aria-expanded', 'true');
        }
        
        this.enablePageBlur();
        
        const firstItem = menu.querySelector('.dropdown-item');
        if (firstItem && document.activeElement !== document.body) {
            setTimeout(() => firstItem.focus(), 100);
        }
    }

    closeDropdown(dropdown) {
        const toggle = dropdown.querySelector('.dropdown-toggle') || 
                      dropdown.querySelector('a[data-bs-toggle="dropdown"]') ||
                      dropdown.querySelector('.nav-link');
        const menu = dropdown.querySelector('.dropdown-menu');
        
        dropdown.classList.remove('show');
        menu.classList.remove('show');
        if (toggle) {
            toggle.setAttribute('aria-expanded', 'false');
        }
        
        setTimeout(() => {
            const hasOpenDropdown = this.navbar.querySelector('.dropdown.show');
            const isHoveringNavbar = this.navbar.matches(':hover');
            if (!hasOpenDropdown && !isHoveringNavbar) {
                this.disablePageBlur();
            }
        }, 100);
    }

    setupSearch() {
        if (!this.searchForm || !this.searchInput) return;
        
        this.searchInput.addEventListener('focus', () => {
            this.searchInput.parentElement.classList.add('search-focused');
        });
        
        this.searchInput.addEventListener('blur', () => {
            this.searchInput.parentElement.classList.remove('search-focused');
        });
        
        this.searchForm.addEventListener('submit', (e) => {
            const query = this.searchInput.value.trim();
            if (!query) {
                e.preventDefault();
                this.searchInput.focus();
                this.showSearchError('Please enter a search term');
                return;
            }
            
            this.trackSearchQuery(query);
        });
        
        this.setupSearchSuggestions();
    }

    setupSearchSuggestions() {
        let searchTimeout;
        
        this.searchInput.addEventListener('input', () => {
            clearTimeout(searchTimeout);
            searchTimeout = setTimeout(() => {
                const query = this.searchInput.value.trim();
                if (query.length >= 2) {
                }
            }, 300);
        });
    }

    showSearchError(message) {
        let errorEl = this.searchForm.querySelector('.search-error');
        if (!errorEl) {
            errorEl = document.createElement('div');
            errorEl.className = 'search-error alert alert-warning alert-sm mt-2';
            this.searchForm.appendChild(errorEl);
        }
        
        errorEl.textContent = message;
        errorEl.style.display = 'block';
        
        setTimeout(() => {
            errorEl.style.display = 'none';
        }, 3000);
    }

    trackSearchQuery(query) {
        console.log('Search query:', query);
    }

    setupMobileNavigation() {
        const toggler = document.querySelector('.navbar-toggler');
        const collapse = document.querySelector('.navbar-collapse');
        const mobileThemeToggle = document.querySelector('#mobileThemeToggle');
        
        if (!toggler || !collapse) return;
        
        // 监听Bootstrap的collapse事件
        collapse.addEventListener('show.bs.collapse', () => {
            document.body.classList.add('navbar-mobile-open');
            
            // 确保移动端主题切换按钮在菜单打开时可见
            if (mobileThemeToggle) {
                mobileThemeToggle.style.display = 'flex';
                mobileThemeToggle.style.opacity = '1';
                mobileThemeToggle.style.visibility = 'visible';
            }
        });
        
        collapse.addEventListener('hide.bs.collapse', () => {
            document.body.classList.remove('navbar-mobile-open');
            
            // 菜单关闭时保持主题切换按钮可见（已修复CSS）
            if (mobileThemeToggle) {
                mobileThemeToggle.style.display = 'flex';
                mobileThemeToggle.style.opacity = '1';
                mobileThemeToggle.style.visibility = 'visible';
            }
        });
        
        // 防止Bootstrap默认的自动关闭行为
        collapse.addEventListener('click', (e) => {
            // 如果点击的是导航链接或下拉菜单项
            if (e.target.closest('.nav-link') || e.target.closest('.dropdown-item')) {
                const target = e.target.closest('.nav-link') || e.target.closest('.dropdown-item');
                
                // 检查是否是下拉菜单的触发按钮
                const isDropdownToggle = target && (
                    target.hasAttribute('data-bs-toggle') || 
                    target.closest('.dropdown-toggle') ||
                    target.closest('[data-bs-toggle="dropdown"]')
                );
                
                // 如果是下拉菜单触发按钮，不关闭导航栏
                if (isDropdownToggle) {
                    console.log('Dropdown toggle clicked, keeping navbar open');
                    return;
                }
                
                // 如果是下拉菜单项，延迟关闭
                if (e.target.closest('.dropdown-item') && window.innerWidth < 992) {
                    console.log('Dropdown item clicked, closing navbar in 200ms');
                    setTimeout(() => {
                        const bsCollapse = bootstrap.Collapse.getInstance(collapse);
                        if (bsCollapse) {
                            bsCollapse.hide();
                        }
                    }, 200);
                    return;
                }
                
                // 如果是普通导航链接（非下拉菜单触发），延迟关闭
                if (target && !isDropdownToggle && window.innerWidth < 992) {
                    console.log('Navigation link clicked, closing navbar in 200ms');
                    setTimeout(() => {
                        const bsCollapse = bootstrap.Collapse.getInstance(collapse);
                        if (bsCollapse) {
                            bsCollapse.hide();
                        }
                    }, 200);
                }
            }
        });
    }

    setupActiveStates() {
    }

    setupAccessibility() {
        this.improveFocusManagement();
        
        this.enhanceAriaLabels();
    }

    

    improveFocusManagement() {
        const collapse = document.querySelector('.navbar-collapse');
        if (collapse) {
            collapse.addEventListener('keydown', (e) => {
                if (e.key == 'Escape' && collapse.classList.contains('show')) {
                    const toggler = document.querySelector('.navbar-toggler');
                    if (toggler) toggler.click();
                }
            });
        }
    }

    enhanceAriaLabels() {
        this.dropdowns.forEach(dropdown => {
            const toggle = dropdown.querySelector('.dropdown-toggle') || 
                          dropdown.querySelector('a[data-bs-toggle="dropdown"]') ||
                          dropdown.querySelector('.nav-link');
            const menu = dropdown.querySelector('.dropdown-menu');
            
            if (toggle && !toggle.getAttribute('aria-haspopup')) {
                toggle.setAttribute('aria-haspopup', 'true');
            }
            
            if (menu && toggle && !menu.getAttribute('aria-labelledby')) {
                const toggleId = toggle.id || `dropdown-${Math.random().toString(36).substr(2, 9)}`;
                toggle.id = toggleId;
                menu.setAttribute('aria-labelledby', toggleId);
            }
        });
    }

    improveFocusVisibility() {
        const style = document.createElement('style');
        style.textContent = `
            .navbar .nav-link:focus,
            .navbar .btn:focus,
            .navbar .dropdown-toggle:focus {
                outline: 2px solid #DAA520;
                outline-offset: 2px;
                box-shadow: 0 0 0 3px rgba(218, 165, 32, 0.2);
            }
            
            .skip-nav:focus {
                outline: 2px solid #fff;
                outline-offset: 2px;
            }
        `;
        document.head.appendChild(style);
    }

    setupLanguageSelector() {
        const languageDropdown = document.querySelector('#languageDropdown');
        const languageItems = document.querySelectorAll('.lang-btn[data-lang]');
        
        if (!languageDropdown || !languageItems.length) return;
        
        const currentLang = localStorage.getItem('preferredLanguage') || (navigator.language||'en').split('-')[0];
        this.updateLanguageDisplay(currentLang);
        
        languageItems.forEach(item => {
            item.addEventListener('click', (e) => {
                e.preventDefault();
                const lang = item.getAttribute('data-lang');
                this.changeLanguage(lang);
            });
        });
    }

    changeLanguage(lang) {
        localStorage.setItem('preferredLanguage', lang);
        this.updateLanguageDisplay(lang);
        if (window.I18n && typeof window.I18n.setLanguage == 'function') {
            window.I18n.setLanguage(lang);
        } else if (typeof setLanguage == 'function') {
            // fallback to legacy if exists
            setLanguage(lang);
        }
        
        console.log('Language changed to:', lang);
    }

    updateLanguageDisplay(lang) {
        const currentLanguageSpan = document.querySelector('#currentLanguage');
        if (currentLanguageSpan) {
            const langMap = { 'en': 'EN', 'zh': '中', 'ms': 'MS', 'ru': 'РУ', 'ar': 'ع', 'fr': 'FR' };
            currentLanguageSpan.textContent = langMap[lang] || 'EN';
        }
        
        const languageItems = document.querySelectorAll('.lang-btn[data-lang]');
        languageItems.forEach(item => {
            item.classList.toggle('active', item.getAttribute('data-lang') == lang);
        });
    }

    setupThemeToggle() {
        // 桌面端主题切换按钮
        const desktopThemeToggle = document.querySelector('.theme-toggle-wrapper.d-none.d-lg-flex theme-button');
        // 移动端主题切换按钮
        const mobileThemeToggle = document.querySelector('#mobileThemeToggle theme-button');
        
        const savedTheme = localStorage.getItem('theme') || 'light';
        this.applyTheme(savedTheme);
        
        // 为桌面端和移动端主题切换按钮添加事件监听
        [desktopThemeToggle, mobileThemeToggle].forEach(toggle => {
            if (toggle) {
                toggle.addEventListener('change', (event) => {
                    const newTheme = event.detail;
                    this.applyTheme(newTheme);
                    localStorage.setItem('theme', newTheme);
                });
            }
        });
        
        // 监听主题变化事件（来自theme-toggle.js）
        document.addEventListener('theme-changed', (event) => {
            const newTheme = event.detail;
            this.applyTheme(newTheme);
            localStorage.setItem('theme', newTheme);
        });
    }

    applyTheme(theme) {
        const html = document.documentElement;
        
        if (theme == 'dark') {
            document.body.classList.add('dark-mode');
            html.setAttribute('data-theme', 'dark');
            
            // 更新所有主题切换按钮的状态
            const allThemeButtons = document.querySelectorAll('theme-button');
            allThemeButtons.forEach(button => {
                if (button.setTheme) {
                    button.setTheme('dark');
                }
            });
            
            console.log('Dark mode applied to navigation');
        } else {
            document.body.classList.remove('dark-mode');
            html.setAttribute('data-theme', 'light');
            
            // 更新所有主题切换按钮的状态
            const allThemeButtons = document.querySelectorAll('theme-button');
            allThemeButtons.forEach(button => {
                if (button.setTheme) {
                    button.setTheme('light');
                }
            });
            
            console.log('Light mode applied to navigation');
        }
    }
}

document.addEventListener('DOMContentLoaded', () => {
    window.enhancedNavigation = new EnhancedNavigation();
});

if (typeof module != 'undefined' && module.exports) {
    module.exports = EnhancedNavigation;
}