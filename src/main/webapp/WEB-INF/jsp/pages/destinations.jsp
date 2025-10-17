<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="Explore Destinations - Discover the World's Beauty" />
</jsp:include>

<meta name="current-page" content="destinations">
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
        background: var(--color-bg-primary, white);
        pointer-events: none;
        z-index: -1;
    }

    .hero-section {
        min-height: 80vh;
        display: flex;
        align-items: center;
        position: relative;
        overflow: hidden;
        margin-bottom: 4rem;
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

    .hero-overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(
            135deg,
            rgba(0, 0, 0, 0.6) 0%,
            rgba(0, 0, 0, 0.4) 50%,
            rgba(0, 0, 0, 0.6) 100%
        );
        z-index: 2;
    }

    .hero-content {
        position: relative;
        z-index: 3;
        text-align: center;
        max-width: 800px;
        margin: 0 auto;
        padding: 2rem;
    }

    .hero-title {
        font-family: 'Playfair Display', serif;
        font-size: 4.5rem;
        font-weight: 700;
        color: white;
        margin-bottom: 1.5rem;
        text-shadow: 0 4px 20px rgba(0, 0, 0, 0.5);
        animation: fadeInUp 1s ease-out;
        line-height: 1.1;
    }

    .hero-subtitle {
        font-size: 1.5rem;
        color: rgba(255, 255, 255, 0.9);
        margin-bottom: 3rem;
        font-weight: 300;
        animation: fadeInUp 1s ease-out 0.2s both;
        text-shadow: 0 2px 10px rgba(0, 0, 0, 0.3);
    }

    .hero-cta {
        animation: fadeInUp 1s ease-out 0.4s both;
    }

    .hero-cta .btn {
        padding: 1rem 2.5rem;
        font-size: 1.2rem;
        font-weight: 600;
        border-radius: 50px;
        background: var(--primary-color);
        border: none;
        color: white;
        transition: var(--transition);
        text-decoration: none;
        display: inline-block;
        box-shadow: 0 8px 25px rgba(218, 165, 32, 0.4);
    }

    .hero-cta .btn:hover {
        background: var(--primary-hover);
        transform: translateY(-3px);
        box-shadow: 0 12px 35px rgba(218, 165, 32, 0.6);
        color: white;
        text-decoration: none;
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

    .hero-stats {
        position: absolute;
        bottom: 2rem;
        right: 2rem;
        background: rgba(255, 255, 255, 0.15);
        backdrop-filter: blur(20px);
        border: 1px solid rgba(255, 255, 255, 0.2);
        border-radius: var(--border-radius);
        padding: 1.5rem;
        color: white;
        text-align: center;
        min-width: 150px;
        animation: fadeInRight 1s ease-out 0.6s both;
        z-index: 3;
    }

    @keyframes fadeInRight {
        from {
            opacity: 0;
            transform: translateX(30px);
        }
        to {
            opacity: 1;
            transform: translateX(0);
        }
    }

    .hero-stats .stat-number {
        font-size: 2.5rem;
        font-weight: 700;
        line-height: 1;
        margin-bottom: 0.5rem;
        display: block;
    }

    .hero-stats .stat-label {
        font-size: 0.9rem;
        opacity: 0.9;
    }

    .container {
        max-width: 1400px;
        margin: 0 auto;
        padding: 0 1rem;
    }

    .filter-section {
        margin-bottom: 4rem;
        animation: fadeInUp 0.8s ease-out;
    }

    .section-title {
        font-family: 'Playfair Display', serif;
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

    .filter-card {
        background: white;
        border-radius: var(--border-radius);
        padding: 2rem;
        box-shadow: var(--shadow-light);
        border: 1px solid rgba(0, 0, 0, 0.05);
        transition: var(--transition);
    }

    .filter-card:hover {
        box-shadow: var(--shadow-medium);
        transform: translateY(-2px);
    }

    .form-label {
        font-weight: 600;
        color: var(--dark-bg);
        margin-bottom: 0.5rem;
        font-size: 0.9rem;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .form-control, .form-select {
        border-radius: 12px;
        border: 2px solid #e9ecef;
        padding: 0.75rem 1rem;
        font-size: 1rem;
        transition: var(--transition);
        background: #fafbfc;
    }

    .form-control:focus, .form-select:focus {
        border-color: var(--primary-color);
        box-shadow: 0 0 0 0.2rem rgba(218, 165, 32, 0.25);
        background: white;
    }

    .btn-outline-secondary {
        border: 2px solid #6c757d;
        color: #6c757d;
        border-radius: 12px;
        font-weight: 600;
        transition: var(--transition);
    }

    .btn-outline-secondary:hover {
        background: #6c757d;
        border-color: #6c757d;
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(108, 117, 125, 0.3);
    }

    .info-card {
        background: var(--gradient-accent);
        border-radius: var(--border-radius);
        color: white;
        padding: 2rem;
        text-align: center;
        border: none;
        box-shadow: var(--shadow-medium);
        transition: var(--transition);
        height: 100%;
    }

    .info-card:hover {
        transform: translateY(-5px);
        box-shadow: var(--shadow-heavy);
    }

    .info-card i {
        font-size: 3rem;
        margin-bottom: 1rem;
        opacity: 0.9;
    }

    .info-card h5 {
        font-weight: 600;
        margin-bottom: 1rem;
    }

    .destinations-grid {
        margin-bottom: 4rem;
    }

    .destination-card {
        animation: fadeInUp 0.6s ease-out;
        animation-fill-mode: both;
    }

    .destination-card:nth-child(1) { animation-delay: 0.1s; }
    .destination-card:nth-child(2) { animation-delay: 0.2s; }
    .destination-card:nth-child(3) { animation-delay: 0.3s; }
    .destination-card:nth-child(4) { animation-delay: 0.4s; }
    .destination-card:nth-child(5) { animation-delay: 0.5s; }
    .destination-card:nth-child(6) { animation-delay: 0.6s; }

    .card {
        border: none;
        border-radius: var(--border-radius);
        overflow: hidden;
        transition: var(--transition);
        background: var(--color-bg-secondary, white);
        box-shadow: var(--shadow-light);
        display: flex;
        flex-direction: column;
        height: 100%;
    }

    .card:hover {
        transform: translateY(-8px);
        box-shadow: var(--shadow-heavy);
    }

    .destination-image {
        height: 280px;
        object-fit: cover;
        transition: var(--transition);
    }

    .card:hover .destination-image {
        transform: scale(1.05);
    }

    .card-img-top {
        position: relative;
        overflow: hidden;
    }

    .overlay-gradient {
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        height: 60%;
        background: linear-gradient(to top, rgba(0, 0, 0, 0.7) 0%, transparent 100%);
        pointer-events: none;
    }

    .badge {
        border-radius: 20px;
        padding: 0.5rem 1rem;
        font-weight: 500;
        letter-spacing: 0.3px;
        font-size: 0.8rem;
    }

    .badge.bg-warning {
        background: linear-gradient(135deg, #ffd700, #ffb347) !important;
        color: #8b4513;
        box-shadow: 0 4px 15px rgba(255, 215, 0, 0.4);
    }

    /* 不同类别的标签颜色 */
    .badge.category-nature {
        background: linear-gradient(135deg, #4CAF50, #45a049) !important;
        color: white;
        box-shadow: 0 4px 15px rgba(76, 175, 80, 0.4);
    }
    
    .badge.category-city {
        background: linear-gradient(135deg, #2196F3, #1976D2) !important;
        color: white;
        box-shadow: 0 4px 15px rgba(33, 150, 243, 0.4);
    }
    
    .badge.category-beach {
        background: linear-gradient(135deg, #00BCD4, #0097A7) !important;
        color: white;
        box-shadow: 0 4px 15px rgba(0, 188, 212, 0.4);
    }
    
    .badge.category-heritage {
        background: linear-gradient(135deg, #FF9800, #F57C00) !important;
        color: white;
        box-shadow: 0 4px 15px rgba(255, 152, 0, 0.4);
    }
    
    .badge.category-adventure {
        background: linear-gradient(135deg, #F44336, #D32F2F) !important;
        color: white;
        box-shadow: 0 4px 15px rgba(244, 67, 54, 0.4);
    }

    .badge.bg-primary {
        background: var(--gradient-primary) !important;
        box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
    }

    .rating-stars {
        display: flex;
        align-items: center;
        gap: 0.2rem;
    }

    .rating-stars i {
        font-size: 1rem;
        filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.3));
    }

    .card-body {
        padding: 1.5rem;
        display: flex;
        flex-direction: column;
        flex-grow: 1;
    }

    .card-title {
        font-family: 'Playfair Display', serif;
        font-size: 1.4rem;
        font-weight: 600;
        color: var(--dark-bg);
        margin-bottom: 1rem;
        line-height: 1.3;
    }

    .location-info {
        display: flex;
        align-items: center;
        margin-bottom: 1rem;
        font-size: 0.9rem;
    }

    .location-info i {
        color: var(--primary-color);
        margin-right: 0.5rem;
    }

    .card-text {
        font-size: 0.95rem;
        line-height: 1.6;
        color: #6c757d;
    }

    .highlights {
        margin-bottom: 1.5rem;
    }

    .highlights h6 {
        color: var(--dark-bg);
        font-weight: 600;
        margin-bottom: 0.75rem;
    }

    .highlight-tags .badge {
        background: #f8f9fa !important;
        color: #495057;
        border: 1px solid #e9ecef;
        margin-right: 0.5rem;
        margin-bottom: 0.5rem;
    }

    .destination-details {
        background: var(--color-bg-secondary, #f8f9fa);
        border-radius: 12px;
        padding: 1rem;
        margin-bottom: 1.5rem;
    }

    .detail-item {
        text-align: center;
    }

    .detail-item i {
        color: var(--primary-color);
        font-size: 1.2rem;
        margin-bottom: 0.5rem;
        display: block;
    }

    /* Colorful icon accents */
    .detail-item .icon-duration { /* calendar icon: duration */
        color: #87CEEB; /* sky blue */
    }
    .detail-item .icon-season { /* thermometer icon: best season */
        color: #FF6B6B; /* coral red */
    }
    .detail-item .difficulty-easy { /* mountain icon: easy */
        color: #27AE60; /* green */
    }
    .detail-item .difficulty-moderate { /* mountain icon: moderate */
        color: #F39C12; /* orange */
    }
    .detail-item .difficulty-hard { /* mountain icon: challenging */
        color: #E74C3C; /* red */
    }

    .detail-item small {
        color: #6c757d;
        font-weight: 500;
        font-size: 0.8rem;
    }

    .price-info {
        display: flex;
        flex-direction: column;
    }

    .price-label {
        font-size: 0.8rem;
        color: #6c757d;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        font-weight: 500;
    }

    .price-amount {
        font-size: 1.5rem;
        font-weight: 700;
        color: var(--primary-color);
        line-height: 1;
    }

    .action-buttons {
        display: flex;
        gap: 0.5rem;
        margin-top: auto;
    }
    
    .card-footer-section {
        margin-top: auto;
        padding-top: 1rem;
        border-top: 1px solid #f0f0f0;
    }

    .btn-sm {
        padding: 0.5rem 1rem;
        font-size: 0.85rem;
        border-radius: 8px;
        font-weight: 600;
        transition: var(--transition);
    }

    .btn-outline-primary {
        border: 2px solid var(--primary-color);
        color: var(--primary-color);
    }

    .btn-outline-primary:hover {
        background: var(--primary-color);
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(218, 165, 32, 0.3);
    }

    .btn-primary {
        background: var(--primary-color);
        border: 2px solid var(--primary-color);
    }

    .btn-primary:hover {
        background: var(--primary-hover);
        border-color: var(--primary-hover);
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(218, 165, 32, 0.4);
    }

    .empty-state {
        text-align: center;
        padding: 4rem 2rem;
        background: var(--color-bg-secondary, white);
        border-radius: var(--border-radius);
        box-shadow: var(--shadow-light);
    }

    .empty-state i {
        font-size: 4rem;
        color: #dee2e6;
        margin-bottom: 1.5rem;
    }

    .empty-state h4 {
        color: #6c757d;
        margin-bottom: 1rem;
        font-weight: 600;
    }

    .empty-state p {
        color: #6c757d;
        margin-bottom: 2rem;
        max-width: 500px;
        margin-left: auto;
        margin-right: auto;
    }

    .alert {
        border-radius: var(--border-radius);
        padding: 1rem 1.5rem;
        border: none;
        box-shadow: var(--shadow-light);
    }

    .alert-danger {
        background: linear-gradient(135deg, #ff6b6b, #ee5a52);
        color: white;
    }

    .floating-action {
        position: fixed;
        bottom: 2rem;
        right: 2rem;
        z-index: 1000;
    }


    /* ============================================
       RESPONSIVE DESIGN - OPTIMIZED FOR ALL DEVICES
       ============================================ */
    
    /* Large Desktops (1200px+) */
    @media (max-width: 1400px) {
        .container {
            max-width: 1200px;
        }
    }
    
    /* Medium Desktops (992px - 1199px) */
    @media (max-width: 1200px) {
        .hero-title {
            font-size: 3.8rem;
        }
        
        .hero-subtitle {
            font-size: 1.4rem;
        }
        
        .container {
            max-width: 1140px;
        }
        
        .destination-image {
            height: 250px;
        }
    }

    /* Tablets Landscape (768px - 991px) */
    @media (max-width: 992px) {
        .hero-section {
            min-height: 70vh;
        }
        
        .hero-title {
            font-size: 3.2rem;
            line-height: 1.2;
        }
        
        .hero-subtitle {
            font-size: 1.25rem;
            margin-bottom: 2rem;
        }
        
        .hero-cta .btn {
            padding: 0.9rem 2rem;
            font-size: 1.1rem;
        }
        
        .hero-stats {
            position: static;
            margin: 2rem auto 0;
            max-width: 180px;
            padding: 1.25rem;
        }
        
        .hero-stats .stat-number {
            font-size: 2rem;
        }
        
        .section-title {
            font-size: 2.2rem;
        }
        
        .filter-section {
            margin-bottom: 3rem;
        }
        
        /* 3列改为2列 */
        .destinations-grid .col-lg-4 {
            flex: 0 0 50%;
            max-width: 50%;
        }
    }

    /* Tablets Portrait (576px - 767px) */
    @media (max-width: 768px) {
        .hero-section {
            min-height: 60vh;
            margin-bottom: 2rem;
        }
        
        .hero-title {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }
        
        .hero-subtitle {
            font-size: 1.1rem;
            margin-bottom: 1.5rem;
        }
        
        .hero-cta .btn {
            padding: 0.8rem 1.75rem;
            font-size: 1rem;
        }
        
        .hero-content {
            padding: 1.5rem;
        }
        
        .section-title {
            font-size: 1.8rem;
        }
        
        .section-title::after {
            width: 50px;
            height: 3px;
        }
        
        .filter-card {
            padding: 1.25rem;
        }
        
        .form-label {
            font-size: 0.85rem;
        }
        
        /* 过滤器改为单列布局 */
        .filter-section .col-md-5,
        .filter-section .col-md-2 {
            margin-bottom: 0.75rem;
        }
        
        .filter-section .col-md-5:last-child,
        .filter-section .col-md-2:last-child {
            margin-bottom: 0;
        }
        
        /* 卡片改为单列 */
        .destinations-grid .col-lg-4,
        .destinations-grid .col-md-6 {
            flex: 0 0 100%;
            max-width: 100%;
        }
        
        .destination-image {
            height: 280px;
        }
        
        .card-title {
            font-size: 1.35rem;
        }
        
        .destination-details {
            padding: 1rem;
        }
        
        .destination-details .col-4 {
            flex: 0 0 33.333%;
            max-width: 33.333%;
            margin-bottom: 0;
            text-align: center;
        }
        
        .detail-item {
            flex-direction: column;
            align-items: center;
            text-align: center;
        }
        
        .detail-item i {
            margin-bottom: 0.25rem;
        }
        
        .detail-item small {
            font-size: 0.75rem;
            line-height: 1.2;
        }
        
        /* 价格和按钮布局优化 */
        .card-body > .d-flex:last-child {
            flex-direction: column;
            align-items: stretch !important;
            gap: 1rem;
        }
        
        .price-info {
            align-items: center;
            text-align: center;
        }
        
        .action-buttons {
            flex-direction: row;
            width: 100%;
        }
        
        .action-buttons .btn {
            flex: 1;
            padding: 0.6rem 0.75rem;
            font-size: 0.85rem;
        }
        
        .action-buttons .btn i {
            display: none;
        }
        
        .floating-action {
            bottom: 1rem;
            right: 1rem;
        }
        
        /* 徽章优化 */
        .badge {
            padding: 0.4rem 0.8rem;
            font-size: 0.75rem;
        }
        
        .highlight-tags .badge {
            font-size: 0.7rem;
            padding: 0.3rem 0.6rem;
        }
    }

    /* Mobile (max 575px) */
    @media (max-width: 576px) {
        .hero-section {
            min-height: 50vh;
            margin-bottom: 1.5rem;
        }
        
        .hero-title {
            font-size: 2rem;
            line-height: 1.15;
        }
        
        .hero-subtitle {
            font-size: 0.95rem;
            margin-bottom: 1.25rem;
        }
        
        .hero-cta .btn {
            padding: 0.7rem 1.5rem;
            font-size: 0.95rem;
            width: 100%;
            max-width: 280px;
        }
        
        .hero-content {
            padding: 1rem;
        }
        
        /* 移动端优化视频显示 */
        .hero-video {
            display: block;
            height: 100%;
            object-fit: cover;
        }
        
        .hero-overlay {
            background: linear-gradient(
                135deg,
                rgba(0, 0, 0, 0.5) 0%,
                rgba(0, 0, 0, 0.3) 50%,
                rgba(0, 0, 0, 0.5) 100%
            );
        }
        
        .container {
            padding: 0 0.75rem;
        }
        
        .section-title {
            font-size: 1.5rem;
            margin-bottom: 0.75rem;
        }
        
        .filter-section {
            margin-bottom: 2rem;
        }
        
        .filter-card {
            padding: 1rem;
            border-radius: 12px;
        }
        
        .form-control, .form-select {
            padding: 0.65rem 0.85rem;
            font-size: 0.95rem;
            border-radius: 10px;
        }
        
        .btn-outline-secondary {
            padding: 0.65rem 0.85rem;
            font-size: 0.95rem;
        }
        
        .destinations-grid {
            margin-bottom: 2rem;
        }
        
        .destination-image {
            height: 220px;
        }
        
        .card {
            border-radius: 12px;
        }
        
        .card-body {
            padding: 1rem;
        }
        
        .card-title {
            font-size: 1.25rem;
            margin-bottom: 0.75rem;
        }
        
        .location-info {
            font-size: 0.85rem;
            margin-bottom: 0.75rem;
        }
        
        .card-text {
            font-size: 0.9rem;
            line-height: 1.5;
            margin-bottom: 1rem;
        }
        
        .highlights h6 {
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }
        
        .highlight-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 0.25rem;
        }
        
        .highlight-tags .badge {
            font-size: 0.7rem;
            padding: 0.25rem 0.5rem;
            margin: 0;
        }
        
        .destination-details {
            padding: 0.75rem;
            margin-bottom: 1rem;
        }
        
        .destination-details .col-4 {
            padding: 0.25rem;
        }
        
        .detail-item i {
            font-size: 1rem;
        }
        
        .detail-item small {
            font-size: 0.7rem;
        }
        
        .price-info {
            margin-bottom: 1rem;
        }
        
        .price-amount {
            font-size: 1.35rem;
        }
        
        .price-label {
            font-size: 0.75rem;
        }
        
        .action-buttons {
            gap: 0.5rem;
        }
        
        .action-buttons .btn {
            padding: 0.6rem 0.5rem;
            font-size: 0.8rem;
            border-radius: 8px;
        }
        
        /* 在移动端显示按钮图标 */
        .action-buttons .btn i {
            display: inline;
            margin-right: 0.25rem;
        }
        
        /* 评分星星优化 */
        .rating-stars {
            gap: 0.15rem;
        }
        
        .rating-stars i {
            font-size: 0.85rem;
        }
        
        .rating-stars span {
            font-size: 0.75rem;
        }
        
        /* 位置徽章优化 */
        .position-absolute.top-0.start-0,
        .position-absolute.top-0.end-0 {
            margin: 0.5rem;
        }
        
        .badge {
            padding: 0.35rem 0.7rem;
            font-size: 0.7rem;
        }
        
        /* 空状态优化 */
        .empty-state {
            padding: 2.5rem 1rem;
        }
        
        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        
        .empty-state h4 {
            font-size: 1.1rem;
        }
        
        .empty-state p {
            font-size: 0.9rem;
        }
        
        /* 浮动按钮优化 */
        .floating-action {
            bottom: 0.75rem;
            right: 0.75rem;
        }
        
        .floating-action .btn {
            width: 50px;
            height: 50px;
            padding: 0;
            border-radius: 50%;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
        }
    }
    
    /* Very Small Devices (max 375px) */
    @media (max-width: 375px) {
        .hero-title {
            font-size: 1.75rem;
        }
        
        .hero-subtitle {
            font-size: 0.9rem;
        }
        
        .section-title {
            font-size: 1.35rem;
        }
        
        .card-title {
            font-size: 1.15rem;
        }
        
        .destination-image {
            height: 200px;
        }
        
        .action-buttons {
            flex-direction: column;
            gap: 0.5rem;
        }
        
        .action-buttons .btn {
            width: 100%;
        }
        
        .destination-details .col-4 {
            flex: 0 0 100%;
            max-width: 100%;
            margin-bottom: 0.5rem;
        }
        
        .destination-details .col-4:last-child {
            margin-bottom: 0;
        }
    }
    
    /* Touch Device Optimizations */
    @media (hover: none) and (pointer: coarse) {
        .btn, .form-control, .form-select {
            min-height: 44px; /* iOS推荐的最小触摸目标 */
        }
        
        .card:hover {
            transform: none; /* 移除hover效果 */
        }
        
        .card:active {
            transform: scale(0.98);
            transition: transform 0.1s ease;
        }
        
        /* 为触摸设备增加点击反馈 */
        .btn:active {
            transform: scale(0.95);
        }
        
        /* 移除hover动画，使用active状态 */
        .destination-image {
            transition: none;
        }
        
        .card:active .destination-image {
            opacity: 0.9;
        }
    }
    
    /* Landscape Phone Optimization */
    @media (max-width: 896px) and (orientation: landscape) {
        .hero-section {
            min-height: 100vh;
        }
        
        .hero-title {
            font-size: 2.5rem;
        }
        
        .hero-subtitle {
            font-size: 1rem;
        }
    }
    
    /* Print Styles */
    @media print {
        .hero-video,
        .hero-overlay,
        .filter-section,
        .action-buttons,
        .floating-action {
            display: none !important;
        }
        
        .card {
            page-break-inside: avoid;
        }
    }

    .loading-shimmer {
        background: linear-gradient(90deg, #f0f0f0 25%, #e0e0e0 50%, #f0f0f0 75%);
        background-size: 200% 100%;
        animation: shimmer 1.5s infinite;
    }

    @keyframes shimmer {
        0% { background-position: -200% 0; }
        100% { background-position: 200% 0; }
    }

    .text-gradient {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
    }
    
    /* Dark mode overrides */
    [data-theme="dark"] .section-title,
    body.dark-mode .section-title,
    [data-theme="dark"] .card-title,
    body.dark-mode .card-title {
        color: var(--color-text-primary, #f8f9fa);
    }

    [data-theme="dark"] .card,
    body.dark-mode .card {
        background: rgba(255, 255, 255, 0.04);
        border: 1px solid rgba(255, 255, 255, 0.08);
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.35);
        backdrop-filter: blur(12px) saturate(140%);
    }

    [data-theme="dark"] .card-text,
    body.dark-mode .card-text,
    [data-theme="dark"] .location-info .text-muted,
    body.dark-mode .location-info .text-muted {
        color: var(--color-text-secondary, #adb5bd) !important;
    }

    [data-theme="dark"] .destination-details,
    body.dark-mode .destination-details {
        background: rgba(255, 255, 255, 0.04);
        border: 1px solid rgba(255, 255, 255, 0.08);
    }

    [data-theme="dark"] .filter-card,
    body.dark-mode .filter-card {
        background: rgba(255, 255, 255, 0.04);
        border: 1px solid rgba(255, 255, 255, 0.08);
        box-shadow: 0 8px 24px rgba(0, 0, 0, 0.3);
        backdrop-filter: blur(10px) saturate(130%);
    }

    [data-theme="dark"] .page-container::before,
    body.dark-mode .page-container::before {
        background: var(--color-bg-primary, #212529);
    }

    /* Fix: remove thin top white bar by aligning hero with global body padding */
    .page-container .hero-section { margin-top: -85px !important; padding-top: 85px !important; }
    @media (max-width: 768px) { .page-container .hero-section { margin-top: -65px !important; padding-top: 65px !important; } }
</style>

<jsp:include page="../includes/navigation.jsp">
    <jsp:param name="currentPage" value="destinations" />
</jsp:include>

<div class="page-container">
    <section class="hero-section">
        <video class="hero-video" autoplay muted loop playsinline>
            <source src="${pageContext.request.contextPath}/videos/EuropeanCities.mp4" type="video/mp4">
            <span data-i18n="video.unsupported">Your browser does not support the video tag.</span>
        </video>
        <div class="hero-overlay"></div>
        
        <div class="hero-content">
            <h1 class="hero-title" data-i18n="dest.hero.title">Find Your Corner of the World</h1>
            <p class="hero-subtitle" data-i18n="dest.hero.subtitle">Your next great story is waiting. We've collected the planet's best spots—all that's missing is you.</p>
            
            <div class="hero-cta">
                <a href="#destinations" class="btn">
                    <i data-lucide="compass" class="me-2"></i><span data-i18n="dest.cta">Show Me the Magic</span>
                </a>
            </div>
        </div>
        
        <div class="hero-stats d-none d-md-block">
            <span class="stat-number" data-counter="${fn:length(destinations)}">0</span>
            <span class="stat-label" data-i18n="dest.stat.places">Amazing Places</span>
        </div>
    </section>

    <div class="container">
        <section class="filter-section">
            <div class="row">
                <div class="col-lg-9">
                    <h3 class="section-title">
                        <i data-lucide="filter" class="me-2"></i><span data-i18n="dest.filter.title">Find Your Perfect Vibe</span>
                    </h3>
                    
                    <div class="filter-card">
                        <div class="row g-3">
                            <div class="col-md-5">
                                <label class="form-label" data-i18n="dest.filter.country">Country</label>
                                <select class="form-select" id="countryFilter" onchange="applyFilters()">
                                    <option value="" data-i18n="dest.filter.allCountries">All Countries</option>
                                    <c:forEach var="country" items="${countries}">
                                        <option value="${country}">${country}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-5">
                                <label class="form-label" data-i18n="dest.filter.category">Category</label>
                                <select class="form-select" id="categoryFilter" onchange="applyFilters()">
                                    <option value="" data-i18n="dest.filter.allCategories">All Categories</option>
                                    <option value="NATURE" data-i18n="dest.cat.nature">Nature & Wildlife</option>
                                    <option value="CITY" data-i18n="dest.cat.city">City Experience</option>
                                    <option value="BEACH" data-i18n="dest.cat.beach">Beach Resort</option>
                                    <option value="HERITAGE" data-i18n="dest.cat.heritage">Cultural Heritage</option>
                                    <option value="ADVENTURE" data-i18n="dest.cat.adventure">Adventure</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label">&nbsp;</label>
                                <div class="d-grid">
                                    <button class="btn btn-outline-secondary" onclick="resetFilters()">
                                        <i data-lucide="rotate-ccw" class="me-1"></i><span data-i18n="common.reset">Reset</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="destinations-grid" id="destinations">
            <div class="row g-4" id="destinationsContainer">
                <c:choose>
                    <c:when test="${not empty destinations}">
                        <c:forEach var="destination" items="${destinations}">
                            <div class="col-lg-4 col-md-6 destination-card" 
                                 data-country="${destination.country}" 
                                 data-category="${destination.category}">
                                <div class="card h-100">
                                    <div class="position-relative">
                                        <c:choose>
                                            <c:when test="${not empty destination.imagePath}">
                                                <img src="${pageContext.request.contextPath}/${destination.imagePath}" 
                                                     class="card-img-top destination-image" 
                                                     alt="${destination.name}"
                                                     onerror="this.src='${pageContext.request.contextPath}/images/default-destination.jpg'" />
                                            </c:when>
                                            <c:otherwise>
                                                <img src="${pageContext.request.contextPath}/images/default-destination.jpg" 
                                                     class="card-img-top destination-image" 
                                                     alt="${destination.name}" />
                                            </c:otherwise>
                                        </c:choose>
                                        
                                        <c:if test="${destination.featured}">
                                            <div class="position-absolute top-0 start-0 m-3">
                                                <span class="badge bg-warning">
                                                    <i data-lucide="crown" class="me-1"></i><span data-i18n="dest.recommended">Recommended</span>
                                                </span>
                                            </div>
                                        </c:if>
                                        
                                        <div class="position-absolute top-0 end-0 m-3">
                                            <c:choose>
                                                <c:when test="${destination.category == 'NATURE'}">
                                                    <span class="badge category-nature">
                                                        <i data-lucide="leaf" class="me-1"></i><span data-i18n="dest.cat.nature">Nature & Wildlife</span>
                                                    </span>
                                                </c:when>
                                                <c:when test="${destination.category == 'CITY'}">
                                                    <span class="badge category-city">
                                                        <i data-lucide="building-2" class="me-1"></i><span data-i18n="dest.cat.city">City Experience</span>
                                                    </span>
                                                </c:when>
                                                <c:when test="${destination.category == 'BEACH'}">
                                                    <span class="badge category-beach">
                                                        <i data-lucide="umbrella" class="me-1"></i><span data-i18n="dest.cat.beach">Beach Resort</span>
                                                    </span>
                                                </c:when>
                                                <c:when test="${destination.category == 'HERITAGE'}">
                                                    <span class="badge category-heritage">
                                                        <i data-lucide="landmark" class="me-1"></i><span data-i18n="dest.cat.heritage">Cultural Heritage</span>
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge category-adventure">
                                                        <i data-lucide="mountain" class="me-1"></i><span data-i18n="dest.cat.adventure">Adventure</span>
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        
                                        <div class="overlay-gradient"></div>
                                        
                                        <div class="position-absolute bottom-0 start-0 p-3 text-white">
                                            <div class="rating-stars">
                                                <c:forEach begin="1" end="${destination.rating}">
                                                    <i data-lucide="star" class="text-warning"></i>
                                                </c:forEach>
                                                <c:forEach begin="${destination.rating + 1}" end="5">
                                                    <i data-lucide="star" class="text-warning" style="opacity:0.35"></i>
                                                </c:forEach>
                                                <span class="ms-2">(${destination.totalReviews} <span data-i18n="dest.reviews">reviews</span>)</span>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="card-body">
                                        <h5 class="card-title" data-i18n="dest.name.${destination.id}">${fn:escapeXml(destination.name)}</h5>
                                        
                                        <div class="location-info">
                                            <i data-lucide="map-pin"></i>
                                            <span class="text-muted">
                                                <c:if test="${not empty destination.city}">
                                                    ${destination.city}, 
                                                </c:if>
                                                ${destination.country}
                                            </span>
                                        </div>
                                        
                                        <p class="card-text" data-i18n="dest.desc.${destination.id}">
                                            ${fn:substring(fn:escapeXml(destination.description), 0, 120)}
                                            <c:if test="${fn:length(destination.description) > 120}">...</c:if>
                                        </p>
                                        
                                        <c:if test="${not empty destination.highlights}">
                                            <div class="highlights">
                                                <h6 data-i18n="dest.highlights">Highlights</h6>
                                                <div class="highlight-tags" data-i18n="dest.highlights.${destination.id}">
                                                    <c:forEach var="highlight" items="${fn:split(destination.highlights, ',')}" end="2">
                                                        <span class="badge bg-light text-dark">
                                                            ${fn:trim(highlight)}
                                                        </span>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </c:if>
                                        
                                        <div class="destination-details">
                                            <div class="row">
                                                <div class="col-4">
                                                    <div class="detail-item">
                                                        <i data-lucide="calendar" class="icon-duration"></i>
                                                        <small>
                                                            <c:choose>
                                                                <c:when test="${destination.averageDuration > 0}">
                                                                    ${destination.averageDuration} days trip
                                                                </c:when>
                                                                <c:otherwise>
                                                                    Flexible
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </small>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="detail-item">
                                                        <i data-lucide="thermometer" class="icon-season"></i>
                                                        <small data-i18n="dest.bestTime.${destination.id}">
                                                            ${destination.bestTimeToVisit != null ? destination.bestTimeToVisit : 'Year-round'}
                                                        </small>
                                                    </div>
                                                </div>
                                                <div class="col-4">
                                                    <div class="detail-item">
                                                        <i data-lucide="mountain" class="icon-difficulty ${destination.difficultyLevel == 'EASY' ? 'difficulty-easy' : destination.difficultyLevel == 'MODERATE' ? 'difficulty-moderate' : 'difficulty-hard'}"></i>
                                                        <small>
                                                            ${destination.difficultyLevel == 'EASY' ? 'Easy' : 
                                                              destination.difficultyLevel == 'MODERATE' ? 'Moderate' : 'Challenging'}
                                                        </small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <!-- Price and button area - fixed at card bottom -->
                                        <div class="card-footer-section">
                                            <div class="price-info mb-3">
                                                <c:if test="${destination.basePrice != null}">
                                                    <span class="price-label" data-i18n="dest.from">From</span>
                                                    <div class="price-amount">
                                                        RM <fmt:formatNumber value="${destination.basePrice}" pattern="#,##0.00" />
                                                    </div>
                                                </c:if>
                                            </div>
                                            <div class="action-buttons">
                                                <a href="${pageContext.request.contextPath}/destinations/${destination.id}" 
                                                   class="btn btn-outline-primary btn-sm">
                                                    <i data-lucide="eye" class="me-1"></i><span data-i18n="dest.explore">Explore</span>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/booking?destination=${destination.id}" 
                                                   class="btn btn-primary btn-sm">
                                                    <i data-lucide="plane" class="me-1"></i><span data-i18n="dest.takeMeThere">Take Me There</span>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="col-12">
                            <div class="empty-state">
                                <i data-lucide="map-pin"></i>
                                <h4 data-i18n="dest.empty.title">It's a Bit Empty In Here...</h4>
                                <p data-i18n="dest.empty.desc">We couldn't find any destinations matching your filters. Try a different combination or check back soon as we're always adding new places!</p>
                                <a href="${pageContext.request.contextPath}/contact" class="btn btn-primary">
                                    <i data-lucide="mail" class="me-2"></i><span data-i18n="dest.empty.suggest">Suggest a Destination</span>
                                </a>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger" role="alert">
                <i data-lucide="alert-triangle" class="me-2"></i>${error}
            </div>
        </c:if>
    </div>

</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        animateCounter();
        initializeScrollAnimations();
        initializeVideoBackground();
        initializeResponsiveOptimizations();
        initializeTouchOptimizations();
    });

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
    
    function initializeResponsiveOptimizations() {
        // 响应窗口大小变化
        let resizeTimer;
        window.addEventListener('resize', function() {
            clearTimeout(resizeTimer);
            resizeTimer = setTimeout(function() {
                handleResponsiveChanges();
            }, 250);
        });
        
        // 初始化时执行一次
        handleResponsiveChanges();
    }
    
    function handleResponsiveChanges() {
        const width = window.innerWidth;
        const video = document.querySelector('.hero-video');
        
        // 确保视频在所有设备上显示
        if (video && video.readyState >= 2) {
            video.style.display = 'block';
            video.play().catch(console.error);
        }
        
        // 调整卡片动画延迟
        const cards = document.querySelectorAll('.destination-card');
        const baseDelay = width <= 768 ? 0.05 : 0.1;
        cards.forEach((card, index) => {
            card.style.animationDelay = (index * baseDelay) + 's';
        });
    }
    
    function initializeTouchOptimizations() {
        // 检测是否为触摸设备
        const isTouchDevice = 'ontouchstart' in window || navigator.maxTouchPoints > 0;
        
        if (isTouchDevice) {
            // 为卡片添加触摸反馈
            const cards = document.querySelectorAll('.card');
            cards.forEach(card => {
                card.addEventListener('touchstart', function() {
                    this.style.transform = 'scale(0.98)';
                }, { passive: true });
                
                card.addEventListener('touchend', function() {
                    setTimeout(() => {
                        this.style.transform = '';
                    }, 150);
                }, { passive: true });
            });
            
            // 优化滚动性能
            document.body.style.webkitOverflowScrolling = 'touch';
        }
    }

    function animateCounter() {
        const counter = document.querySelector('[data-counter]');
        if (counter) {
            const target = parseInt(counter.getAttribute('data-counter'));
            let current = 0;
            const increment = target / 100;
            const timer = setInterval(() => {
                current += increment;
                counter.textContent = Math.floor(current);
                if (current >= target) {
                    counter.textContent = target;
                    clearInterval(timer);
                }
            }, 20);
        }
    }

    function initializeScrollAnimations() {
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.animationPlayState = 'running';
                }
            });
        }, observerOptions);

        document.querySelectorAll('.destination-card').forEach(card => {
            card.style.animationPlayState = 'paused';
            observer.observe(card);
        });
    }

    function applyFilters() {
        const countryFilter = document.getElementById('countryFilter').value;
        const categoryFilter = document.getElementById('categoryFilter').value;
        
        const cards = document.querySelectorAll('.destination-card');
        let visibleCount = 0;
        
        cards.forEach(card => {
            const cardCountry = card.getAttribute('data-country');
            const cardCategory = card.getAttribute('data-category');
            
            const matchesCountry = !countryFilter || cardCountry === countryFilter;
            const matchesCategory = !categoryFilter || cardCategory === categoryFilter;
            
            if (matchesCountry && matchesCategory) {
                card.style.display = 'block';
                card.style.animationDelay = (visibleCount * 0.1) + 's';
                visibleCount++;
            } else {
                card.style.display = 'none';
            }
        });

        if (visibleCount === 0) {
            showNoResultsMessage();
        } else {
            hideNoResultsMessage();
        }
    }

    function resetFilters() {
        document.getElementById('countryFilter').value = '';
        document.getElementById('categoryFilter').value = '';
        
        document.querySelectorAll('.destination-card').forEach((card, index) => {
            card.style.display = 'block';
            card.style.animationDelay = (index * 0.1) + 's';
        });
        
        hideNoResultsMessage();
    }

    function showNoResultsMessage() {
        let noResultsMsg = document.getElementById('noResultsMessage');
        if (!noResultsMsg) {
            noResultsMsg = document.createElement('div');
            noResultsMsg.id = 'noResultsMessage';
            noResultsMsg.className = 'col-12';
            noResultsMsg.innerHTML = `
                <div class="empty-state">
                    <i data-lucide="search"></i>
                    <h4 data-i18n="dest.noresults.title">No Matching Destinations Found</h4>
                    <p data-i18n="dest.noresults.desc">Please try adjusting your search criteria or filters</p>
                    <button class="btn btn-primary" onclick="resetFilters()">
                        <i data-lucide="rotate-ccw" class="me-2"></i><span data-i18n="dest.noresults.reset">Reset Filters</span>
                    </button>
                </div>
            `;
            if (typeof lucide !== 'undefined') { try { lucide.createIcons(); } catch (e) {} }
            document.getElementById('destinationsContainer').appendChild(noResultsMsg);
        }
        noResultsMsg.style.display = 'block';
    }

    function hideNoResultsMessage() {
        const noResultsMsg = document.getElementById('noResultsMessage');
        if (noResultsMsg) {
            noResultsMsg.style.display = 'none';
        }
    }


    // 桌面端的hover效果（仅在非触摸设备上生效）
    const isTouchDevice = 'ontouchstart' in window || navigator.maxTouchPoints > 0;
    
    if (!isTouchDevice) {
        document.querySelectorAll('.card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-8px) scale(1.02)';
            });
            
            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0) scale(1)';
            });
        });
    }

    // 平滑滚动到目的地列表
    const heroBtn = document.querySelector('.hero-cta .btn');
    if (heroBtn) {
        heroBtn.addEventListener('click', function(e) {
            e.preventDefault();
            const destSection = document.getElementById('destinations');
            if (destSection) {
                destSection.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    }
    
    // 优化移动端过滤器体验
    const filterInputs = document.querySelectorAll('.filter-card select');
    filterInputs.forEach(input => {
        input.addEventListener('change', function() {
            // 添加视觉反馈
            this.style.borderColor = 'var(--primary-color)';
            setTimeout(() => {
                this.style.borderColor = '';
            }, 300);
        });
    });
    
    // 懒加载图片优化
    if ('IntersectionObserver' in window) {
        const imageObserver = new IntersectionObserver((entries, observer) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    const img = entry.target;
                    if (img.dataset.src) {
                        img.src = img.dataset.src;
                        img.removeAttribute('data-src');
                        observer.unobserve(img);
                    }
                }
            });
        }, {
            rootMargin: '50px 0px'
        });
        
        document.querySelectorAll('img[data-src]').forEach(img => {
            imageObserver.observe(img);
        });
    }
</script>

<jsp:include page="../includes/footer.jsp" />