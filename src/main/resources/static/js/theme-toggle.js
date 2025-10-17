(() => {
    'use strict';
    
    const CONFIG = {
        TRANSITION_DURATION: 700,
        HOVER_RESET_DELAY: 500,
        CLOUD_ANIMATION_INTERVAL: 2000,
        DEFAULT_SIZE: 3,
        STORAGE_KEY: 'theme'
    };
    
    const AnimationState = {
        isTransitioning: false,
        cloudAnimationId: null,
        hoverTimeoutId: null
    };
    
    function getStorageItem(key, defaultValue = 'light') {
        try {
            return localStorage.getItem(key) || defaultValue;
        } catch (error) {
            console.warn('localStorage read failed:', error);
            return defaultValue;
        }
    }
    
    function setStorageItem(key, value) {
        try {
            localStorage.setItem(key, value);
        } catch (error) {
            console.warn('localStorage write failed:', error);
        }
    }
    
    function createOptimizedCSS(fontSize) {
        return `
            * { 
                margin: 0; 
                padding: 0; 
                transition: ${CONFIG.TRANSITION_DURATION / 1000}s; 
                -webkit-tap-highlight-color: rgba(0,0,0,0);
                box-sizing: border-box;
            }
            
            .container { 
                position: absolute; 
                margin-top: -35em; 
                margin-left: -90em; 
                width: 180em; 
                height: 70em; 
                display: inline-block; 
                vertical-align: bottom; 
                transform: translate3d(0, 0, 0);
                font-size: ${fontSize}px;
            }
            
            .components { 
                position: fixed; 
                width: 180em; 
                height: 70em; 
                background-color: rgba(70, 133, 192, 1); 
                border-radius: 100em; 
                box-shadow: inset 0 0 5em 3em rgba(0, 0, 0, 0.5); 
                overflow: hidden; 
                transition: background-color ${CONFIG.TRANSITION_DURATION / 1000}s cubic-bezier(0, 0.5, 1, 1); 
                cursor: pointer;
                will-change: background-color;
            }
            
            .main-button { 
                margin: 7.5em 0 0 7.5em; 
                width: 55em; 
                height: 55em; 
                background-color: rgba(255, 195, 35, 1); 
                border-radius: 50%; 
                box-shadow: 3em 3em 5em rgba(0, 0, 0, 0.5), 
                           inset -3em -5em 3em -3em rgba(0, 0, 0, 0.5), 
                           inset 4em 5em 2em -2em rgba(255, 230, 80, 1); 
                transition: transform 1s cubic-bezier(0.56, 1.35, 0.52, 1.00),
                           background-color ${CONFIG.TRANSITION_DURATION / 1000}s,
                           box-shadow ${CONFIG.TRANSITION_DURATION / 1000}s;
                will-change: transform, background-color, box-shadow;
            }
            
            .moon { 
                position: absolute; 
                background-color: rgba(150, 160, 180, 1); 
                box-shadow: inset 0 0 1em 1em rgba(0, 0, 0, 0.3); 
                border-radius: 50%; 
                transition: opacity 0.5s ease-in-out; 
                opacity: 0;
                will-change: opacity;
            }
            
            .moon:nth-child(1) { top: 7.5em; left: 25em; width: 12.5em; height: 12.5em; }
            .moon:nth-child(2) { top: 20em; left: 7.5em; width: 20em; height: 20em; }
            .moon:nth-child(3) { top: 32.5em; left: 32.5em; width: 12.5em; height: 12.5em; }
            
            .daytime-background { 
                position: absolute; 
                border-radius: 50%; 
                transition: transform 1s cubic-bezier(0.56, 1.35, 0.52, 1.00);
                will-change: transform;
            }
            
            .daytime-background:nth-child(2) { 
                top: -20em; left: -20em; width: 110em; height: 110em; 
                background-color: rgba(255, 255, 255, 0.2); z-index: -2; 
            }
            .daytime-background:nth-child(3) { 
                top: -32.5em; left: -17.5em; width: 135em; height: 135em; 
                background-color: rgba(255, 255, 255, 0.1); z-index: -3; 
            }
            .daytime-background:nth-child(4) { 
                top: -45em; left: -15em; width: 160em; height: 160em; 
                background-color: rgba(255, 255, 255, 0.05); z-index: -4; 
            }
            
            .cloud, .cloud-light { 
                transform: translateY(10em); 
                transition: transform 1s cubic-bezier(0.56, 1.35, 0.52, 1.00);
                will-change: transform;
            }
            
            .cloud-son { 
                position: absolute; 
                background-color: #fff; 
                border-radius: 50%; 
                z-index: -1; 
                transition: transform 3s ease-in-out, right 1s, bottom 1s;
                will-change: transform, right, bottom;
            }
            
            .cloud-son:nth-child(6n+1) { right: -20em; bottom: 10em; width: 50em; height: 50em; }
            .cloud-son:nth-child(6n+2) { right: -10em; bottom: -25em; width: 60em; height: 60em; }
            .cloud-son:nth-child(6n+3) { right: 20em; bottom: -40em; width: 60em; height: 60em; }
            .cloud-son:nth-child(6n+4) { right: 50em; bottom: -35em; width: 60em; height: 60em; }
            .cloud-son:nth-child(6n+5) { right: 75em; bottom: -60em; width: 75em; height: 75em; }
            .cloud-son:nth-child(6n+6) { right: 110em; bottom: -50em; width: 60em; height: 60em; }
            
            .cloud { z-index: -2; }
            .cloud-light { 
                position: absolute; 
                right: 0; 
                bottom: 25em; 
                opacity: 0.5; 
                z-index: -3; 
            }
            
            .stars { 
                transform: translateY(-125em); 
                z-index: -2; 
                transition: transform 1s cubic-bezier(0.56, 1.35, 0.52, 1.00), 
                           opacity ${CONFIG.TRANSITION_DURATION / 1000}s;
                will-change: transform, opacity;
            }
            
            .star { 
                position: absolute; 
                transform: scale(1); 
                transition: transform 1s cubic-bezier(0.56, 1.35, 0.52, 1.00); 
                animation-iteration-count: infinite; 
                animation-direction: alternate; 
                animation-timing-function: linear;
                will-change: transform;
            }
            
            .big { --size: 7.5em; }
            .medium { --size: 5em; }
            .small { --size: 3em; }
            
            .star { width: calc(2 * var(--size)); height: calc(2 * var(--size)); }
            .star:nth-child(1) { top: 11em; left: 39em; animation: star 3.5s; }
            .star:nth-child(2) { top: 39em; left: 91em; animation: star 4.1s; }
            .star:nth-child(3) { top: 26em; left: 19em; animation: star 4.9s; }
            .star:nth-child(4) { top: 37em; left: 66em; animation: star 5.3s; }
            .star:nth-child(5) { top: 21em; left: 75em; animation: star 3s; }
            .star:nth-child(6) { top: 51em; left: 38em; animation: star 2.2s; }
            
            @keyframes star { 
                0%, 20% { transform: scale(0); } 
                20%, 100% { transform: scale(1); } 
            }
            
            .star-son { 
                float: left; 
                width: var(--size); 
                height: var(--size); 
            }
            
            .star-son:nth-child(1) { background-image: radial-gradient(circle var(--size) at left 0, transparent var(--size), #fff); }
            .star-son:nth-child(2) { background-image: radial-gradient(circle var(--size) at right 0, transparent var(--size), #fff); }
            .star-son:nth-child(3) { background-image: radial-gradient(circle var(--size) at 0 bottom, transparent var(--size), #fff); }
            .star-son:nth-child(4) { background-image: radial-gradient(circle var(--size) at right bottom, transparent var(--size), #fff); }
            
            @media (prefers-reduced-motion: reduce) {
                * { transition: none !important; animation: none !important; }
            }
        `;
    }
    
    function initThemeToggle(root, initTheme, changeTheme) {
        const elements = {
            mainButton: root.querySelector('.main-button'),
            daytimeBackground: root.querySelectorAll('.daytime-background'),
            cloud: root.querySelector('.cloud'),
            cloudList: root.querySelectorAll('.cloud-son'),
            cloudLight: root.querySelector('.cloud-light'),
            components: root.querySelector('.components'),
            moon: root.querySelectorAll('.moon'),
            stars: root.querySelector('.stars'),
            star: root.querySelectorAll('.star')
        };
        
        if (!elements.mainButton || !elements.components) {
            console.error('Theme toggle: Required elements not found');
            return;
        }
        
        let isDarkMode = false;
        
        const themeStates = {
            light: {
                mainButton: {
                    transform: 'translateX(0)',
                    backgroundColor: 'rgba(255, 195, 35, 1)',
                    boxShadow: '3em 3em 5em rgba(0, 0, 0, 0.5), inset -3em -5em 3em -3em rgba(0, 0, 0, 0.5), inset 4em 5em 2em -2em rgba(255, 230, 80, 1)'
                },
                background: {
                    backgroundColor: 'rgba(70, 133, 192, 1)',
                    daytimeTransforms: ['translateX(0)', 'translateX(0)', 'translateX(0)']
                },
                clouds: {
                    transform: 'translateY(10em)',
                    lightTransform: 'translateY(10em)'
                },
                celestial: {
                    moonOpacity: '0',
                    starsTransform: 'translateY(-125em)',
                    starsOpacity: '0'
                }
            },
            dark: {
                mainButton: {
                    transform: 'translateX(110em)',
                    backgroundColor: 'rgba(195, 200, 210, 1)',
                    boxShadow: '3em 3em 5em rgba(0, 0, 0, 0.5), inset -3em -5em 3em -3em rgba(0, 0, 0, 0.5), inset 4em 5em 2em -2em rgba(255, 255, 210, 1)'
                },
                background: {
                    backgroundColor: 'rgba(25, 30, 50, 1)',
                    daytimeTransforms: ['translateX(110em)', 'translateX(80em)', 'translateX(50em)']
                },
                clouds: {
                    transform: 'translateY(80em)',
                    lightTransform: 'translateY(80em)'
                },
                celestial: {
                    moonOpacity: '1',
                    starsTransform: 'translateY(-62.5em)',
                    starsOpacity: '1'
                }
            }
        };
        
        function applyThemeState(theme) {
            if (AnimationState.isTransitioning) return;
            
            AnimationState.isTransitioning = true;
            const state = themeStates[theme];
            
            Object.assign(elements.mainButton.style, state.mainButton);
            
            elements.components.style.backgroundColor = state.background.backgroundColor;
            elements.daytimeBackground.forEach((bg, index) => {
                if (bg && state.background.daytimeTransforms[index]) {
                    bg.style.transform = state.background.daytimeTransforms[index];
                }
            });
            
            if (elements.cloud) elements.cloud.style.transform = state.clouds.transform;
            if (elements.cloudLight) elements.cloudLight.style.transform = state.clouds.lightTransform;
            
            elements.moon.forEach(moon => {
                if (moon) moon.style.opacity = state.celestial.moonOpacity;
            });
            
            if (elements.stars) {
                elements.stars.style.transform = state.celestial.starsTransform;
                elements.stars.style.opacity = state.celestial.starsOpacity;
            }
            
            isDarkMode = theme == 'dark';
            changeTheme(theme);
            
            setTimeout(() => {
                AnimationState.isTransitioning = false;
            }, CONFIG.TRANSITION_DURATION);
        }
        
        function toggleTheme() {
            if (AnimationState.isTransitioning) return;
            
            const newTheme = isDarkMode ? 'light' : 'dark';
            applyThemeState(newTheme);
        }
        
        function handleSystemThemeChange() {
            const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
            const targetTheme = prefersDark ? 'dark' : 'light';
            
            if ((targetTheme == 'dark') != isDarkMode) {
                applyThemeState(targetTheme);
            }
        }
        
        function handleMouseMove() {
            if (AnimationState.isTransitioning) return;
            
            const hoverStates = isDarkMode ? {
                mainButton: 'translateX(100em)',
                daytimeTransforms: ['translateX(100em)', 'translateX(73em)', 'translateX(46em)'],
                starPositions: [
                    { top: '10em', left: '36em' },
                    { top: '40em', left: '87em' },
                    { top: '26em', left: '16em' },
                    { top: '38em', left: '63em' },
                    { top: '20.5em', left: '72em' },
                    { top: '51.5em', left: '35em' }
                ]
            } : {
                mainButton: 'translateX(10em)',
                daytimeTransforms: ['translateX(10em)', 'translateX(7em)', 'translateX(4em)'],
                cloudPositions: [
                    { right: '-24em', bottom: '10em' },
                    { right: '-12em', bottom: '-27em' },
                    { right: '17em', bottom: '-43em' },
                    { right: '46em', bottom: '-39em' },
                    { right: '70em', bottom: '-65em' },
                    { right: '109em', bottom: '-54em' },
                    { right: '-23em', bottom: '10em' },
                    { right: '-11em', bottom: '-26em' },
                    { right: '18em', bottom: '-42em' },
                    { right: '47em', bottom: '-38em' },
                    { right: '74em', bottom: '-64em' },
                    { right: '110em', bottom: '-55em' }
                ]
            };
            
            elements.mainButton.style.transform = hoverStates.mainButton;
            
            elements.daytimeBackground.forEach((bg, index) => {
                if (bg && hoverStates.daytimeTransforms[index]) {
                    bg.style.transform = hoverStates.daytimeTransforms[index];
                }
            });
            
            if (isDarkMode && hoverStates.starPositions) {
                elements.star.forEach((star, index) => {
                    if (star && hoverStates.starPositions[index]) {
                        const pos = hoverStates.starPositions[index];
                        star.style.top = pos.top;
                        star.style.left = pos.left;
                    }
                });
            } else if (!isDarkMode && hoverStates.cloudPositions) {
                elements.cloudList.forEach((cloud, index) => {
                    if (cloud && hoverStates.cloudPositions[index]) {
                        const pos = hoverStates.cloudPositions[index];
                        cloud.style.right = pos.right;
                        cloud.style.bottom = pos.bottom;
                    }
                });
            }
        }
        
        function handleMouseOut() {
            if (AnimationState.isTransitioning) return;
            
            applyThemeState(isDarkMode ? 'dark' : 'light');
        }
        
        function startCloudAnimation() {
            const directions = ['2em', '-2em'];
            
            function animateClouds() {
                elements.cloudList.forEach(cloud => {
                    if (cloud) {
                        const randomX = directions[Math.floor(Math.random() * 2)];
                        const randomY = directions[Math.floor(Math.random() * 2)];
                        cloud.style.transform = `translate(${randomX}, ${randomY})`;
                    }
                });
                
                AnimationState.cloudAnimationId = setTimeout(() => {
                    requestAnimationFrame(animateClouds);
                }, CONFIG.CLOUD_ANIMATION_INTERVAL);
            }
            
            animateClouds();
        }
        
        function stopCloudAnimation() {
            if (AnimationState.cloudAnimationId) {
                clearTimeout(AnimationState.cloudAnimationId);
                AnimationState.cloudAnimationId = null;
            }
        }
        
        elements.components.addEventListener('click', toggleTheme);
        elements.mainButton.addEventListener('mousemove', handleMouseMove);
        elements.mainButton.addEventListener('mouseout', handleMouseOut);
        
        const mediaQuery = window.matchMedia('(prefers-color-scheme: dark)');
        if (mediaQuery.addEventListener) {
            mediaQuery.addEventListener('change', handleSystemThemeChange);
        } else {
            mediaQuery.addEventListener('change', callback);
        }
        
        startCloudAnimation();
        
        const savedTheme = getStorageItem(CONFIG.STORAGE_KEY, initTheme);
        applyThemeState(savedTheme);
        
        return function cleanup() {
            stopCloudAnimation();
            elements.components.removeEventListener('click', toggleTheme);
            elements.mainButton.removeEventListener('mousemove', handleMouseMove);
            elements.mainButton.removeEventListener('mouseout', handleMouseOut);
            
            if (mediaQuery.removeEventListener) {
                mediaQuery.removeEventListener('change', handleSystemThemeChange);
            } else {
                mediaQuery.removeEventListener('change', callback);
            }
            
            if (AnimationState.hoverTimeoutId) {
                clearTimeout(AnimationState.hoverTimeoutId);
            }
        };
    }

    class ThemeButton extends HTMLElement {
        constructor() {
            super();
            this.cleanup = null;
        }
        
        connectedCallback() {
            try {
                const initTheme = this.getAttribute('value') || 'light';
                const size = Math.max(1, +(this.getAttribute('size') || CONFIG.DEFAULT_SIZE));
                
                const shadow = this.attachShadow({ mode: 'closed' });
                const container = document.createElement('div');
                container.className = 'container';
                
                container.innerHTML = `
                    <div class="components">
                        <div class="main-button">
                            <div class="moon"></div>
                            <div class="moon"></div>
                            <div class="moon"></div>
                        </div>
                        <div class="daytime-background"></div>
                        <div class="daytime-background"></div>
                        <div class="daytime-background"></div>
                        <div class="cloud">
                            ${Array(6).fill('<div class="cloud-son"></div>').join('')}
                        </div>
                        <div class="cloud-light">
                            ${Array(6).fill('<div class="cloud-son"></div>').join('')}
                        </div>
                        <div class="stars">
                            ${['big', 'big', 'medium', 'medium', 'small', 'small'].map(size => 
                                `<div class="star ${size}">${Array(4).fill('<div class="star-son"></div>').join('')}</div>`
                            ).join('')}
                        </div>
                    </div>
                `;
                
                const style = document.createElement('style');
                style.textContent = createOptimizedCSS(size / 3);
                
                const changeTheme = (theme) => {
                    try {
                        setStorageItem(CONFIG.STORAGE_KEY, theme);
                        
                        document.body.classList.toggle('dark-mode', theme == 'dark');
                        
                        this.dispatchEvent(new CustomEvent('change', { 
                            detail: theme,
                            bubbles: true
                        }));
                        
                        document.dispatchEvent(new CustomEvent('theme-changed', { 
                            detail: theme 
                        }));
                        
                    } catch (error) {
                        console.error('Theme change failed:', error);
                    }
                };
                
                this.cleanup = initThemeToggle(container, initTheme, changeTheme);
                
                shadow.appendChild(style);
                shadow.appendChild(container);
                
            } catch (error) {
                console.error('ThemeButton initialization failed:', error);
            }
        }
        
        disconnectedCallback() {
            if (this.cleanup) {
                this.cleanup();
                this.cleanup = null;
            }
        }
        
        setTheme(theme) {
            const components = this.shadowRoot?.querySelector('.components');
            if (components && (theme == 'light' || theme == 'dark')) {
                components.click();
            }
        }
        
        getCurrentTheme() {
            return getStorageItem(CONFIG.STORAGE_KEY, 'light');
        }
    }
    
    try {
        if (!customElements.get('theme-button')) {
            customElements.define('theme-button', ThemeButton);
        }
    } catch (error) {
        console.error('Failed to register theme-button custom element:', error);
    }
    
})();