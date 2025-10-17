<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="Customer Feedback - MyTour Malaysia" />
</jsp:include>

<!-- Feedback Page Specific Styles -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/feedback.css">

<jsp:include page="../includes/navigation.jsp">
    <jsp:param name="currentPage" value="feedback" />
</jsp:include>

<div class="container my-5">
    <div class="row">
        <div class="col-lg-8">
            <div class="feedback-form">
                <div class="text-center mb-3">
                    <h3 class="form-title" data-i18n="fb.title">Tell Us Your Travel Story!</h3>
                    <p class="text-muted mb-0" data-i18n="fb.subtitle">Good, bad, or hilarious—we want to hear it all. Your stories help us make adventures even better.</p>
                </div>
                
                <!-- Success Message -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i data-lucide="check-circle" class="me-2"></i>
                        ${successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <!-- Error Message -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i data-lucide="alert-circle" class="me-2"></i>
                        ${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <!-- Welcome Message (User is already logged in to reach this page) -->
                <div class="alert alert-success" role="alert">
                    <i data-lucide="check-circle" class="me-2"></i>
                    <span data-i18n="fb.welcome">Awesome,</span> ${sessionScope.loggedInUser.firstName}! <span data-i18n="fb.welcome.tail">We're all ears. Lay it on us.</span>
                </div>
                
                <form id="feedbackForm" action="${pageContext.request.contextPath}/contact" method="post" novalidate>
                    <!-- Hidden field to identify this as feedback -->
                    <input type="hidden" name="subject" value="Customer Feedback">
                    
                    <!-- Customer Information -->
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                <i data-lucide="user" class="me-2"></i><span data-i18n="fb.fullname">Full Name</span>
                            </label>
                            <input type="text" name="name" id="name" class="form-control"
                                   placeholder="Enter your full name" data-i18n="fb.fullname.placeholder" data-i18n-attr="placeholder" 
                                   value="${sessionScope.loggedInUser.firstName} ${sessionScope.loggedInUser.lastName}"
                                   required>
                            <div class="invalid-feedback"></div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                <i data-lucide="mail" class="me-2"></i><span data-i18n="fb.email">Email Address</span>
                            </label>
                            <input type="email" name="email" id="email" class="form-control"
                                   placeholder="Enter your email address" data-i18n="fb.email.placeholder" data-i18n-attr="placeholder"
                                   value="${sessionScope.loggedInUser.email}"
                                   required>
                            <div class="invalid-feedback"></div>
                        </div>
                    </div>

                    <!-- Travel Details -->
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                <i data-lucide="calendar" class="me-2"></i><span data-i18n="fb.travelDate">When did you travel?</span>
                            </label>
                            <input type="date" name="travelDate" id="travelDate" class="form-control">
                            <div class="invalid-feedback"></div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                <i data-lucide="map-pin" class="me-2"></i><span data-i18n="fb.destination">Where did you explore?</span>
                            </label>
                            <select name="destinationId" id="destinationId" class="form-select">
                                <option value="" data-i18n="fb.destination.select">Select destination</option>
                                <c:forEach var="destination" items="${destinations}">
                                    <option value="${destination.id}">${destination.name}</option>
                                </c:forEach>
                            </select>
                            <div class="invalid-feedback"></div>
                        </div>
                    </div>

                    <!-- Package and Rating -->
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                <i data-lucide="gift" class="me-2"></i><span data-i18n="fb.package">Which adventure was it?</span>
                            </label>
                            <select name="packageId" id="packageId" class="form-select">
                                <option value="" data-i18n="fb.package.select">Select package (optional)</option>
                                <c:forEach var="travelPackage" items="${travelPackages}">
                                    <option value="${travelPackage.id}">${travelPackage.name}</option>
                                </c:forEach>
                            </select>
                            <div class="invalid-feedback"></div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">
                                <i data-lucide="star" class="me-2"></i><span data-i18n="fb.rating">The Vibe Check *</span>
                            </label>
                            <div class="rating-container">
                                <div class="rating-stars" id="ratingStars">
                                    <span class="star" data-rating="1"><i data-lucide="star"></i></span>
                                    <span class="star" data-rating="2"><i data-lucide="star"></i></span>
                                    <span class="star" data-rating="3"><i data-lucide="star"></i></span>
                                    <span class="star" data-rating="4"><i data-lucide="star"></i></span>
                                    <span class="star" data-rating="5"><i data-lucide="star"></i></span>
                                </div>
                                <div class="rating-text" id="ratingText" data-i18n="fb.rating.cta">Click to rate</div>
                            </div>
                            <input type="hidden" name="rating" id="rating" required>
                            <div class="invalid-feedback"></div>
                        </div>
                    </div>

                    <!-- Feedback Content -->
                    <div class="mb-3">
                            <label class="form-label">
                            	<i data-lucide="message-square" class="me-2"></i><span data-i18n="fb.feedback">Spill the Tea... *</span>
                        </label>
                        <textarea name="feedback" id="feedback" class="form-control" rows="5" 
                                      placeholder="How was it? We're ready for the good, the bad, and the 'you won't believe this' moments." data-i18n="fb.feedback.placeholder" data-i18n-attr="placeholder" required></textarea>
                        <div class="char-counter">
                            	<span id="charCount">0</span>/<span data-i18n="fb.feedback.max">1000 characters</span>
                        </div>
                        <div class="invalid-feedback"></div>
                    </div>

                    <!-- Suggestions -->
                    <div class="mb-3">
                            <label class="form-label">
                            	<i data-lucide="lightbulb" class="me-2"></i><span data-i18n="fb.suggest">Got a Bright Idea?</span>
                        </label>
                        <textarea name="suggestions" id="suggestions" class="form-control" rows="3" 
                                      placeholder="If you were us, what would you do differently? Don't be shy!" data-i18n="fb.suggest.placeholder" data-i18n-attr="placeholder"></textarea>
                        <div class="invalid-feedback"></div>
                    </div>

                    <!-- Recommendation -->
                    <div class="mb-3">
                            <label class="form-label">
                                <i data-lucide="thumbs-up" class="me-2"></i><span data-i18n="fb.recommend">Would you tell a friend about us?</span>
                        </label>
                        <div class="recommendation-options">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="recommendation" id="recommend-yes" value="yes">
                                <label class="form-check-label" for="recommend-yes" data-i18n="fb.recommend.yes">
                                    Yes, I'm already shouting from the rooftops!
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="recommendation" id="recommend-maybe" value="maybe">
                                <label class="form-check-label" for="recommend-maybe" data-i18n="fb.recommend.maybe">
                                    Maybe, if they ask nicely.
                                </label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="recommendation" id="recommend-no" value="no">
                                <label class="form-check-label" for="recommend-no" data-i18n="fb.recommend.no">
                                    No, I'm keeping this gem to myself.
                                </label>
                            </div>
                        </div>
                    </div>

                    <!-- Contact Permission -->
                    <div class="contact-permission-section">
                        <div class="contact-permission-check">
                            <input class="form-check-input" type="checkbox" name="allowContact" id="allowContact" value="true">
                            <label class="form-check-label" for="allowContact">
                                <span data-i18n="fb.agree.prefix">I agree to the</span> <a href="#" class="contact-link" data-i18n="fb.agree.terms">Terms & Conditions</a> <span data-i18n="fb.agree.and">and</span> <a href="#" class="contact-link" data-i18n="fb.agree.privacy">Privacy Policy</a> *
                            </label>
                        </div>
                        <div class="contact-permission-note">
                            <span data-i18n="fb.agree.note">By checking this, you're cool with us reaching out about your feedback. We might also send you cool stuff, but no spam, we promise.</span>
                        </div>
                    </div>

                    <!-- Hidden field for structured data -->
                    <input type="hidden" name="phone" id="phoneData">
                    
                    <!-- Hidden field for formatted message -->
                    <input type="hidden" name="message" id="formattedMessage">

                    <!-- Submit Button (User is already logged in) -->
                    <button type="submit" class="btn btn-submit" id="submitBtn">
                        <i data-lucide="send"></i> <span data-i18n="fb.submit">Send My Story</span>
                    </button>
                </form>
            </div>
        </div>

        <div class="col-lg-4">
            <div class="feedback-info">
                <div class="info-item">
                    <div class="info-icon">
                        <i data-lucide="bar-chart-3"></i>
                    </div>
                    <div class="info-content">
                        <h5>You're Shaping Future Adventures</h5>
                        <p>Your stories and ideas directly influence our next trips. You're basically a co-creator!</p>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon">
                        <i data-lucide="users"></i>
                    </div>
                    <div class="info-content">
                        <h5>You Keep Us Awesome</h5>
                        <p>Hearing what you loved (and what you didn't) is how we make sure every trip is top-notch.</p>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon">
                        <i data-lucide="heart"></i>
                    </div>
                    <div class="info-content">
                        <h5>Your Happiness is Our Compass</h5>
                        <p>Your feedback is the map we use to make sure we're always heading in the right direction: Awesomeville.</p>
                    </div>
                </div>

                <div class="info-item">
                    <div class="info-icon">
                        <i data-lucide="award"></i>
                    </div>
                    <div class="info-content">
                        <h5>You're Our Secret Ingredient</h5>
                        <p>Your insights help us perfect everything, from the destinations we offer to the dad jokes our guides tell.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/public.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    console.log('DOM Content Loaded - initializing feedback form');
    
    // Check if all required elements exist
    const requiredElements = ['feedbackForm', 'rating', 'feedback', 'submitBtn'];
    requiredElements.forEach(id => {
        const element = document.getElementById(id);
        if (element) {
            console.log('Found element:', id);
        } else {
            console.error('Missing element:', id);
        }
    });
    
    initFeedbackForm();
    initRatingStars();
    initCharCounter();
    initThemeToggle();
    loadDestinations();
    
    console.log('Feedback form initialization complete');
});

function initThemeToggle() {
    const themeToggle = document.getElementById('themeToggle');
    const themeIcon = document.getElementById('themeIcon');
    
    if (!themeToggle || !themeIcon) return;
    
    // Check saved theme preference or default to light
    const savedTheme = localStorage.getItem('theme') || 'light';
    const isDarkMode = savedTheme === 'dark' || (!savedTheme && window.matchMedia('(prefers-color-scheme: dark)').matches);
    
    if (isDarkMode) {
        document.body.classList.add('dark-mode');
        themeIcon.className = 'fas fa-sun';
        themeToggle.title = 'Toggle Light Mode';
    }
    
    themeToggle.addEventListener('click', function() {
        const isDark = document.body.classList.contains('dark-mode');
        
        if (isDark) {
            document.body.classList.remove('dark-mode');
            themeIcon.className = 'fas fa-moon';
            themeToggle.title = 'Toggle Dark Mode';
            localStorage.setItem('theme', 'light');
        } else {
            document.body.classList.add('dark-mode');
            themeIcon.className = 'fas fa-sun';
            themeToggle.title = 'Toggle Light Mode';
            localStorage.setItem('theme', 'dark');
        }
    });
}

function initFeedbackForm() {
    const form = document.getElementById('feedbackForm');
    if (!form) {
        console.error('Feedback form not found');
        return;
    }

    form.addEventListener('submit', function(e) {
        e.preventDefault();
        console.log('Form submit event triggered');
        
        if (validateForm()) {
            formatAndSubmitFeedback();
        } else {
            console.log('Form validation failed');
        }
    });

    // Add click handler for submit button as backup
    const submitBtn = document.getElementById('submitBtn');
    if (submitBtn) {
        submitBtn.addEventListener('click', function(e) {
            e.preventDefault();
            console.log('Submit button clicked');
            
            if (validateForm()) {
                formatAndSubmitFeedback();
            } else {
                console.log('Form validation failed from button click');
            }
        });
    }

    const nameField = document.getElementById('name');
    const emailField = document.getElementById('email');
    const feedbackField = document.getElementById('feedback');
    const ratingField = document.getElementById('rating');

    if (nameField) {
        nameField.addEventListener('blur', function() {
            validateField(this, 'Please enter your full name.');
        });
    }

    if (emailField) {
        emailField.addEventListener('blur', function() {
            validateEmail(this);
        });
    }

    if (feedbackField) {
        feedbackField.addEventListener('blur', function() {
            validateField(this, 'Please enter your feedback.');
        });
    }

    console.log('Feedback form initialized');
}

function initRatingStars() {
    const ratingStars = document.getElementById('ratingStars');
    const ratingText = document.getElementById('ratingText');
    const ratingInput = document.getElementById('rating');
    
    if (!ratingStars) return;

    const stars = ratingStars.querySelectorAll('.star');
    const ratingLabels = ['Poor', 'Fair', 'Good', 'Very Good', 'Excellent'];

    stars.forEach((star, index) => {
        star.addEventListener('click', function() {
            const rating = parseInt(this.dataset.rating);
            updateStars(stars, rating);
            
            if (ratingInput) {
                ratingInput.value = rating;
            }
            
            if (ratingText) {
                ratingText.textContent = ratingLabels[rating - 1];
            }
        });

        star.addEventListener('mouseenter', function() {
            const rating = parseInt(this.dataset.rating);
            updateStars(stars, rating);
        });
    });

    ratingStars.addEventListener('mouseleave', function() {
        const currentRating = ratingInput ? parseInt(ratingInput.value) || 0 : 0;
        updateStars(stars, currentRating);
    });
}

function updateStars(stars, rating) {
    stars.forEach((star, index) => {
        if (index < rating) {
            star.classList.add('active');
        } else {
            star.classList.remove('active');
        }
    });
}

function initCharCounter() {
    const feedbackField = document.getElementById('feedback');
    const charCount = document.getElementById('charCount');
    
    if (!feedbackField || !charCount) return;

    feedbackField.addEventListener('input', function() {
        const count = this.value.length;
        charCount.textContent = count;
        
        if (count > 1000) {
            charCount.style.color = '#dc3545';
            this.setCustomValidity('Feedback cannot exceed 1000 characters');
        } else {
            charCount.style.color = '#6c757d';
            this.setCustomValidity('');
        }
    });
}

function loadDestinations() {
    // Get destinations from server-side rendered data
    // This is already loaded from the controller
}

function validateForm() {
    const nameField = document.getElementById('name');
    const emailField = document.getElementById('email');
    const feedbackField = document.getElementById('feedback');
    const ratingField = document.getElementById('rating');

    let isValid = true;

    // Clear previous errors
    document.querySelectorAll('.is-invalid').forEach(field => {
        field.classList.remove('is-invalid');
    });

    if (nameField && !validateField(nameField, 'Please enter your full name.')) {
        isValid = false;
    }

    if (emailField && !validateEmail(emailField)) {
        isValid = false;
    }

    if (feedbackField && !validateField(feedbackField, 'Please enter your feedback.')) {
        isValid = false;
    }

    if (ratingField && !ratingField.value) {
        showFieldError(ratingField, 'Please select a rating.');
        alert('Please select a rating by clicking on the stars.');
        isValid = false;
    }

    console.log('Form validation result:', isValid);
    console.log('Rating value:', ratingField ? ratingField.value : 'No rating field');

    return isValid;
}

function validateField(field, errorMessage) {
    const value = field.value.trim();
    if (!value && field.hasAttribute('required')) {
        showFieldError(field, errorMessage);
        return false;
    } else if (value) {
        clearFieldError(field);
        return true;
    }
    return true;
}

function validateEmail(field) {
    const value = field.value.trim();
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!value) {
        showFieldError(field, 'Please enter your email address.');
        return false;
    } else if (!emailRegex.test(value)) {
        showFieldError(field, 'Please enter a valid email address.');
        return false;
    } else {
        clearFieldError(field);
        return true;
    }
}

function showFieldError(field, message) {
    field.classList.add('is-invalid');
    field.classList.remove('is-valid');
    const feedback = field.nextElementSibling;
    if (feedback && feedback.classList.contains('invalid-feedback')) {
        feedback.textContent = message;
    }
}

function clearFieldError(field) {
    field.classList.remove('is-invalid');
    field.classList.add('is-valid');
    const feedback = field.nextElementSibling;
    if (feedback && feedback.classList.contains('invalid-feedback')) {
        feedback.textContent = '';
    }
}

function formatAndSubmitFeedback() {
    const form = document.getElementById('feedbackForm');
    const submitBtn = document.getElementById('submitBtn');
    
    console.log('Starting to format and submit feedback...');
    
    // Check if form exists
    if (!form) {
        console.error('Form not found');
        alert('Form not found. Please refresh the page and try again.');
        return;
    }
    
    // User must be logged in to access this page (enforced by controller)
    // No need to check login status here
    
    // Gather all form data
    const formData = {
        rating: document.getElementById('rating').value,
        feedback: document.getElementById('feedback').value,
        suggestions: document.getElementById('suggestions').value || '',
        travelDate: document.getElementById('travelDate').value || '',
        destinationId: document.getElementById('destinationId').value || '',
        packageId: document.getElementById('packageId').value || '',
        recommendation: document.querySelector('input[name="recommendation"]:checked')?.value || '',
        allowContact: document.getElementById('allowContact').checked
    };
    
    console.log('Form data collected:', formData);
    
    // Validate required fields
    if (!formData.rating || !formData.feedback) {
        alert('Please fill in all required fields (Rating and Feedback)');
        return;
    }
    
    // Format structured data for phone field
    const phoneData = JSON.stringify({
        rating: formData.rating,
        destinationId: formData.destinationId,
        packageId: formData.packageId,
        travelDate: formData.travelDate,
        recommendation: formData.recommendation,
        allowContact: formData.allowContact
    });
    
    // Format the message field
    let messageContent = "=== CUSTOMER FEEDBACK ===\n\n";
    messageContent += "Rating: " + formData.rating + "/5 stars\n\n";
    messageContent += "Detailed Feedback:\n" + formData.feedback + "\n\n";
    
    if (formData.suggestions) {
        messageContent += "Suggestions for Improvement:\n" + formData.suggestions + "\n\n";
    }
    
    if (formData.travelDate) {
        messageContent += "Travel Date: " + formData.travelDate + "\n";
    }
    
    if (formData.destinationId) {
        const destinationSelect = document.getElementById('destinationId');
        if (destinationSelect.selectedIndex > 0) {
            const selectedDestination = destinationSelect.options[destinationSelect.selectedIndex].text;
            messageContent += "Destination: " + selectedDestination + "\n";
        }
    }
    
    if (formData.packageId) {
        const packageSelect = document.getElementById('packageId');
        if (packageSelect.selectedIndex > 0) {
            const selectedPackage = packageSelect.options[packageSelect.selectedIndex].text;
            messageContent += "Package: " + selectedPackage + "\n";
        }
    }
    
    if (formData.recommendation) {
        messageContent += "Would recommend: " + formData.recommendation + "\n";
    }
    
    messageContent += "Contact permission: " + (formData.allowContact ? 'Yes' : 'No') + "\n";
    messageContent += "\nSubmitted: " + new Date().toLocaleString();
    
    // Set the hidden fields
    const phoneField = document.getElementById('phoneData');
    const messageField = document.getElementById('formattedMessage');
    
    if (phoneField) {
        phoneField.value = phoneData;
        console.log('Phone data set:', phoneData);
    } else {
        console.error('Phone data field not found');
    }
    
    if (messageField) {
        messageField.value = messageContent;
        console.log('Message content set:', messageContent);
    } else {
        console.error('Message field not found');
    }
    
    // Submit the form
    if (submitBtn) {
        submitBtn.disabled = true;
        submitBtn.innerHTML = '<i data-lucide="loader-2" class="spin"></i> Submitting...';
        if (typeof lucide !== 'undefined') { try { lucide.createIcons(); } catch(e){} }
    }
    
    console.log('Submitting feedback form...');
    
    try {
        form.submit();
    } catch (error) {
        console.error('Error submitting form:', error);
        alert('Error submitting form. Please try again.');
        if (submitBtn) {
            submitBtn.disabled = false;
            submitBtn.innerHTML = '<i data-lucide="send"></i> Send My Story';
            if (typeof lucide !== 'undefined') { try { lucide.createIcons(); } catch(e){} }
        }
    }
}

// Load packages when destination changes
const destinationSelect = document.getElementById('destinationId');
const packageSelect = document.getElementById('packageId');

if (destinationSelect && packageSelect) {
    destinationSelect.addEventListener('change', function() {
        const destinationId = this.value;
        
        if (destinationId) {
            // Clear current packages
            packageSelect.innerHTML = '<option value="">Loading packages...</option>';
            
            // Load packages for selected destination
            fetch(`" + window.location.origin + "/api/packages?destination=" + destinationId + "`)
                .then(response => response.json())
                .then(data => {
                    packageSelect.innerHTML = '<option value="">Select package (optional)</option>';
                    
                    const packages = data.items || data;
                    packages.forEach(pkg => {
                        const option = document.createElement('option');
                        option.value = pkg.id;
                        option.textContent = pkg.name;
                        packageSelect.appendChild(option);
                    });
                })
                .catch(error => {
                    console.error('Error loading packages:', error);
                    packageSelect.innerHTML = '<option value="">Error loading packages</option>';
                });
        } else {
            packageSelect.innerHTML = '<option value="">Select package (optional)</option>';
        }
    });
}
</script>

<script>
  // Ensure Lucide icons render after this page's DOM is parsed
  (function(){
    if (typeof lucide !== 'undefined') { try { lucide.createIcons(); } catch(e) {} }
  })();
</script>

<jsp:include page="../includes/footer.jsp" />