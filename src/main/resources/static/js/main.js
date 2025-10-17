// i18n integration: use global I18n manager
let currentLanguage = localStorage.getItem('preferredLanguage') || (navigator.language||'en').split('-')[0];

function updatePageTitle() {
    const titleElement = document.querySelector('h1[data-i18n], h1[data-translate]');
    if (!titleElement) return;
    const key = titleElement.getAttribute('data-i18n') || titleElement.getAttribute('data-translate');
    if (window.I18n && typeof window.I18n.t == 'function') {
        const translated = window.I18n.t(key, titleElement.textContent);
        document.title = `${translated} - MyTour Global`;
    }
}

function updateWeatherWidget() {
    const weatherConditions = [
        { icon: 'sun', temp: '28°C', desc: 'home.weather.sunny' },
        { icon: 'cloud', temp: '24°C', desc: 'home.weather.partlyCloudy' },
        { icon: 'cloud', temp: '22°C', desc: 'home.weather.cloudy' },
        { icon: 'cloud-rain', temp: '18°C', desc: 'home.weather.rainy' }
    ];

    const weatherIcon = document.querySelector('.weather-icon i');
    const tempElement = weatherIcon?.nextElementSibling;
    const descElement = tempElement?.nextElementSibling;

    if (weatherIcon && tempElement && descElement) {
        const weather = weatherConditions[Math.floor(Math.random() * weatherConditions.length)];
        weatherIcon.className = `bi ${weather.icon} fs-1 text-warning`;
        tempElement.textContent = weather.temp;
        if (window.I18n && typeof window.I18n.t == 'function') {
            descElement.textContent = window.I18n.t(weather.desc, weather.desc);
        }
    }
}

function smoothScrollTo(elementId) {
    document.getElementById(elementId)?.scrollIntoView({
        behavior: 'smooth',
        block: 'start'
    });
}

function initLazyLoading() {
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                img.src = img.dataset.src;
                img.classList.remove('lazy');
                observer.unobserve(img);
            }
        });
    });

    document.querySelectorAll('img[data-src]').forEach(img => observer.observe(img));
}

function calculateReadingTime() {
    const content = document.querySelector('.content');
    if (!content) return;

    const words = content.textContent.trim().split(/\s+/).length;
    const time = Math.ceil(words / 200);

    const timeElement = document.createElement('div');
    timeElement.className = 'reading-time text-muted small mb-3';
    timeElement.innerHTML = `<i data-lucide="clock" class="me-1"></i>${time} min read`;
    if (typeof lucide !== 'undefined') lucide.createIcons();

    document.querySelector('article header')?.appendChild(timeElement);
}

function shareToSocial(platform) {
    const url = encodeURIComponent(window.location.href);
    const title = encodeURIComponent(document.title);
    const text = encodeURIComponent('Check out this amazing destination!');

    const urls = {
        facebook: `https://www.facebook.com/sharer/sharer.php?u=${url}`,
        twitter: `https://twitter.com/intent/tweet?url=${url}&text=${text}`,
        whatsapp: `https://wa.me/?text=${text}%20${url}`,
        email: `mailto:?subject=${title}&body=${text}%20${url}`
    };

    if (urls[platform]) window.open(urls[platform], '_blank', 'width=600,height=400');
}

function copyToClipboard(e) {
    const shareInput = document.getElementById('shareUrl');
    if (!shareInput) return;

    shareInput.select();

    navigator.clipboard?.writeText(shareInput.value)
        .then(() => showCopySuccess(e.target))
        .catch(() => {
            document.execCommand('copy');
            showCopySuccess(e.target);
        });
}

function showCopySuccess(button) {
    if (!button) return;

    const originalHTML = button.innerHTML;
    button.innerHTML = '<i data-lucide="check"></i>';
    button.classList.replace('btn-outline-secondary', 'btn-success');
    if (typeof lucide !== 'undefined') lucide.createIcons();

    setTimeout(() => {
        button.innerHTML = originalHTML;
        button.classList.replace('btn-success', 'btn-outline-secondary');
    }, 2000);
}

function initScrollProgress() {
    const progressBar = document.createElement('div');
    progressBar.className = 'scroll-progress';
    progressBar.style.cssText = `
        position: fixed;
        top: 0;
        left: 0;
        height: 3px;
        background: linear-gradient(90deg, #007bff, #28a745);
        z-index: 9999;
        transition: width 0.1s ease-out;
    `;

    document.body.appendChild(progressBar);

    window.addEventListener('scroll', () => {
        const height = document.documentElement.scrollHeight - window.innerHeight;
        progressBar.style.width = `${Math.min((window.scrollY / height) * 100, 100)}%`;
    });
}

function initThemeToggle() {
    document.addEventListener('theme-changed', e => {
        updateWeatherForTheme(e.detail);
        updateLanguageSwitcherForTheme(e.detail);
    });

    if (localStorage.getItem('theme') == 'dark') {
        document.body.classList.add('dark-mode');
    }
}

function showAlert(message, type = 'info') {
    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${type} alert-dismissible fade show position-fixed`;
    alertDiv.style.cssText = 'top: 20px; right: 20px; z-index: 9999; min-width: 300px;';

    if (document.body.classList.contains('dark-mode')) {
        alertDiv.style.backgroundColor = '#2d2d2d';
        alertDiv.style.color = '#e0e0e0';
        alertDiv.style.borderColor = '#404040';
    }

    alertDiv.innerHTML = `
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"
            ${document.body.classList.contains('dark-mode') ? 'style="filter: invert(1);"' : ''}></button>
    `;

    document.body.appendChild(alertDiv);

    setTimeout(() => alertDiv.remove(), 5000);
}

function initFormHandling() {
    document.querySelectorAll('form').forEach(form => {
        if (form.id == 'contactForm') return;

        form.addEventListener('submit', function (e) {
            e.preventDefault();
            let isValid = true;

            this.querySelectorAll('[required]').forEach(field => {
                if (!field.value.trim()) {
                    field.classList.add('is-invalid');
                    isValid = false;
                } else {
                    field.classList.remove('is-invalid');
                }
            });

            if (isValid) {
                const message = (window.I18n && typeof window.I18n.t == 'function') ? window.I18n.t('form.thanks', 'Thank you for your message!') : 'Thank you for your message!';
                showAlert(message, 'success');
                this.reset();
            }
        });
    });
}

document.addEventListener('DOMContentLoaded', () => {
    if (window.I18n && typeof window.I18n.setLanguage == 'function') {
        window.I18n.setLanguage(localStorage.getItem('preferredLanguage') || currentLanguage);
    }

    document.querySelectorAll('.lang-btn').forEach(btn => {
        btn.addEventListener('click', (e) => {
            e.preventDefault();
            if (window.I18n && typeof window.I18n.setLanguage === 'function') {
                window.I18n.setLanguage(btn.dataset.lang);
            }
        });
    });

    document.querySelectorAll('[data-share]').forEach(btn => {
        btn.addEventListener('click', (e) => {
            e.preventDefault();
            shareToSocial(btn.dataset.share);
        });
    });

    const copyBtn = document.getElementById('copyButton');
    if (copyBtn) {
        copyBtn.addEventListener('click', e => copyToClipboard(e));
    }

    initFormHandling();
    initLazyLoading();
    initScrollProgress();
    initThemeToggle();
    calculateReadingTime();

    [...document.querySelectorAll('[data-bs-toggle="tooltip"]')].forEach(
        el => new bootstrap.Tooltip(el)
    );

    [...document.querySelectorAll('[data-bs-toggle="popover"]')].forEach(
        el => new bootstrap.Popover(el)
    );

    updateWeatherWidget();
    setInterval(updateWeatherWidget, 300000);
});

window.MyTourApp = {
    setLanguage: function(lang){ if (window.I18n) window.I18n.setLanguage(lang); },
    shareToSocial,
    copyToClipboard,
    smoothScrollTo,
    showAlert
};