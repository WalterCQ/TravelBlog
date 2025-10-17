/**
 * MODERN BOOKING PAGE - ENHANCED JAVASCRIPT
 * Implements best practices for conversion optimization and UX
 * - Smart form validation with real-time feedback
 * - Auto-save functionality
 * - Dynamic price calculation
 * - Promo code system
 * - Smooth step transitions
 * - Accessibility features
 */

class BookingManager {
    constructor() {
        this.currentStep = 1;
        this.totalSteps = 4;
        this.isSubmitting = false;
        this.formData = this.loadSavedData();
        this.validationRules = {
            required: (value) => value && value.trim() !== '',
            email: (value) => /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(value),
            phone: (value) => /^[\d\s\-\+\(\)]+$/.test(value) && value.replace(/\D/g, '').length >= 10,
            minLength: (value, min) => value.length >= min,
            futureDate: (value) => new Date(value) > new Date()
        };
        
        this.promoCodes = {
            'WELCOME10': { type: 'percentage', value: 10, description: '10% Welcome Discount' },
            'SUMMER25': { type: 'percentage', value: 25, description: '25% Summer Special' },
            'FAMILY50': { type: 'fixed', value: 50, description: 'RM50 Family Package Discount' }
        };
        
        this.init();
    }

    init() {
        this.bindEvents();
        this.restoreFormData();
        this.calculatePrice();
        this.setMinDate();
        this.initCharCounter();
        
        // Auto-select package from URL and advance to step 2
        const urlParams = new URLSearchParams(window.location.search);
        const packageId = urlParams.get('package') || urlParams.get('packageId') || urlParams.get('travelPackage');
        if (packageId) {
            console.log('Auto-selected package ID:', packageId);
            
            // Check if package is pre-selected from server
            const selectedPackage = document.getElementById('packageId');
            if (selectedPackage) {
                if (!selectedPackage.value) {
                    selectedPackage.value = packageId;
                }
                // Auto-advance to step 2 after a short delay
                setTimeout(() => {
                    this.currentStep = 2;
                    this.updateStepDisplay();
                    window.scrollTo({ top: 0, behavior: 'smooth' });
                    console.log('Auto-advanced to step 2');
                }, 500);
            }
        }
        
        console.log('Booking Manager initialized');
    }

    bindEvents() {
        // Navigation buttons
        document.getElementById('nextBtn')?.addEventListener('click', () => this.nextStep());
        document.getElementById('prevBtn')?.addEventListener('click', () => this.prevStep());
        document.getElementById('submitBtn')?.addEventListener('click', (e) => this.handleSubmit(e));

        // Form inputs - validation and auto-save
        const inputs = document.querySelectorAll('.form-input, .form-select, .form-textarea');
        inputs.forEach(input => {
            // Real-time validation
            input.addEventListener('blur', () => this.validateField(input));
            input.addEventListener('input', () => {
                if (input.classList.contains('invalid')) {
                    this.validateField(input);
                }
            });
            
            // Auto-save
            input.addEventListener('change', () => this.saveFormData());
        });

        // Radio buttons validation
        const radioGroups = document.querySelectorAll('input[type="radio"]');
        radioGroups.forEach(radio => {
            radio.addEventListener('change', () => {
                // Validate the entire radio group
                const name = radio.getAttribute('name');
                const group = document.querySelectorAll(`input[name="${name}"]`);
                group.forEach(r => this.validateField(r));
                this.saveFormData();
            });
        });

        // Checkbox validation
        const checkboxes = document.querySelectorAll('input[type="checkbox"]');
        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', () => {
                this.validateField(checkbox);
                this.saveFormData();
            });
        });

        // Price calculation triggers
        document.getElementById('numberOfParticipants')?.addEventListener('change', () => this.calculatePrice());
        
        // Promo code
        document.getElementById('applyPromoBtn')?.addEventListener('click', () => this.applyPromoCode());
        document.getElementById('promoCode')?.addEventListener('keypress', (e) => {
            if (e.key === 'Enter') {
                e.preventDefault();
                this.applyPromoCode();
            }
        });

        // Form submission
        const form = document.getElementById('bookingForm');
        if (form) {
            form.addEventListener('submit', (e) => this.handleSubmit(e));
        }
    }

    /* ============================================================
       STEP NAVIGATION
       ============================================================ */

    nextStep() {
        // Validate current step before proceeding
        if (!this.validateCurrentStep()) {
            this.showCriticalValidationError();
            this.focusFirstErrorInStep();
            return;
        }

        // Additional validation for specific steps
        if (this.currentStep === 1) {
            // Ensure package is selected and price is calculated
            const packageId = document.getElementById('packageId');
            if (!packageId || !packageId.value) {
                this.showStepValidationErrors(['Please select a travel package first']);
                return;
            }
            this.calculatePrice(); // Recalculate price before proceeding
        }

        if (this.currentStep < this.totalSteps) {
            this.currentStep++;
            this.updateStepDisplay();
            
            // Update confirmation summary on step 4
            if (this.currentStep === 4) {
                this.populateConfirmationSummary();
            }
            
            // Scroll to top smoothly
            window.scrollTo({ top: 0, behavior: 'smooth' });
            
            // Show success message for completed steps
            this.showStepCompletionMessage();
        }
    }

    showCriticalValidationError() {
        // Create a critical error banner at the top of the page
        const existingBanner = document.querySelector('.critical-error-banner');
        if (existingBanner) {
            existingBanner.remove();
        }

        const banner = document.createElement('div');
        banner.className = 'critical-error-banner';
        banner.style.cssText = `
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            background: linear-gradient(135deg, #DC2626, #EF4444);
            color: white;
            padding: 1rem;
            text-align: center;
            font-weight: 700;
            font-size: 1.125rem;
            z-index: 10000;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            animation: criticalErrorSlideDown 0.5s ease-out;
        `;
        
        banner.innerHTML = `
            <div style="display: flex; align-items: center; justify-content: center; gap: 0.5rem;">
                <span style="font-size: 1.5rem;">🚨</span>
                <span>Please complete all required fields before proceeding to the next step</span>
                <span style="font-size: 1.5rem;">🚨</span>
            </div>
        `;

        document.body.insertBefore(banner, document.body.firstChild);

        // Add CSS animation if not exists
        if (!document.querySelector('#criticalErrorAnimation')) {
            const style = document.createElement('style');
            style.id = 'criticalErrorAnimation';
            style.textContent = `
                @keyframes criticalErrorSlideDown {
                    0% { transform: translateY(-100%); opacity: 0; }
                    100% { transform: translateY(0); opacity: 1; }
                }
            `;
            document.head.appendChild(style);
        }

        // Auto-remove banner after 5 seconds
        setTimeout(() => {
            if (banner.parentNode) {
                banner.style.animation = 'criticalErrorSlideDown 0.5s ease-out reverse';
                setTimeout(() => banner.remove(), 500);
            }
        }, 5000);

        // Add top padding to body to prevent content overlap
        document.body.style.paddingTop = '80px';
        setTimeout(() => {
            document.body.style.paddingTop = '0';
        }, 5000);
    }

    showStepCompletionMessage() {
        const messages = {
            2: 'Great! Your adventure details are confirmed.',
            3: 'Perfect! Payment method selected.',
            4: 'Almost there! Review your booking details.'
        };

        const message = messages[this.currentStep];
        if (message) {
            const alert = document.createElement('div');
            alert.className = 'alert alert-success';
            alert.setAttribute('role', 'alert');
            alert.innerHTML = `
                <i data-lucide="check-circle"></i>
                <div>
                    <strong>Step ${this.currentStep} Complete!</strong>
                    <p>${message}</p>
                </div>
            `;
            
            const container = document.querySelector('.booking-container');
            if (container) {
                container.insertBefore(alert, container.firstChild);
                
                // Auto-remove alert after 3 seconds
                setTimeout(() => alert.remove(), 3000);
            }

            // Initialize Lucide icons
            if (typeof lucide !== 'undefined') {
                lucide.createIcons();
            }
        }
    }

    prevStep() {
        if (this.currentStep > 1) {
            this.currentStep--;
            this.updateStepDisplay();
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }
    }

    updateStepDisplay() {
        // Hide all step contents
        const stepContents = document.querySelectorAll('.step-content');
        stepContents.forEach(content => {
            content.style.display = 'none';
        });
        
        // Show current step content
        const currentContent = document.getElementById(`stepContent${this.currentStep}`);
        if (currentContent) {
            currentContent.style.display = 'block';
        }

        // Update progress indicators
        const steps = document.querySelectorAll('.step');
        steps.forEach((step, index) => {
            step.classList.remove('active', 'completed', 'invalid');
            
            const stepNum = index + 1;
            if (stepNum === this.currentStep) {
                step.classList.add('active');
                // Check if current step has validation errors
                if (!this.validateCurrentStep()) {
                    step.classList.add('invalid');
                }
            } else if (stepNum < this.currentStep) {
                step.classList.add('completed');
            }
        });

        // Update progress bar
        const progressLine = document.getElementById('progressLine');
        if (progressLine) {
            const percentage = ((this.currentStep - 1) / (this.totalSteps - 1)) * 100;
            progressLine.style.width = percentage + '%';
        }

        // Update button visibility and state
        const prevBtn = document.getElementById('prevBtn');
        const nextBtn = document.getElementById('nextBtn');
        const submitBtn = document.getElementById('submitBtn');

        if (prevBtn) prevBtn.style.display = this.currentStep > 1 ? 'inline-flex' : 'none';
        if (nextBtn) {
            nextBtn.style.display = this.currentStep < this.totalSteps ? 'inline-flex' : 'none';
            // Disable next button if current step is invalid
            nextBtn.disabled = !this.validateCurrentStep();
        }
        if (submitBtn) {
            submitBtn.style.display = this.currentStep === this.totalSteps ? 'inline-flex' : 'none';
            // Disable submit button if form is invalid
            submitBtn.disabled = !this.validateEntireForm();
        }

        // Update ARIA attributes
        const progressContainer = document.querySelector('.progress-steps');
        if (progressContainer) {
            progressContainer.setAttribute('aria-valuenow', this.currentStep);
        }
    }

    /* ============================================================
       FORM VALIDATION
       ============================================================ */

    validateCurrentStep() {
        const stepContent = document.getElementById(`stepContent${this.currentStep}`);
        if (!stepContent) return true;

        let allValid = true;
        let validationErrors = [];

        // Step-specific validation
        switch (this.currentStep) {
            case 1:
                allValid = this.validateStep1(validationErrors);
                break;
            case 2:
                allValid = this.validateStep2(validationErrors);
                break;
            case 3:
                allValid = this.validateStep3(validationErrors);
                break;
            case 4:
                allValid = this.validateStep4(validationErrors);
                break;
        }

        // Show specific validation errors if any
        if (!allValid && validationErrors.length > 0) {
            this.showStepValidationErrors(validationErrors);
        }

        return allValid;
    }

    validateStep1(errors) {
        let isValid = true;

        // Check if package is selected
        const packageId = document.getElementById('packageId');
        if (!packageId || !packageId.value) {
            errors.push('Please select a travel package');
            isValid = false;
        }

        // Validate departure date
        const departureDate = document.getElementById('departureDate');
        if (!departureDate || !departureDate.value) {
            errors.push('Please select a departure date');
            isValid = false;
        } else if (!this.validationRules.futureDate(departureDate.value)) {
            errors.push('Please select a future date');
            isValid = false;
        }

        // Validate number of participants
        const participants = document.getElementById('numberOfParticipants');
        if (!participants || !participants.value) {
            errors.push('Please select number of travelers');
            isValid = false;
        } else if (parseInt(participants.value) < 1 || parseInt(participants.value) > 10) {
            errors.push('Number of travelers must be between 1 and 10');
            isValid = false;
        }

        return isValid;
    }

    validateStep2(errors) {
        let isValid = true;

        // Validate customer name
        const customerName = document.getElementById('customerName');
        if (!customerName || !customerName.value.trim()) {
            errors.push('Please enter your full name');
            isValid = false;
        } else if (customerName.value.trim().length < 3) {
            errors.push('Full name must be at least 3 characters');
            isValid = false;
        }

        // Validate email
        const customerEmail = document.getElementById('customerEmail');
        if (!customerEmail || !customerEmail.value.trim()) {
            errors.push('Please enter your email address');
            isValid = false;
        } else if (!this.validationRules.email(customerEmail.value)) {
            errors.push('Please enter a valid email address');
            isValid = false;
        }

        // Validate phone
        const customerPhone = document.getElementById('customerPhone');
        if (!customerPhone || !customerPhone.value.trim()) {
            errors.push('Please enter your phone number');
            isValid = false;
        } else if (!this.validationRules.phone(customerPhone.value)) {
            errors.push('Please enter a valid phone number');
            isValid = false;
        }

        // Validate nationality (optional but if provided, should be valid)
        const nationality = document.getElementById('nationality');
        if (nationality && nationality.value && nationality.value === 'OTHER') {
            // Could add additional validation for "Other" option
        }

        return isValid;
    }

    validateStep3(errors) {
        let isValid = true;

        // Validate payment method selection
        const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked');
        if (!paymentMethod) {
            errors.push('Please select a payment method');
            isValid = false;
        }

        // Validate terms acceptance
        const agreeTerms = document.getElementById('agreeTerms');
        if (!agreeTerms || !agreeTerms.checked) {
            errors.push('You must agree to the Terms & Conditions');
            isValid = false;
        }

        return isValid;
    }

    validateStep4(errors) {
        // Step 4 is confirmation, no additional validation needed
        // But we can double-check that all previous steps are still valid
        let isValid = true;

        // Re-validate all previous steps
        const originalStep = this.currentStep;
        
        for (let step = 1; step <= 3; step++) {
            this.currentStep = step;
            if (!this.validateCurrentStep()) {
                isValid = false;
                errors.push(`Step ${step} validation failed`);
            }
        }
        
        this.currentStep = originalStep;
        return isValid;
    }

    showStepValidationErrors(errors) {
        // Remove existing validation alerts
        const existingAlert = document.querySelector('.alert-error');
        if (existingAlert) {
            existingAlert.remove();
        }

        const alert = document.createElement('div');
        alert.className = 'alert alert-error';
        alert.setAttribute('role', 'alert');
        alert.style.zIndex = '9999';
        alert.innerHTML = `
            <i data-lucide="alert-triangle" style="font-size: 1.5rem; color: var(--error-color);"></i>
            <div style="flex: 1;">
                <strong style="font-size: 1.125rem; color: #991B1B;">⚠️ Please fix the following issues:</strong>
                <ul style="margin: 0.75rem 0 0 1.5rem; padding: 0; font-size: 1rem;">
                    ${errors.map(error => `<li style="margin-bottom: 0.5rem; font-weight: 600;">❌ ${error}</li>`).join('')}
                </ul>
            </div>
        `;
        
        const container = document.querySelector('.booking-container');
        if (container) {
            container.insertBefore(alert, container.firstChild);
            
            // Add shake animation to the alert
            alert.style.animation = 'errorPulse 2s ease-in-out infinite, shake 0.5s ease-in-out';
            
            // Scroll to alert with smooth behavior
            alert.scrollIntoView({ 
                behavior: 'smooth', 
                block: 'center',
                inline: 'nearest'
            });
            
            // Auto-remove alert after 10 seconds
            setTimeout(() => {
                if (alert.parentNode) {
                    alert.style.animation = 'fadeOut 0.5s ease-out';
                    setTimeout(() => alert.remove(), 500);
                }
            }, 10000);
        }

        // Initialize Lucide icons for the new alert
        if (typeof lucide !== 'undefined') {
            lucide.createIcons();
        }

        // Add fadeOut animation to CSS if not exists
        if (!document.querySelector('#fadeOutAnimation')) {
            const style = document.createElement('style');
            style.id = 'fadeOutAnimation';
            style.textContent = `
                @keyframes fadeOut {
                    0% { opacity: 1; transform: scale(1); }
                    100% { opacity: 0; transform: scale(0.95); }
                }
            `;
            document.head.appendChild(style);
        }
    }

    validateField(input) {
        const formGroup = input.closest('.form-group');
        if (!formGroup) return true;

        const validationRules = input.getAttribute('data-validation');
        const inputType = (input.getAttribute('type') || input.type || '').toLowerCase();
        const value = (inputType === 'checkbox' || inputType === 'radio') ? input.value : (input.value || '').trim();
        let isValid = true;
        let errorMessage = '';

        // Skip validation for non-required empty fields
        if (inputType !== 'checkbox' && inputType !== 'radio' && !input.hasAttribute('required') && value === '') {
            this.markFieldAsValid(input, formGroup);
            return true;
        }

        // Required validation
        if (input.hasAttribute('required')) {
            if (inputType === 'checkbox') {
                if (!input.checked) {
                    isValid = false;
                    errorMessage = 'This field is required';
                }
            } else if (inputType === 'radio') {
                const name = input.getAttribute('name');
                const form = input.form || document.getElementById('bookingForm');
                const checked = form ? form.querySelector(`input[name="${name}"]:checked`) : null;
                if (!checked) {
                    isValid = false;
                    errorMessage = 'Please select an option';
                }
            } else if (!this.validationRules.required(value)) {
                isValid = false;
                errorMessage = `${input.getAttribute('placeholder') || 'This field'} is required`;
            }
        }

        // Additional validation rules
        if (validationRules && isValid) {
            const rules = validationRules.split('|');
            
            for (const rule of rules) {
                const [ruleName, param] = rule.split(':');
                
                switch (ruleName) {
                    case 'email':
                        if (!this.validationRules.email(value)) {
                            isValid = false;
                            errorMessage = 'Please enter a valid email address';
                        }
                        break;
                    case 'phone':
                        if (!this.validationRules.phone(value)) {
                            isValid = false;
                            errorMessage = 'Please enter a valid phone number';
                        }
                        break;
                    case 'minLength':
                        if (!this.validationRules.minLength(value, parseInt(param))) {
                            isValid = false;
                            errorMessage = `Minimum ${param} characters required`;
                        }
                        break;
                    case 'futureDate':
                        if (!this.validationRules.futureDate(value)) {
                            isValid = false;
                            errorMessage = 'Please select a future date';
                        }
                        break;
                }
            }
        }

        if (isValid) {
            this.markFieldAsValid(input, formGroup);
        } else {
            this.markFieldAsInvalid(input, formGroup, errorMessage);
        }

        return isValid;
    }

    focusFirstErrorInStep() {
        const stepContent = document.getElementById(`stepContent${this.currentStep}`);
        if (!stepContent) return;
        // Try to find the first explicitly invalid element
        const firstInvalid = stepContent.querySelector('.invalid, [aria-invalid="true"], .form-group.has-error input, .form-group.has-error select, .form-group.has-error textarea');
        if (firstInvalid && firstInvalid.scrollIntoView) {
            firstInvalid.scrollIntoView({ behavior: 'smooth', block: 'center' });
            if (typeof firstInvalid.focus === 'function') {
                setTimeout(() => firstInvalid.focus(), 300);
            }
        }
    }

    markFieldAsValid(input, formGroup) {
        input.classList.remove('invalid');
        input.classList.add('valid');
        formGroup.classList.remove('has-error');
    }

    markFieldAsInvalid(input, formGroup, message) {
        input.classList.remove('valid');
        input.classList.add('invalid');
        formGroup.classList.add('has-error');
        
        const errorElement = formGroup.querySelector('.form-error');
        if (errorElement && message) {
            errorElement.textContent = message;
        }
    }

    showValidationErrors() {
        const alert = document.createElement('div');
        alert.className = 'alert alert-error';
        alert.setAttribute('role', 'alert');
        alert.innerHTML = `
            <i data-lucide="alert-triangle"></i>
            <div>
                <strong>Validation Error</strong>
                <p>Please fill in all required fields correctly.</p>
            </div>
        `;
        
        const container = document.querySelector('.booking-container');
        if (container) {
            container.insertBefore(alert, container.firstChild);
            window.scrollTo({ top: 0, behavior: 'smooth' });
            
            // Auto-remove alert after 5 seconds
            setTimeout(() => alert.remove(), 5000);
        }
    }

    /* ============================================================
       PRICE CALCULATION
       ============================================================ */

    calculatePrice() {
        const packagePriceInput = document.getElementById('packageId');
        const travelersSelect = document.getElementById('numberOfParticipants');
        
        if (!packagePriceInput) return;

        const basePrice = parseFloat(packagePriceInput.getAttribute('data-price')) || 0;
        const travelers = parseInt(travelersSelect?.value || '1');
        
        const subtotal = basePrice * travelers;
        const taxRate = 0.06; // 6% tax
        const tax = subtotal * taxRate;
        
        // Apply discount if any
        const discountAmount = this.calculateDiscount(subtotal);
        
        const total = subtotal + tax - discountAmount;

        // Update display
        this.updatePriceDisplay({
            basePrice: basePrice.toFixed(2),
            travelers: travelers,
            subtotal: subtotal.toFixed(2),
            tax: tax.toFixed(2),
            discount: discountAmount.toFixed(2),
            total: total.toFixed(2)
        });

        // Update hidden total price for server submission
        const totalPriceHidden = document.getElementById('totalPriceHidden');
        if (totalPriceHidden) {
            totalPriceHidden.value = total.toFixed(2);
        }
    }

    updatePriceDisplay(prices) {
        // Update all price elements
        const elements = {
            'basePackagePrice': prices.basePrice,
            'travelersCount': prices.travelers,
            'subtotalPrice': prices.subtotal,
            'taxPrice': prices.tax,
            'discountAmount': prices.discount,
            'totalAmount': prices.total
        };

        Object.entries(elements).forEach(([id, value]) => {
            const element = document.getElementById(id);
            if (element) {
                element.textContent = value;
            }
        });

        // Show/hide discount row
        const discountRow = document.getElementById('discountRow');
        if (discountRow) {
            discountRow.style.display = parseFloat(prices.discount) > 0 ? 'flex' : 'none';
        }
    }

    /* ============================================================
       PROMO CODE SYSTEM
       ============================================================ */

    applyPromoCode() {
        const promoInput = document.getElementById('promoCode');
        const promoMessage = document.getElementById('promoMessage');
        
        if (!promoInput || !promoMessage) return;

        const code = promoInput.value.trim().toUpperCase();
        
        if (!code) {
            this.showPromoMessage('Please enter a promo code', 'error');
            return;
        }

        const promo = this.promoCodes[code];
        
        if (promo) {
            this.appliedPromo = promo;
            this.appliedPromoCode = code;
            this.calculatePrice();
            this.showPromoMessage(`✓ ${promo.description} applied!`, 'success');
            promoInput.disabled = true;
            document.getElementById('applyPromoBtn').textContent = 'Applied';
            document.getElementById('applyPromoBtn').style.background = 'var(--success-color)';
        } else {
            this.showPromoMessage('Invalid promo code', 'error');
        }
    }

    calculateDiscount(subtotal) {
        if (!this.appliedPromo) return 0;

        if (this.appliedPromo.type === 'percentage') {
            return subtotal * (this.appliedPromo.value / 100);
        } else if (this.appliedPromo.type === 'fixed') {
            return Math.min(this.appliedPromo.value, subtotal);
        }
        
        return 0;
    }

    showPromoMessage(message, type) {
        const promoMessage = document.getElementById('promoMessage');
        if (!promoMessage) return;

        promoMessage.textContent = message;
        promoMessage.style.color = type === 'success' ? 'var(--success-color)' : 'var(--error-color)';
        promoMessage.style.fontWeight = '600';
    }

    /* ============================================================
       AUTO-SAVE FUNCTIONALITY
       ============================================================ */

    saveFormData() {
        const form = document.getElementById('bookingForm');
        if (!form) return;

        const formData = new FormData(form);
        const data = {};
        
        formData.forEach((value, key) => {
            data[key] = value;
        });

        try {
            localStorage.setItem('bookingFormData', JSON.stringify(data));
            localStorage.setItem('bookingFormTimestamp', Date.now().toString());
            console.log('Form data auto-saved');
        } catch (e) {
            console.error('Error saving form data:', e);
        }
    }

    loadSavedData() {
        try {
            const savedData = localStorage.getItem('bookingFormData');
            const timestamp = localStorage.getItem('bookingFormTimestamp');
            
            if (savedData && timestamp) {
                const age = Date.now() - parseInt(timestamp);
                const maxAge = 24 * 60 * 60 * 1000; // 24 hours
                
                if (age < maxAge) {
                    return JSON.parse(savedData);
                } else {
                    // Clear old data
                    this.clearSavedData();
                }
            }
        } catch (e) {
            console.error('Error loading saved data:', e);
        }
        
        return {};
    }

    restoreFormData() {
        if (!this.formData || Object.keys(this.formData).length === 0) return;

        Object.entries(this.formData).forEach(([name, value]) => {
            const input = document.querySelector(`[name="${name}"]`);
            if (input && value) {
                input.value = value;
                
                // Trigger change event to recalculate prices
                input.dispatchEvent(new Event('change'));
            }
        });

        console.log('Form data restored from previous session');
    }

    clearSavedData() {
        localStorage.removeItem('bookingFormData');
        localStorage.removeItem('bookingFormTimestamp');
    }

    /* ============================================================
       CONFIRMATION SUMMARY
       ============================================================ */

    populateConfirmationSummary() {
        const packageNameEl = document.querySelector('.package-name');
        const departureDateInput = document.getElementById('departureDate');
        const travelersInput = document.getElementById('numberOfParticipants');
        const nameInput = document.getElementById('customerName');
        const emailInput = document.getElementById('customerEmail');
        const phoneInput = document.getElementById('customerPhone');
        const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked');

        // Populate summary
        const summaryData = {
            'summaryPackageName': packageNameEl?.textContent || 'N/A',
            'summaryDepartureDate': departureDateInput?.value ? this.formatDate(departureDateInput.value) : 'N/A',
            'summaryTravelers': travelersInput?.value ? `${travelersInput.value} ${parseInt(travelersInput.value) === 1 ? 'Person' : 'People'}` : 'N/A',
            'summaryContactName': nameInput?.value || 'N/A',
            'summaryEmail': emailInput?.value || 'N/A',
            'summaryPhone': phoneInput?.value || 'N/A',
            'summaryPaymentMethod': paymentMethod?.nextElementSibling?.querySelector('.payment-name')?.textContent || 'N/A'
        };

        Object.entries(summaryData).forEach(([id, value]) => {
            const element = document.getElementById(id);
            if (element) {
                element.textContent = value;
            }
        });
    }

    formatDate(dateString) {
        const date = new Date(dateString);
        const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
        return date.toLocaleDateString('en-US', options);
    }

    /* ============================================================
       FORM SUBMISSION
       ============================================================ */

    async handleSubmit(e) {
        e.preventDefault();

        // Final validation across entire form (all steps)
        if (!this.validateEntireForm()) {
            this.showValidationErrors();
            return;
        }

        // Check terms acceptance
        const termsCheckbox = document.getElementById('agreeTerms');
        if (termsCheckbox && !termsCheckbox.checked) {
            alert('Please accept the Terms & Conditions to continue.');
            return;
        }

        // Show loading overlay and mark submitting to bypass beforeunload
        this.isSubmitting = true;
        this.showLoading(true);

        try {
            // Submit form
            const form = document.getElementById('bookingForm');
            
            // Add promo code if applied
            if (this.appliedPromoCode) {
                const promoInput = document.createElement('input');
                promoInput.type = 'hidden';
                promoInput.name = 'appliedPromoCode';
                promoInput.value = this.appliedPromoCode;
                form.appendChild(promoInput);
            }

            // Clear saved data on successful submission
            this.clearSavedData();
            
            // Submit the form (standard POST)
            form.submit();

            // Fallback: if still on this page after 10s, try AJAX submission
            setTimeout(() => {
                // If the overlay is still visible and page hasn't navigated, use AJAX fallback
                const overlay = document.getElementById('loadingOverlay');
                if (overlay && getComputedStyle(overlay).display !== 'none') {
                    console.warn('Form submission seems stuck, attempting AJAX fallback...');
                    this.submitViaAjaxFallback();
                }
            }, 10000);
            
        } catch (error) {
            console.error('Submission error:', error);
            this.isSubmitting = false;
            this.showLoading(false);
            alert('An error occurred while processing your booking. Please try again.');
        }
    }

    submitViaAjaxFallback() {
        try {
            const form = document.getElementById('bookingForm');
            if (!form) return;

            const getValue = (selector) => document.querySelector(selector)?.value || '';
            const getRadio = (name) => document.querySelector(`input[name="${name}"]:checked`)?.value || '';

            const data = {
                packageId: getValue('#packageId') || new URLSearchParams(window.location.search).get('package'),
                customerName: getValue('#customerName'),
                customerEmail: getValue('#customerEmail'),
                customerPhone: getValue('#customerPhone'),
                numberOfParticipants: getValue('#numberOfParticipants') || '1',
                departureDate: getValue('#departureDate'),
                returnDate: getValue('#returnDate') || '',
                specialRequests: getValue('#specialRequests') || '',
                emergencyContact: getValue('#emergencyContact') || '',
                emergencyPhone: getValue('#emergencyPhone') || '',
                totalPrice: document.getElementById('totalPriceHidden')?.value || '0.00',
                paymentMethod: getRadio('paymentMethod') || 'FPX',
                cardNumber: getValue('#cardNumber') || '',
                cardHolder: getValue('#cardHolder') || '',
                expiryDate: getValue('#expiryDate') || '',
                cvv: getValue('#cvv') || ''
            };

            fetch('/booking/submit-with-payment-ajax', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data)
            })
            .then(res => res.json())
            .then(json => {
                if (json && json.redirectUrl) {
                    window.location.href = json.redirectUrl;
                } else if (json && json.message) {
                    this.isSubmitting = false;
                    this.showLoading(false);
                    alert(json.message);
                } else {
                    this.isSubmitting = false;
                    this.showLoading(false);
                    alert('Submission failed. Please try again.');
                }
            })
            .catch(err => {
                console.error('AJAX fallback error:', err);
                this.isSubmitting = false;
                this.showLoading(false);
                alert('Network error. Please try again.');
            });
        } catch (e) {
            console.error('AJAX fallback exception:', e);
            this.isSubmitting = false;
            this.showLoading(false);
        }
    }

    // Validate all required fields across the entire form, not just current step
    validateEntireForm() {
        const form = document.getElementById('bookingForm');
        if (!form) return true;

        const inputs = form.querySelectorAll('[required], [data-validation]');
        let allValid = true;

        inputs.forEach(input => {
            if (!this.validateField(input)) {
                allValid = false;
            }
        });

        return allValid;
    }

    showLoading(show) {
        const overlay = document.getElementById('loadingOverlay');
        if (overlay) {
            overlay.style.display = show ? 'flex' : 'none';
        }
    }

    /* ============================================================
       UTILITY FUNCTIONS
       ============================================================ */

    setMinDate() {
        const departureDateInput = document.getElementById('departureDate');
        if (departureDateInput) {
            const tomorrow = new Date();
            tomorrow.setDate(tomorrow.getDate() + 1);
            const minDate = tomorrow.toISOString().split('T')[0];
            departureDateInput.setAttribute('min', minDate);
        }
    }

    initCharCounter() {
        const textarea = document.getElementById('specialRequests');
        const charCount = document.getElementById('charCount');
        
        if (textarea && charCount) {
            textarea.addEventListener('input', () => {
                charCount.textContent = textarea.value.length;
            });
        }
    }
}

// Initialize when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    window.bookingManager = new BookingManager();
});

// Warn before leaving with unsaved changes
window.addEventListener('beforeunload', (e) => {
    const form = document.getElementById('bookingForm');
    // Skip warning during active submission
    if (window.bookingManager && window.bookingManager.isSubmitting) {
        return;
    }
    if (form && form.querySelector('.valid')) {
        e.preventDefault();
        e.returnValue = '';
        return 'You have unsaved changes. Are you sure you want to leave?';
    }
});

