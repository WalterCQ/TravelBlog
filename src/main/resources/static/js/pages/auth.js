document.addEventListener('DOMContentLoaded', function() {
    initializeAuthForms();
    initializePasswordToggle();
    initializePasswordStrength();
    initializeFormAnimation();
    
    autoHideAlerts();
});

function initializeAuthForms() {
    const loginForm = document.getElementById('loginForm');
    const registerForm = document.getElementById('registerForm');
    
    if (loginForm) {
        loginForm.addEventListener('submit', handleLoginSubmit);
    }
    
    if (registerForm) {
        registerForm.addEventListener('submit', handleRegisterSubmit);
        
        const passwordField = registerForm.querySelector('#password');
        const confirmPasswordField = registerForm.querySelector('#confirmPassword');
        
        if (passwordField) {
            passwordField.addEventListener('input', checkPasswordStrength);
        }
        
        if (confirmPasswordField) {
            confirmPasswordField.addEventListener('input', checkPasswordMatch);
        }
    }
}

function handleLoginSubmit(event) {
    const form = event.target;
    const submitBtn = form.querySelector('button[type="submit"]');
    const btnText = submitBtn.querySelector('.btn-text');
    const btnSpinner = submitBtn.querySelector('.btn-spinner');
    
    const username = form.querySelector('#username').value.trim();
    const password = form.querySelector('#password').value;
    
    if (!username || !password) {
        event.preventDefault();
        showFormError('Please fill in all required fields');
        return;
    }
    
    submitBtn.disabled = true;
    btnText.classList.add('d-none');
    btnSpinner.classList.remove('d-none');
    
}

function handleRegisterSubmit(event) {
    const form = event.target;
    const submitBtn = form.querySelector('button[type="submit"]');
    const btnText = submitBtn.querySelector('.btn-text');
    const btnSpinner = submitBtn.querySelector('.btn-spinner');
    
    if (!validateRegistrationForm(form)) {
        event.preventDefault();
        return;
    }
    
    submitBtn.disabled = true;
    btnText.classList.add('d-none');
    btnSpinner.classList.remove('d-none');
}

function validateRegistrationForm(form) {
    const username = form.querySelector('#username').value.trim();
    const email = form.querySelector('#email').value.trim();
    const password = form.querySelector('#password').value;
    const confirmPassword = form.querySelector('#confirmPassword').value;
    const firstName = form.querySelector('#firstName').value.trim();
    const lastName = form.querySelector('#lastName').value.trim();
    const termsCheckbox = form.querySelector('#terms');
    
    clearFormErrors();
    
    let isValid = true;
    
    if (!username || username.length < 3 || username.length > 20) {
        showFieldError('#username', 'Username must be between 3 and 20 characters');
        isValid = false;
    } else if (!/^[a-zA-Z0-9_]+$/.test(username)) {
        showFieldError('#username', 'Username can only contain letters, numbers, and underscores');
        isValid = false;
    }
    
    const emailPattern = /^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
    if (!email || !emailPattern.test(email)) {
        showFieldError('#email', 'Please enter a valid email address');
        isValid = false;
    }
    
    if (!password || password.length < 6) {
        showFieldError('#password', 'Password must be at least 6 characters long');
        isValid = false;
    }
    
    if (password != confirmPassword) {
        showFieldError('#confirmPassword', 'Passwords do not match');
        isValid = false;
    }
    
    if (!firstName || firstName.length < 1) {
        showFieldError('#firstName', 'First name is required');
        isValid = false;
    }
    
    if (!lastName || lastName.length < 1) {
        showFieldError('#lastName', 'Last name is required');
        isValid = false;
    }
    
    if (termsCheckbox && !termsCheckbox.checked) {
        showFormError('You must agree to the Terms of Service');
        isValid = false;
    }
    
    return isValid;
}

function initializePasswordToggle() {
    const toggleButtons = document.querySelectorAll('.password-toggle');
    
    toggleButtons.forEach(button => {
        button.addEventListener('click', function() {
            const fieldId = this.parentElement.querySelector('input').id;
            togglePassword(fieldId);
        });
    });
}

function togglePassword(fieldId) {
    const passwordField = document.getElementById(fieldId);
    const eyeIcon = document.getElementById(fieldId + '-eye');
    
    if (passwordField && eyeIcon) {
        if (passwordField.type == 'password') {
            passwordField.type = 'text';
            eyeIcon.setAttribute('data-lucide', 'eye-off');
            if (typeof lucide !== 'undefined') lucide.createIcons();
        } else {
            passwordField.type = 'password';
            eyeIcon.setAttribute('data-lucide', 'eye');
            if (typeof lucide !== 'undefined') lucide.createIcons();
        }
    }
}

function initializePasswordStrength() {
    const passwordField = document.getElementById('password');
    if (passwordField) {
        passwordField.addEventListener('input', checkPasswordStrength);
    }
}

function checkPasswordStrength() {
    const password = this.value;
    const strengthMeter = document.getElementById('passwordStrength');
    
    if (!strengthMeter) return;
    
    if (password.length == 0) {
        strengthMeter.className = 'password-strength';
        return;
    }
    
    let strength = 0;
    
    if (password.length >= 8) strength++;
    if (password.length >= 12) strength++;
    
    if (/[a-z]/.test(password)) strength++;
    if (/[A-Z]/.test(password)) strength++;
    if (/[0-9]/.test(password)) strength++;
    if (/[^A-Za-z0-9]/.test(password)) strength++;
    
    if (strength <= 2) {
        strengthMeter.className = 'password-strength weak';
    } else if (strength <= 4) {
        strengthMeter.className = 'password-strength medium';
    } else {
        strengthMeter.className = 'password-strength strong';
    }
}

function checkPasswordMatch() {
    const password = document.getElementById('password').value;
    const confirmPassword = this.value;
    const matchIndicator = document.getElementById('passwordMatch');
    
    if (!matchIndicator) return;
    
    if (confirmPassword.length == 0) {
        matchIndicator.textContent = '';
        matchIndicator.className = 'password-match';
        return;
    }
    
    if (password == confirmPassword) {
        matchIndicator.textContent = 'Passwords match';
        matchIndicator.className = 'password-match match';
    } else {
        matchIndicator.textContent = 'Passwords do not match';
        matchIndicator.className = 'password-match no-match';
    }
}

function initializeFormAnimation() {
    const authContainer = document.querySelector('.auth-form-container');
    if (authContainer) {
        authContainer.classList.add('fade-in');
    }
    
    const formInputs = document.querySelectorAll('.auth-input');
    formInputs.forEach(input => {
        input.addEventListener('focus', function() {
            this.parentElement.style.transform = 'scale(1.02)';
            this.parentElement.style.transition = 'transform 0.2s ease';
        });
        
        input.addEventListener('blur', function() {
            this.parentElement.style.transform = 'scale(1)';
        });
    });
}

function autoHideAlerts() {
    const alerts = document.querySelectorAll('.auth-alert');
    
    alerts.forEach(alert => {
        setTimeout(() => {
            alert.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
            alert.style.opacity = '0';
            alert.style.transform = 'translateY(-10px)';
            
            setTimeout(() => {
                alert.remove();
            }, 500);
        }, 5000);
    });
}

function showFormError(message) {
    const existingErrors = document.querySelectorAll('.auth-alert.alert-danger');
    existingErrors.forEach(alert => alert.remove());
    
    const alertDiv = document.createElement('div');
    alertDiv.className = 'alert alert-danger auth-alert';
    alertDiv.innerHTML = `
        <i data-lucide="alert-triangle"></i>
        ${message}
    `;
    if (typeof lucide !== 'undefined') lucide.createIcons();
    
    const form = document.querySelector('.auth-form');
    if (form) {
        form.parentNode.insertBefore(alertDiv, form);
    }
    
    setTimeout(() => {
        alertDiv.style.transition = 'opacity 0.5s ease';
        alertDiv.style.opacity = '0';
        setTimeout(() => alertDiv.remove(), 500);
    }, 5000);
}

function showFieldError(fieldSelector, message) {
    const field = document.querySelector(fieldSelector);
    if (!field) return;
    
    field.classList.add('is-invalid');
    
    const existingError = field.parentElement.querySelector('.field-error');
    if (existingError) {
        existingError.remove();
    }
    
    const errorDiv = document.createElement('div');
    errorDiv.className = 'field-error text-danger small mt-1';
    errorDiv.textContent = message;
    
    field.parentElement.appendChild(errorDiv);
    
    field.addEventListener('input', function() {
        this.classList.remove('is-invalid');
        const error = this.parentElement.querySelector('.field-error');
        if (error) {
            error.remove();
        }
    }, { once: true });
}

function clearFormErrors() {
    const invalidFields = document.querySelectorAll('.is-invalid');
    invalidFields.forEach(field => field.classList.remove('is-invalid'));
    
    const errorMessages = document.querySelectorAll('.field-error');
    errorMessages.forEach(error => error.remove());
    
    const errorAlerts = document.querySelectorAll('.auth-alert.alert-danger');
    errorAlerts.forEach(alert => alert.remove());
}

function setupInputInteractions() {
    const inputs = document.querySelectorAll('.auth-input');
    
    inputs.forEach(input => {
        input.addEventListener('focus', function() {
            const icon = this.parentElement.querySelector('.input-icon i');
            if (icon) {
                icon.style.color = '#667eea';
                icon.style.transform = 'scale(1.1)';
            }
        });
        
        input.addEventListener('blur', function() {
            const icon = this.parentElement.querySelector('.input-icon i');
            if (icon) {
                icon.style.color = '#666';
                icon.style.transform = 'scale(1)';
            }
        });
        
        input.addEventListener('input', function() {
            this.classList.remove('is-invalid');
            const errorElement = this.parentElement.querySelector('.field-error');
            if (errorElement) {
                errorElement.remove();
            }
        });
    });
}

document.addEventListener('DOMContentLoaded', setupInputInteractions);