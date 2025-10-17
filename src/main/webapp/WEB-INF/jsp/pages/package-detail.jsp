<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="${travelPackage.name} - MyTour Global" />
    <jsp:param name="currentPage" value="package-detail" />
</jsp:include>

<jsp:include page="../includes/navigation.jsp">
    <jsp:param name="currentPage" value="packages" />
</jsp:include>

<style>
.package-hero {
    position: relative;
    height: 60vh;
    min-height: 400px;
    overflow: hidden;
}

.hero-container {
    position: relative;
    width: 100%;
    height: 100%;
}

.hero-media {
    position: relative;
    width: 100%;
    height: 100%;
}

.hero-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
    object-position: center;
}

.hero-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: linear-gradient(135deg, rgba(0,0,0,0.6) 0%, rgba(0,0,0,0.3) 100%);
    display: flex;
    align-items: end;
    padding-bottom: 3rem;
}

.hero-content {
    color: white;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
}

.package-title {
    font-size: 3rem;
    font-weight: 700;
    margin-bottom: 1rem;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.7);
}

.package-badges {
    margin-bottom: 1rem;
    display: flex;
    gap: 0.5rem;
    flex-wrap: wrap;
}

.badge-featured {
    background-color: #ffc107;
    color: #000;
    padding: 0.5rem 1rem;
    border-radius: 2rem;
    font-weight: 600;
}

.badge-type {
    padding: 0.5rem 1rem;
    border-radius: 2rem;
    font-weight: 600;
    color: white;
}

.badge-type.budget {
    background-color: #6c757d;
}

.badge-type.standard {
    background-color: #0d6efd;
}

.badge-type.premium {
    background-color: #198754;
}

.badge-type.luxury {
    background-color: #dc3545;
}

.badge-destination {
    background-color: #20c997;
    color: white;
    padding: 0.5rem 1rem;
    border-radius: 2rem;
    font-weight: 600;
}

.package-meta {
    display: flex;
    gap: 2rem;
    flex-wrap: wrap;
}

.meta-item {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    font-size: 1.1rem;
}

.meta-item i {
    color: #ffc107;
}

.content-section {
    margin-bottom: 3rem;
}

.section-title {
    font-size: 1.8rem;
    font-weight: 600;
    color: #2c3e50;
    margin-bottom: 1.5rem;
    padding-bottom: 0.5rem;
    border-bottom: 2px solid #e9ecef;
}

.package-description {
    font-size: 1.1rem;
    line-height: 1.7;
    color: #555;
}

.inclusions-content, .exclusions-content {
    background: #f8f9fa;
    padding: 1.5rem;
    border-radius: 0.5rem;
    border-left: 4px solid #28a745;
}

.exclusions-content {
    border-left-color: #dc3545;
}

.inclusions-list, .exclusions-list {
    display: grid;
    gap: 0.75rem;
}

.inclusion-item, .exclusion-item {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    font-size: 1rem;
}

.itinerary-content {
    background: #fff;
    padding: 1.5rem;
    border-radius: 0.5rem;
    border: 1px solid #e9ecef;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
}

.destination-overview {
    background: #f8f9fa;
    padding: 1.5rem;
    border-radius: 0.5rem;
    border: 1px solid #e9ecef;
}

.destination-quick-info .info-item {
    margin-bottom: 1rem;
    padding-bottom: 1rem;
    border-bottom: 1px solid #dee2e6;
}

.destination-quick-info .info-item:last-child {
    border-bottom: none;
    margin-bottom: 0;
    padding-bottom: 0;
}

.sticky-sidebar {
    position: sticky;
    top: 2rem;
}

.booking-card {
    background: white;
    border-radius: 1rem;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    padding: 2rem;
    margin-bottom: 2rem;
    border: 1px solid #e9ecef;
}

.price-section {
    text-align: center;
    padding-bottom: 1.5rem;
    border-bottom: 1px solid #e9ecef;
    margin-bottom: 1.5rem;
    position: relative;
}

.price-display {
    display: flex;
    align-items: baseline;
    justify-content: center;
    gap: 0.25rem;
    margin-bottom: 0.5rem;
}

.price-currency {
    font-size: 1.5rem;
    font-weight: 600;
    color: #28a745;
}

.price-amount {
    font-size: 3rem;
    font-weight: 700;
    color: #28a745;
    line-height: 1;
}

.price-unit {
    font-size: 1rem;
    color: #6c757d;
    align-self: flex-end;
    margin-bottom: 0.5rem;
}

.price-badge {
    background: linear-gradient(45deg, #ffc107, #ffeb3b);
    color: #000;
    padding: 0.25rem 0.75rem;
    border-radius: 1rem;
    font-size: 0.8rem;
    font-weight: 600;
    display: inline-flex;
    align-items: center;
    gap: 0.25rem;
}

.availability-status {
    text-align: center;
    padding: 0.5rem 0;
}

.availability-status .badge {
    font-size: 0.85rem;
    padding: 0.5rem 1rem;
}

#lastUpdated {
    font-size: 0.75rem;
    color: #6c757d;
}

.package-quick-details {
    margin-bottom: 1.5rem;
}

.detail-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0.75rem 0;
    border-bottom: 1px solid #f1f3f4;
}

.detail-row:last-child {
    border-bottom: none;
}

.detail-label {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    color: #6c757d;
    font-weight: 500;
}

.detail-label i {
    color: #0d6efd;
    width: 16px;
}

.detail-value {
    font-weight: 600;
    color: #2c3e50;
}

.booking-actions {
    margin-bottom: 1.5rem;
}

.contact-options {
    display: grid;
    gap: 0.5rem;
}

.guarantee-badges {
    border-top: 1px solid #e9ecef;
    padding-top: 1rem;
}

.badge-item {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    font-size: 0.9rem;
    color: #6c757d;
    margin-bottom: 0.5rem;
}

.badge-item:last-child {
    margin-bottom: 0;
}

.package-stats {
    border-top: 1px solid #e9ecef;
    padding-top: 1rem;
}

.stats-header h6 {
    color: #2c3e50;
    font-weight: 600;
    margin-bottom: 0.75rem;
}

.stats-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 0.75rem;
}

.stat-item {
    text-align: center;
    padding: 0.5rem;
    background: #f8f9fa;
    border-radius: 0.5rem;
    border: 1px solid #e9ecef;
}

.stat-number {
    display: block;
    font-size: 1.2rem;
    font-weight: 700;
    color: #28a745;
    margin-bottom: 0.25rem;
}

.stat-label {
    font-size: 0.8rem;
    color: #6c757d;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.destination-summary-card {
    background: white;
    border-radius: 1rem;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    padding: 1.5rem;
    border: 1px solid #e9ecef;
}

.destination-summary-card h4 {
    color: #2c3e50;
    margin-bottom: 1rem;
    font-size: 1.2rem;
    font-weight: 600;
}

.destination-preview {
    display: flex;
    flex-direction: column;
    gap: 1rem;
}

.destination-thumb {
    width: 100%;
    height: 120px;
    object-fit: cover;
    border-radius: 0.5rem;
}

.destination-info h5 {
    color: #2c3e50;
    margin-bottom: 0.25rem;
    font-size: 1.1rem;
}

.rating-display {
    margin: 0.5rem 0;
    font-size: 0.9rem;
}

.default-inclusions {
    display: grid;
    gap: 0.75rem;
}

.related-packages-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 1.5rem;
    margin-top: 1rem;
}

.related-package-card {
    background: white;
    border-radius: 1rem;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    border: 1px solid #e9ecef;
}

.related-package-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
}

.related-package-image {
    position: relative;
    height: 180px;
    overflow: hidden;
}

.related-package-image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.3s ease;
}

.related-package-card:hover .related-package-image img {
    transform: scale(1.05);
}

.featured-badge {
    position: absolute;
    top: 0.5rem;
    right: 0.5rem;
    background: #ffc107;
    color: #000;
    padding: 0.25rem 0.5rem;
    border-radius: 0.5rem;
    font-size: 0.75rem;
    font-weight: 600;
}

.related-package-content {
    padding: 1rem;
}

.related-package-content h5 {
    color: #2c3e50;
    margin-bottom: 0.5rem;
    font-size: 1rem;
    font-weight: 600;
}

.related-package-content p {
    font-size: 0.9rem;
    line-height: 1.4;
    margin-bottom: 0.75rem;
}

.package-meta {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 1rem;
    font-size: 0.9rem;
}

.package-meta .duration {
    color: #6c757d;
}

.package-meta .price {
    font-weight: 700;
    color: #28a745;
    font-size: 1rem;
}

.package-actions {
    display: flex;
    gap: 0.5rem;
}

.package-actions .btn {
    flex: 1;
    font-size: 0.85rem;
}

.popular-packages-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 1rem;
    margin-top: 1rem;
}

.popular-package-card {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 1.5rem;
    border-radius: 1rem;
    text-align: center;
    transition: transform 0.3s ease;
}

.popular-package-card:hover {
    transform: translateY(-3px);
}

.popular-package-content h6 {
    color: white;
    margin-bottom: 0.5rem;
    font-weight: 600;
}

.package-destination {
    margin-bottom: 0.75rem;
    font-size: 0.9rem;
    opacity: 0.9;
}

.package-destination i {
    margin-right: 0.25rem;
}

.popular-package-card .package-price {
    font-size: 1.2rem;
    font-weight: 700;
    margin-bottom: 1rem;
}

.popular-package-card .btn {
    background: rgba(255,255,255,0.2);
    border: 1px solid rgba(255,255,255,0.3);
    color: white;
    font-weight: 500;
}

.popular-package-card .btn:hover {
    background: rgba(255,255,255,0.3);
    border-color: rgba(255,255,255,0.5);
    color: white;
}

/* 套餐对比表格样式 */
.comparison-table {
    background: transparent;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: none;
    border: 1px solid rgba(0,0,0,0.08);
}

.comparison-table thead th {
    background: rgba(255,255,255,0.9);
    color: #2c3e50;
    font-weight: 700;
    text-transform: uppercase;
    font-size: 0.85rem;
    letter-spacing: 0.5px;
    padding: 1rem 0.75rem;
    border-bottom: 2px solid #dee2e6;
}

.comparison-table tbody tr {
    transition: all 0.3s ease;
    border-bottom: 1px solid rgba(0,0,0,0.05);
    background: rgba(255,255,255,0.6);
}

.comparison-table tbody tr:hover {
    background: rgba(248,249,250,0.9);
    transform: translateX(5px);
    box-shadow: 0 2px 8px rgba(0,0,0,0.08);
}

/* 当前套餐高亮 */
.comparison-table tbody tr.current-package {
    background: rgba(13,110,253,0.08);
    border-left: 4px solid #0d6efd;
}

.comparison-table tbody tr.current-package:hover {
    background: rgba(13,110,253,0.15);
}

.comparison-table tbody td {
    padding: 1.25rem 0.75rem;
    vertical-align: middle;
}

.package-desc {
    font-size: 0.9rem;
    line-height: 1.5;
    color: #6c757d;
}

.price-cell strong {
    font-size: 1.2rem;
    font-weight: 700;
}

.comparison-table .badge {
    padding: 0.4rem 0.7rem;
    font-size: 0.75rem;
    font-weight: 600;
    border-radius: 6px;
}

.comparison-table .btn-group-vertical {
    gap: 0.25rem;
}

.comparison-table .btn {
    padding: 0.4rem 0.6rem;
    border-radius: 6px;
}

/* 标签颜色优化 */
.comparison-table .badge.bg-warning {
    background: linear-gradient(135deg, #4A90E2 0%, #357ABD 100%) !important;
    color: white !important;
}

.comparison-table .badge.bg-success {
    background: linear-gradient(135deg, #FFD700 0%, #FFA500 100%) !important;
    color: white !important;
}

.comparison-table .badge.bg-primary {
    background: linear-gradient(135deg, #6C757D 0%, #495057 100%) !important;
    color: white !important;
}

@media (max-width: 992px) {
    .package-title {
        font-size: 2.5rem;
    }
    
    .package-meta {
        gap: 1rem;
    }
    
    .meta-item {
        font-size: 1rem;
    }
    
    .sticky-sidebar {
        position: static;
        margin-top: 2rem;
    }
}

@media (max-width: 768px) {
    .package-hero {
        height: 50vh;
        min-height: 300px;
    }
    
    .package-title {
        font-size: 2rem;
    }
    
    .package-badges {
        gap: 0.25rem;
    }
    
    .badge-featured,
    .badge-type,
    .badge-destination {
        padding: 0.375rem 0.75rem;
        font-size: 0.8rem;
    }
    
    .package-meta {
        flex-direction: column;
        gap: 0.5rem;
    }
    
    .price-amount {
        font-size: 2.5rem;
    }
    
    .booking-card {
        padding: 1.5rem;
    }
    
    .destination-preview {
        text-align: center;
    }

    /* 移动端表格优化 */
    .comparison-table {
        font-size: 0.85rem;
    }

    .comparison-table thead th {
        padding: 0.75rem 0.5rem;
        font-size: 0.75rem;
    }

    .comparison-table tbody td {
        padding: 0.75rem 0.5rem;
    }

    .package-desc {
        font-size: 0.8rem;
    }

    .price-cell strong {
        font-size: 1rem;
    }
}

@media (max-width: 576px) {
    .hero-overlay {
        padding-bottom: 2rem;
    }
    
    .package-title {
        font-size: 1.8rem;
    }
    
    .price-display {
        flex-direction: column;
        gap: 0;
    }
    
    .price-amount {
        font-size: 2rem;
    }
    
    .detail-row {
        flex-direction: column;
        align-items: flex-start;
        gap: 0.25rem;
    }
    
    .contact-options {
        gap: 0.75rem;
    }
}

/* ==================== Dark Mode Styles ==================== */
[data-theme="dark"] .package-hero,
body.dark-mode .package-hero {
    background: var(--color-bg-primary, #212529);
}

[data-theme="dark"] .section-title,
body.dark-mode .section-title {
    color: var(--color-text-primary, #f8f9fa);
    border-bottom-color: rgba(255, 255, 255, 0.2);
}

[data-theme="dark"] .package-description,
body.dark-mode .package-description {
    color: var(--color-text-secondary, #adb5bd);
}

[data-theme="dark"] .inclusions-content,
body.dark-mode .inclusions-content {
    background: rgba(255, 255, 255, 0.08);
    border-left-color: #28a745;
    border: 1px solid rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(10px) saturate(130%);
}

[data-theme="dark"] .exclusions-content,
body.dark-mode .exclusions-content {
    background: rgba(255, 255, 255, 0.08);
    border-left-color: #dc3545;
    border: 1px solid rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(10px) saturate(130%);
}

[data-theme="dark"] .inclusion-item,
[data-theme="dark"] .exclusion-item,
body.dark-mode .inclusion-item,
body.dark-mode .exclusion-item {
    color: var(--color-text-secondary, #adb5bd);
}

[data-theme="dark"] .itinerary-content,
body.dark-mode .itinerary-content {
    background: rgba(255, 255, 255, 0.08);
    border-color: rgba(255, 255, 255, 0.15);
    backdrop-filter: blur(10px) saturate(130%);
    color: var(--color-text-secondary, #adb5bd);
}

[data-theme="dark"] .destination-overview,
body.dark-mode .destination-overview {
    background: rgba(255, 255, 255, 0.08);
    border-color: rgba(255, 255, 255, 0.15);
    backdrop-filter: blur(10px) saturate(130%);
}

[data-theme="dark"] .destination-overview p,
body.dark-mode .destination-overview p {
    color: var(--color-text-secondary, #adb5bd);
}

[data-theme="dark"] .destination-overview .highlights h5,
body.dark-mode .destination-overview .highlights h5 {
    color: var(--color-text-primary, #f8f9fa);
}

[data-theme="dark"] .destination-overview .text-muted,
body.dark-mode .destination-overview .text-muted {
    color: var(--color-text-muted, #6c757d) !important;
}

[data-theme="dark"] .destination-quick-info .info-item,
body.dark-mode .destination-quick-info .info-item {
    border-bottom-color: rgba(255, 255, 255, 0.1);
}

[data-theme="dark"] .destination-quick-info .info-item strong,
body.dark-mode .destination-quick-info .info-item strong {
    color: var(--color-text-primary, #f8f9fa);
}

[data-theme="dark"] .destination-quick-info .info-item p,
body.dark-mode .destination-quick-info .info-item p {
    color: var(--color-text-secondary, #adb5bd);
}

[data-theme="dark"] .booking-card,
body.dark-mode .booking-card {
    background: rgba(255, 255, 255, 0.08);
    border-color: rgba(255, 255, 255, 0.15);
    backdrop-filter: blur(16px) saturate(140%);
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.3);
}

[data-theme="dark"] .price-section,
body.dark-mode .price-section {
    border-bottom-color: rgba(255, 255, 255, 0.1);
}

[data-theme="dark"] .price-currency,
[data-theme="dark"] .price-amount,
body.dark-mode .price-currency,
body.dark-mode .price-amount {
    color: #28a745;
}

[data-theme="dark"] .price-unit,
body.dark-mode .price-unit {
    color: var(--color-text-muted, #6c757d);
}

[data-theme="dark"] .price-badge,
body.dark-mode .price-badge {
    background: linear-gradient(45deg, #ffc107, #ffeb3b);
    color: #000;
}

[data-theme="dark"] .detail-row,
body.dark-mode .detail-row {
    border-bottom-color: rgba(255, 255, 255, 0.1);
}

[data-theme="dark"] .detail-label,
body.dark-mode .detail-label {
    color: var(--color-text-secondary, #adb5bd);
}

[data-theme="dark"] .detail-value,
body.dark-mode .detail-value {
    color: var(--color-text-primary, #f8f9fa);
}

[data-theme="dark"] .guarantee-badges,
body.dark-mode .guarantee-badges {
    border-top-color: rgba(255, 255, 255, 0.1);
}

[data-theme="dark"] .badge-item,
body.dark-mode .badge-item {
    color: var(--color-text-secondary, #adb5bd);
}

[data-theme="dark"] .package-stats,
body.dark-mode .package-stats {
    border-top-color: rgba(255, 255, 255, 0.1);
}

[data-theme="dark"] .stats-header h6,
body.dark-mode .stats-header h6 {
    color: var(--color-text-primary, #f8f9fa);
}

[data-theme="dark"] .stat-item,
body.dark-mode .stat-item {
    background: rgba(255, 255, 255, 0.08);
    border-color: rgba(255, 255, 255, 0.15);
    backdrop-filter: blur(8px) saturate(120%);
}

[data-theme="dark"] .stat-number,
body.dark-mode .stat-number {
    color: #28a745;
}

[data-theme="dark"] .stat-label,
body.dark-mode .stat-label {
    color: var(--color-text-muted, #6c757d);
}

[data-theme="dark"] .destination-summary-card,
body.dark-mode .destination-summary-card {
    background: rgba(255, 255, 255, 0.08);
    border-color: rgba(255, 255, 255, 0.15);
    backdrop-filter: blur(16px) saturate(140%);
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.3);
}

[data-theme="dark"] .destination-summary-card h4,
body.dark-mode .destination-summary-card h4 {
    color: var(--color-text-primary, #f8f9fa);
}

[data-theme="dark"] .destination-info h5,
body.dark-mode .destination-info h5 {
    color: var(--color-text-primary, #f8f9fa);
}

[data-theme="dark"] .destination-info .text-muted,
body.dark-mode .destination-info .text-muted {
    color: var(--color-text-muted, #6c757d) !important;
}

[data-theme="dark"] .rating-display,
body.dark-mode .rating-display {
    color: var(--color-text-secondary, #adb5bd);
}

[data-theme="dark"] .comparison-table,
body.dark-mode .comparison-table {
    border-color: rgba(255, 255, 255, 0.1);
}

[data-theme="dark"] .comparison-table thead th,
body.dark-mode .comparison-table thead th {
    background: rgba(255, 255, 255, 0.08);
    color: var(--color-text-primary, #f8f9fa);
    border-bottom-color: rgba(255, 255, 255, 0.2);
    backdrop-filter: blur(10px) saturate(130%);
}

[data-theme="dark"] .comparison-table tbody tr,
body.dark-mode .comparison-table tbody tr {
    background: rgba(255, 255, 255, 0.04);
    border-bottom-color: rgba(255, 255, 255, 0.05);
}

[data-theme="dark"] .comparison-table tbody tr:hover,
body.dark-mode .comparison-table tbody tr:hover {
    background: rgba(255, 255, 255, 0.08);
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
}

[data-theme="dark"] .comparison-table tbody tr.current-package,
body.dark-mode .comparison-table tbody tr.current-package {
    background: rgba(13, 110, 253, 0.15);
    border-left-color: #0d6efd;
}

[data-theme="dark"] .comparison-table tbody tr.current-package:hover,
body.dark-mode .comparison-table tbody tr.current-package:hover {
    background: rgba(13, 110, 253, 0.25);
}

[data-theme="dark"] .comparison-table tbody td,
body.dark-mode .comparison-table tbody td {
    color: var(--color-text-secondary, #adb5bd);
}

[data-theme="dark"] .package-desc,
body.dark-mode .package-desc {
    color: var(--color-text-secondary, #adb5bd);
}

[data-theme="dark"] .price-cell strong,
body.dark-mode .price-cell strong {
    color: #28a745;
}

[data-theme="dark"] .modal-content,
body.dark-mode .modal-content {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(20px) saturate(150%);
}

[data-theme="dark"] .modal-header,
body.dark-mode .modal-header {
    border-bottom-color: rgba(255, 255, 255, 0.2);
}

[data-theme="dark"] .modal-title,
body.dark-mode .modal-title {
    color: var(--color-text-primary, #212529);
}

[data-theme="dark"] .modal-body,
body.dark-mode .modal-body {
    color: var(--color-text-secondary, #495057);
}

[data-theme="dark"] .form-control,
body.dark-mode .form-control {
    background: rgba(255, 255, 255, 0.9);
    border-color: rgba(255, 255, 255, 0.3);
    color: var(--color-text-primary, #212529);
}

[data-theme="dark"] .form-control:focus,
body.dark-mode .form-control:focus {
    background: rgba(255, 255, 255, 1);
    border-color: #0d6efd;
    box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
}

[data-theme="dark"] .btn-outline-secondary,
body.dark-mode .btn-outline-secondary {
    border-color: rgba(255, 255, 255, 0.3);
    color: var(--color-text-secondary, #495057);
}

[data-theme="dark"] .btn-outline-secondary:hover,
body.dark-mode .btn-outline-secondary:hover {
    background: rgba(255, 255, 255, 0.1);
    border-color: rgba(255, 255, 255, 0.5);
    color: var(--color-text-primary, #212529);
}

/* Dark mode for form elements */
[data-theme="dark"] .form-control,
[data-theme="dark"] .form-select,
body.dark-mode .form-control,
body.dark-mode .form-select {
    background: rgba(255, 255, 255, 0.08);
    border-color: rgba(255, 255, 255, 0.15);
    color: var(--color-text-primary, #f8f9fa);
}

[data-theme="dark"] .form-control:focus,
[data-theme="dark"] .form-select:focus,
body.dark-mode .form-control:focus,
body.dark-mode .form-select:focus {
    background: rgba(255, 255, 255, 0.12);
    border-color: #0d6efd;
    box-shadow: 0 0 0 0.2rem rgba(13, 110, 253, 0.25);
    color: var(--color-text-primary, #f8f9fa);
}

/* Dark mode for buttons */
[data-theme="dark"] .btn-primary,
body.dark-mode .btn-primary {
    background: #0d6efd;
    border-color: #0d6efd;
}

[data-theme="dark"] .btn-primary:hover,
body.dark-mode .btn-primary:hover {
    background: #0b5ed7;
    border-color: #0a58ca;
}

[data-theme="dark"] .btn-outline-primary,
body.dark-mode .btn-outline-primary {
    border-color: #0d6efd;
    color: #0d6efd;
}

[data-theme="dark"] .btn-outline-primary:hover,
body.dark-mode .btn-outline-primary:hover {
    background: #0d6efd;
    border-color: #0d6efd;
    color: white;
}

[data-theme="dark"] .btn-outline-secondary,
body.dark-mode .btn-outline-secondary {
    border-color: rgba(255, 255, 255, 0.3);
    color: var(--color-text-secondary, #adb5bd);
}

[data-theme="dark"] .btn-outline-secondary:hover,
body.dark-mode .btn-outline-secondary:hover {
    background: rgba(255, 255, 255, 0.1);
    border-color: rgba(255, 255, 255, 0.5);
    color: var(--color-text-primary, #f8f9fa);
}

/* Dark mode for badges */
[data-theme="dark"] .badge.bg-primary,
body.dark-mode .badge.bg-primary {
    background: #0d6efd !important;
    color: white !important;
}

[data-theme="dark"] .badge.bg-success,
body.dark-mode .badge.bg-success {
    background: #198754 !important;
    color: white !important;
}

[data-theme="dark"] .badge.bg-warning,
body.dark-mode .badge.bg-warning {
    background: #ffc107 !important;
    color: #000 !important;
}

[data-theme="dark"] .badge.bg-info,
body.dark-mode .badge.bg-info {
    background: #0dcaf0 !important;
    color: #000 !important;
}

/* Dark mode for text colors */
[data-theme="dark"] .text-muted,
body.dark-mode .text-muted {
    color: var(--color-text-muted, #6c757d) !important;
}

[data-theme="dark"] .text-success,
body.dark-mode .text-success {
    color: #198754 !important;
}

[data-theme="dark"] .text-warning,
body.dark-mode .text-warning {
    color: #ffc107 !important;
}

[data-theme="dark"] .text-primary,
body.dark-mode .text-primary {
    color: #0d6efd !important;
}

[data-theme="dark"] .text-info,
body.dark-mode .text-info {
    color: #0dcaf0 !important;
}
</style>

<main class="package-detail-content" role="main">
    
    <section class="package-hero">
        <div class="hero-container">
            <div class="hero-media">
                <c:choose>
                    <c:when test="${not empty travelPackage.imagePath}">
                        <img src="${pageContext.request.contextPath}/${travelPackage.imagePath}" 
                             alt="${travelPackage.name}" class="hero-image"
                             onerror="this.src='${pageContext.request.contextPath}/images/default-package.jpg'">
                    </c:when>
                    <c:when test="${not empty destination && not empty destination.imagePath}">
                        <img src="${pageContext.request.contextPath}/${destination.imagePath}" 
                             alt="${destination.name}" class="hero-image"
                             onerror="this.src='${pageContext.request.contextPath}/images/default-package.jpg'">
                    </c:when>
                    <c:otherwise>
                        <img src="https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=1200&h=600&fit=crop&auto=format" 
                             alt="${travelPackage.name}" class="hero-image">
                    </c:otherwise>
                </c:choose>
                
                <div class="position-absolute top-0 end-0 m-3">
                    <button class="btn btn-light btn-sm rounded-circle" data-bs-toggle="modal" data-bs-target="#shareModal">
                        <i data-lucide="share-2"></i>
                    </button>
                </div>
            </div>
            
            <div class="hero-overlay">
                <div class="container">
                    <div class="hero-content">
                        <div class="package-header">
                            <div class="package-badges">
                                <c:if test="${travelPackage.featured}">
                                    <span class="badge badge-featured">
                                        <i data-lucide="star"></i> <span data-i18n="packages.detail.featured">Featured</span>
                                    </span>
                                </c:if>
                                <span class="badge badge-type ${fn:toLowerCase(travelPackage.type)}">
                                    ${travelPackage.type}
                                </span>
                                <c:if test="${not empty destination}">
                                    <span class="badge badge-destination">
                                        <i data-lucide="map-pin"></i> <span data-i18n="dest.name.${destination.id}">${destination.name}</span>
                                    </span>
                                </c:if>
                            </div>
                            
                            <h1 class="package-title" data-i18n="pkg.name.${travelPackage.id}">${travelPackage.name}</h1>
                            
                            <div class="package-meta">
                                <c:if test="${not empty destination}">
                                    <div class="meta-item">
                                        <i data-lucide="map-pin"></i>
                                        <span>${destination.city}, ${destination.country}</span>
                                    </div>
                                </c:if>
                                <div class="meta-item">
                                    <i data-lucide="clock"></i>
                                    <span>${travelPackage.durationDays} <span data-i18n="packages.detail.days">Days</span> 
                                        <c:if test="${travelPackage.durationNights != null && travelPackage.durationNights > 0}">
                                            / ${travelPackage.durationNights} <span data-i18n="packages.detail.nights">Nights</span>
                                        </c:if>
                                    </span>
                                </div>
                                <div class="meta-item">
                                    <i data-lucide="users"></i>
                                    <span>
                                        ${travelPackage.minParticipants}
                                        <c:if test="${travelPackage.maxParticipants != null && travelPackage.maxParticipants != travelPackage.minParticipants}">
                                            - ${travelPackage.maxParticipants}
                                        </c:if>
                                        <span data-i18n="packages.detail.participants">participants</span>
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <section class="package-info py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    
                    <div class="content-section mb-5">
                        <h2 class="section-title" data-i18n="packages.detail.overview">The Lowdown on This Adventure</h2>
                        <div class="package-description">
                            <p data-i18n="pkg.desc.${travelPackage.id}">${travelPackage.description}</p>
                        </div>
                    </div>
                    
                    <c:if test="${not empty travelPackage.itinerary}">
                        <div class="content-section mb-5">
                            <h2 class="section-title">
                                <i data-lucide="route" class="me-2"></i>
                                <span data-i18n="packages.detail.itinerary">The Day-by-Day Game Plan</span>
                            </h2>
                            <div class="itinerary-content">
                                <p data-i18n="pkg.itinerary.${travelPackage.id}">${travelPackage.itinerary}</p>
                            </div>
                        </div>
                    </c:if>
                    
                    <div class="content-section mb-5">
                        <h2 class="section-title">
                            <i data-lucide="check-circle" class="me-2"></i>
                            <span data-i18n="packages.detail.inclusions">The Awesome Stuff You Get</span>
                        </h2>
                        <div class="inclusions-content">
                            <c:choose>
                                <c:when test="${not empty travelPackage.inclusions}">
                                    <div class="inclusions-list" data-i18n="pkg.inclusions.${travelPackage.id}" data-i18n-type="list">
                                        <c:forEach var="inclusion" items="${fn:split(travelPackage.inclusions, ',')}">
                                            <div class="inclusion-item">
                                                <i data-lucide="check" class="text-success me-2"></i>
                                                <span>${fn:trim(inclusion)}</span>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="default-inclusions">
                                        <div class="inclusion-item">
                                            <i data-lucide="check" class="text-success me-2"></i>
                                            <span data-i18n="packages.detail.default.guide">Professional tour guide</span>
                                        </div>
                                        <div class="inclusion-item">
                                            <i data-lucide="check" class="text-success me-2"></i>
                                            <span data-i18n="packages.detail.default.transport">Transportation as per itinerary</span>
                                        </div>
                                        <div class="inclusion-item">
                                            <i data-lucide="check" class="text-success me-2"></i>
                                            <span data-i18n="packages.detail.default.fees">Entrance fees to attractions</span>
                                        </div>
                                        <div class="inclusion-item">
                                            <i data-lucide="check" class="text-success me-2"></i>
                                            <span data-i18n="packages.detail.default.insurance">Travel insurance</span>
                                        </div>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    
                    
                    <c:if test="${not empty destination}">
                        <div class="content-section mb-5">
                            <h2 class="section-title">
                                <i data-lucide="map" class="me-2"></i>
                                <span data-i18n="packages.detail.about">A Little About</span> <span data-i18n="dest.name.${destination.id}">${destination.name}</span>
                            </h2>
                            <div class="destination-overview">
                                <div class="row">
                                    <div class="col-md-8">
                                        <p data-i18n="dest.desc.${destination.id}">${destination.description}</p>
                                        <c:if test="${not empty destination.highlights}">
                                            <div class="highlights mt-3">
                                                <h5 data-i18n="packages.detail.highlights">Highlights:</h5>
                                                <p class="text-muted" data-i18n="dest.highlights.${destination.id}">${destination.highlights}</p>
                                            </div>
                                        </c:if>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="destination-quick-info">
                                            <c:if test="${not empty destination.bestTimeToVisit}">
                                                <div class="info-item">
                                                    <strong data-i18n="dest.detail.besttime">Best Time to Visit:</strong>
                                                    <p data-i18n="dest.bestTime.${destination.id}">${destination.bestTimeToVisit}</p>
                                                </div>
                                            </c:if>
                                            <c:if test="${destination.averageDuration != null}">
                                                <div class="info-item">
                                                    <strong data-i18n="dest.detail.length">Recommended Duration:</strong>
                                                    <p>${destination.averageDuration} days</p>
                                                </div>
                                            </c:if>
                                            <c:if test="${not empty destination.difficultyLevel}">
                                                <div class="info-item">
                                                    <strong data-i18n="dest.detail.level">Difficulty Level:</strong>
                                                    <p>${destination.difficultyLevel}</p>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    
                </div>
                
                <div class="col-lg-4">
                    <div class="sticky-sidebar">
                        
                        <div class="booking-card">
                            <div class="price-section">
                                <div class="price-display" data-package-id="${travelPackage.id}">
                                    <span class="price-currency">RM</span>
                                    <span class="price-amount" data-base-price="${travelPackage.price}">
                                        <fmt:formatNumber value="${travelPackage.price}" type="number" groupingUsed="true" />
                                    </span>
                                    <span class="price-unit" data-i18n="dest.detail.perperson">per person</span>
                                </div>
                                <c:if test="${travelPackage.featured}">
                                    <div class="price-badge">
                                        <i data-lucide="star"></i> <span data-i18n="packages.detail.featuredDeal">Featured Deal</span>
                                    </div>
                                </c:if>
                                
                                <div class="availability-status mt-2" id="availabilityStatus">
                                    <c:choose>
                                        <c:when test="${isAvailable}">
                                            <span class="badge bg-success">
                                                <i data-lucide="check-circle"></i> <span data-i18n="packages.detail.available">Available Now</span>
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-warning">
                                                <i data-lucide="clock"></i> <span data-i18n="packages.detail.checkAvailability">Check Availability</span>
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                    <small class="text-muted d-block mt-1" id="lastUpdated">
                                        <span data-i18n="packages.detail.updated">Updated:</span> <span id="updateTime">
                                            <jsp:useBean id="now" class="java.util.Date" />
                                            <fmt:formatDate value="${now}" pattern="HH:mm" />
                                        </span>
                                    </small>
                                </div>
                            </div>
                            
                            <div class="package-quick-details">
                                <div class="detail-row">
                                    <span class="detail-label">
                                        <i data-lucide="clock"></i> <span data-i18n="packages.detail.duration">Duration</span>
                                    </span>
                                    <span class="detail-value">
                                        ${travelPackage.durationDays} <span data-i18n="packages.detail.days">days</span>
                                        <c:if test="${travelPackage.durationNights != null && travelPackage.durationNights > 0}">
                                            / ${travelPackage.durationNights} <span data-i18n="packages.detail.nights">nights</span>
                                        </c:if>
                                    </span>
                                </div>
                                <div class="detail-row">
                                    <span class="detail-label">
                                        <i data-lucide="users"></i> <span data-i18n="packages.detail.groupSize">Group Size</span>
                                    </span>
                                    <span class="detail-value">
                                        ${travelPackage.minParticipants}
                                        <c:if test="${travelPackage.maxParticipants != null && travelPackage.maxParticipants != travelPackage.minParticipants}">
                                            - ${travelPackage.maxParticipants}
                                        </c:if>
                                        <span data-i18n="packages.detail.people">people</span>
                                    </span>
                                </div>
                                <div class="detail-row">
                                    <span class="detail-label">
                                        <i data-lucide="tag"></i> <span data-i18n="packages.detail.packageType">Package Type</span>
                                    </span>
                                    <span class="detail-value">
                                        <span class="badge bg-primary">${travelPackage.type}</span>
                                    </span>
                                </div>
                                <c:if test="${not empty destination}">
                                    <div class="detail-row">
                                        <span class="detail-label">
                                            <i data-lucide="map-pin"></i> <span data-i18n="packages.detail.destination">Destination</span>
                                        </span>
                                        <span class="detail-value" data-i18n="dest.name.${destination.id}">${destination.name}</span>
                                    </div>
                                </c:if>
                            </div>
                            
                            <div class="booking-actions">
                                   <a href="${pageContext.request.contextPath}/booking?packageId=${travelPackage.id}" 
                                   class="btn btn-primary btn-lg w-100 mb-3">
                                    <i data-lucide="calendar-check" class="me-2"></i>
                                    <span data-i18n="packages.detail.cta.book">Let's Do This!</span>
                                </a>
                                
                                <div class="contact-options">
                                    <a href="${pageContext.request.contextPath}/contact?package=${travelPackage.id}" 
                                       class="btn btn-outline-secondary w-100 mb-2">
                                        <i data-lucide="mail" class="me-2"></i>
                                        <span data-i18n="packages.detail.cta.question">Got a Question?</span>
                                    </a>
                                </div>
                            </div>
                            
                            <div class="guarantee-badges">
                                <div class="badge-item">
                                    <i data-lucide="shield" class="text-success"></i>
                                    <span data-i18n="packages.detail.badge.priceGuarantee">Our "No Rip-offs" Price Guarantee</span>
                                </div>
                                <div class="badge-item">
                                    <i data-lucide="rotate-ccw" class="text-info"></i>
                                    <span data-i18n="packages.detail.badge.flexible">Change of Plans? No Worries.</span>
                                </div>
                                <div class="badge-item">
                                    <i data-lucide="headphones" class="text-primary"></i>
                                    <span data-i18n="packages.detail.badge.support247">24/7 Support from Real Humans</span>
                                </div>
                            </div>
                            
                            <div class="package-stats mt-3" id="packageStats">
                                <div class="stats-header">
                                    <h6 data-i18n="packages.detail.stats.title">Adventure Bragging Rights</h6>
                                </div>
                                <div class="stats-grid">
                                    <div class="stat-item">
                                        <span class="stat-number" id="averageRating">
                                            <fmt:formatNumber value="${packageStats.averageRating}" type="number" maxFractionDigits="1" />
                                        </span>
                                        <span class="stat-label" data-i18n="packages.detail.stats.avg">Average Rating</span>
                                    </div>
                                    <div class="stat-item">
                                        <span class="stat-number" id="reviewCount">${packageStats.reviewCount}</span>
                                        <span class="stat-label" data-i18n="packages.detail.stats.reviews">Reviews</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <c:if test="${not empty destination}">
                            <div class="destination-summary-card">
                                <h4 data-i18n="packages.detail.destinationSnapshot">Destination Snapshot</h4>
                                <div class="destination-preview">
                                    <c:if test="${not empty destination.imagePath}">
                                        <img src="${pageContext.request.contextPath}/${destination.imagePath}" 
                                             alt="${destination.name}" class="destination-thumb"
                                             onerror="this.src='${pageContext.request.contextPath}/images/default-destination.jpg'">
                                    </c:if>
                                    <div class="destination-info">
                                        <h5>${destination.name}</h5>
                                        <p class="text-muted">${destination.city}, ${destination.country}</p>
                                        <c:if test="${destination.rating != null}">
                                            <div class="rating-display">
                                                <c:forEach begin="1" end="${destination.rating}">
                                                    <i data-lucide="star" class="text-warning"></i>
                                                </c:forEach>
                                                <c:forEach begin="${destination.rating + 1}" end="5">
                                                    <i data-lucide="star" class="text-warning" style="opacity:.3"></i>
                                                </c:forEach>
                                                <span class="ms-1">(${destination.totalReviews} <span data-i18n="packages.detail.travelerTales">traveler tales</span>)</span>
                                            </div>
                                        </c:if>
                                        <a href="${pageContext.request.contextPath}/destinations/${destination.id}" 
                                           class="btn btn-sm btn-outline-primary mt-2">
                                            <span data-i18n="packages.detail.explore">Explore</span> ${destination.name}
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        
                    </div>
                </div>
            </div>
            
            <c:if test="${not empty destination}">
                <div class="row mt-5">
                    <div class="col-12">
                        <div class="content-section">
                            <h2 class="section-title">
                                <i data-lucide="list" class="me-2"></i>
                                Other Flavors of Adventure in ${destination.name}
                            </h2>
                            <div class="table-responsive">
                                <table class="table table-hover align-middle comparison-table">
                                    <thead class="table-light">
                                        <tr>
                                            <th style="width: 25%;">Package Type</th>
                                            <th style="width: 35%;">Description</th>
                                            <th class="text-center" style="width: 10%;">Duration</th>
                                            <th class="text-center" style="width: 10%;">Group Size</th>
                                            <th class="text-end" style="width: 12%;">Price</th>
                                            <th class="text-center" style="width: 8%;"></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <!-- Current package (highlighted) -->
                                        <tr class="package-row current-package">
                                            <td>
                                                <div class="d-flex align-items-center gap-2">
                                                    <c:choose>
                                                    <c:when test="${travelPackage.type == 'LUXURY'}">
                                                        <span class="badge bg-warning text-dark" data-i18n="packages.badge.luxury">💎 LUXURY</span>
                                                        </c:when>
                                                    <c:when test="${travelPackage.type == 'PREMIUM'}">
                                                        <span class="badge bg-success" data-i18n="packages.badge.premium">👑 PREMIUM</span>
                                                        </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-primary" data-i18n="packages.badge.standard">⭐ STANDARD</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <span class="badge bg-info text-white">
                                                        <i class="data-lucide="eye""></i> <span data-i18n="packages.detail.current">Current</span>
                                                    </span>
                                                    <c:if test="${travelPackage.featured}">
                                                        <i class="data-lucide="star" text-warning" title="Featured"></i>
                                                    </c:if>
                                                </div>
                                                <div class="mt-1 small text-muted" data-i18n="pkg.name.${travelPackage.id}">${travelPackage.name}</div>
                                            </td>
                                            <td>
                                                <div class="package-desc" data-i18n="pkg.desc.${travelPackage.id}">
                                                    ${fn:substring(travelPackage.description, 0, 100)}<c:if test="${fn:length(travelPackage.description) > 100}">...</c:if>
                                                </div>
                                            </td>
                                            <td class="text-center">
                                                <i data-lucide="clock" class="text-primary me-1"></i>
                                                <strong>${travelPackage.durationDays}</strong> days
                                            </td>
                                            <td class="text-center">
                                                <i data-lucide="users" class="text-info me-1"></i>
                                                ${travelPackage.minParticipants}-${travelPackage.maxParticipants}
                                            </td>
                                            <td class="text-end">
                                                <div class="price-cell">
                                                    <strong class="text-success fs-5">
                                                        RM <fmt:formatNumber value="${travelPackage.price}" pattern="#,##0"/>
                                                    </strong>
                                                </div>
                                            </td>
                                            <td class="text-center">
                                                <div class="btn-group-vertical btn-group-sm" role="group">
                                                    <button class="btn btn-secondary btn-sm mb-1" disabled>
                                                        <i data-lucide="check"></i>
                                                    </button>
                                                    <a href="${pageContext.request.contextPath}/booking?packageId=${travelPackage.id}" 
                                                       class="btn btn-primary btn-sm">
                                                        <i data-lucide="shopping-cart"></i>
                                                    </a>
                                                </div>
                                            </td>
                                        </tr>
                                        
                                        <!-- Other packages -->
                                        <c:forEach var="relatedPkg" items="${relatedPackages}">
                                            <tr class="package-row">
                                                <td>
                                                    <div class="d-flex align-items-center gap-2">
                                                        <c:choose>
                                                    <c:when test="${relatedPkg.type == 'LUXURY'}">
                                                        <span class="badge bg-warning text-dark" data-i18n="packages.badge.luxury">💎 LUXURY</span>
                                                            </c:when>
                                                    <c:when test="${relatedPkg.type == 'PREMIUM'}">
                                                        <span class="badge bg-success" data-i18n="packages.badge.premium">👑 PREMIUM</span>
                                                            </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-primary" data-i18n="packages.badge.standard">⭐ STANDARD</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <c:if test="${relatedPkg.featured}">
                                                            <i class="data-lucide="star" text-warning" title="Featured"></i>
                                                        </c:if>
                                                    </div>
                                                    <div class="mt-1 small text-muted" data-i18n="pkg.name.${relatedPkg.id}">${relatedPkg.name}</div>
                                                </td>
                                                <td>
                                                    <div class="package-desc" data-i18n="pkg.desc.${relatedPkg.id}">
                                                        ${fn:substring(relatedPkg.description, 0, 100)}<c:if test="${fn:length(relatedPkg.description) > 100}">...</c:if>
                                                    </div>
                                                </td>
                                                <td class="text-center">
                                                <i class="data-lucide="clock" text-primary me-1"></i>
                                                <strong>${relatedPkg.durationDays}</strong> <span data-i18n="packages.detail.days">days</span>
                                                </td>
                                                <td class="text-center">
                                                    <i class="data-lucide="users" text-info me-1"></i>
                                                    ${relatedPkg.minParticipants}-${relatedPkg.maxParticipants}
                                                </td>
                                                <td class="text-end">
                                                    <div class="price-cell">
                                                        <strong class="text-success fs-5">
                                                            RM <fmt:formatNumber value="${relatedPkg.price}" pattern="#,##0"/>
                                                        </strong>
                                                    </div>
                                                </td>
                                                <td class="text-center">
                                                    <div class="btn-group-vertical btn-group-sm" role="group">
                                                        <a href="${pageContext.request.contextPath}/packages/${relatedPkg.id}" 
                                                           class="btn btn-outline-primary btn-sm mb-1">
                                                            <i data-lucide="info"></i>
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/booking?packageId=${relatedPkg.id}" 
                                                           class="btn btn-primary btn-sm">
                                                        <i data-lucide="shopping-cart"></i>
                                                        </a>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
            
        </div>
    </section>
    
</main>

<div class="modal fade" id="shareModal" tabindex="-1" aria-labelledby="shareModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="shareModalLabel">Share This Awesome Trip</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center">
                <div class="d-flex justify-content-center gap-3 mb-3">
                    <a href="#" class="btn btn-primary btn-lg rounded-circle" onclick="shareToFacebook()">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a href="#" class="btn btn-info btn-lg rounded-circle" onclick="shareToTwitter()">
                        <i class="fab fa-twitter"></i>
                    </a>
                    <a href="#" class="btn btn-success btn-lg rounded-circle" onclick="shareToWhatsApp()">
                        <i class="fab fa-whatsapp"></i>
                    </a>
                    <a href="#" class="btn btn-secondary btn-lg rounded-circle" onclick="shareViaEmail()">
                        <i class="data-lucide="mail""></i>
                    </a>
                </div>
                <hr>
                <div class="input-group">
                    <input type="text" class="form-control" id="shareUrl" value="${pageContext.request.requestURL}" readonly>
                    <button class="btn btn-outline-secondary" type="button" onclick="copyToClipboard()">
                        <i class="data-lucide="clipboard""></i>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
// Package Detail JavaScript - Merged Version
document.addEventListener('DOMContentLoaded', function() {
    initializePackageDetail();
    initializeScrollEffects();
    initializeImageLazyLoading();
    initializeRealTimeUpdates();
});

function initializePackageDetail() {
    console.log('Package detail page initialized');
    
    addBookingButtonClickHandler();
    addContactButtonClickHandler();
    setupPriceCalculator();
    initializeTooltips();
}

function initializeRealTimeUpdates() {
    const packageId = document.querySelector('[data-package-id]')?.dataset.packageId;
    if (!packageId) return;
    
    console.log('Initializing real-time updates for package:', packageId);
    
    updateAvailabilityStatus(packageId);
    updatePackageStats(packageId);
    
    setInterval(() => {
        updateAvailabilityStatus(packageId);
    }, 30000);
    
    setInterval(() => {
        updatePackageStats(packageId);
    }, 60000);
}

function updateAvailabilityStatus(packageId) {
    fetch(`/api/packages/${packageId}/availability`)
        .then(response => response.json())
        .then(data => {
            const statusElement = document.getElementById('availabilityStatus');
            if (!statusElement) return;
            
            const badge = statusElement.querySelector('.badge');
            const timeElement = document.getElementById('updateTime');
            
            if (badge) {
                if (data.available) {
                    badge.className = 'badge bg-success';
                    badge.innerHTML = '<i data-lucide="check-circle"></i> Available Now';
                } else {
                    badge.className = 'badge bg-warning';
                    badge.innerHTML = '<i data-lucide="alert-triangle"></i> ' + (data.reason || 'Check Availability');
                }
                if (typeof lucide !== 'undefined') { try { lucide.createIcons(); } catch (e) {} }
            }
            
            if (timeElement) {
                timeElement.textContent = new Date().toLocaleTimeString('en-US', {
                    hour: '2-digit',
                    minute: '2-digit'
                });
            }
            
            console.log('Availability status updated:', data.available);
        })
        .catch(error => {
            console.error('Failed to update availability status:', error);
        });
}

function updatePackageStats(packageId) {
    fetch(`/api/packages/${packageId}/stats`)
        .then(response => response.json())
        .then(data => {
            updateStatElement('totalBookings', data.totalBookings);
            updateStatElement('averageRating', data.averageRating?.toFixed(1));
            updateStatElement('reviewCount', data.reviewCount);
            updateStatElement('popularityScore', data.popularity + '%');
            
            console.log('Package stats updated:', data);
        })
        .catch(error => {
            console.error('Failed to update package stats:', error);
        });
}

function updateStatElement(elementId, value) {
    const element = document.getElementById(elementId);
    if (element && value !== undefined) {
        const currentValue = element.textContent;
        if (currentValue !== value.toString()) {
            element.style.transition = 'all 0.3s ease';
            element.style.transform = 'scale(1.1)';
            element.style.color = '#007bff';
            
            setTimeout(() => {
                element.textContent = value;
                element.style.transform = 'scale(1)';
                element.style.color = '';
            }, 150);
        }
    }
}

function addBookingButtonClickHandler() {
    const bookingButtons = document.querySelectorAll('[href*="/booking"]');
    bookingButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            const packageId = new URLSearchParams(this.getAttribute('href').split('?')[1]).get('packageId');
            if (packageId) {
                trackBookingClick(packageId);
                
                fetch(`/api/packages/${packageId}/availability`)
                    .then(response => response.json())
                    .then(data => {
                        if (!data.available) {
                            e.preventDefault();
                            showNotification('This package is currently not available. Please check back later or contact us for assistance.', 'warning');
                            return false;
                        }
                    })
                    .catch(error => {
                        console.warn('Could not verify availability before booking:', error);
                    });
            }
        });
    });
}

function addContactButtonClickHandler() {
    const contactButtons = document.querySelectorAll('[href*="/contact"]');
    contactButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            trackInquiryClick();
        });
    });
}

function setupPriceCalculator() {
    const participantsInput = document.getElementById('participants');
    if (participantsInput) {
        participantsInput.addEventListener('change', updateTotalPrice);
        participantsInput.addEventListener('input', updateTotalPrice);
    }
}

function updateTotalPrice() {
    const participantsInput = document.getElementById('participants');
    const priceDisplay = document.querySelector('.price-amount');
    
    if (participantsInput && priceDisplay) {
        const basePrice = parseFloat(priceDisplay.dataset.basePrice || priceDisplay.textContent.replace(/[^0-9.]/g, ''));
        const participants = parseInt(participantsInput.value) || 1;
        const totalPrice = basePrice * participants;
        
        priceDisplay.textContent = formatPrice(totalPrice);
        
        const priceUnit = document.querySelector('.price-unit');
        if (priceUnit) {
            priceUnit.textContent = participants === 1 ? 'per person' : `for ${participants} people`;
        }
    }
}

function formatPrice(price) {
    return new Intl.NumberFormat('en-US', {
        minimumFractionDigits: 0,
        maximumFractionDigits: 2
    }).format(price);
}

function initializeScrollEffects() {
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };
    
    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);
    
    const animatedElements = document.querySelectorAll('.content-section, .booking-card, .destination-summary-card');
    animatedElements.forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(20px)';
        el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(el);
    });
}


function initializeImageLazyLoading() {
    const images = document.querySelectorAll('img[data-src]');
    
    const imageObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                img.src = img.dataset.src;
                img.removeAttribute('data-src');
                img.classList.remove('lazy');
                observer.unobserve(img);
            }
        });
    });
    
    images.forEach(img => imageObserver.observe(img));
}

function initializeTooltips() {
    const tooltipElements = document.querySelectorAll('[data-bs-toggle="tooltip"]');
    tooltipElements.forEach(element => {
        new bootstrap.Tooltip(element);
    });
}

function sharePackage() {
    if (navigator.share) {
        navigator.share({
            title: document.title,
            text: 'Check out this amazing travel package!',
            url: window.location.href
        }).catch(err => {
            console.log('Error sharing:', err);
            fallbackShare();
        });
    } else {
        fallbackShare();
    }
}

function fallbackShare() {
    const modal = new bootstrap.Modal(document.getElementById('shareModal'));
    modal.show();
}

function shareToFacebook() {
    const url = encodeURIComponent(window.location.href);
    const title = encodeURIComponent(document.title);
    window.open(`https://www.facebook.com/sharer/sharer.php?u=${url}&quote=${title}`, '_blank', 'width=600,height=400');
}

function shareToTwitter() {
    const url = encodeURIComponent(window.location.href);
    const text = encodeURIComponent('Check out this amazing travel package: ' + document.title);
    window.open(`https://twitter.com/intent/tweet?url=${url}&text=${text}`, '_blank', 'width=600,height=400');
}

function shareToWhatsApp() {
    const url = encodeURIComponent(window.location.href);
    const text = encodeURIComponent('Check out this travel package: ' + document.title + ' - ' + url);
    window.open(`https://wa.me/?text=${text}`, '_blank');
}

function shareViaEmail() {
    const subject = encodeURIComponent('Travel Package: ' + document.title);
    const body = encodeURIComponent(`I found this amazing travel package that you might be interested in:\n\n${document.title}\n${window.location.href}`);
    window.location.href = `mailto:?subject=${subject}&body=${body}`;
}

function copyToClipboard() {
    const urlInput = document.getElementById('shareUrl');
    urlInput.select();
    urlInput.setSelectionRange(0, 99999);
    
    try {
        document.execCommand('copy');
        showNotification('URL copied to clipboard!', 'success');
    } catch (err) {
        console.error('Failed to copy: ', err);
        showNotification('Failed to copy URL. Please try again.', 'error');
    }
}

function showNotification(message, type = 'info') {
    const notification = document.createElement('div');
    notification.className = `alert alert-${type == 'error' ? 'danger' : 'success'} alert-dismissible fade show position-fixed`;
    notification.style.cssText = `
        top: 20px;
        right: 20px;
        z-index: 9999;
        min-width: 300px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
    `;
    
    notification.innerHTML = `
        <i data-lucide="${type == 'error' ? 'alert-triangle' : 'check-circle'}" class="me-2"></i>
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    `;
    
    document.body.appendChild(notification);
    
    setTimeout(() => {
        if (notification.parentNode) {
            notification.remove();
        }
    }, 3000);
}

function trackBookingClick(packageId) {
    console.log('Booking clicked for package:', packageId);
    
    if (typeof gtag !== 'undefined') {
        gtag('event', 'package_booking_click', {
            package_id: packageId,
            event_category: 'engagement',
            event_label: 'package_detail_page'
        });
    }
}

function trackInquiryClick() {
    console.log('Inquiry clicked');
    
    if (typeof gtag !== 'undefined') {
        gtag('event', 'package_inquiry_click', {
            event_category: 'engagement',
            event_label: 'package_detail_page'
        });
    }
}

function scrollToSection(sectionId) {
    const section = document.getElementById(sectionId);
    if (section) {
        section.scrollIntoView({
            behavior: 'smooth',
            block: 'start'
        });
    }
}

window.addEventListener('beforeunload', function() {
    const bookingCard = document.querySelector('.booking-card');
    if (bookingCard) {
        bookingCard.style.position = 'static';
        bookingCard.style.width = 'auto';
        bookingCard.style.zIndex = 'auto';
    }
});

function refreshPackageData() {
    const packageId = document.querySelector('[data-package-id]')?.dataset.packageId;
    if (!packageId) return;
    
    console.log('Manually refreshing package data...');
    
    const refreshButton = document.querySelector('.refresh-data');
    if (refreshButton) {
        refreshButton.disabled = true;
        refreshButton.innerHTML = '<i data-lucide="loader-2" class="spin"></i> Updating...';
    }
    
    Promise.all([
        updateAvailabilityStatus(packageId),
        updatePackageStats(packageId)
    ]).finally(() => {
        if (refreshButton) {
            refreshButton.disabled = false;
            refreshButton.innerHTML = '<i data-lucide="refresh-ccw"></i> Refresh';
            if (typeof lucide !== 'undefined') { try { lucide.createIcons(); } catch (e) {} }
        }
        
        showNotification('Package data updated successfully!', 'success');
    });
}

document.querySelectorAll('.related-package-card, .popular-package-card').forEach(card => {
    card.addEventListener('mouseenter', function() {
        this.style.transform = 'translateY(-5px) scale(1.02)';
    });
    
    card.addEventListener('mouseleave', function() {
        this.style.transform = '';
    });
});

function adjustPriceDisplay() {
    const priceElements = document.querySelectorAll('.price-amount');
    priceElements.forEach(element => {
        const price = parseFloat(element.textContent.replace(/[^0-9.]/g, ''));
        if (price >= 10000) {
            element.style.fontSize = '2.5rem';
        } else if (price >= 1000) {
            element.style.fontSize = '2.8rem';
        } else {
            element.style.fontSize = '3rem';
        }
    });
}

adjustPriceDisplay();
</script>

<jsp:include page="../includes/footer.jsp" />