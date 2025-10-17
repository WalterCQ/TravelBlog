<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="${pageContext.request.locale.language}">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title data-i18n="account.register">Register - MyTour Global</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link href="${pageContext.request.contextPath}/css/auth.css" rel="stylesheet">
    
    <style>
        :root {
            --primary-color: #DAA520;
            --primary-hover: #B8941C;
            --success-color: #10b981;
            --danger-color: #ef4444;
            --warning-color: #f59e0b;
            --glass-bg: rgba(255, 255, 255, 0.1);
            --glass-border: rgba(255, 255, 255, 0.2);
            --text-light: rgba(255, 255, 255, 0.9);
            --text-muted: rgba(255, 255, 255, 0.7);
            --shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            --shadow-hover: 0 12px 48px rgba(0, 0, 0, 0.15);
        }

        [data-theme="dark"] {
            --glass-bg: rgba(0, 0, 0, 0.2);
            --glass-border: rgba(255, 255, 255, 0.1);
            --text-light: rgba(255, 255, 255, 0.95);
            --text-muted: rgba(255, 255, 255, 0.8);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif;
            margin: 0;
            min-height: 100vh;
            overflow-x: hidden;
            position: relative;
            background-color: #ff9a9e;
            background-image: 
                radial-gradient(closest-side, rgba(217, 255, 214, 1), rgba(217, 255, 214, 0)),
                radial-gradient(closest-side, rgba(171, 255, 222, 1), rgba(171, 255, 222, 0)),
                radial-gradient(closest-side, rgba(19, 122, 252, 1), rgba(19, 122, 252, 0)),
                radial-gradient(closest-side, rgba(90, 0, 165, 1), rgba(90, 0, 165, 0)),
                radial-gradient(closest-side, rgba(64, 0, 65, 1), rgba(64, 0, 65, 0));
            background-size: 
                130vmax 130vmax,
                80vmax 80vmax,
                90vmax 90vmax,
                110vmax 110vmax,
                90vmax 90vmax;
            background-position:
                -80vmax -80vmax,
                60vmax -30vmax,
                10vmax 10vmax,
                -30vmax -10vmax,
                50vmax 50vmax;
            background-repeat: no-repeat;
            animation: gradientMovement 15s linear infinite;
        }

        body::after {
            content: '';
            display: block;
            position: fixed;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            z-index: 1;
        }

        [data-theme="dark"] body {
            background-color: #2d1b69;
            background-image: 
                radial-gradient(closest-side, rgba(217, 255, 214, 1), rgba(217, 255, 214, 0)),
                radial-gradient(closest-side, rgba(171, 255, 222, 1), rgba(171, 255, 222, 0)),
                radial-gradient(closest-side, rgba(19, 122, 252, 1), rgba(19, 122, 252, 0)),
                radial-gradient(closest-side, rgba(90, 0, 165, 1), rgba(90, 0, 165, 0)),
                radial-gradient(closest-side, rgba(64, 0, 65, 1), rgba(64, 0, 65, 0));
        }

        @keyframes gradientMovement {
            0%, 100% {
                background-size: 
                    130vmax 130vmax,
                    80vmax 80vmax,
                    90vmax 90vmax,
                    110vmax 110vmax,
                    90vmax 90vmax;
                background-position:
                    -80vmax -80vmax,
                    60vmax -30vmax,
                    10vmax 10vmax,
                    -30vmax -10vmax,
                    50vmax 50vmax;
            }
            25% {
                background-size: 
                    100vmax 100vmax,
                    90vmax 90vmax,
                    100vmax 100vmax,
                    90vmax 90vmax,
                    60vmax 60vmax;
                background-position:
                    -60vmax -90vmax,
                    50vmax -40vmax,
                    0vmax -20vmax,
                    -40vmax -20vmax,
                    40vmax 60vmax;
            }
            50% {
                background-size: 
                    80vmax 80vmax,
                    110vmax 110vmax,
                    80vmax 80vmax,
                    60vmax 60vmax,
                    80vmax 80vmax;
                background-position:
                    -50vmax -70vmax,
                    40vmax -30vmax,
                    10vmax 0vmax,
                    20vmax 10vmax,
                    30vmax 70vmax;
            }
            75% {
                background-size: 
                    90vmax 90vmax,
                    90vmax 90vmax,
                    100vmax 100vmax,
                    90vmax 90vmax,
                    70vmax 70vmax;
                background-position:
                    -50vmax -40vmax,
                    50vmax -30vmax,
                    20vmax 0vmax,
                    -10vmax 10vmax,
                    40vmax 60vmax;
            }
        }

        .auth-container {
            position: relative;
            z-index: 10;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }

        .auth-card {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: 20px;
            box-shadow: var(--shadow);
            transition: all 0.3s ease;
            overflow: hidden;
            max-width: 1200px;
            width: 100%;
            margin: 2rem auto;
            min-height: 650px;
        }

        .auth-card:hover {
            box-shadow: var(--shadow-hover);
        }

        .auth-branding {
            padding: 3rem;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            background: linear-gradient(135deg, 
                rgba(255, 255, 255, 0.1) 0%, 
                rgba(255, 255, 255, 0.05) 100%);
        }

        .brand-title {
            font-size: 3rem;
            font-weight: 700;
            color: var(--text-light);
            margin-bottom: 1rem;
            text-shadow: 0 2px 20px rgba(0, 0, 0, 0.3);
        }

        .brand-subtitle {
            font-size: 1.2rem;
            color: var(--text-muted);
            margin-bottom: 2rem;
            line-height: 1.6;
        }

        .feature-item {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
            color: var(--text-light);
        }

        .feature-item i {
            font-size: 1.5rem;
            margin-right: 1rem;
            color: var(--primary-color);
            min-width: 30px;
        }

        .auth-form-container {
            padding: 3rem;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .auth-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .auth-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--text-light);
            margin-bottom: 0.5rem;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
        }

        .auth-subtitle {
            color: var(--text-muted);
            font-size: 1.1rem;
        }

        .theme-toggle {
            position: absolute;
            top: 2rem;
            right: 2rem;
            background: var(--glass-bg);
            border: 1px solid var(--glass-border);
            border-radius: 50%;
            width: 50px;
            height: 50px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-light);
            cursor: pointer;
            transition: all 0.3s ease;
            z-index: 100;
        }

        .theme-toggle:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: scale(1.1);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .form-floating {
            margin-bottom: 1.5rem;
            position: relative;
        }

        .form-floating .form-control {
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 12px;
            color: var(--text-light);
            font-size: 1rem;
            font-weight: 500;
            padding: 1rem 1.2rem;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .form-floating .form-control:focus {
            background: rgba(255, 255, 255, 0.15);
            border-color: var(--primary-color);
            box-shadow: 0 0 0 0.2rem rgba(218, 165, 32, 0.25);
            color: var(--text-light);
            outline: none;
        }

        .form-floating .form-control.is-invalid {
            border-color: var(--danger-color);
            box-shadow: 0 0 0 0.2rem rgba(239, 68, 68, 0.25);
        }

        .form-floating .form-control.is-valid {
            border-color: var(--success-color);
            box-shadow: 0 0 0 0.2rem rgba(16, 185, 129, 0.25);
        }

        .form-floating .form-control::placeholder {
            color: transparent;
        }

        .form-floating label {
            color: var(--text-muted);
            font-weight: 500;
            padding: 1rem 1.2rem;
            transition: all 0.3s ease;
        }

        .form-floating .form-control:focus ~ label,
        .form-floating .form-control:not(:placeholder-shown) ~ label {
            transform: scale(0.85) translateY(-0.5rem) translateX(0.15rem);
            color: var(--primary-color);
            font-weight: 600;
        }

        .input-icon {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            pointer-events: none;
        }

        .password-toggle {
            position: absolute;
            right: 3rem;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: var(--text-muted);
            cursor: pointer;
            padding: 0.5rem;
            border-radius: 6px;
            transition: all 0.3s ease;
            z-index: 10;
        }

        .password-toggle:hover {
            color: var(--primary-color);
            background: rgba(255, 255, 255, 0.1);
        }

        .password-strength {
            margin-top: 0.75rem;
            padding: 0 0.5rem;
        }

        .strength-bar {
            height: 6px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 3px;
            overflow: hidden;
            margin-bottom: 0.5rem;
        }

        .strength-fill {
            height: 100%;
            transition: all 0.3s ease;
            border-radius: 3px;
        }

        .strength-weak { background: var(--danger-color); width: 25%; }
        .strength-fair { background: var(--warning-color); width: 50%; }
        .strength-good { background: var(--success-color); width: 75%; }
        .strength-strong { background: var(--success-color); width: 100%; }

        .strength-text {
            font-size: 0.8rem;
            font-weight: 500;
            color: var(--text-muted);
        }

        .password-match {
            margin-top: 0.75rem;
            padding: 0 0.5rem;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .match-success { color: var(--success-color); }
        .match-error { color: var(--danger-color); }

        .form-feedback {
            font-size: 0.8rem;
            margin-top: 0.5rem;
            padding: 0 0.5rem;
        }

        .invalid-feedback {
            color: var(--danger-color);
        }

        .valid-feedback {
            color: var(--success-color);
        }

        .form-check {
            display: flex;
            align-items: flex-start;
            gap: 0.7rem;
            margin: 1.5rem 0;
        }

        .form-check-input {
            background: var(--glass-bg);
            border: 1px solid var(--glass-border);
            border-radius: 4px;
            transition: all 0.3s ease;
            margin-top: 0.125rem;
            flex-shrink: 0;
        }

        .form-check-input:checked {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
        }

        .form-check-input:focus {
            box-shadow: 0 0 0 0.2rem rgba(218, 165, 32, 0.25);
        }

        .form-check-label {
            color: var(--text-muted);
            font-weight: 500;
            line-height: 1.4;
        }

        .form-text {
            color: var(--text-muted);
            font-size: 0.8rem;
            margin-top: 0.25rem;
        }

        .auth-btn {
            width: 100%;
            padding: 1rem 2rem;
            font-size: 1.1rem;
            font-weight: 600;
            border-radius: 16px;
            border: 2px solid rgba(218, 165, 32, 0.5);
            background: linear-gradient(135deg, 
                rgba(218, 165, 32, 0.25) 0%, 
                rgba(218, 165, 32, 0.15) 50%,
                rgba(218, 165, 32, 0.25) 100%);
            backdrop-filter: blur(20px) saturate(180%) brightness(1.2);
            -webkit-backdrop-filter: blur(20px) saturate(180%) brightness(1.2);
            color: white;
            text-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
            box-shadow: 
                0 8px 32px rgba(218, 165, 32, 0.3),
                inset 0 1px 0 rgba(255, 255, 255, 0.4),
                inset 0 -1px 0 rgba(0, 0, 0, 0.2);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            margin-bottom: 1.5rem;
        }

        .auth-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, 
                transparent, 
                rgba(255, 255, 255, 0.3), 
                transparent);
            transition: left 0.6s ease;
        }

        .auth-btn::after {
            content: '';
            position: absolute;
            inset: 0;
            border-radius: 14px;
            padding: 2px;
            background: linear-gradient(135deg, 
                rgba(255, 255, 255, 0.4) 0%,
                transparent 50%,
                rgba(218, 165, 32, 0.4) 100%);
            -webkit-mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
            -webkit-mask-composite: xor;
            mask-composite: exclude;
            opacity: 0.6;
            pointer-events: none;
        }

        .auth-btn:hover:not(:disabled) {
            transform: translateY(-3px) scale(1.01);
            border-color: rgba(218, 165, 32, 0.8);
            background: linear-gradient(135deg, 
                rgba(218, 165, 32, 0.35) 0%, 
                rgba(218, 165, 32, 0.25) 50%,
                rgba(218, 165, 32, 0.35) 100%);
            backdrop-filter: blur(25px) saturate(200%) brightness(1.3);
            -webkit-backdrop-filter: blur(25px) saturate(200%) brightness(1.3);
            box-shadow: 
                0 12px 40px rgba(218, 165, 32, 0.5),
                inset 0 1px 0 rgba(255, 255, 255, 0.6),
                inset 0 -1px 0 rgba(0, 0, 0, 0.15),
                0 0 30px rgba(218, 165, 32, 0.3);
        }

        .auth-btn:hover:not(:disabled)::before {
            left: 100%;
        }

        .auth-btn:hover:not(:disabled)::after {
            opacity: 1;
        }

        .auth-btn:active:not(:disabled) {
            transform: translateY(-1px) scale(0.99);
        }

        .auth-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
            background: rgba(255, 255, 255, 0.1);
            border-color: rgba(255, 255, 255, 0.2);
        }

        .auth-link {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .auth-link:hover {
            color: var(--primary-hover);
            text-decoration: underline;
        }

        .auth-footer {
            text-align: center;
            color: var(--text-muted);
        }

        .auth-alert {
            border-radius: 12px;
            border: none;
            font-weight: 500;
            margin-bottom: 1.5rem;
            backdrop-filter: blur(10px);
            animation: slideDown 0.3s ease-out;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert-danger {
            background: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
            border-left: 4px solid var(--danger-color);
        }

        .social-divider {
            display: flex;
            align-items: center;
            margin: 1.5rem 0;
            opacity: 0.8;
        }

        .divider-line {
            flex: 1;
            height: 1px;
            background: linear-gradient(90deg, transparent, var(--glass-border), transparent);
        }

        .divider-text {
            padding: 0 1rem;
            font-size: 0.9rem;
            color: var(--text-muted);
            font-weight: 500;
        }

        .social-buttons {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .btn-social {
            flex: 1;
            padding: 0.8rem 1rem;
            border-radius: 10px;
            border: 1px solid var(--glass-border);
            background: var(--glass-bg);
            color: var(--text-light);
            font-size: 0.9rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .btn-social:hover {
            background: rgba(255, 255, 255, 0.15);
            color: var(--text-light);
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        @media (max-width: 991.98px) {
            .auth-branding {
                display: none;
            }
            
            .auth-form-container {
                padding: 2rem;
            }
            
            .brand-title {
                font-size: 2.5rem;
            }
            
            .auth-title {
                font-size: 2rem;
            }
            
            .form-row {
                grid-template-columns: 1fr;
                gap: 0;
            }
        }

        .home-btn {
            position: fixed;
            top: 2rem;
            left: 2rem;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid var(--glass-border);
            border-radius: 12px;
            padding: 0.8rem 1.5rem;
            color: var(--text-light);
            cursor: pointer;
            transition: all 0.3s ease;
            z-index: 1000;
            box-shadow: var(--shadow);
            display: flex;
            align-items: center;
            gap: 0.5rem;
            text-decoration: none;
            font-weight: 600;
            font-size: 0.95rem;
        }
        
        .home-btn:hover {
            background: rgba(255, 255, 255, 0.2);
            transform: translateY(-2px);
            box-shadow: var(--shadow-hover);
            color: var(--primary-color);
            text-decoration: none;
        }
        
        .home-btn i {
            font-size: 1.2rem;
        }

        @media (max-width: 767.98px) {
            .auth-card {
                margin: 1rem auto;
                border-radius: 16px;
                min-height: auto;
            }
            
            .auth-form-container {
                padding: 1.5rem;
            }
            
            .home-btn {
                top: 1rem;
                left: 1rem;
                padding: 0.6rem 1rem;
                font-size: 0.85rem;
            }
            
            .home-btn i {
                font-size: 1rem;
            }
            
            .social-buttons {
                flex-direction: column;
            }
        }

        @media (max-width: 575.98px) {
            .auth-form-container {
                padding: 1rem;
            }
            
            .auth-title {
                font-size: 1.8rem;
            }
            
            .auth-subtitle {
                font-size: 1rem;
            }
            
            .home-btn {
                padding: 0.5rem 0.8rem;
                font-size: 0.8rem;
            }
        }
    </style>
</head>
<body class="auth-body">
    <!-- Home Button -->
    <a href="${pageContext.request.contextPath}/" class="home-btn" aria-label="Back to Home" data-i18n-attr='{"aria-label":"nav.home"}'>
        <i data-lucide="home"></i>
        <span data-i18n="nav.home">Home</span>
    </a>

    <div class="auth-container">
        <div class="container">
            <div class="auth-card">
                <div class="row g-0 h-100">
                    <div class="col-lg-6 d-none d-lg-block">
                        <div class="auth-branding">
                            <h1 class="brand-title" data-i18n="register.brand.title">Join the Adventure</h1>
                            <p class="brand-subtitle" data-i18n="register.brand.subtitle">An account is your passport to a world of seamless travel planning. Let's get you set up.</p>
                            <div class="feature-list">
                                <div class="feature-item">
                                    <i data-lucide="user-plus"></i>
                                    <span data-i18n="register.feature.fast">Spend less time booking, more time dreaming</span>
                                </div>
                                <div class="feature-item">
                                    <i data-lucide="bookmark"></i>
                                    <span data-i18n="register.feature.wishlist">Keep a wishlist of your future adventures</span>
                                </div>
                                <div class="feature-item">
                                    <i data-lucide="shield-check"></i>
                                    <span data-i18n="register.feature.secure">Book with confidence and peace of mind</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-lg-6">
                        <div class="auth-form-container">
                            <div class="auth-header">
                                <h2 class="auth-title" data-i18n="register.title">Your Adventure Starts Here</h2>
                                <p class="auth-subtitle" data-i18n="register.subtitle">Create an account to join our global community of explorers.</p>
                            </div>
                            
                            <c:if test="${not empty errorMessage}">
                                <div class="alert alert-danger auth-alert" role="alert">
                                    <i data-lucide="alert-circle" class="me-2"></i>
                                    ${errorMessage}
                                </div>
                            </c:if>
                            
                            <c:if test="${not empty successMessage}">
                                <div class="alert alert-success auth-alert" role="alert">
                                    <i data-lucide="check-circle" class="me-2"></i>
                                    ${successMessage}
                                </div>
                            </c:if>

                            <div class="social-buttons">
                                <a href="${pageContext.request.contextPath}/auth/google" class="btn-social" aria-label="Sign up with Google" data-i18n-attr='{"aria-label":"register.social.google"}'>
                                    <i data-lucide="chrome"></i>
                                    <span data-i18n="register.social.google">Google</span>
                                </a>
                                <a href="${pageContext.request.contextPath}/auth/facebook" class="btn-social" aria-label="Sign up with Facebook" data-i18n-attr='{"aria-label":"register.social.facebook"}'>
                                    <i data-lucide="facebook"></i>
                                    <span data-i18n="register.social.facebook">Facebook</span>
                                </a>
                            </div>

                            <div class="social-divider">
                                <div class="divider-line"></div>
                                <span class="divider-text" data-i18n="register.or">or sign up with email</span>
                                <div class="divider-line"></div>
                            </div>

                            <form id="registerForm" method="post" action="${pageContext.request.contextPath}/account/register" class="auth-form">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="text" 
                                                   class="form-control auth-input" 
                                                   id="firstName" 
                                                   name="firstName" 
                                                   data-i18n-attr='{"placeholder":"register.firstName.placeholder"}' placeholder="First Name"
                                                   value="${firstName}"
                                                   required
                                                   autocomplete="given-name">
                                            <label for="firstName" data-i18n="register.firstName">First Name</label>
                                            <div class="input-icon">
                                                <i data-lucide="user"></i>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="text" 
                                                   class="form-control auth-input" 
                                                   id="lastName" 
                                                   name="lastName" 
                                                   data-i18n-attr='{"placeholder":"register.lastName.placeholder"}' placeholder="Last Name"
                                                   value="${lastName}"
                                                   autocomplete="family-name">
                                            <label for="lastName" data-i18n="register.lastName">Last Name</label>
                                            <div class="input-icon">
                                                <i data-lucide="user"></i>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-floating mb-3">
                                    <input type="text" 
                                           class="form-control auth-input" 
                                           id="username" 
                                           name="username" 
                                           data-i18n-attr='{"placeholder":"register.username.placeholder"}' placeholder="Username"
                                           value="${username}"
                                           required
                                           minlength="3"
                                           maxlength="20"
                                           pattern="^[a-zA-Z0-9_]+$"
                                           autocomplete="username">
                                    <label for="username" data-i18n="register.username">Username</label>
                                    <div class="input-icon">
                                        <i data-lucide="at-sign"></i>
                                    </div>
                                    <small class="form-text text-muted" data-i18n="register.username.helper">3-20 characters, letters, numbers, and underscore only</small>
                                </div>

                                <div class="form-floating mb-3">
                                    <input type="email" 
                                           class="form-control auth-input" 
                                           id="email" 
                                           name="email" 
                                           data-i18n-attr='{"placeholder":"register.email.placeholder"}' placeholder="Email Address"
                                           value="${email}"
                                           required
                                           autocomplete="email">
                                    <label for="email" data-i18n="register.email">Email Address</label>
                                    <div class="input-icon">
                                        <i data-lucide="mail"></i>
                                    </div>
                                </div>

                                <div class="form-floating mb-3">
                                    <input type="tel" 
                                           class="form-control auth-input" 
                                           id="phone" 
                                           name="phone" 
                                           data-i18n-attr='{"placeholder":"register.phone.placeholder"}' placeholder="Phone Number (Optional)"
                                           value="${phone}"
                                           autocomplete="tel">
                                    <label for="phone" data-i18n="register.phone">Phone Number (Optional)</label>
                                    <div class="input-icon">
                                        <i data-lucide="phone"></i>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="password" 
                                                   class="form-control auth-input" 
                                                   id="password" 
                                                   name="password" 
                                                   data-i18n-attr='{"placeholder":"register.password.placeholder"}' placeholder="Password"
                                                   required
                                                   minlength="6"
                                                   autocomplete="new-password">
                                            <label for="password" data-i18n="register.password">Password</label>
                                            <div class="input-icon">
                                                <i data-lucide="lock"></i>
                                            </div>
                                            <button type="button" class="password-toggle" onclick="togglePassword('password')">
                                                <i data-lucide="eye" id="password-eye"></i>
                                            </button>
                                            <div class="password-strength" id="passwordStrength"></div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="password" 
                                                   class="form-control auth-input" 
                                                   id="confirmPassword" 
                                                   name="confirmPassword" 
                                                   data-i18n-attr='{"placeholder":"register.confirmPassword.placeholder"}' placeholder="Confirm Password"
                                                   required
                                                   minlength="6"
                                                   autocomplete="new-password">
                                            <label for="confirmPassword" data-i18n="register.confirmPassword">Confirm Password</label>
                                            <div class="input-icon">
                                                <i data-lucide="lock"></i>
                                            </div>
                                            <button type="button" class="password-toggle" onclick="togglePassword('confirmPassword')">
                                                <i data-lucide="eye" id="confirmPassword-eye"></i>
                                            </button>
                                            <div class="password-match" id="passwordMatch"></div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-check mb-4">
                                    <input type="checkbox" class="form-check-input" id="terms" name="terms" required>
                                    <label class="form-check-label" for="terms">
                                        <span data-i18n="register.terms.prefix">I agree to the</span> 
                                        <a href="${pageContext.request.contextPath}/terms" target="_blank" class="auth-link">
                                            <span data-i18n="register.terms.service">Terms of Service</span>
                                        </a> 
                                        <span data-i18n="register.terms.and">and</span> 
                                        <a href="${pageContext.request.contextPath}/privacy" target="_blank" class="auth-link">
                                            <span data-i18n="register.terms.privacy">Privacy Policy</span>
                                        </a>
                                    </label>
                                </div>

                                <button type="submit" class="btn btn-primary auth-btn w-100 mb-3">
                                    <span class="btn-text" data-i18n="register.submit">Start My Journey</span>
                                    <span class="btn-spinner d-none">
                                        <span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>
                                        <span data-i18n="register.submitting">Creating account...</span>
                                    </span>
                                </button>
                            </form>

                            <div class="auth-footer">
                                <p><span data-i18n="register.haveAccount">Already have an account?</span> 
                                    <a href="${pageContext.request.contextPath}/account/login" class="auth-link">
                                        <span data-i18n="register.loginCta">Welcome back! Sign in.</span>
                                    </a>
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Lucide Icons -->
    <script src="https://unpkg.com/lucide@latest"></script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- i18n Support -->
    <script src="${pageContext.request.contextPath}/js/core/i18n.js"></script>
    <script>
        // Initialize i18n and Lucide icons
        document.addEventListener('DOMContentLoaded', async function() {
            // Wait for i18n to load
            if (window.I18n && window.I18n.init) {
                try {
                    await window.I18n.init();
                } catch(e) {
                    console.warn('I18n initialization failed:', e);
                }
            }
            
            // Initialize Lucide icons after i18n loads
            if (typeof lucide !== 'undefined') {
                try {
                    lucide.createIcons();
                } catch(e) {
                    console.warn('Lucide icons initialization failed:', e);
                }
            }
        });
    </script>
    
    <script src="${pageContext.request.contextPath}/js/auth.js"></script>
    
    <script>
        function togglePassword(fieldId) {
            const passwordField = document.getElementById(fieldId);
            const toggleIcon = document.getElementById(fieldId + '-eye');
            
            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                toggleIcon.setAttribute('data-lucide', 'eye-off');
            } else {
                passwordField.type = 'password';
                toggleIcon.setAttribute('data-lucide', 'eye');
            }
            if (typeof lucide !== 'undefined') { try { lucide.createIcons(); } catch(e){} }
        }

        function checkPasswordStrength(password) {
            const strengthIndicator = document.getElementById('passwordStrength');
            
            if (!password || !strengthIndicator) return;
            
            let score = 0;
            let feedbackKey = '';
            
            if (password.length >= 8) score++;
            if (/[a-z]/.test(password)) score++;
            if (/[A-Z]/.test(password)) score++;
            if (/[0-9]/.test(password)) score++;
            if (/[^A-Za-z0-9]/.test(password)) score++;
            
            let className = '';
            if (score < 2) {
                className = 'text-danger';
                feedbackKey = 'register.passwordStrength.weak';
            } else if (score < 3) {
                className = 'text-warning';
                feedbackKey = 'register.passwordStrength.fair';
            } else if (score < 4) {
                className = 'text-info';
                feedbackKey = 'register.passwordStrength.good';
            } else {
                className = 'text-success';
                feedbackKey = 'register.passwordStrength.strong';
            }
            
            // Use i18n if available, fallback to English
            const strengthLabel = window.I18n ? window.I18n.t('register.passwordStrength') : 'Password strength:';
            const strengthValue = window.I18n ? window.I18n.t(feedbackKey) : feedbackKey.split('.').pop();
            
            strengthIndicator.innerHTML = `<small class="${className}">${strengthLabel} ${strengthValue}</small>`;
        }

        function checkPasswordMatch() {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            const matchIndicator = document.getElementById('passwordMatch');
            
            if (!confirmPassword || !matchIndicator) return;
            
            // Use i18n if available
            const matchText = window.I18n ? window.I18n.t('register.passwordMatch.yes') : 'Passwords match';
            const noMatchText = window.I18n ? window.I18n.t('register.passwordMatch.no') : 'Passwords do not match';
            
            if (password === confirmPassword) {
                matchIndicator.innerHTML = `<small class="text-success">${matchText}</small>`;
            } else {
                matchIndicator.innerHTML = `<small class="text-danger">${noMatchText}</small>`;
            }
        }

        document.addEventListener('DOMContentLoaded', function() {
            if (typeof lucide !== 'undefined') { try { lucide.createIcons(); } catch(e){} }

            const passwordField = document.getElementById('password');
            const confirmPasswordField = document.getElementById('confirmPassword');
            const form = document.getElementById('registerForm');
            
            if (passwordField) {
                passwordField.addEventListener('input', function() {
                    checkPasswordStrength(this.value);
                    if (confirmPasswordField.value) {
                        checkPasswordMatch();
                    }
                });
            }
            
            if (confirmPasswordField) {
                confirmPasswordField.addEventListener('input', checkPasswordMatch);
            }
            
            if (form) {
                form.addEventListener('submit', function(e) {
                    const submitBtn = this.querySelector('button[type="submit"]');
                    const btnText = submitBtn.querySelector('.btn-text');
                    const btnSpinner = submitBtn.querySelector('.btn-spinner');
                    
                    const username = this.querySelector('#username').value.trim();
                    const email = this.querySelector('#email').value.trim();
                    const password = this.querySelector('#password').value;
                    const confirmPassword = this.querySelector('#confirmPassword').value;
                    const firstName = this.querySelector('#firstName').value.trim();
                    const terms = this.querySelector('#terms').checked;
                    
                    if (!username || !email || !password || !confirmPassword || !firstName || !terms) {
                        e.preventDefault();
                        const errorMsg = window.I18n ? window.I18n.t('register.validation.required') : 'Please fill in all required fields and accept the terms';
                        alert(errorMsg);
                        return;
                    }
                    
                    if (password !== confirmPassword) {
                        e.preventDefault();
                        const errorMsg = window.I18n ? window.I18n.t('register.validation.passwordMatch') : 'Passwords do not match';
                        alert(errorMsg);
                        return;
                    }
                    
                    submitBtn.disabled = true;
                    btnText.classList.add('d-none');
                    btnSpinner.classList.remove('d-none');
                });
            }
        });
    </script>
</body>
</html>