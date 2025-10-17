(function () {
    'use strict';

    const supportedLanguages = ['en', 'zh', 'ms', 'ru', 'ar', 'fr'];
    let currentLanguage = localStorage.getItem('preferredLanguage') || detectLanguage();
    let dictionary = {};
    const contextPath = (function() {
        try {
            return document.querySelector('meta[name="contextPath"]').content || '';
        } catch (_) {
            return '';
        }
    })();

    function detectLanguage() {
        try {
            const n = (navigator.language || 'en').split('-')[0].toLowerCase();
            return supportedLanguages.includes(n) ? n : 'en';
        } catch (_) {
            return 'en';
        }
    }

    function setLanguageDirection() {
        const isRtl = currentLanguage === 'ar';
        document.documentElement.lang = currentLanguage;
        document.documentElement.dir = isRtl ? 'rtl' : 'ltr';
        // Support both legacy and new RTL body classes
        document.body.classList.toggle('rtl', isRtl);
        document.body.classList.toggle('rtl-active', isRtl);
    }

    function translate(key, fallback) {
        return Object.prototype.hasOwnProperty.call(dictionary, key) ? dictionary[key] : (fallback ?? key);
    }

    function applyTranslations(root = document) {
        // Support new data-i18n and legacy data-translate
        root.querySelectorAll('[data-i18n], [data-translate]').forEach(function (el) {
            const key = el.getAttribute('data-i18n') || el.getAttribute('data-translate');
            const attrSpec = el.getAttribute('data-i18n-attr');
            const i18nType = el.getAttribute('data-i18n-type');
            const value = translate(key, el.textContent);
            if (attrSpec) {
                // If attrSpec looks like a JSON map, set multiple attributes; otherwise treat as single attribute name
                const isJsonMap = attrSpec.trim().startsWith('{');
                if (isJsonMap) {
                    try {
                        const map = JSON.parse(attrSpec);
                        Object.keys(map).forEach(function (attrName) {
                            const attrKey = map[attrName];
                            const translatedValue = translate(attrKey, el.getAttribute(attrName));
                            console.log('i18n debug:', attrName, attrKey, translatedValue);
                            el.setAttribute(attrName, translatedValue);
                        });
                    } catch (e) {
                        console.error('i18n JSON parse error:', e, attrSpec);
                        el.setAttribute(attrSpec, value);
                    }
                } else {
                    el.setAttribute(attrSpec, value);
                }
            } else {
                if (el.classList.contains('highlight-tags') || i18nType === 'list') {
                    el.innerHTML = ''; // Clear existing tags
                    const items = value.split(',');
                    const isHighlight = el.classList.contains('highlight-tags');
                    const isInclusion = el.classList.contains('inclusions-list');

                    items.forEach(itemText => {
                        if (itemText.trim()) {
                            if (isHighlight) {
                                const span = document.createElement('span');
                                span.className = 'badge bg-light text-dark';
                                span.textContent = itemText.trim();
                                el.appendChild(span);
                            } else if (isInclusion) {
                                const div = document.createElement('div');
                                div.className = 'inclusion-item';
                                const icon = document.createElement('i');
                                icon.setAttribute('data-lucide', 'check');
                                icon.className = 'text-success me-2';
                                const span = document.createElement('span');
                                span.textContent = itemText.trim();
                                div.appendChild(icon);
                                div.appendChild(span);
                                el.appendChild(div);
                            } else {
                                // Default list item rendering if needed
                                const li = document.createElement('li');
                                li.textContent = itemText.trim();
                                el.appendChild(li);
                            }
                        }
                    });
                    if (typeof lucide !== 'undefined' && isInclusion) {
                        try { lucide.createIcons(); } catch (e) { console.error(e); }
                    }
                } else if (i18nType === 'html') {
                    // Support HTML content for elements with data-i18n-type="html"
                    el.innerHTML = value;
                } else {
                    el.textContent = value;
                }
            }
        });

        // Placeholder legacy support: data-translate-placeholder
        root.querySelectorAll('[data-translate-placeholder]').forEach(function (el) {
            const key = el.getAttribute('data-translate-placeholder');
            el.setAttribute('placeholder', translate(key, el.getAttribute('placeholder')));
        });
    }

    async function loadLanguage(target) {
        const lang = (target || 'en').toLowerCase();
        const normalized = supportedLanguages.includes(lang) ? lang : 'en';
        const url = contextPath + '/i18n/' + normalized + '.json';
        const fetchUrl = url + '?v=' + Date.now(); // bust caches to avoid stale/garbled content
        try {
            let res = await fetch(fetchUrl, { cache: 'no-store' });
            if (!res.ok) {
                // fallback to EN
                res = await fetch(contextPath + '/i18n/en.json?v=' + Date.now(), { cache: 'no-store' });
                currentLanguage = 'en';
        } else {
            currentLanguage = normalized;
        }
        dictionary = await res.json();
        // Apply translations after successful language load
        setLanguageDirection();
        applyTranslations();
    } catch (e) {
        // network or parsing failure → keep dictionary empty, set language but don't break UI
        console.error('i18n load failed:', e);
        currentLanguage = normalized;
        // Still apply translations even if language load failed
        setLanguageDirection();
        applyTranslations();
    }
    localStorage.setItem('preferredLanguage', currentLanguage);
    document.dispatchEvent(new CustomEvent('languageChanged', { detail: { language: currentLanguage } }));
    }

    // Expose API
    const I18nAPI = {
        init: async function() {
            try {
                await loadLanguage(currentLanguage);
            } catch (e) {
                console.warn('I18n initialization failed:', e);
                setLanguageDirection();
                applyTranslations();
            }
        },
        setLanguage: loadLanguage,
        t: translate,
        apply: applyTranslations,
        getLanguage: function () { return currentLanguage; },
        supported: supportedLanguages
    };

    // Expose globally for legacy support
    window.I18n = I18nAPI;

    // Auto-init for non-module usage
    if (typeof module === 'undefined') {
        // Wait for DOM to be ready before initializing
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', function() {
                loadLanguage(currentLanguage);
            });
        } else {
            // DOM is already ready
            loadLanguage(currentLanguage);
        }
    }

    // Export for ES6 modules
    if (typeof module !== 'undefined' && module.exports) {
        module.exports = I18nAPI;
    }
    if (typeof window !== 'undefined') {
        window.I18n = I18nAPI;
    }
})();


