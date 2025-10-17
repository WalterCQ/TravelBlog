class FilterManager {
    constructor() {
        this.filters = {
            search: '',
            category: '',
            country: '',
            priceRange: [0, 10000],
            sortBy: 'name'
        };
        this.init();
    }

    init() {
        this.initializeFilters();
        this.initializePriceRange();
        this.initializeSorting();
    }

    initializeFilters() {
        const searchInput = document.getElementById('searchInput');
        if (searchInput) {
            searchInput.addEventListener('input', (e) => {
                this.filters.search = e.target.value.toLowerCase();
                this.applyFilters();
            });
        }

        const categoryFilter = document.getElementById('categoryFilter');
        if (categoryFilter) {
            categoryFilter.addEventListener('change', (e) => {
                this.filters.category = e.target.value;
                this.applyFilters();
            });
        }

        const countryFilter = document.getElementById('countryFilter');
        if (countryFilter) {
            countryFilter.addEventListener('change', (e) => {
                this.filters.country = e.target.value;
                this.applyFilters();
            });
        }

        document.querySelectorAll('.filter-tab').forEach(tab => {
            tab.addEventListener('click', (e) => {
                document.querySelectorAll('.filter-tab').forEach(t => t.classList.remove('active'));
                e.target.classList.add('active');
                
                const filterType = e.target.dataset.filter;
                const filterValue = e.target.dataset.value;
                
                if (filterType && filterValue != undefined) {
                    this.filters[filterType] = filterValue;
                    this.applyFilters();
                }
            });
        });
    }

    initializePriceRange() {
        const priceRange = document.getElementById('priceRange');
        if (priceRange) {
            priceRange.addEventListener('input', (e) => {
                const value = parseInt(e.target.value);
                this.filters.priceRange[1] = value;
                document.getElementById('priceValue').textContent = `RM ${value.toLocaleString()}`;
                this.applyFilters();
            });
        }
    }

    initializeSorting() {
        const sortSelect = document.getElementById('sortBy');
        if (sortSelect) {
            sortSelect.addEventListener('change', (e) => {
                this.filters.sortBy = e.target.value;
                this.applySorting();
            });
        }
    }

    applyFilters() {
        const items = document.querySelectorAll('[data-filterable]');
        let visibleCount = 0;

        items.forEach(item => {
            if (this.itemMatchesFilters(item)) {
                this.showItem(item);
                visibleCount++;
            } else {
                this.hideItem(item);
            }
        });

        this.updateResultsCount(visibleCount);
        this.applySorting();
    }

    itemMatchesFilters(item) {
        const title = item.dataset.title?.toLowerCase() || '';
        const description = item.dataset.description?.toLowerCase() || '';
        const category = item.dataset.category || '';
        const country = item.dataset.country || '';
        const price = parseInt(item.dataset.price) || 0;

        const matchesSearch = !this.filters.search || 
                            title.includes(this.filters.search) || 
                            description.includes(this.filters.search);

        const matchesCategory = !this.filters.category || category == this.filters.category;
        const matchesCountry = !this.filters.country || country == this.filters.country;
        const matchesPrice = price >= this.filters.priceRange[0] && price <= this.filters.priceRange[1];

        return matchesSearch && matchesCategory && matchesCountry && matchesPrice;
    }

    showItem(item) {
        item.style.display = 'block';
        setTimeout(() => {
            item.style.opacity = '1';
            item.style.transform = 'translateY(0)';
        }, 50);
    }

    hideItem(item) {
        item.style.opacity = '0';
        item.style.transform = 'translateY(20px)';
        setTimeout(() => {
            item.style.display = 'none';
        }, 300);
    }

    applySorting() {
        const container = document.querySelector('.modern-grid, .results-container');
        if (!container) return;

        const items = Array.from(container.querySelectorAll('[data-filterable]:not([style*="display: none"])'));
        
        items.sort((a, b) => {
            switch (this.filters.sortBy) {
                case 'name':
                    return (a.dataset.title || '').localeCompare(b.dataset.title || '');
                case 'price-low':
                    return (parseInt(a.dataset.price) || 0) - (parseInt(b.dataset.price) || 0);
                case 'price-high':
                    return (parseInt(b.dataset.price) || 0) - (parseInt(a.dataset.price) || 0);
                case 'rating':
                    return (parseFloat(b.dataset.rating) || 0) - (parseFloat(a.dataset.rating) || 0);
                case 'newest':
                    return new Date(b.dataset.date || 0) - new Date(a.dataset.date || 0);
                default:
                    return 0;
            }
        });

        items.forEach(item => container.appendChild(item));
    }

    updateResultsCount(count) {
        let countElement = document.getElementById('resultsCount');
        if (!countElement) {
            countElement = document.createElement('div');
            countElement.id = 'resultsCount';
            countElement.className = 'results-count text-muted mb-3';
            
            const container = document.querySelector('.modern-grid, .results-container');
            if (container) {
                container.parentNode.insertBefore(countElement, container);
            }
        }
        
        countElement.textContent = `显示 ${count} 个结果`;
    }

    resetFilters() {
        this.filters = {
            search: '',
            category: '',
            country: '',
            priceRange: [0, 10000],
            sortBy: 'name'
        };

        document.getElementById('searchInput')?.setValue('');
        document.getElementById('categoryFilter')?.setValue('');
        document.getElementById('countryFilter')?.setValue('');
        document.getElementById('sortBy')?.setValue('name');
        
        document.querySelectorAll('.filter-tab').forEach(tab => {
            tab.classList.remove('active');
        });
        
        document.querySelector('.filter-tab[data-value=""]')?.classList.add('active');

        this.applyFilters();
    }
}

class PublicFeatures {
    constructor() {
        this.initializeModals();
        this.initializeTooltips();
        this.initializeAnimations();
    }

    initializeModals() {
        this.initializeImageModal();
        this.initializeConfirmModal();
    }

    initializeImageModal() {
        document.querySelectorAll('[data-image-modal]').forEach(trigger => {
            trigger.addEventListener('click', (e) => {
                e.preventDefault();
                const imageUrl = trigger.dataset.imageModal;
                this.showImageModal(imageUrl);
            });
        });
    }

    showImageModal(imageUrl) {
        const modal = document.createElement('div');
        modal.className = 'modal fade';
        modal.innerHTML = `
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body p-0">
                        <img src="${imageUrl}" class="img-fluid w-100" alt="查看大图">
                    </div>
                </div>
            </div>
        `;
        
        document.body.appendChild(modal);
        const bsModal = new bootstrap.Modal(modal);
        bsModal.show();
        
        modal.addEventListener('hidden.bs.modal', () => {
            document.body.removeChild(modal);
        });
    }

    initializeConfirmModal() {
        document.querySelectorAll('[data-confirm]').forEach(trigger => {
            trigger.addEventListener('click', (e) => {
                e.preventDefault();
                const message = trigger.dataset.confirm;
                const action = trigger.href || trigger.dataset.action;
                this.showConfirmModal(message, action);
            });
        });
    }

    showConfirmModal(message, action) {
        const modal = document.createElement('div');
        modal.className = 'modal fade';
        modal.innerHTML = `
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">确认操作</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <p>${message}</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">取消</button>
                        <button type="button" class="btn btn-primary" onclick="window.location.href='${action}'">确认</button>
                    </div>
                </div>
            </div>
        `;
        
        document.body.appendChild(modal);
        const bsModal = new bootstrap.Modal(modal);
        bsModal.show();
        
        modal.addEventListener('hidden.bs.modal', () => {
            document.body.removeChild(modal);
        });
    }

    initializeTooltips() {
        const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
        const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => 
            new bootstrap.Tooltip(tooltipTriggerEl)
        );
    }

    initializeAnimations() {
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('animate-in');
                }
            });
        }, observerOptions);

        document.querySelectorAll('[data-animate]').forEach(element => {
            observer.observe(element);
        });
    }
}

window.resetFilters = function() {
    if (window.filterManager) {
        window.filterManager.resetFilters();
    }
};

document.addEventListener('DOMContentLoaded', () => {
    window.filterManager = new FilterManager();
    new PublicFeatures();
});