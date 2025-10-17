/**
 * MyTour Global - Profile Page JavaScript (2025)
 * Modern Interactive Features & Form Validation
 */

// ============================================
// Document Ready
// ============================================
document.addEventListener('DOMContentLoaded', function() {
    initializeProfilePage();
});

// ============================================
// Initialize All Features
// ============================================
function initializeProfilePage() {
    initPasswordToggle();
    initPasswordStrength();
    initFormValidation();
    initAutoSave();
    initPreferences();
    initAnimations();
}

// ============================================
// Password Toggle Visibility
// ============================================
function initPasswordToggle() {
    const toggleButtons = document.querySelectorAll('.password-toggle');
    
    toggleButtons.forEach(button => {
        button.addEventListener('click', function() {
            const targetId = this.getAttribute('data-target');
            const passwordInput = document.getElementById(targetId);
            const icon = this.querySelector('i');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                icon.setAttribute('data-lucide', 'eye-off');
                if (typeof lucide !== 'undefined') lucide.createIcons();
            } else {
                passwordInput.type = 'password';
                icon.setAttribute('data-lucide', 'eye');
                if (typeof lucide !== 'undefined') lucide.createIcons();
            }
        });
    });
}

// ============================================
// Password Strength Indicator
// ============================================
function initPasswordStrength() {
    const newPasswordInput = document.getElementById('newPassword');
    const confirmPasswordInput = document.getElementById('confirmPassword');
    
    if (newPasswordInput) {
        newPasswordInput.addEventListener('input', function() {
            const password = this.value;
            const strength = calculatePasswordStrength(password);
            displayPasswordStrength(strength);
        });
    }
    
    if (confirmPasswordInput) {
        confirmPasswordInput.addEventListener('input', function() {
            validatePasswordMatch();
        });
    }
}

function calculatePasswordStrength(password) {
    let strength = 0;
    
    if (password.length >= 6) strength += 1;
    if (password.length >= 10) strength += 1;
    if (/[a-z]/.test(password)) strength += 1;
    if (/[A-Z]/.test(password)) strength += 1;
    if (/[0-9]/.test(password)) strength += 1;
    if (/[^a-zA-Z0-9]/.test(password)) strength += 1;
    
    return strength;
}

function displayPasswordStrength(strength) {
    const strengthDiv = document.getElementById('passwordStrength');
    
    if (!strengthDiv) return;
    
    let level, text, className;
    
    if (strength <= 2) {
        level = 'weak';
        text = 'Weak Password';
        className = 'text-danger';
    } else if (strength <= 4) {
        level = 'medium';
        text = 'Medium Strength';
        className = 'text-warning';
    } else {
        level = 'strong';
        text = 'Strong Password';
        className = 'text-success';
    }
    
    strengthDiv.className = `password-strength ${level}`;
    strengthDiv.innerHTML = `<small class="${className} fw-bold">${text}</small>`;
}

function validatePasswordMatch() {
    const newPassword = document.getElementById('newPassword');
    const confirmPassword = document.getElementById('confirmPassword');
    
    if (!newPassword || !confirmPassword) return;
    
    if (confirmPassword.value && newPassword.value !== confirmPassword.value) {
        confirmPassword.classList.add('is-invalid');
        return false;
    } else {
        confirmPassword.classList.remove('is-invalid');
        return true;
    }
}

// ============================================
// Form Validation
// ============================================
function initFormValidation() {
    // Profile Form Validation
    const profileForm = document.getElementById('profileForm');
    if (profileForm) {
        profileForm.addEventListener('submit', function(e) {
            if (!validateProfileForm()) {
                e.preventDefault();
                e.stopPropagation();
            }
            this.classList.add('was-validated');
        });
    }
    
    // Password Form Validation
    const passwordForm = document.getElementById('passwordForm');
    if (passwordForm) {
        passwordForm.addEventListener('submit', function(e) {
            if (!validatePasswordForm()) {
                e.preventDefault();
                e.stopPropagation();
            }
            this.classList.add('was-validated');
        });
    }
    
    // Real-time email validation
    const emailInput = document.getElementById('email');
    if (emailInput) {
        emailInput.addEventListener('blur', function() {
            validateEmail(this.value);
        });
    }
}

function validateProfileForm() {
    const firstName = document.getElementById('firstName').value.trim();
    const lastName = document.getElementById('lastName').value.trim();
    const email = document.getElementById('email').value.trim();
    
    let isValid = true;
    
    if (!firstName || firstName.length < 2) {
        showFieldError('firstName', 'First name must be at least 2 characters');
        isValid = false;
    }
    
    if (!lastName || lastName.length < 2) {
        showFieldError('lastName', 'Last name must be at least 2 characters');
        isValid = false;
    }
    
    if (!validateEmail(email)) {
        isValid = false;
    }
    
    return isValid;
}

function validatePasswordForm() {
    const currentPassword = document.getElementById('currentPassword').value;
    const newPassword = document.getElementById('newPassword').value;
    const confirmPassword = document.getElementById('confirmPassword').value;
    
    let isValid = true;
    
    if (!currentPassword) {
        showFieldError('currentPassword', 'Current password is required');
        isValid = false;
    }
    
    if (!newPassword || newPassword.length < 6) {
        showFieldError('newPassword', 'New password must be at least 6 characters');
        isValid = false;
    }
    
    if (newPassword !== confirmPassword) {
        showFieldError('confirmPassword', 'Passwords do not match');
        isValid = false;
    }
    
    return isValid;
}

function validateEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const emailInput = document.getElementById('email');
    
    if (!emailRegex.test(email)) {
        if (emailInput) {
            emailInput.classList.add('is-invalid');
        }
        return false;
    } else {
        if (emailInput) {
            emailInput.classList.remove('is-invalid');
            emailInput.classList.add('is-valid');
        }
        return true;
    }
}

function showFieldError(fieldId, message) {
    const field = document.getElementById(fieldId);
    if (field) {
        field.classList.add('is-invalid');
        const feedback = field.nextElementSibling;
        if (feedback && feedback.classList.contains('invalid-feedback')) {
            feedback.textContent = message;
        }
    }
}

// ============================================
// Auto-Save Functionality
// ============================================
function initAutoSave() {
    const profileForm = document.getElementById('profileForm');
    if (!profileForm) return;
    
    const inputs = profileForm.querySelectorAll('input:not([readonly]):not([disabled])');
    
    inputs.forEach(input => {
        input.addEventListener('input', debounce(function() {
            saveFormData();
        }, 1000));
    });
    
    // Load saved data on page load
    loadFormData();
}

function saveFormData() {
    const formData = {
        firstName: document.getElementById('firstName')?.value || '',
        lastName: document.getElementById('lastName')?.value || '',
        email: document.getElementById('email')?.value || '',
        phone: document.getElementById('phone')?.value || '',
        timestamp: new Date().toISOString()
    };
    
    try {
        localStorage.setItem('profileFormData', JSON.stringify(formData));
        showAutoSaveIndicator();
    } catch (e) {
        console.error('Failed to save form data:', e);
    }
}

function loadFormData() {
    try {
        const savedData = localStorage.getItem('profileFormData');
        if (!savedData) return;
        
        const formData = JSON.parse(savedData);
        
        // Check if data is not too old (24 hours)
        const savedTime = new Date(formData.timestamp);
        const now = new Date();
        const hoursDiff = (now - savedTime) / (1000 * 60 * 60);
        
        if (hoursDiff > 24) {
            localStorage.removeItem('profileFormData');
            return;
        }
        
        // Only restore if fields are empty (user hasn't filled them yet)
        const firstNameInput = document.getElementById('firstName');
        if (firstNameInput && !firstNameInput.value) {
            firstNameInput.value = formData.firstName || '';
        }
        
    } catch (e) {
        console.error('Failed to load form data:', e);
    }
}

function showAutoSaveIndicator() {
    // Create or update auto-save indicator
    let indicator = document.getElementById('autoSaveIndicator');
    
    if (!indicator) {
        indicator = document.createElement('div');
        indicator.id = 'autoSaveIndicator';
        indicator.style.cssText = `
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: linear-gradient(135deg, #28a745, #34d058);
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            box-shadow: 0 4px 16px rgba(0,0,0,0.2);
            z-index: 9999;
            font-size: 14px;
            font-weight: 600;
            opacity: 0;
            transition: opacity 0.3s ease;
        `;
        indicator.innerHTML = '<i data-lucide="check-circle" class="me-2"></i>Changes saved';
        if (typeof lucide !== 'undefined') lucide.createIcons();
        document.body.appendChild(indicator);
    }
    
    indicator.style.opacity = '1';
    
    setTimeout(() => {
        indicator.style.opacity = '0';
    }, 2000);
}

// ============================================
// Preferences Management
// ============================================
function initPreferences() {
    loadPreferences();
    
    // Theme preference
    const themeButtons = document.querySelectorAll('input[name="theme"]');
    themeButtons.forEach(button => {
        button.addEventListener('change', function() {
            if (this.checked) {
                applyTheme(this.id);
            }
        });
    });
    
    // Language preference
    const languageSelect = document.getElementById('language');
    if (languageSelect) {
        languageSelect.addEventListener('change', function() {
            savePreference('language', this.value);
        });
    }
    
    // Currency preference
    const currencySelect = document.getElementById('currency');
    if (currencySelect) {
        currencySelect.addEventListener('change', function() {
            savePreference('currency', this.value);
        });
    }
}

function savePreferences() {
    const preferences = {
        theme: document.querySelector('input[name="theme"]:checked')?.id || 'lightTheme',
        emailBooking: document.getElementById('emailBooking')?.checked || false,
        emailPromo: document.getElementById('emailPromo')?.checked || false,
        emailNewsletter: document.getElementById('emailNewsletter')?.checked || false,
        language: document.getElementById('language')?.value || 'English (US)',
        currency: document.getElementById('currency')?.value || 'MYR - Malaysian Ringgit (RM)'
    };
    
    try {
        localStorage.setItem('userPreferences', JSON.stringify(preferences));
        showSuccessMessage('Preferences saved successfully!');
    } catch (e) {
        console.error('Failed to save preferences:', e);
        showErrorMessage('Failed to save preferences');
    }
}

function loadPreferences() {
    try {
        const saved = localStorage.getItem('userPreferences');
        if (!saved) return;
        
        const preferences = JSON.parse(saved);
        
        // Apply theme
        const themeButton = document.getElementById(preferences.theme);
        if (themeButton) {
            themeButton.checked = true;
            applyTheme(preferences.theme);
        }
        
        // Apply notification preferences
        if (document.getElementById('emailBooking')) {
            document.getElementById('emailBooking').checked = preferences.emailBooking;
        }
        if (document.getElementById('emailPromo')) {
            document.getElementById('emailPromo').checked = preferences.emailPromo;
        }
        if (document.getElementById('emailNewsletter')) {
            document.getElementById('emailNewsletter').checked = preferences.emailNewsletter;
        }
        
        // Apply language
        if (document.getElementById('language')) {
            document.getElementById('language').value = preferences.language;
        }
        
        // Apply currency
        if (document.getElementById('currency')) {
            document.getElementById('currency').value = preferences.currency;
        }
        
    } catch (e) {
        console.error('Failed to load preferences:', e);
    }
}

function savePreference(key, value) {
    try {
        const saved = localStorage.getItem('userPreferences');
        const preferences = saved ? JSON.parse(saved) : {};
        preferences[key] = value;
        localStorage.setItem('userPreferences', JSON.stringify(preferences));
    } catch (e) {
        console.error('Failed to save preference:', e);
    }
}

function applyTheme(themeId) {
    // This is a placeholder for theme application
    // In a full implementation, this would change CSS variables or switch stylesheets
    console.log('Applying theme:', themeId);
    savePreference('theme', themeId);
}

// ============================================
// Animations & Effects
// ============================================
function initAnimations() {
    // Animate stat cards on load
    const statItems = document.querySelectorAll('.stat-item');
    statItems.forEach((item, index) => {
        item.style.animationDelay = `${index * 0.1}s`;
    });
    
    // Animate quick action buttons
    const actionButtons = document.querySelectorAll('.action-btn');
    actionButtons.forEach((button, index) => {
        button.style.animationDelay = `${index * 0.05}s`;
    });
    
    // Scroll animations
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('visible');
            }
        });
    }, { threshold: 0.1 });
    
    document.querySelectorAll('.glass-effect').forEach(el => {
        observer.observe(el);
    });
}

// ============================================
// Success/Error Messages
// ============================================
function showSuccessMessage(message) {
    showMessage(message, 'success');
}

function showErrorMessage(message) {
    showMessage(message, 'danger');
}

function showMessage(message, type) {
    const container = document.querySelector('.container.py-5');
    if (!container) return;
    
    const alert = document.createElement('div');
    alert.className = `alert alert-${type} alert-dismissible fade show modern-alert`;
    alert.innerHTML = `
        <i data-lucide="${type === 'success' ? 'check-circle' : 'alert-triangle'}" class="me-2"></i>
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    `;
    
    container.insertBefore(alert, container.firstChild);
    
    // Auto-dismiss after 5 seconds
    setTimeout(() => {
        alert.remove();
    }, 5000);
}

// ============================================
// Utility Functions
// ============================================
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

// ============================================
// Avatar Upload (Placeholder)
// ============================================
document.querySelector('.avatar-edit-btn')?.addEventListener('click', function() {
    // This is a placeholder for avatar upload functionality
    // In a full implementation, this would open a file picker
    alert('Avatar upload feature coming soon!');
});

// ============================================
// Export Functions for Global Access
// ============================================
window.savePreferences = savePreferences;
window.validateEmail = validateEmail;

// ============================================
// Console Welcome Message
// ============================================
console.log('%c👤 MyTour Global Profile Page', 'color: #1e3c72; font-size: 20px; font-weight: bold;');
console.log('%c✨ Modern Interactive Profile Management (2025)', 'color: #4a90e2; font-size: 14px;');

