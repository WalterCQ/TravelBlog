<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="Help Center - MyTour Global" />
</jsp:include>

<meta name="current-page" content="help">
<meta name="context-path" content="${pageContext.request.contextPath}">

<link href="${pageContext.request.contextPath}/css/public.css" rel="stylesheet">

<style>
    :root {
        --primary-color: #DAA520;
        --primary-hover: #B8941C;
        --secondary-color: #2c3e50;
        --accent-color: #3498db;
        --success-color: #27ae60;
        --warning-color: #f39c12;
        --danger-color: #e74c3c;
        --light-bg: #f8f9fa;
        --dark-bg: #2c3e50;
        --glass-bg: rgba(255, 255, 255, 0.1);
        --glass-border: rgba(255, 255, 255, 0.2);
        --shadow-light: 0 4px 6px rgba(0, 0, 0, 0.07);
        --shadow-medium: 0 8px 25px rgba(0, 0, 0, 0.1);
        --shadow-heavy: 0 15px 35px rgba(0, 0, 0, 0.15);
        --gradient-primary: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        --gradient-secondary: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        --gradient-accent: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        --border-radius: 16px;
        --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    body {
        font-family: var(--font-body);
        line-height: 1.6;
        color: #333;
        overflow-x: hidden;
    }

    .page-container {
        min-height: 100vh;
        position: relative;
    }

    .page-container::before {
        content: '';
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        pointer-events: none;
        z-index: -1;
    }

    .hero-section {
        background: var(--gradient-primary);
        min-height: 50vh;
        display: flex;
        align-items: center;
        position: relative;
        overflow: hidden;
        margin-bottom: 4rem;
    }

    .hero-section::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background: 
            url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 1000"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="50" cy="50" r="1" fill="white" opacity="0.1"/></pattern></defs><rect width="100%" height="100%" fill="url(%23grain)"/></svg>'),
            linear-gradient(45deg, transparent 30%, rgba(255, 255, 255, 0.1) 50%, transparent 70%);
        animation: shimmer 8s ease-in-out infinite;
    }

    @keyframes shimmer {
        0%, 100% { transform: translateX(-100%); }
        50% { transform: translateX(100%); }
    }

    .hero-content {
        position: relative;
        z-index: 2;
        text-align: center;
        max-width: 800px;
        margin: 0 auto;
        padding: 2rem;
    }

    .hero-title {
        font-family: var(--font-heading);
        font-size: 3.5rem;
        font-weight: 700;
        color: white;
        margin-bottom: 1.5rem;
        text-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
        animation: fadeInUp 1s ease-out;
    }

    .hero-subtitle {
        font-size: 1.3rem;
        color: rgba(255, 255, 255, 0.9);
        margin-bottom: 2rem;
        font-weight: 300;
        animation: fadeInUp 1s ease-out 0.2s both;
    }

    @keyframes fadeInUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    .container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 0 1rem;
    }

    .section-title {
        font-family: var(--font-heading);
        font-size: 2.5rem;
        font-weight: 600;
        color: var(--dark-bg);
        margin-bottom: 1rem;
        position: relative;
        display: inline-block;
    }

    .section-title::after {
        content: '';
        position: absolute;
        bottom: -0.5rem;
        left: 0;
        width: 60px;
        height: 4px;
        background: var(--primary-color);
        border-radius: 2px;
    }

    .section-subtitle {
        font-size: 1.1rem;
        color: #6c757d;
        max-width: 600px;
        margin: 0 auto 3rem;
        text-align: center;
    }

    .quick-help-section {
        margin-bottom: 5rem;
        animation: fadeInUp 0.8s ease-out;
    }

    .help-category-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 2rem;
        margin-top: 2rem;
    }

    .help-category-card {
        background: white;
        border-radius: var(--border-radius);
        padding: 2rem;
        text-align: center;
        border: 2px solid #f8f9fa;
        transition: var(--transition);
        height: 100%;
        cursor: pointer;
        position: relative;
        overflow: hidden;
        box-shadow: var(--shadow-light);
    }

    .help-category-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(218, 165, 32, 0.1), transparent);
        transition: left 0.5s ease;
    }

    .help-category-card:hover::before {
        left: 100%;
    }

    .help-category-card:hover {
        transform: translateY(-10px);
        box-shadow: var(--shadow-heavy);
        border-color: var(--primary-color);
    }

    .category-icon-container {
        width: 80px;
        height: 80px;
        background: linear-gradient(135deg, var(--primary-color), var(--primary-hover));
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 1.5rem;
        transition: var(--transition);
        position: relative;
        z-index: 1;
    }

    .help-category-card:hover .category-icon-container {
        transform: scale(1.1) rotate(5deg);
    }

    .category-icon {
        color: white;
    }
    /* Ensure Lucide SVG inside the icon scales visibly within the circle */
    .category-icon,
    .category-icon svg {
        width: 40px;
        height: 40px;
    }

    .category-title {
        font-size: 1.25rem;
        font-weight: 700;
        color: #333;
        margin-bottom: 1rem;
        position: relative;
        z-index: 1;
    }

    .category-description {
        color: #6c757d;
        margin-bottom: 1.5rem;
        line-height: 1.6;
        position: relative;
        z-index: 1;
    }

    .category-articles-count {
        color: var(--primary-color);
        font-weight: 600;
        font-size: 0.9rem;
        position: relative;
        z-index: 1;
    }

	.hero-video {
	    position: absolute;
	    top: 0;
	    left: 0;
	    width: 100%;
	    height: 100%;
	    object-fit: cover;
	    z-index: 1;
	}

    .two-column-layout {
        display: grid;
        grid-template-columns: 1fr 350px;
        gap: 3rem;
        margin-top: 3rem;
    }

    .main-content {
        min-height: 600px;
    }

    .sidebar {
        background: white;
        border-radius: var(--border-radius);
        padding: 2rem;
        box-shadow: var(--shadow-light);
        height: fit-content;
        position: sticky;
        top: 2rem;
    }

    .sidebar-title {
        font-size: 1.5rem;
        font-weight: 600;
        color: var(--dark-bg);
        margin-bottom: 1.5rem;
        border-bottom: 2px solid var(--primary-color);
        padding-bottom: 0.5rem;
    }

    .sidebar-section {
        margin-bottom: 2rem;
    }

    .sidebar-section h6 {
        color: var(--dark-bg);
        font-weight: 600;
        margin-bottom: 1rem;
    }

    .sidebar-section ul {
        list-style: none;
        padding: 0;
    }

    .sidebar-section li {
        margin-bottom: 0.5rem;
    }

    .sidebar-section a {
        color: #6c757d;
        text-decoration: none;
        transition: var(--transition);
        display: block;
        padding: 0.5rem 0;
        border-radius: 4px;
    }

    .sidebar-section a:hover {
        color: var(--primary-color);
        background: rgba(218, 165, 32, 0.1);
        padding-left: 0.5rem;
    }

    .contact-widget {
        background: var(--gradient-accent);
        border-radius: var(--border-radius);
        padding: 1.5rem;
        text-align: center;
        color: white;
        margin-top: 2rem;
    }

    .contact-widget h6 {
        font-weight: 600;
        margin-bottom: 1rem;
    }

    .contact-widget p {
        margin-bottom: 1rem;
        opacity: 0.9;
    }

    .contact-widget .btn {
        background: white;
        color: var(--accent-color);
        border: none;
        padding: 0.5rem 1rem;
        border-radius: 20px;
        font-weight: 600;
        transition: var(--transition);
    }

    .contact-widget .btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
    }

    .faq-section {
        background: white;
        border-radius: var(--border-radius);
        padding: 3rem 2rem;
        margin-bottom: 3rem;
        box-shadow: var(--shadow-light);
        animation: fadeInUp 0.8s ease-out 0.2s both;
    }

    .faq-container {
        max-width: 100%;
        margin: 0;
    }

    .faq-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(450px, 1fr));
        gap: 2rem;
        margin-top: 2rem;
    }

    .faq-item {
        background: #f8f9fa;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
        transition: var(--transition);
        margin-bottom: 1rem;
    }

    .faq-item:hover {
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }

    .faq-question {
        background: #f8f9fa;
        border: none;
        padding: 1.5rem;
        width: 100%;
        text-align: left;
        font-weight: 600;
        color: var(--dark-bg);
        font-size: 1.1rem;
        transition: var(--transition);
        border-radius: 12px;
        cursor: pointer;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .faq-question:hover {
        background: #e9ecef;
    }

    .faq-question.active {
        background: var(--primary-color);
        color: white;
    }

    .faq-toggle {
        font-size: 1.5rem;
        font-weight: bold;
        transition: transform 0.3s ease;
        line-height: 1;
    }

    .faq-question.active .faq-toggle {
        transform: rotate(45deg);
    }

    .faq-answer {
        max-height: 0;
        overflow: hidden;
        transition: max-height 0.3s ease, padding 0.3s ease;
        background: white;
        padding: 0 1.5rem;
    }

    .faq-answer.show {
        max-height: 300px;
        padding: 1.5rem;
    }

    .faq-answer p {
        margin: 0;
        color: #6c757d;
        line-height: 1.7;
    }

    .contact-support-section {
        background: var(--gradient-accent);
        border-radius: var(--border-radius);
        padding: 3rem 2rem;
        text-align: center;
        color: white;
        animation: fadeInUp 0.8s ease-out 0.4s both;
    }

    .contact-title {
        font-size: 2rem;
        font-weight: 700;
        margin-bottom: 1rem;
    }

    .contact-description {
        font-size: 1.1rem;
        margin-bottom: 2rem;
        opacity: 0.9;
    }

    .contact-options {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 2rem;
        margin-top: 2rem;
    }

    .contact-option {
        background: rgba(255, 255, 255, 0.15);
        border-radius: 12px;
        padding: 1.5rem;
        border: 1px solid rgba(255, 255, 255, 0.2);
        transition: var(--transition);
        text-decoration: none;
        color: white;
        display: block;
    }

    .contact-option:hover {
        background: rgba(255, 255, 255, 0.25);
        transform: translateY(-3px);
        color: white;
        text-decoration: none;
    }

    .contact-option i {
        font-size: 2rem;
        margin-bottom: 1rem;
        display: block;
    }

    .contact-option h5 {
        font-weight: 600;
        margin-bottom: 0.5rem;
    }

    .contact-option p {
        margin: 0;
        opacity: 0.9;
        font-size: 0.9rem;
    }

    .floating-action {
        position: fixed;
        bottom: 2rem;
        right: 2rem;
        z-index: 1000;
    }

    .breadcrumb {
        background: rgba(255, 255, 255, 0.9);
        backdrop-filter: blur(10px);
        border-radius: 12px;
        padding: 1rem 1.5rem;
        margin-bottom: 2rem;
        border: 1px solid rgba(255, 255, 255, 0.2);
    }

    .breadcrumb-item + .breadcrumb-item::before {
        content: "›";
        color: var(--primary-color);
        font-weight: 600;
    }

    .breadcrumb-item.active {
        color: var(--primary-color);
        font-weight: 600;
    }

    .loading-shimmer {
        background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
        background-size: 200% 100%;
        animation: shimmer 1.5s infinite;
    }

    @media (max-width: 992px) {
        .hero-title {
            font-size: 3rem;
        }
        
        .hero-subtitle {
            font-size: 1.1rem;
        }
        
        .help-category-grid {
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 1.5rem;
        }
        
        .two-column-layout {
            grid-template-columns: 1fr;
            gap: 2rem;
        }
        
        .sidebar {
            position: static;
            order: -1;
        }
        
        .contact-options {
            grid-template-columns: 1fr;
            gap: 1rem;
        }
    }

    @media (max-width: 768px) {
        .hero-title {
            font-size: 2.5rem;
        }
        
        .section-title {
            font-size: 2rem;
        }
        
        .help-category-card {
            padding: 2rem 1.5rem;
        }
        
        .faq-section,
        .contact-support-section {
            padding: 2rem 1.5rem;
        }
        
        .floating-action {
            bottom: 1rem;
            right: 1rem;
        }
        
        .faq-grid {
            grid-template-columns: 1fr;
        }
    }

    @media (max-width: 576px) {
        .hero-content {
            padding: 1rem;
        }
        
        .hero-title {
            font-size: 2rem;
        }
        
        .hero-subtitle {
            font-size: 1rem;
        }
        
        .container {
            padding: 0 0.5rem;
        }
        
        .help-category-grid {
            grid-template-columns: 1fr;
        }
        
        .help-category-card {
            padding: 1.5rem 1rem;
        }
        
        .sidebar {
            padding: 1.5rem;
        }
    }

    /* Fix: remove thin top white bar by aligning hero with global body padding */
    .page-container .hero-section { margin-top: -85px !important; padding-top: 85px !important; }
    @media (max-width: 768px) { .page-container .hero-section { margin-top: -65px !important; padding-top: 65px !important; } }

    body.dark-mode .help-category-card {
        background: #2d2d2d;
        border-color: #555;
    }

    body.dark-mode .faq-section {
        background: #2d2d2d;
    }

    body.dark-mode .faq-item {
        background: #404040;
    }

    body.dark-mode .faq-question {
        background: #404040;
        color: #e0e0e0;
    }

    body.dark-mode .faq-question:hover {
        background: #4a4a4a;
    }

    body.dark-mode .faq-question.active {
        background: var(--primary-color);
        color: white;
    }

    body.dark-mode .faq-answer {
        background: #333;
    }

    body.dark-mode .faq-answer p {
        color: #ccc;
    }

    body.dark-mode .sidebar {
        background: #2d2d2d;
        border: 1px solid #555;
    }

    body.dark-mode .sidebar-title {
        color: #ffffff;
    }

    body.dark-mode .sidebar-section h6 {
        color: #ffffff;
    }

    body.dark-mode .sidebar-section a {
        color: #ccc;
    }

    body.dark-mode .sidebar-section a:hover {
        color: var(--primary-color);
    }
</style>

<jsp:include page="../includes/navigation.jsp">
    <jsp:param name="currentPage" value="help" />
</jsp:include>

<div class="page-container">
	<section class="hero-section">
	    <video class="hero-video" autoplay muted loop playsinline>
	        <source src="${pageContext.request.contextPath}/videos/ChinaDanxia.mp4" type="video/mp4">
	        <span data-i18n="video.unsupported">Your browser does not support the video tag.</span>
	    </video>
	    <div class="hero-overlay"></div>
	    
	    <div class="hero-content">
	        <h1 class="hero-title" data-i18n="help.hero.title">Got a Hitch in Your Travel Plans?</h1>
	        <p class="hero-subtitle" data-i18n="help.hero.subtitle">No worries, we've got the map. Find the answers you need to get back on track.</p>
	    </div>
	</section>
    <div class="container">
        <section class="quick-help-section">
            <div class="text-center">
				<h2 class="section-title" data-i18n="help.quick.title">What's On Your Mind?</h2>
				<p class="section-subtitle" data-i18n="help.quick.subtitle">Jump straight to what you need. We've sorted our best tips and tricks into these handy categories.</p>
            </div>

            <div class="help-category-grid">
                <div class="help-category-card" onclick="showCategory('booking')">
                    <div class="category-icon-container">
                        <i data-lucide="calendar-check" class="category-icon"></i>
                    </div>
                    <h4 class="category-title" data-i18n="help.category.booking.title">Your Bookings</h4>
                    <p class="category-description" data-i18n="help.category.booking.desc">All about booking, changing, or canceling your trips.</p>
                </div>

                <div class="help-category-card" onclick="showCategory('payment')">
                    <div class="category-icon-container">
                        <i data-lucide="credit-card" class="category-icon"></i>
                    </div>
                    <h4 class="category-title" data-i18n="help.category.payment.title">Payments & Refunds</h4>
                    <p class="category-description" data-i18n="help.category.payment.desc">Everything you need to know about paying, refunds, and keeping your wallet happy.</p>
                </div>

                <div class="help-category-card" onclick="showCategory('travel')">
                    <div class="category-icon-container">
                        <i data-lucide="lightbulb" class="category-icon"></i>
                    </div>
                    <h4 class="category-title" data-i18n="help.category.travel.title">Pro Travel Tips</h4>
                    <p class="category-description" data-i18n="help.category.travel.desc">Our secret stash of tips for traveling smarter, not harder.</p>
                </div>

                <div class="help-category-card" onclick="showCategory('support')">
                    <div class="category-icon-container">
                        <i data-lucide="headphones" class="category-icon"></i>
                    </div>
                    <h4 class="category-title" data-i18n="help.category.support.title">Account & Tech Support</h4>
                    <p class="category-description" data-i18n="help.category.support.desc">For when you can't log in or the website is acting weird.</p>
                </div>
            </div>
        </section>

        <div class="two-column-layout">
            <div class="main-content">
                <section class="faq-section">
                    <div class="faq-container">
                        <div class="text-center mb-4">
                            <h2 class="section-title" data-i18n="help.faq.title">Your Questions, Answered</h2>
                            <p class="section-subtitle" data-i18n="help.faq.subtitle">Here are some of the greatest hits from our support inbox. Your answer might be just a click away.</p>
                        </div>

                        <div class="faq-grid">
                            <div class="faq-column">
                                <div class="faq-item">
                                    <button class="faq-question" data-faq="0">
                                        <span data-translate="faq-1-question">I just sent a message. How long 'til I hear back?</span>
                                        <span class="faq-toggle">+</span>
                                    </button>
                                    <div class="faq-answer">
                                        <p data-translate="faq-1-answer">We're on it! Our team answers all messages within 24 hours on business days. If it's a real travel emergency, give us a call!</p>
                                    </div>
                                </div>

                                <div class="faq-item">
                                    <button class="faq-question" data-faq="1">
                                        <span data-translate="faq-2-question">What info should I give you to get the best help?</span>
                                        <span class="faq-toggle">+</span>
                                    </button>
                                    <div class="faq-answer">
                                        <p data-translate="faq-2-answer">The more, the better! Tell us your travel dates, where you want to go, and how many people are in your crew. It'll help us help you faster.</p>
                                    </div>
                                </div>

                                <div class="faq-item">
                                    <button class="faq-question" data-faq="2">
                                        <span data-translate="faq-3-question">I need to change my booking. Is it too late?</span>
                                        <span class="faq-toggle">+</span>
                                    </button>
                                    <div class="faq-answer">
                                        <p data-translate="faq-3-answer">Probably not! Most bookings can be changed, depending on availability. Just know that some changes might have extra fees.</p>
                                    </div>
                                </div>
                            </div>

                            <div class="faq-column">
                                <div class="faq-item">
                                    <button class="faq-question" data-faq="3">
                                        <span data-translate="faq-4-question">I'm traveling with my whole squad. Do we get a discount?</span>
                                        <span class="faq-toggle">+</span>
                                    </button>
                                    <div class="faq-answer">
                                        <p data-translate="faq-4-answer">Absolutely! We love groups. If you've got 10 or more people, we'll whip up a custom quote with a sweet discount for you.</p>
                                    </div>
                                </div>

                                <div class="faq-item">
                                    <button class="faq-question" data-faq="4">
                                        <span data-translate="faq-5-question">How can I pay for my adventure?</span>
                                        <span class="faq-toggle">+</span>
                                    </button>
                                    <div class="faq-answer">
                                        <p data-translate="faq-5-answer">We accept all major credit cards, bank transfers, and TNG. We even have payment plans for the really big adventures!</p>
                                    </div>
                                </div>

                                <div class="faq-item">
                                    <button class="faq-question" data-faq="5">
                                        <span data-translate="faq-6-question">Do I really need travel insurance? (Spoiler: Yes)</span>
                                        <span class="faq-toggle">+</span>
                                    </button>
                                    <div class="faq-answer">
                                        <p data-translate="faq-6-answer">We can't say it enough: yes! It's the superhero cape for your trip, protecting you from the unexpected. We can help you pick the perfect plan.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <section class="contact-support-section">
                    <div class="contact-title" data-i18n="help.contact.title">Still Stuck? Let's Talk.</div>
                    <div class="contact-description" data-i18n="help.contact.desc">Don't waste your precious vacation-planning time being confused. Our support squad is ready to jump in.</div>
                    
                    <div class="contact-options">
                        <a href="${pageContext.request.contextPath}/contact" class="contact-option">
                            <i data-lucide="mail"></i>
                            <h5 data-i18n="help.contact.email.title">Email Our Experts</h5>
                            <p data-i18n="help.contact.email.desc">Best for detailed questions</p>
                        </a>
                        
                        <a href="tel:+601234567" class="contact-option">
                            <i data-lucide="phone"></i>
                            <h5 data-i18n="help.contact.call.title">Give Us a Call</h5>
                            <p data-i18n="help.contact.call.desc">For when you need an answer, like, right now</p>
                        </a>
                        
                        <a href="#" class="contact-option" onclick="openLiveChat()">
                            <i data-lucide="messages-square"></i>
                            <h5 data-i18n="help.contact.chat.title">Chat With Us</h5>
                            <p data-i18n="help.contact.chat.desc">Get quick answers without leaving the site</p>
                        </a>
                    </div>
                </section>
            </div>

            <div class="sidebar">
                <h4 class="sidebar-title" data-i18n="help.sidebar.quickLinks">Speedy Links</h4>
                
                <div class="sidebar-section">
                    <h6 data-i18n="help.sidebar.hotTopics">Hot Topics</h6>
                    <ul>
                        <li><a href="#" onclick="searchHelp('booking')" data-i18n="help.sidebar.howToBook">How to Book</a></li>
                        <li><a href="#" onclick="searchHelp('cancel')" data-i18n="help.sidebar.cancellation">Cancellation Policy</a></li>
                        <li><a href="#" onclick="searchHelp('payment')" data-i18n="help.sidebar.paymentMethods">Payment Methods</a></li>
                        <li><a href="#" onclick="searchHelp('refund')" data-i18n="help.sidebar.refund">Refund Process</a></li>
                        <li><a href="#" onclick="searchHelp('travel insurance')" data-i18n="help.sidebar.insurance">Travel Insurance</a></li>
                    </ul>
                </div>

                <div class="sidebar-section">
                    <h6 data-i18n="help.sidebar.browse">Browse by Topic</h6>
                    <ul>
                        <li><a href="#" onclick="showCategory('booking')" data-i18n="help.sidebar.cat.booking">Booking & Reservations</a></li>
                        <li><a href="#" onclick="showCategory('payment')" data-i18n="help.sidebar.cat.payment">Payment & Billing</a></li>
                        <li><a href="#" onclick="showCategory('travel')" data-i18n="help.sidebar.cat.travel">Travel Tips</a></li>
                        <li><a href="#" onclick="showCategory('support')" data-i18n="help.sidebar.cat.support">Customer Support</a></li>
                    </ul>
                </div>

                <div class="sidebar-section">
                    <h6 data-i18n="help.sidebar.yourStuff">Your Stuff</h6>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/my-bookings" data-i18n="account.bookings">My Bookings</a></li>
                        <li><a href="${pageContext.request.contextPath}/profile" data-i18n="help.sidebar.profileSettings">Profile Settings</a></li>
                        <li><a href="${pageContext.request.contextPath}/logout" data-i18n="account.logout">Sign Out</a></li>
                    </ul>
                </div>

                <div class="contact-widget">
                    <h6 data-i18n="help.widget.title">Need a Human?</h6>
                    <p data-i18n="help.widget.desc">Our travel pros are on standby to help you craft the perfect escape.</p>
                    <a href="${pageContext.request.contextPath}/contact" class="btn" data-i18n="help.widget.cta">Get Help</a>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="liveChatWidget" class="live-chat-widget" style="display: none;">
    <div class="chat-header">
        <div class="chat-title">
            <i data-lucide="messages-square" class="me-2"></i>
            <span data-i18n="help.chat.title">Live Support</span>
        </div>
        <button class="btn-close-chat" onclick="closeLiveChat()">×</button>
    </div>
    <div class="chat-body" id="chatBody">
        <div class="chat-message bot-message">
            <p data-i18n="help.chat.greeting">Hello! How can I help you today?</p>
        </div>
    </div>
    <div class="chat-footer">
        <div class="chat-input-container">
            <input type="text" id="chatInput" data-i18n-attr='{"placeholder":"help.chat.placeholder"}' placeholder="Type your message..." onkeypress="if(event.key==='Enter') sendChatMessage()">
            <button class="btn-send" onclick="sendChatMessage()">
                <i data-lucide="send"></i>
            </button>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/help-center.js"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    const faqQuestions = document.querySelectorAll('.faq-question');
    
    faqQuestions.forEach(question => {
        question.addEventListener('click', function() {
            const faqItem = this.closest('.faq-item');
            const answer = faqItem.querySelector('.faq-answer');
            const toggle = this.querySelector('.faq-toggle');
            
            this.classList.toggle('active');
            answer.classList.toggle('show');
            
            if (this.classList.contains('active')) {
                toggle.textContent = '−';
            } else {
                toggle.textContent = '+';
            }
        });
    });
});

function showCategory(category) {
    console.log('Showing category:', category);
}

function searchHelp(query) {
    console.log('Searching for:', query);
}

function initializeVideoBackground() {
    const video = document.querySelector('.hero-video');
    if (video) {
        video.addEventListener('loadeddata', function() {
            video.play().catch(console.error);
        });

        video.addEventListener('error', function() {
            console.warn('Video failed to load, falling back to gradient background');
            const heroSection = document.querySelector('.hero-section');
            heroSection.style.background = 'var(--gradient-primary)';
            video.style.display = 'none';
        });
    }
}

function openLiveChat() {
    document.getElementById('liveChatWidget').style.display = 'flex';
}

function closeLiveChat() {
    document.getElementById('liveChatWidget').style.display = 'none';
}

function sendChatMessage() {
    const input = document.getElementById('chatInput');
    const message = input.value.trim();
    
    if (message) {
        const chatBody = document.getElementById('chatBody');
        chatBody.innerHTML += `
            <div class="chat-message user-message">
                <p>${message}</p>
            </div>
        `;
        input.value = '';
        chatBody.scrollTop = chatBody.scrollHeight;
        
        setTimeout(() => {
            chatBody.innerHTML += `
                <div class="chat-message bot-message">
                    <p>${window.I18n ? I18n.t('help.chat.autoReply') : 'Thank you for your message. A support agent will respond shortly.'}</p>
                </div>
            `;
            chatBody.scrollTop = chatBody.scrollHeight;
        }, 1000);
    }
}
</script>

<style>
.live-chat-widget {
    position: fixed;
    bottom: 100px;
    right: 2rem;
    width: 350px;
    height: 400px;
    background: white;
    border-radius: 16px;
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
    display: flex;
    flex-direction: column;
    z-index: 1001;
    animation: slideInUp 0.3s ease-out;
}

@keyframes slideInUp {
    from {
        transform: translateY(100%);
        opacity: 0;
    }
    to {
        transform: translateY(0);
        opacity: 1;
    }
}

.chat-header {
    background: var(--primary-color);
    color: white;
    padding: 1rem;
    border-radius: 16px 16px 0 0;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.chat-title {
    font-weight: 600;
}

.btn-close-chat {
    background: none;
    border: none;
    color: white;
    font-size: 1.5rem;
    cursor: pointer;
    line-height: 1;
}

.chat-body {
    flex: 1;
    padding: 1rem;
    overflow-y: auto;
    background: #f8f9fa;
}

.chat-message {
    margin-bottom: 1rem;
}

.chat-message p {
    margin: 0;
    padding: 0.75rem 1rem;
    border-radius: 18px;
    max-width: 80%;
}

.user-message p {
    background: var(--primary-color);
    color: white;
    margin-left: auto;
}

.bot-message p {
    background: white;
    color: #333;
    border: 1px solid #e9ecef;
}

.chat-footer {
    padding: 1rem;
    background: white;
    border-radius: 0 0 16px 16px;
}

.chat-input-container {
    display: flex;
    gap: 0.5rem;
    align-items: center;
}

#chatInput {
    flex: 1;
    border: 1px solid #e9ecef;
    border-radius: 20px;
    padding: 0.5rem 1rem;
    font-size: 0.9rem;
}

#chatInput:focus {
    outline: none;
    border-color: var(--primary-color);
}

.btn-send {
    background: var(--primary-color);
    border: none;
    color: white;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: all 0.3s ease;
}

.btn-send:hover {
    background: var(--primary-hover);
    transform: scale(1.05);
}

@media (max-width: 768px) {
    .live-chat-widget {
        right: 1rem;
        width: calc(100% - 2rem);
        max-width: 350px;
    }
}
</style>

<jsp:include page="../includes/footer.jsp" />