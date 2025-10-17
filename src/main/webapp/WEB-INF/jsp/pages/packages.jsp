<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="${pageTitle}" />
    <jsp:param name="currentPage" value="packages" />
</jsp:include>


<script>
    // Viewport height fix for mobile browsers (handles address bar show/hide)
    (function() {
        function setViewportUnit() {
            var vh = window.innerHeight * 0.01;
            document.documentElement.style.setProperty('--vh', vh + 'px');
        }
        setViewportUnit();
        window.addEventListener('resize', setViewportUnit);
        window.addEventListener('orientationchange', setViewportUnit);
    })();
</script>

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
        --gradient-luxury: linear-gradient(135deg, #ffd700 0%, #ffb347 100%);
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
        margin: 0 !important;
        padding: 0 !important;
    }
    
    /* 确保页面从最顶部开始，避免闪烁 */
    html {
        margin: 0;
        padding: 0;
        overflow-x: hidden;
    }
    
    /* 防止页面加载时的布局跳动 */
    html, body, #root, .page-container, .hero-section {
        margin: 0 !important;
    }

    .page-container {
        min-height: 100vh;
        position: relative;
        padding-top: 0 !important;
        margin-top: 0 !important;
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
        /* Full-viewport height across browsers */
        height: 100vh;
        height: 100svh;
        height: 100dvh;
        min-height: 100dvh;
        height: calc(var(--vh, 1vh) * 100);
        min-height: calc(var(--vh, 1vh) * 100);
        width: 100%;
        display: flex;
        align-items: center;
        position: relative;
        overflow: hidden;
        margin: 0 !important;
        padding: 0 !important;
        top: 0;
        left: 0;
    }

    /* Neutralize global navigation offsets for packages page */
    .packages-page .hero-section {
        margin-top: 0 !important;
        padding-top: 0 !important;
        height: calc(var(--vh, 1vh) * 100) !important;
        min-height: calc(var(--vh, 1vh) * 100) !important;
    }

    .hero-video {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        object-fit: cover;
        z-index: 1;
        opacity: 1;
        transition: opacity 0.3s ease;
    }
    
    /* 移除依赖[src]选择器的隐藏逻辑，避免因<source>子元素导致视频被永久隐藏 */

    .hero-overlay {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(
            135deg,
            rgba(0, 0, 0, 0.7) 0%,
            rgba(0, 0, 0, 0.5) 50%,
            rgba(0, 0, 0, 0.7) 100%
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
        font-family: var(--font-heading);
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

    .filter-section {
        margin-bottom: 3rem;
        animation: fadeInUp 0.8s ease-out;
    }

    .filter-card {
        background: var(--color-bg-secondary, white);
        border-radius: var(--border-radius);
        padding: 2rem;
        box-shadow: var(--shadow-light);
        border: 1px solid rgba(0, 0, 0, 0.05);
        transition: var(--transition);
        margin-bottom: 2rem;
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

    .form-control, .form-select, .form-range {
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

    .input-group-text {
        background: var(--primary-color);
        border: 2px solid var(--primary-color);
        color: white;
        border-radius: 12px 0 0 12px;
    }

    .input-group .form-control {
        border-left: none;
        border-radius: 0 12px 12px 0;
    }

    .price-range-container {
        position: relative;
    }

    .price-value {
        display: block;
        text-align: center;
        margin-top: 0.5rem;
        font-weight: 600;
        color: var(--primary-color);
        font-size: 0.9rem;
    }

    .filter-tabs {
        display: flex;
        gap: 0.5rem;
        flex-wrap: wrap;
    }

    .filter-tab {
        background: #f8f9fa;
        border: 2px solid #e9ecef;
        color: #6c757d;
        border-radius: 25px;
        padding: 0.5rem 1.5rem;
        font-size: 0.9rem;
        font-weight: 500;
        transition: var(--transition);
        cursor: pointer;
    }

    .filter-tab:hover {
        background: #e9ecef;
        border-color: #dee2e6;
    }

    .filter-tab.active {
        background: var(--primary-color);
        border-color: var(--primary-color);
        color: white;
        box-shadow: 0 4px 15px rgba(218, 165, 32, 0.3);
    }

    .filter-reset {
        background: #6c757d;
        border: 2px solid #6c757d;
        color: white;
        border-radius: 12px;
        padding: 0.75rem 1.5rem;
        font-weight: 600;
        transition: var(--transition);
    }

    .filter-reset:hover {
        background: #5a6268;
        border-color: #5a6268;
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(108, 117, 125, 0.3);
    }

    .results-count {
        font-size: 1rem;
        color: #6c757d;
        font-weight: 500;
        margin-bottom: 1rem;
    }

    .modern-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(380px, 1fr));
        gap: 2rem;
        margin-bottom: 0;
    }

    .package-card {
        animation: fadeInUp 0.6s ease-out;
        animation-fill-mode: both;
    }

    .package-card:nth-child(1) { animation-delay: 0.1s; }
    .package-card:nth-child(2) { animation-delay: 0.2s; }
    .package-card:nth-child(3) { animation-delay: 0.3s; }
    .package-card:nth-child(4) { animation-delay: 0.4s; }
    .package-card:nth-child(5) { animation-delay: 0.5s; }
    .package-card:nth-child(6) { animation-delay: 0.6s; }

    .card {
        border: none;
        border-radius: var(--border-radius);
        overflow: hidden;
        transition: var(--transition);
        background: var(--color-bg-secondary, white);
        box-shadow: var(--shadow-light);
    }

    .card:hover {
        transform: translateY(-8px);
        box-shadow: var(--shadow-heavy);
    }

    .card-img-container {
        position: relative;
        overflow: hidden;
        height: 250px;
    }

    .card-img-top {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: var(--transition);
    }

    .card:hover .card-img-top {
        transform: scale(1.05);
    }

    .package-badge {
        position: absolute;
        top: 1rem;
        right: 1rem;
        z-index: 10;
    }

    .featured-badge {
        position: absolute;
        top: 1rem;
        left: 1rem;
        z-index: 10;
    }

    .badge {
        display: inline-flex;
        align-items: center;
        border-radius: 14px;
        padding: 0.35rem 0.6rem;
        font-weight: 600;
        letter-spacing: 0.5px;
        font-size: 0.7rem;
        line-height: 1;
        text-transform: uppercase;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        border: 1px solid rgba(255, 255, 255, 0.3);
        backdrop-filter: blur(10px);
        transition: var(--transition);
    }

    /* Ensure icons inside badges are consistently sized */
    .badge i,
    .badge [data-lucide],
    .badge svg {
        width: 14px;
        height: 14px;
    }

    .badge:hover {
        transform: scale(1.05);
        box-shadow: 0 6px 20px rgba(0, 0, 0, 0.3);
    }

    /* 标准型 - 灰色渐变 */
    .badge.bg-primary {
        background: linear-gradient(135deg, #6C757D 0%, #495057 100%) !important;
        color: #ffffff;
        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
        border-color: rgba(255, 255, 255, 0.3);
    }

    /* 豪华型 - 金色渐变 */
    .badge.bg-success {
        background: linear-gradient(135deg, #FFD700 0%, #FFA500 100%) !important;
        color: #ffffff;
        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        border-color: rgba(255, 255, 255, 0.4);
    }

    /* 奢华型 - 蓝色渐变 */
    .badge.bg-warning {
        background: linear-gradient(135deg, #4A90E2 0%, #357ABD 100%) !important;
        color: #ffffff;
        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        border-color: rgba(255, 255, 255, 0.4);
    }

    /* 推荐标签 - 热情红渐变 */
    .badge.bg-danger {
        background: linear-gradient(135deg, #FF6B6B 0%, #EE5A6F 100%) !important;
        color: #ffffff;
        text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        border-color: rgba(255, 255, 255, 0.4);
        animation: pulse 2s ease-in-out infinite;
    }

    @keyframes pulse {
        0%, 100% {
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.4);
        }
        50% {
            box-shadow: 0 4px 25px rgba(255, 107, 107, 0.7);
        }
    }

    .card-body {
        padding: 1rem 1.5rem 0.75rem;
    }

    .destination-info {
        display: flex;
        align-items: center;
        margin-bottom: 1rem;
        font-size: 0.9rem;
    }

    .destination-info i {
        color: var(--primary-color);
        margin-right: 0.5rem;
    }

    .card-title {
        font-family: var(--font-heading);
        font-size: 1.4rem;
        font-weight: 600;
        color: var(--dark-bg);
        margin-bottom: 1rem;
        line-height: 1.3;
    }

    .card-text {
        font-size: 0.95rem;
        line-height: 1.6;
        color: #6c757d;
        margin-bottom: 1.5rem;
    }

    /* 套餐等级选择器样式 */
    .package-type-selector {
        margin-bottom: 1.2rem;
        position: relative;
    }

    .package-type-selector label {
        font-size: 0.8rem;
        font-weight: 700;
        color: #495057;
        margin-bottom: 0.6rem;
        display: flex;
        align-items: center;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }

    .package-type-selector label i {
        color: var(--primary-color);
        margin-right: 0.4rem;
        font-size: 0.9rem;
    }

    .package-type-selector select {
        width: 100%;
        padding: 0.8rem 2.5rem 0.8rem 1rem;
        border: 2px solid #e9ecef;
        border-radius: 12px;
        font-size: 1rem;
        font-weight: 600;
        color: #2c3e50;
        background: linear-gradient(to bottom, #ffffff, #f8f9fa);
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 12 12'%3E%3Cpath fill='%23DAA520' d='M6 9L1 4h10z'/%3E%3C/svg%3E");
        background-repeat: no-repeat;
        background-position: right 1rem center;
        background-size: 12px;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        cursor: pointer;
        appearance: none;
        -webkit-appearance: none;
        -moz-appearance: none;
        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
    }

    .package-type-selector select:hover {
        border-color: var(--primary-color);
        background: linear-gradient(to bottom, #ffffff, #ffffff);
        box-shadow: 0 4px 12px rgba(218, 165, 32, 0.15);
        transform: translateY(-1px);
    }

    .package-type-selector select:focus {
        outline: none;
        border-color: var(--primary-color);
        background: #ffffff;
        box-shadow: 0 0 0 4px rgba(218, 165, 32, 0.1), 0 4px 12px rgba(218, 165, 32, 0.2);
        transform: translateY(-1px);
    }

    .package-type-selector select:active {
        transform: translateY(0);
    }

    .package-type-selector select option {
        padding: 0.5rem;
        font-weight: 600;
        background: white;
        color: #2c3e50;
    }

    .package-type-selector select option:hover {
        background: #f8f9fa;
    }

    .package-details {
        background: var(--color-bg-secondary, #f8f9fa);
        border-radius: 12px;
        padding: 1rem;
        margin-bottom: 0.75rem;
    }

    .package-details .row > div {
        text-align: center;
        padding: 0.5rem;
    }

    .package-details i {
        color: var(--primary-color);
        font-size: 1.2rem;
        margin-bottom: 0.5rem;
        display: block;
    }

    .package-details small {
        color: #6c757d;
        font-weight: 500;
        font-size: 0.8rem;
    }

    .card-footer {
        background: transparent;
        border: none;
        padding: 0.5rem 1.5rem 1rem;
    }

    .card-footer .d-flex {
        gap: 0.5rem;
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

    .price {
        font-size: 1.8rem;
        font-weight: 700;
        color: var(--primary-color);
        line-height: 1;
        transition: var(--transition);
    }

    .package-actions {
        display: flex;
        gap: 0.5rem;
        flex-wrap: wrap;
        align-items: center;
        justify-content: flex-end;
    }

    .package-actions .btn {
        flex-shrink: 0;
        white-space: nowrap;
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
        grid-column: 1 / -1;
        text-align: center;
        padding: 4rem 2rem;
        background: var(--color-bg-secondary, white);
        border-radius: var(--border-radius);
        box-shadow: var(--shadow-light);
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
    [data-theme="dark"] .destination-info .text-muted,
    body.dark-mode .destination-info .text-muted {
        color: var(--color-text-secondary, #adb5bd) !important;
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

    /* Package details dark mode */
    [data-theme="dark"] .package-details,
    body.dark-mode .package-details {
        background: rgba(255, 255, 255, 0.06);
        border: 1px solid rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(8px) saturate(120%);
    }

    [data-theme="dark"] .package-details small,
    body.dark-mode .package-details small {
        color: var(--color-text-secondary, #adb5bd) !important;
    }

    [data-theme="dark"] .package-details i,
    [data-theme="dark"] .package-details [data-lucide],
    body.dark-mode .package-details i,
    body.dark-mode .package-details [data-lucide] {
        color: var(--primary-color) !important;
    }

    /* Form controls dark mode */
    [data-theme="dark"] .form-control,
    [data-theme="dark"] .form-select,
    [data-theme="dark"] .form-range,
    body.dark-mode .form-control,
    body.dark-mode .form-select,
    body.dark-mode .form-range {
        background: rgba(255, 255, 255, 0.08);
        border-color: rgba(255, 255, 255, 0.15);
        color: var(--color-text-primary, #f8f9fa);
    }

    [data-theme="dark"] .form-control:focus,
    [data-theme="dark"] .form-select:focus,
    [data-theme="dark"] .form-range:focus,
    body.dark-mode .form-control:focus,
    body.dark-mode .form-select:focus,
    body.dark-mode .form-range:focus {
        background: rgba(255, 255, 255, 0.12);
        border-color: var(--primary-color);
        box-shadow: 0 0 0 0.2rem rgba(218, 165, 32, 0.25);
    }

    /* Filter tabs dark mode */
    [data-theme="dark"] .filter-tab,
    body.dark-mode .filter-tab {
        background: rgba(255, 255, 255, 0.08);
        border-color: rgba(255, 255, 255, 0.15);
        color: var(--color-text-secondary, #adb5bd);
    }

    [data-theme="dark"] .filter-tab:hover,
    body.dark-mode .filter-tab:hover {
        background: rgba(255, 255, 255, 0.12);
        border-color: rgba(255, 255, 255, 0.2);
        color: var(--color-text-primary, #f8f9fa);
    }

    [data-theme="dark"] .filter-tab.active,
    body.dark-mode .filter-tab.active {
        background: var(--primary-color);
        border-color: var(--primary-color);
        color: white;
        box-shadow: 0 4px 15px rgba(218, 165, 32, 0.4);
    }

    /* Price range slider dark mode */
    [data-theme="dark"] .form-range::-webkit-slider-track,
    body.dark-mode .form-range::-webkit-slider-track {
        background: rgba(255, 255, 255, 0.15);
        border-radius: 6px;
    }

    [data-theme="dark"] .form-range::-webkit-slider-thumb,
    body.dark-mode .form-range::-webkit-slider-thumb {
        background: var(--primary-color);
        border: 2px solid rgba(255, 255, 255, 0.2);
        box-shadow: 0 2px 8px rgba(218, 165, 32, 0.3);
    }

    [data-theme="dark"] .form-range::-moz-range-track,
    body.dark-mode .form-range::-moz-range-track {
        background: rgba(255, 255, 255, 0.15);
        border-radius: 6px;
    }

    [data-theme="dark"] .form-range::-moz-range-thumb,
    body.dark-mode .form-range::-moz-range-thumb {
        background: var(--primary-color);
        border: 2px solid rgba(255, 255, 255, 0.2);
        box-shadow: 0 2px 8px rgba(218, 165, 32, 0.3);
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
        margin-bottom: 2rem;
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

    @media (max-width: 1200px) {
        .hero-title {
            font-size: 4rem;
        }
        
        .container {
            max-width: 1140px;
        }
        
        .modern-grid {
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
        }
    }

    @media (max-width: 992px) {
        .hero-title {
            font-size: 3.5rem;
        }
        
        .hero-subtitle {
            font-size: 1.3rem;
        }
        
        .hero-stats {
            position: static;
            margin: 2rem auto 0;
            max-width: 200px;
        }
        
        .modern-grid {
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-bottom: 0;
        }
    }

    @media (max-width: 768px) {
        .hero-section {
            /* Ensure true full-screen height on mobile */
            height: 100vh;
            height: 100svh;
            height: 100dvh;
            min-height: 100dvh;
            height: calc(var(--vh, 1vh) * 100);
            min-height: calc(var(--vh, 1vh) * 100);
            margin: 0 !important;
            padding: 0 !important;
        }
        
        .hero-title {
            font-size: 3rem;
        }
        
        .hero-subtitle {
            font-size: 1.1rem;
            margin-bottom: 2rem;
        }
        
        .section-title {
            font-size: 2rem;
        }
        
        .filter-card {
            padding: 1.5rem;
        }
        
        .modern-grid {
            grid-template-columns: 1fr;
            gap: 1rem;
            margin-bottom: 0;
        }
        
        .package-actions {
            flex-direction: row;
            flex-wrap: wrap;
            justify-content: flex-end;
        }

        .package-actions .btn {
            font-size: 0.8rem;
            padding: 0.4rem 0.8rem;
        }
        
        .floating-action {
            bottom: 1rem;
            right: 1rem;
        }
        
    }

    @media (max-width: 576px) {
        .hero-content {
            padding: 1rem;
        }
        
        .hero-title {
            font-size: 2.5rem;
        }
        
        .hero-subtitle {
            font-size: 1rem;
        }
        
        .container {
            padding: 0 0.5rem;
        }
        
        .filter-card {
            padding: 1rem;
        }
        
        .card-body {
            padding: 1rem;
        }
        
        .package-details {
            padding: 0.75rem;
        }
        
        .filter-tabs {
            justify-content: center;
        }
        
        .filter-tab {
            font-size: 0.8rem;
            padding: 0.4rem 1rem;
        }
    }

    /* Keep stats hidden; show overlay text */
    .hero-stats {
        display: none;
    }
</style>

<jsp:include page="../includes/navigation.jsp">
    <jsp:param name="currentPage" value="packages" />
</jsp:include>

<div class="page-container">
    <section class="hero-section">
        <video class="hero-video" autoplay muted loop playsinline>
            <source src="${pageContext.request.contextPath}/videos/MountTimelapse1.mp4" type="video/mp4">
            <span data-i18n="video.unsupported">Your browser does not support the video tag.</span>
        </video>
        <div class="hero-overlay"></div>
        
        <div class="hero-content">
            <h1 class="hero-title" data-i18n="packages.hero.title">Your Next Great Story Starts Here</h1>
            <p class="hero-subtitle" data-i18n="packages.hero.subtitle">Forget ordinary vacations. Let's find an adventure you'll be talking about for years.</p>
            
            <div class="hero-cta">
                <a href="#packages" class="btn">
                    <i data-lucide="suitcase" class="me-2"></i><span data-i18n="packages.hero.cta">Find My Adventure</span>
                </a>
            </div>
        </div>
        
        <div class="hero-stats d-none d-md-block">
            <span class="stat-number" data-counter="${fn:length(availableTravelPackages)}">0</span>
            <span class="stat-label" data-i18n="packages.hero.stats">Adventures Waiting</span>
        </div>
    </section>

    <div class="container">
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i data-lucide="alert-triangle" class="me-2"></i>${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <section class="filter-section">
            <h3 class="section-title">
                <i data-lucide="filter" class="me-2"></i><span data-i18n="packages.filter.title">Find Your Perfect Escape</span>
            </h3>
            
            <div class="filter-card">
                <div class="row g-3">
                    <!-- Search Input -->
                    <div class="col-md-4">
                        <label for="searchInput" class="form-label" data-i18n="packages.filter.searchLabel">Search by Keyword</label>
                        <div class="input-group">
                            <span class="input-group-text">
                                <i data-lucide="search"></i>
                            </span>
                            <input type="text" class="form-control" id="searchInput" data-i18n-attr='{"placeholder":"packages.filter.searchPlaceholder"}' placeholder="Search packages...">
                        </div>
                    </div>
                    
                    <!-- Destination Filter -->
                    <div class="col-md-3">
                        <label for="destinationFilter" class="form-label" data-i18n="packages.filter.destination">Destination</label>
                        <select class="form-select filter-select" id="destinationFilter">
                            <option value="" data-i18n="packages.filter.allDestinations">All Destinations</option>
                            <c:forEach var="destination" items="${destinations}">
                                <option value="${destination.name}" 
                                        ${selectedDestination == destination.name ? 'selected' : ''}>
                                    ${destination.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <!-- Sort -->
                    <div class="col-md-3">
                        <label for="sortBy" class="form-label" data-i18n="packages.filter.sortBy">Sort By</label>
                        <select class="form-select filter-select" id="sortBy">
                            <option value="name" data-i18n="packages.filter.sort.name">Name</option>
                            <option value="price-low" data-i18n="packages.filter.sort.priceLow">Price: Low to High</option>
                            <option value="price-high" data-i18n="packages.filter.sort.priceHigh">Price: High to Low</option>
                            <option value="newest" data-i18n="packages.filter.sort.newest">Newest</option>
                        </select>
                    </div>
                    
                    <!-- Price Range -->
                    <div class="col-md-2">
                        <label for="priceRange" class="form-label" data-i18n="packages.filter.maxPrice">Max Price</label>
                        <div class="price-range-container">
                            <input type="range" class="form-range" id="priceRange" 
                                   min="0" max="10000" value="10000" step="100">
                            <span class="price-value" id="priceValue">RM 10,000</span>
                        </div>
                    </div>
                </div>
                
                <!-- Filter Tabs -->
                <div class="filter-tabs mt-3">
                    <button class="filter-tab active" data-filter="category" data-value="" data-i18n="common.all">All</button>
                    <button class="filter-tab" data-filter="type" data-value="STANDARD" data-i18n="packages.filter.type.standard">Standard</button>
                    <button class="filter-tab" data-filter="type" data-value="PREMIUM" data-i18n="packages.filter.type.premium">Premium</button>
                    <button class="filter-tab" data-filter="type" data-value="LUXURY" data-i18n="packages.filter.type.luxury">Luxury</button>
                </div>
                
                <!-- Reset Button -->
                <div class="mt-3">
                    <button class="btn filter-reset" onclick="resetFilters()">
                        <i data-lucide="rotate-ccw" class="me-2"></i><span data-i18n="packages.filter.reset">Reset Filters</span>
                    </button>
                </div>
            </div>
        </section>

        <!-- Results Count -->
        <div id="resultsCount" class="results-count" data-i18n="packages.results" data-i18n-attr='{"data-count":"packages.results.count"}'>
            Showing ${fn:length(availableTravelPackages)} adventures
        </div>

        <!-- Packages Grid -->
        <section id="packages">
            <div class="modern-grid" id="packagesContainer">
                <c:choose>
                    <c:when test="${empty availableTravelPackages}">
                        <div class="empty-state" id="noPackagesMessage">
                            <i data-lucide="luggage"></i>
                            <h4 data-i18n="packages.empty.title">Looks Like We're Fresh Out!</h4>
                            <p data-i18n="packages.empty.desc">We couldn't find any packages that match your search. Try adjusting your filters or contact us for a custom-made adventure!</p>
                            <a href="${pageContext.request.contextPath}/contact" class="btn btn-primary">
                                <i data-lucide="mail" class="me-2"></i><span data-i18n="packages.empty.cta">Build My Trip</span>
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="pkg" items="${availableTravelPackages}" varStatus="status">
                            <div class="package-card" 
                                 data-filterable="true"
                                 data-destination="${pkg.destinationName}"
                                 data-price="${pkg.price}"
                                 data-type="${pkg.type}">
                                <div class="card h-100">
                                    <!-- Package Image -->
                                    <div class="card-img-container">
                                        <c:choose>
                                            <c:when test="${not empty pkg.imagePath}">
                                                <img src="${pageContext.request.contextPath}/${pkg.imagePath}" 
                                                     class="card-img-top" alt="${pkg.name}"
                                                     onerror="this.src='https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=400&h=250&fit=crop&auto=format'">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=400&h=250&fit=crop&auto=format" 
                                                     class="card-img-top" alt="${pkg.name}">
                                            </c:otherwise>
                                        </c:choose>
                                        
                                        <!-- Package Badge -->
                                        <div class="package-badge">
                                            <c:choose>
                                                <c:when test="${pkg.type == 'LUXURY'}">
                                                    <span class="badge bg-warning" data-i18n="packages.badge.luxury">💎 LUXURY</span>
                                                </c:when>
                                                <c:when test="${pkg.type == 'PREMIUM'}">
                                                    <span class="badge bg-success" data-i18n="packages.badge.premium">👑 PREMIUM</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-primary" data-i18n="packages.badge.standard">⭐ STANDARD</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        
                                        <!-- Featured Badge -->
                                        <c:if test="${pkg.featured}">
                                            <div class="featured-badge">
                                                <span class="badge bg-danger">
                                                    <i data-lucide="star" class="me-1"></i><span data-i18n="dest.recommended">Recommended</span>
                                                </span>
                                            </div>
                                        </c:if>
                                    </div>
                                    
                                    <div class="card-body">
                                        <!-- Destination -->
                                        <div class="destination-info">
                                            <i data-lucide="map-pin"></i>
                                            <small class="text-muted">${pkg.destinationName}</small>
                                        </div>
                                        
                                        <!-- Package Title -->
                                        <h5 class="card-title" data-i18n="pkg.name.${pkg.id}">${pkg.name}</h5>
                                        
                                        <!-- Package Description -->
                                        <p class="card-text" data-i18n="pkg.desc.${pkg.id}">
                                            <c:choose>
                                                <c:when test="${fn:length(pkg.description) > 100}">
                                                    ${fn:substring(pkg.description, 0, 100)}...
                                                </c:when>
                                                <c:otherwise>
                                                    ${pkg.description}
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                        
                                        <!-- Package Details -->
                                        <div class="package-details">
                                            <div class="row">
                                                <div class="col-4">
                                                    <i data-lucide="calendar"></i>
                                                    <small>${pkg.durationDays} days</small>
                                                </div>
                                                <div class="col-4">
                                                    <i data-lucide="users"></i>
                                                    <small>Max ${pkg.maxParticipants}</small>
                                                </div>
                                                <div class="col-4">
                                                    <i data-lucide="star" class="text-warning"></i>
                                                    <small>4.5 rating</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Card Footer -->
                                    <div class="card-footer border-bottom pb-2">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div class="price-info">
                                                <span class="price-label" data-i18n="packages.card.from">From</span>
                                                <h4 class="price">
                                                    RM <fmt:formatNumber value="${pkg.price}" pattern="#,##0.00"/>
                                                </h4>
                                            </div>
                                            <div class="package-actions">
                                                <a href="${pageContext.request.contextPath}/packages/${pkg.id}" 
                                                   class="btn btn-outline-primary btn-sm">
                                                    <i data-lucide="info" class="me-1"></i><span data-i18n="common.viewDetails">Details</span>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/booking?package=${pkg.id}" 
                                                   class="btn btn-primary btn-sm">
                                                    <i data-lucide="shopping-cart" class="me-1"></i><span data-i18n="packages.card.buy">I'm In!</span>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                                        </c:forEach>
                        
                        <!-- No Results Message -->
                        <div class="empty-state" id="noResultsMessage" style="display: none;">
                            <i data-lucide="search"></i>
                            <h4 data-i18n="packages.noresults.title">Well, This is Awkward...</h4>
                            <p data-i18n="packages.noresults.desc">We searched high and low but couldn't find any adventures matching your filters. Time to try a different combo!</p>
                            <button class="btn btn-primary" onclick="resetFilters()">
                                <i data-lucide="rotate-ccw" class="me-2"></i><span data-i18n="packages.noresults.reset">Let's Try Again</span>
                            </button>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>
    </div>
</div>

<script>
    // 套餐数据存储
    const packageData = {};
    
    document.addEventListener('DOMContentLoaded', function() {
        initializeVideoBackground();
        animateCounter();
        initializeFilters();
        initializeScrollAnimations();
    });

    // Removed package switching functionality - each package now displays as a separate card
    function switchPackageType(groupIndex, packageIndex) {
        // Function removed - no longer needed
    }
    
    function _switchPackageType_OLD(groupIndex, packageIndex) {
        console.log('Switching package:', groupIndex, packageIndex);
        
        const card = document.querySelector(`[data-group-index="${groupIndex}"]`);
        if (!card) {
            console.error('Card not found for group:', groupIndex);
            return;
        }
        
        const pkg = packageData[groupIndex][packageIndex];
        if (!pkg) {
            console.error('Package data not found:', groupIndex, packageIndex);
            return;
        }
        
        console.log('Package data:', pkg);
        
        // 添加整体卡片动画
        card.style.transition = 'all 0.3s ease';
        
        // 更新标题（带动画效果）
        const nameElement = card.querySelector('.package-name');
        if (nameElement) {
            nameElement.style.transition = 'all 0.3s ease';
            nameElement.style.opacity = '0.5';
            nameElement.style.transform = 'translateY(-5px)';
            setTimeout(() => {
                nameElement.textContent = pkg.name;
                nameElement.style.opacity = '1';
                nameElement.style.transform = 'translateY(0)';
            }, 150);
        }
        
        // 更新描述（带淡入淡出）
        const descElement = card.querySelector('.package-description');
        if (descElement) {
            descElement.style.transition = 'opacity 0.3s ease';
            descElement.style.opacity = '0.5';
            setTimeout(() => {
                const desc = pkg.description || '';
                descElement.textContent = desc.length > 100 ? desc.substring(0, 100) + '...' : desc;
                descElement.style.opacity = '1';
            }, 150);
        }
        
        // 更新价格（带脉冲动画）
        const priceElement = card.querySelector('.package-price');
        if (priceElement) {
            priceElement.style.transition = 'all 0.3s cubic-bezier(0.68, -0.55, 0.265, 1.55)';
            priceElement.style.transform = 'scale(1.15)';
            priceElement.style.color = '#DAA520';
            setTimeout(() => {
                const formattedPrice = Number(pkg.price).toLocaleString('en-US', {
                    minimumFractionDigits: 2,
                    maximumFractionDigits: 2
                });
                priceElement.innerHTML = 'RM ' + formattedPrice;
                setTimeout(() => {
                    priceElement.style.transform = 'scale(1)';
                    priceElement.style.color = '';
                }, 200);
            }, 150);
        }
        
        // 更新徽章（带旋转动画效果）
        const badgeElement = card.querySelector('.package-type-badge');
        if (badgeElement) {
            let badgeClass = 'bg-primary';
            let badgeText = 'STANDARD';
            let icon = '⭐';
            
            if (pkg.type === 'LUXURY') {
                badgeClass = 'bg-warning';
                badgeText = 'LUXURY';
                icon = '💎';
            } else if (pkg.type === 'PREMIUM') {
                badgeClass = 'bg-success';
                badgeText = 'PREMIUM';
                icon = '👑';
            }
            
            // 添加旋转淡出效果
            badgeElement.style.transition = 'all 0.3s ease';
            badgeElement.style.opacity = '0';
            badgeElement.style.transform = 'scale(0.8) rotateY(90deg)';
            
            setTimeout(() => {
                badgeElement.className = 'badge package-type-badge ' + badgeClass;
                badgeElement.innerHTML = icon + ' ' + badgeText;
                
                // 旋转淡入效果
                setTimeout(() => {
                    badgeElement.style.opacity = '1';
                    badgeElement.style.transform = 'scale(1) rotateY(0deg)';
                }, 50);
            }, 150);
        }
        
        // 更新持续时间（带闪烁效果）
        const durationElement = card.querySelector('.package-duration');
        if (durationElement && pkg.durationDays) {
            durationElement.style.transition = 'opacity 0.3s ease';
            durationElement.style.opacity = '0.5';
            setTimeout(() => {
                durationElement.textContent = pkg.durationDays + ' days';
                durationElement.style.opacity = '1';
            }, 150);
        }
        
        // 更新参与人数（带闪烁效果）
        const participantsElement = card.querySelector('.package-participants');
        if (participantsElement && pkg.maxParticipants) {
            participantsElement.style.transition = 'opacity 0.3s ease';
            participantsElement.style.opacity = '0.5';
            setTimeout(() => {
                participantsElement.textContent = 'Max ' + pkg.maxParticipants;
                participantsElement.style.opacity = '1';
            }, 150);
        }
        
        // 更新按钮链接
        const viewBtn = card.querySelector('.view-details-btn');
        if (viewBtn && pkg.id) {
            viewBtn.href = '${pageContext.request.contextPath}/packages/' + pkg.id;
        }
        
        const bookBtn = card.querySelector('.book-now-btn');
        if (bookBtn && pkg.id) {
            bookBtn.href = '${pageContext.request.contextPath}/booking?package=' + pkg.id;
        }
        
        // 更新图片（带淡入淡出）
        const imgElement = card.querySelector('.package-image');
        if (imgElement && pkg.image) {
            imgElement.style.transition = 'opacity 0.3s ease';
            imgElement.style.opacity = '0.7';
            setTimeout(() => {
                imgElement.src = '${pageContext.request.contextPath}/' + pkg.image;
                imgElement.style.opacity = '1';
            }, 150);
        }
        
        // 更新卡片的data属性以便过滤
        card.dataset.price = pkg.price;
        card.dataset.type = pkg.type;
        card.dataset.destination = pkg.destinationName || '';
        
        // 添加成功提示动画
        card.style.boxShadow = '0 8px 30px rgba(218, 165, 32, 0.3)';
        setTimeout(() => {
            card.style.boxShadow = '';
        }, 600);
        
        console.log('Package switched successfully');
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

        document.querySelectorAll('.package-card').forEach(card => {
            card.style.animationPlayState = 'paused';
            observer.observe(card);
        });
    }

    function initializeFilters() {
        const searchInput = document.getElementById('searchInput');
        const destinationFilter = document.getElementById('destinationFilter');
        const priceRange = document.getElementById('priceRange');
        const priceValue = document.getElementById('priceValue');
        const sortBy = document.getElementById('sortBy');

        if (searchInput) {
            searchInput.addEventListener('input', debounce(applyFilters, 300));
        }

        if (destinationFilter) {
            destinationFilter.addEventListener('change', applyFilters);
        }

        if (priceRange && priceValue) {
            priceRange.addEventListener('input', function() {
                const value = parseInt(this.value);
                priceValue.textContent = 'RM ' + value.toLocaleString();
                applyFilters();
            });
        }

        if (sortBy) {
            sortBy.addEventListener('change', applyFilters);
        }

        document.querySelectorAll('.filter-tab').forEach(tab => {
            tab.addEventListener('click', function() {
                document.querySelectorAll('.filter-tab').forEach(t => t.classList.remove('active'));
                this.classList.add('active');
                applyFilters();
            });
        });
    }

    function applyFilters() {
        const searchTerm = document.getElementById('searchInput')?.value.toLowerCase() || '';
        const destinationFilter = document.getElementById('destinationFilter')?.value || '';
        const maxPrice = parseInt(document.getElementById('priceRange')?.value || 10000);
        const sortBy = document.getElementById('sortBy')?.value || 'name';
        
        // 获取激活的类型过滤
        const activeTypeTab = document.querySelector('.filter-tab.active');
        const typeFilter = activeTypeTab?.dataset.value || '';
        
        const cards = document.querySelectorAll('.package-card');
        let visibleCards = [];
        
        cards.forEach(card => {
            const destination = card.getAttribute('data-destination') || '';
            const currentPrice = parseFloat(card.getAttribute('data-price')) || 0;
            const currentType = card.getAttribute('data-type') || '';
            
            const matchesSearch = !searchTerm || destination.toLowerCase().includes(searchTerm);
            const matchesDestination = !destinationFilter || destination === destinationFilter;
            const matchesPrice = currentPrice <= maxPrice;
            const matchesType = !typeFilter || currentType === typeFilter;
            
            if (matchesSearch && matchesDestination && matchesPrice && matchesType) {
                showPackage(card);
                visibleCards.push(card);
            } else {
                hidePackage(card);
            }
        });

        if (sortBy && visibleCards.length > 0) {
            const container = document.getElementById('packagesContainer');
            visibleCards.sort((a, b) => {
                switch (sortBy) {
                    case 'price-low':
                        return parseFloat(a.getAttribute('data-price') || 0) - parseFloat(b.getAttribute('data-price') || 0);
                    case 'price-high':
                        return parseFloat(b.getAttribute('data-price') || 0) - parseFloat(a.getAttribute('data-price') || 0);
                    case 'name':
                        return (a.getAttribute('data-destination') || '').localeCompare(b.getAttribute('data-destination') || '');
                    default:
                        return 0;
                }
            });

            visibleCards.forEach((card, index) => {
                card.style.animationDelay = (index * 0.1) + 's';
                container.appendChild(card);
            });
        }

        updateResultsCounter(visibleCards.length);
        
        const noResultsMsg = document.getElementById('noResultsMessage');
        if (visibleCards.length === 0) {
            noResultsMsg.style.display = 'block';
        } else {
            noResultsMsg.style.display = 'none';
        }
    }

    function showPackage(element) {
        element.style.display = 'block';
        element.style.opacity = '0';
        element.style.transform = 'translateY(20px)';
        
        setTimeout(() => {
            element.style.opacity = '1';
            element.style.transform = 'translateY(0)';
            element.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
        }, 50);
    }

    function hidePackage(element) {
        element.style.transition = 'opacity 0.3s ease, transform 0.3s ease';
        element.style.opacity = '0';
        element.style.transform = 'translateY(20px)';
        
        setTimeout(() => {
            element.style.display = 'none';
        }, 300);
    }

    function updateResultsCounter(count) {
        const counterElement = document.getElementById('resultsCount');
        if (counterElement) {
            counterElement.textContent = `Showing ${count} destinations`;
        }
    }

    function resetFilters() {
        document.getElementById('searchInput').value = '';
        document.getElementById('destinationFilter').value = '';
        document.getElementById('priceRange').value = '10000';
        document.getElementById('priceValue').textContent = 'RM 10,000';
        document.getElementById('sortBy').value = 'name';
        
        document.querySelectorAll('.filter-tab').forEach(tab => tab.classList.remove('active'));
        document.querySelector('.filter-tab[data-value=""]').classList.add('active');
        
        document.querySelectorAll('.package-card').forEach((card, index) => {
            card.style.display = 'block';
            card.style.animationDelay = (index * 0.1) + 's';
        });
        
        const totalCards = document.querySelectorAll('.package-card').length;
        document.getElementById('resultsCount').textContent = `Showing ${totalCards} destinations`;
        
        document.getElementById('noResultsMessage').style.display = 'none';
    }

    function debounce(func, delay) {
        let timeoutId;
        return function (...args) {
            clearTimeout(timeoutId);
            timeoutId = setTimeout(() => func.apply(this, args), delay);
        };
    }

    document.querySelectorAll('.card').forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-8px) scale(1.02)';
        });
        
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0) scale(1)';
        });
    });

    document.querySelector('.hero-cta .btn').addEventListener('click', function(e) {
        e.preventDefault();
        document.getElementById('packages').scrollIntoView({
            behavior: 'smooth',
            block: 'start'
        });
    });
</script>

<jsp:include page="../includes/footer.jsp" />
