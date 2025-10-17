function initVideoCarousel() {
    const carousel = document.querySelector('#carouselExampleCaptions');
    if (!carousel) return;

    console.log('Video carousel initialized');

    const carouselInstance = new bootstrap.Carousel(carousel, {
        interval: 5000,
        pause: 'hover',
        wrap: true,
        touch: true
    });

    window.addEventListener('load', () => {
        const firstVideo = carousel.querySelector('.carousel-item.active video');
        if (firstVideo) {
            playVideo(firstVideo);
        }
    });

    carousel.addEventListener('slide.bs.carousel', (event) => {
        console.log('Carousel sliding - pausing all videos');
        
        const videos = carousel.querySelectorAll('video');
        videos.forEach(video => {
            if (!video.paused) {
                video.pause();
                console.log('Video paused:', video.src);
            }
        });
    });

    carousel.addEventListener('slid.bs.carousel', (event) => {
        console.log('Carousel slid complete');
        
        setTimeout(() => {
            const activeSlide = carousel.querySelector('.carousel-item.active');
            const activeVideo = activeSlide?.querySelector('video');
            
            if (activeVideo) {
                playVideo(activeVideo);
            }
        }, 100);
    });

    document.addEventListener('visibilitychange', () => {
        const videos = carousel.querySelectorAll('video');
        videos.forEach(video => {
            if (document.hidden && !video.paused) {
                video.pause();
            } else if (!document.hidden && carousel.querySelector('.carousel-item.active video') === video) {
                playVideo(video);
            }
        });
    });
}

function playVideo(video) {
    if (!video) return;
    
    if (video.ended) {
        video.currentTime = 0;
    }
    
    const playPromise = video.play();
    
    if (playPromise !== undefined) {
        playPromise
            .then(() => {
                console.log('Video playing successfully:', video.src);
            })
            .catch(error => {
                console.warn('Video autoplay failed:', error);
            });
    }
}

class EllipticalCarousel {
    constructor() {
        this.imgListOne = document.querySelector('.img-list');
        // Placeholder initialization, will read real DOM list and clone dynamically in init()
        this.imgBoxList = [];
        this.allImgBoxes = [];
        this.imgBoxCount = 0;
        this.root = document.documentElement;
        this.btnGroup = document.querySelector('.btn-group');
        this.lastBtn = document.querySelector('.last');
        this.nextBtn = document.querySelector('.next');
        
        this.currentIndex = 0; // Current displayed real image index (0..N-1)
        this.timer = null;
        this.animationTime = 0.5;
        this.isTransitioning = false;
        this.clonesLeft = 0;   // Dynamic clone count (left)
        this.clonesRight = 0;  // Dynamic clone count (right)
        
        this.postSpacing = Number(getComputedStyle(this.root).getPropertyValue('--post-spacing').replace("vw", ""));
        this.postSize = Number(getComputedStyle(this.root).getPropertyValue('--post-size').replace("vw", ""));
        this.imgBoxLength = this.postSize + this.postSpacing;
        
        this.init();
    }
    
    init() {
        if (!this.imgListOne) {
            console.warn('Elliptical carousel elements not found');
            return;
        }
        // Clean up any preset clone nodes (clone-first/clone-last), unified dynamic cloning by viewport at runtime
        this.imgListOne.querySelectorAll('.clone-first, .clone-last, .is-clone').forEach(n => n.remove());

        // Read real images
        this.imgBoxList = Array.prototype.slice.call(this.imgListOne.querySelectorAll('.img-box'));
        this.imgBoxCount = this.imgBoxList.length;
        if (this.imgBoxCount === 0) {
            console.warn('Elliptical carousel items missing');
            return;
        }

        // Dynamically clone left and right sides to ensure no blank space on any screen
        this.buildDynamicClones();
        this.allImgBoxes = Array.prototype.slice.call(this.imgListOne.querySelectorAll('.img-box'));

        console.log('Elliptical carousel initialized with', this.imgBoxCount, 'real images (', this.allImgBoxes.length, 'total including clones). ClonesLeft:', this.clonesLeft, 'ClonesRight:', this.clonesRight);
        
        // Initial position: center the first real image
        // First real image is at physical index 1 (index 0 is clone)
        // To center: screen center 50vw - half image width 12.5vw - first image start position (1*imgBoxLength)
        // Simplified: when currentIndex=0 show first real image, so offset = -(0+1)*imgBoxLength = -26.78vw
        // But this would make image stick to left edge, we need to center it, so add center offset: 50vw - 12.5vw = 37.5vw
        const centerOffset = 50 - 12.5; // Screen center position (vw units)
        const initialOffset = centerOffset - ((this.clonesLeft + 1) * this.imgBoxLength);
        this.imgListOne.style.transform = `translateX(${initialOffset}vw)`;
        this.imgListOne.style.transition = this.animationTime + 's ease';
        
        setTimeout(() => {
            if (this.btnGroup) {
                this.btnGroup.classList.add('show');
                this.btnGroup.style.opacity = '1';
            }
        }, this.animationTime * 1000);
        
        this.bindEvents();
    }
    
    bindEvents() {
        if (this.nextBtn) {
            this.nextBtn.onclick = this.throttle(() => this.navigate('next'), this.animationTime * 1000);
        }
        
        if (this.lastBtn) {
            this.lastBtn.onclick = this.throttle(() => this.navigate('last'), this.animationTime * 1000);
        }
        
        document.addEventListener('keydown', (e) => {
            if (e.key === 'ArrowLeft') {
                this.navigate('last');
            } else if (e.key === 'ArrowRight') {
                this.navigate('next');
            }
        });
        
        window.addEventListener('resize', this.throttle(() => {
            this.updateDimensions();
        }, 250));
    }
    
    navigate(direction) {
        if (this.isTransitioning) return;
        
        if (direction === 'next') {
            this.moveNext();
        } else {
            this.movePrevious();
        }
    }
    
    moveNext() {
        this.isTransitioning = true;
        this.currentIndex++;
        
        console.log('Moving next, currentIndex:', this.currentIndex);
        
        // Move right: keep image centered
        // Center offset - (left clone count + current index + 1) * image length
        const centerOffset = 50 - 12.5;
        const offset = centerOffset - ((this.clonesLeft + this.currentIndex + 1) * this.imgBoxLength);
        this.imgListOne.style.transition = `transform ${this.animationTime}s ease`;
        this.imgListOne.style.transform = `translateX(${offset}vw)`;
        
        setTimeout(() => {
            // If slid to the last clone image (clone of first image)
            if (this.currentIndex >= this.imgBoxCount) {
                // Instantly jump back to real first image without transition
                this.imgListOne.style.transition = 'none';
                this.currentIndex = 0;
                const resetOffset = centerOffset - ((this.clonesLeft + 1) * this.imgBoxLength);
                this.imgListOne.style.transform = `translateX(${resetOffset}vw)`;
                console.log('Reset to first image (seamless loop)');
            }
            
            this.isTransitioning = false;
        }, this.animationTime * 1000);
    }
    
    movePrevious() {
        this.isTransitioning = true;
        this.currentIndex--;
        
        console.log('Moving previous, currentIndex:', this.currentIndex);
        
        const centerOffset = 50 - 12.5; // 37.5vw
        
        // First move to target position (might be clone image), need to include left clone offset
        const offset = centerOffset - ((this.clonesLeft + this.currentIndex + 1) * this.imgBoxLength);
        this.imgListOne.style.transition = `transform ${this.animationTime}s ease`;
        this.imgListOne.style.transform = `translateX(${offset}vw)`;
        
        console.log('Move to offset:', offset, 'vw');
        
        setTimeout(() => {
            // If moved to first clone image (index -1)
            if (this.currentIndex < 0) {
                // Instantly jump to real last image without transition
                this.imgListOne.style.transition = 'none';
                this.currentIndex = this.imgBoxCount - 1; // 11
                const resetOffset = centerOffset - ((this.clonesLeft + this.currentIndex + 1) * this.imgBoxLength);
                this.imgListOne.style.transform = `translateX(${resetOffset}vw)`;
                console.log('Loop: Jump to last image, currentIndex:', this.currentIndex, ', offset:', resetOffset, 'vw');
                
                // Restore transition effect
                setTimeout(() => {
                    this.imgListOne.style.transition = `transform ${this.animationTime}s ease`;
                }, 50);
            }
            
            this.isTransitioning = false;
        }, this.animationTime * 1000);
    }
    
    updateDimensions() {
        this.postSpacing = Number(getComputedStyle(this.root).getPropertyValue('--post-spacing').replace("vw", ""));
        this.postSize = Number(getComputedStyle(this.root).getPropertyValue('--post-size').replace("vw", ""));
        this.imgListLength = (this.postSize + this.postSpacing) * this.imgBoxCount;
        this.imgBoxLength = this.postSize + this.postSpacing;
    }

    // Dynamically clone left and right side images based on viewport width, ensure sufficient content on both sides at any time to avoid blank space
    buildDynamicClones() {
        // 100vw / each image length (including spacing) + 2 for buffer, minimum 3
        const need = Math.max(3, Math.ceil(100 / this.imgBoxLength) + 2);
        const leftFrag = document.createDocumentFragment();
        const rightFrag = document.createDocumentFragment();

        for (let i = 0; i < need; i++) {
            // Left side: take from end
            const leftIndex = (this.imgBoxCount - 1 - i + this.imgBoxCount) % this.imgBoxCount;
            const leftClone = this.imgBoxList[leftIndex].cloneNode(true);
            leftClone.classList.add('is-clone');
            leftFrag.insertBefore(leftClone, leftFrag.firstChild);

            // Right side: take from beginning in order
            const rightIndex = i % this.imgBoxCount;
            const rightClone = this.imgBoxList[rightIndex].cloneNode(true);
            rightClone.classList.add('is-clone');
            rightFrag.appendChild(rightClone);
        }

        this.imgListOne.insertBefore(leftFrag, this.imgListOne.firstChild);
        this.imgListOne.appendChild(rightFrag);

        this.clonesLeft = need;
        this.clonesRight = need;
    }
    
    throttle(fn, delay) {
        return function() {
            if (this.timer) {
                return;
            }
            fn.apply(this, arguments);
            this.timer = setTimeout(() => {
                this.timer = null;
            }, delay);
        }.bind(this);
    }
}

class DarkModeManager {
    constructor() {
        this.isDark = this.getInitialTheme();
        this.init();
    }
    
    init() {
        this.applyTheme();
        this.bindEvents();
        console.log('Dark mode manager initialized:', this.isDark ? 'dark' : 'light');
    }
    
    getInitialTheme() {
        const stored = localStorage.getItem('theme');
        if (stored) {
            return stored === 'dark';
        }
        
        return window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;
    }
    
    applyTheme() {
        const body = document.body;
        const html = document.documentElement;
        
        if (this.isDark) {
            body.classList.add('dark-mode');
            html.setAttribute('data-theme', 'dark');
        } else {
            body.classList.remove('dark-mode');
            html.setAttribute('data-theme', 'light');
        }
        
        localStorage.setItem('theme', this.isDark ? 'dark' : 'light');
        
        console.log('Theme applied:', this.isDark ? 'dark' : 'light');
    }
    
    toggle() {
        this.isDark = !this.isDark;
        this.applyTheme();
        
        window.dispatchEvent(new CustomEvent('themeChanged', {
            detail: { isDark: this.isDark }
        }));
    }
    
    bindEvents() {
        window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', (e) => {
            if (!localStorage.getItem('theme')) {
                this.isDark = e.matches;
                this.applyTheme();
            }
        });
        
        const toggleButton = document.querySelector('#theme-toggle, .theme-toggle, [data-theme-toggle]');
        if (toggleButton) {
            toggleButton.addEventListener('click', () => this.toggle());
        }
    }
    
    getCurrentTheme() {
        return this.isDark ? 'dark' : 'light';
    }
}

let ellipticalCarousel;
let darkModeManager;

function initEllipticalCarousel() {
    if (!ellipticalCarousel) {
        ellipticalCarousel = new EllipticalCarousel();
    }
    return ellipticalCarousel;
}

function initDarkMode() {
    if (!darkModeManager) {
        darkModeManager = new DarkModeManager();
    }
    return darkModeManager;
}

document.addEventListener('DOMContentLoaded', function() {
    console.log('DOM loaded - initializing homepage components');
    
    initDarkMode();
    
    initVideoCarousel();
    
    initEllipticalCarousel();
    
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            const href = this.getAttribute('href');
            if (!href || href === '#') return; // ignore empty anchors
            const target = document.querySelector(href);
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
    
    console.log('Homepage initialization complete');
});

window.addEventListener('load', function() {
    const carousel = document.querySelector('#carouselExampleCaptions');
    if (carousel && !carousel.hasVideoCarouselInit) {
        console.log('Window loaded - initializing video carousel as fallback');
        carousel.hasVideoCarouselInit = true;
        initVideoCarousel();
    }
    
    if (!ellipticalCarousel) {
        console.log('Window loaded - initializing elliptical carousel as fallback');
        initEllipticalCarousel();
    }
    
    if (!darkModeManager) {
        console.log('Window loaded - initializing dark mode as fallback');
        initDarkMode();
    }
});


document.addEventListener('DOMContentLoaded', function() {
    const tiltElements = document.querySelectorAll('[data-tilt]');
    
    if (tiltElements.length > 0) {
        console.log('Initializing vanilla-tilt for', tiltElements.length, 'elements');
        
        VanillaTilt.init(tiltElements, {
            max: 10,              // Increase tilt angle for more prominent border breakthrough
            speed: 1000,
            scale: 1.05,          // Increase scale ratio
            perspective: 1500,    // Increase perspective depth for enhanced 3D effect
            transition: true,
            reset: true,
            glare: true,          // Enable glare effect
            "max-glare": 0.3      // Increase glare intensity
        });
        
        // Add event listeners to elevate parent card z-index when image tilts
        tiltElements.forEach(function(element) {
            const card = element.closest('.card');
            
            element.addEventListener('mouseenter', function() {
                if (card) {
                    card.classList.add('tilt-active');
                }
            });
            
            element.addEventListener('mouseleave', function() {
                if (card) {
                    card.classList.remove('tilt-active');
                }
            });
        });
        
        console.log('Vanilla-tilt initialization complete');
    } else {
        console.warn('No elements with data-tilt attribute found');
    }
});

window.addEventListener('load', function() {
    const uninitializedElements = document.querySelectorAll('[data-tilt]:not(.js-tilt-glare-hover)');
    
    if (uninitializedElements.length > 0) {
        console.log('Fallback: Initializing remaining tilt elements');
        VanillaTilt.init(uninitializedElements, {
            max: 25,              // Increase tilt angle for more prominent border breakthrough
            speed: 800,
            scale: 1.15,          // Increase scale ratio
            perspective: 1500,    // Increase perspective depth for enhanced 3D effect
            transition: true,
            reset: true,
            glare: true,          // Enable glare effect
            "max-glare": 0.3      // Increase glare intensity
        });
    }
});


window.addEventListener('resize', function() {
    clearTimeout(window.resizeTimer);
    window.resizeTimer = setTimeout(() => {
        if (ellipticalCarousel && ellipticalCarousel.updateDimensions) {
            ellipticalCarousel.updateDimensions();
        }
    }, 250);
});

let ticking = false;
window.addEventListener('scroll', function() {
    if (!ticking) {
        requestAnimationFrame(() => {
            ticking = false;
        });
        ticking = true;
    }
});

// Initialize advanced theme color icons for world section
function initWorldSectionIcons() {
    // Wait for Lucide icons to load
    setTimeout(() => {
        const listItems = document.querySelectorAll('.world-section ul li');
        const colors = ['#4285f4', '#B8860B', '#DAA520']; // Blue + Premium gold theme colors
        
        listItems.forEach((li, index) => {
            if (index < colors.length) {
                // Set text color
                li.style.color = colors[index];
                
                // Set icon color
                const svgs = li.querySelectorAll('svg');
                svgs.forEach(svg => {
                    svg.style.stroke = colors[index];
                    svg.style.color = colors[index];
                });
                
                // Also try to set svg inside i tag
                const icon = li.querySelector('i[data-lucide]');
                if (icon) {
                    icon.style.color = colors[index];
                    const iconSvg = icon.querySelector('svg');
                    if (iconSvg) {
                        iconSvg.style.stroke = colors[index];
                        iconSvg.style.color = colors[index];
                    }
                }
            }
        });
    }, 200);
}

// Initialize icons after page load completes
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initWorldSectionIcons);
} else {
    initWorldSectionIcons();
}

if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        EllipticalCarousel,
        DarkModeManager,
        initVideoCarousel,
        initEllipticalCarousel,
        initDarkMode,
        playVideo,
        initWorldSectionIcons
    };
}

window.EllipticalCarousel = EllipticalCarousel;
window.DarkModeManager = DarkModeManager;
window.initEllipticalCarousel = initEllipticalCarousel;
window.initDarkMode = initDarkMode;
window.initVideoCarousel = initVideoCarousel;
window.playVideo = playVideo;
window.initWorldSectionIcons = initWorldSectionIcons;