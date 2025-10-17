class HelpCenterManager {
    constructor() {
        this.categories = {
            'booking': {
                title: 'Booking & Reservations',
                articles: [
                    { id: 1, title: 'How to make a booking', content: 'Step-by-step guide to booking your travel package...' },
                    { id: 2, title: 'Cancellation policies', content: 'Learn about our cancellation policies and procedures...' },
                    { id: 3, title: 'Modifying your reservation', content: 'How to change your booking details...' }
                ]
            },
            'payment': {
                title: 'Payment & Billing',
                articles: [
                    { id: 4, title: 'Accepted payment methods', content: 'We accept various payment methods including...' },
                    { id: 5, title: 'Refund process', content: 'Understanding our refund policy and process...' },
                    { id: 6, title: 'Payment plans', content: 'Learn about our flexible payment options...' }
                ]
            },
            'travel': {
                title: 'Travel Tips',
                articles: [
                    { id: 7, title: 'Travel insurance', content: 'Why travel insurance is important and how to get it...' },
                    { id: 8, title: 'Packing tips', content: 'Essential packing tips for your journey...' },
                    { id: 9, title: 'Travel documents', content: 'Important documents you need for travel...' }
                ]
            },
            'support': {
                title: 'Customer Support',
                articles: [
                    { id: 10, title: 'Contact us', content: 'How to reach our support team...' },
                    { id: 11, title: 'Account help', content: 'Managing your account and profile...' },
                    { id: 12, title: 'Technical issues', content: 'Troubleshooting common technical problems...' }
                ]
            }
        };
        
        this.searchIndex = [];
        this.chatMessages = [];
        this.isTyping = false;
        
        this.init();
    }
    
    init() {
        this.buildSearchIndex();
        this.initializeEventListeners();
        this.initializeFAQ();
        this.initializeLiveChat();
    }
    
    initializeEventListeners() {
        const searchInput = document.getElementById('helpSearch');
        if (searchInput) {
            searchInput.addEventListener('input', (e) => {
                this.performSearch(e.target.value);
            });
        }
        
        document.addEventListener('click', (e) => {
            if (e.target.classList.contains('help-category-card')) {
                const category = e.target.getAttribute('data-category');
                if (category) {
                    this.showCategory(category);
                }
            }
        });
    }
    
    initializeFAQ() {
        const faqQuestions = document.querySelectorAll('.faq-question');
        
        faqQuestions.forEach(question => {
            question.addEventListener('click', (e) => {
                e.preventDefault();
                
                const faqItem = question.closest('.faq-item');
                const answer = faqItem.querySelector('.faq-answer');
                const toggle = question.querySelector('.faq-toggle');
                
                const isActive = question.classList.contains('active');
                
                document.querySelectorAll('.faq-question').forEach(q => {
                    q.classList.remove('active');
                    q.querySelector('.faq-toggle').textContent = '+';
                });
                
                document.querySelectorAll('.faq-answer').forEach(a => {
                    a.classList.remove('show');
                });
                
                if (!isActive) {
                    question.classList.add('active');
                    answer.classList.add('show');
                    toggle.textContent = '−';
                    
                    setTimeout(() => {
                        answer.scrollIntoView({ 
                            behavior: 'smooth', 
                            block: 'nearest' 
                        });
                    }, 300);
                }
            });
        });
        
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') {
                document.querySelectorAll('.faq-question').forEach(q => {
                    q.classList.remove('active');
                    q.querySelector('.faq-toggle').textContent = '+';
                });
                document.querySelectorAll('.faq-answer').forEach(a => {
                    a.classList.remove('show');
                });
            }
        });
    }
    
    initializeLiveChat() {
        const chatInput = document.getElementById('chatInput');
        if (chatInput) {
            chatInput.addEventListener('keypress', (e) => {
                if (e.key === 'Enter') {
                    this.sendChatMessage();
                }
            });
        }
    }
    
    buildSearchIndex() {
        this.searchIndex = [];
        
        Object.keys(this.categories).forEach(categoryKey => {
            const category = this.categories[categoryKey];
            
            category.articles.forEach(article => {
                this.searchIndex.push({
                    id: article.id,
                    title: article.title,
                    content: article.content,
                    category: categoryKey,
                    categoryTitle: category.title
                });
            });
        });
    }
    
    performSearch(query) {
        if (!query || query.trim().length < 2) {
            this.hideArticles();
            return;
        }
        
        const results = this.searchIndex.filter(item => {
            const searchableText = `${item.title} ${item.content} ${item.categoryTitle}`.toLowerCase();
            return searchableText.includes(query.toLowerCase());
        });
        
        this.displaySearchResults(results, query);
    }
    
    displaySearchResults(results, query) {
        const resultsContainer = document.getElementById('searchResults') || this.createSearchResultsContainer();
        
        if (results.length === 0) {
            resultsContainer.innerHTML = `
                <div class="no-results">
                    <i data-lucide="search" class="mb-3" style="width: 36px; height: 36px;"></i>
                    <h4>No results found</h4>
                    <p>Try searching with different keywords or browse our categories above.</p>
                </div>
            `;
        } else {
            resultsContainer.innerHTML = `
                <div class="search-results-header">
                    <h4>Search Results for "${query}"</h4>
                    <p class="text-muted">${results.length} article${results.length !== 1 ? 's' : ''} found</p>
                </div>
                <div class="search-results-list">
                    ${results.map(result => `
                        <div class="search-result-item" onclick="window.helpCenter.showArticle(${result.id})">
                            <h5>${this.highlightText(result.title, query)}</h5>
                            <p class="text-muted">${this.highlightText(result.content.substring(0, 150), query)}...</p>
                            <small class="text-primary">${result.categoryTitle}</small>
                        </div>
                    `).join('')}
                </div>
            `;
        }
        
        resultsContainer.style.display = 'block';
    }
    
    createSearchResultsContainer() {
        const container = document.createElement('div');
        container.id = 'searchResults';
        container.className = 'search-results-container';
        container.style.cssText = `
            position: absolute;
            top: 100%;
            left: 0;
            right: 0;
            background: white;
            border: 1px solid #ddd;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
            z-index: 1000;
            max-height: 400px;
            overflow-y: auto;
            display: none;
        `;
        
        const searchContainer = document.querySelector('.help-search-container');
        if (searchContainer) {
            searchContainer.style.position = 'relative';
            searchContainer.appendChild(container);
        }
        
        return container;
    }
    
    highlightText(text, query) {
        if (!query) return text;
        
        const regex = new RegExp(`(${query})`, 'gi');
        return text.replace(regex, '<mark>$1</mark>');
    }
    
    hideArticles() {
        const resultsContainer = document.getElementById('searchResults');
        if (resultsContainer) {
            resultsContainer.style.display = 'none';
        }
    }
    
    showCategory(category) {
        const categoryData = this.categories[category];
        if (!categoryData) return;
        
        const articlesContainer = document.getElementById('categoryArticles') || this.createCategoryArticlesContainer();
        
        articlesContainer.innerHTML = `
            <div class="category-header">
                <h3>${categoryData.title}</h3>
                <button class="btn btn-sm btn-outline-secondary" onclick="window.helpCenter.hideArticles()">
                    <i data-lucide="x" class="me-1"></i>Close
                </button>
            </div>
            <div class="articles-grid">
                ${categoryData.articles.map(article => `
                    <div class="article-card" onclick="window.helpCenter.showArticle(${article.id})">
                        <h5>${article.title}</h5>
                        <p>${article.content.substring(0, 100)}...</p>
                        <small class="text-primary">Read more <i data-lucide="arrow-right"></i></small>
                    </div>
                `).join('')}
            </div>
        `;
        
        articlesContainer.style.display = 'block';
        articlesContainer.scrollIntoView({ behavior: 'smooth' });
    }
    
    createCategoryArticlesContainer() {
        const container = document.createElement('div');
        container.id = 'categoryArticles';
        container.className = 'category-articles-container';
        container.style.cssText = `
            background: white;
            border-radius: 16px;
            padding: 2rem;
            margin: 2rem 0;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            display: none;
        `;
        
        const mainContent = document.querySelector('.main-content');
        if (mainContent) {
            mainContent.insertBefore(container, mainContent.firstChild);
        }
        
        return container;
    }
    
    showArticle(articleId) {
        const article = this.searchIndex.find(item => item.id === articleId);
        if (!article) return;
        
        const modal = document.getElementById('articleModal') || this.createArticleModal();
        const modalTitle = modal.querySelector('.modal-title');
        const modalBody = modal.querySelector('.modal-body');
        
        modalTitle.textContent = article.title;
        modalBody.innerHTML = `
            <div class="article-content">
                <div class="article-category">
                    <span class="badge bg-primary">${article.categoryTitle}</span>
                </div>
                <div class="article-text">
                    ${article.content}
                </div>
                <div class="article-actions mt-4">
                    <h6>Was this helpful?</h6>
                    <div class="d-flex gap-2">
                        <button class="btn btn-sm btn-outline-success" onclick="window.helpCenter.rateArticle(${article.id}, true)">
                            <i data-lucide="thumbs-up"></i> Yes
                        </button>
                        <button class="btn btn-sm btn-outline-danger" onclick="window.helpCenter.rateArticle(${article.id}, false)">
                            <i data-lucide="thumbs-down"></i> No
                        </button>
                    </div>
                </div>
            </div>
        `;
        
        const bsModal = new bootstrap.Modal(modal);
        bsModal.show();
    }
    
    createArticleModal() {
        const modal = document.createElement('div');
        modal.id = 'articleModal';
        modal.className = 'modal fade';
        modal.setAttribute('tabindex', '-1');
        modal.innerHTML = `
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Article Title</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Article content will be inserted here -->
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="button" class="btn btn-primary" onclick="window.helpCenter.openLiveChat()">
                            Need More Help?
                        </button>
                    </div>
                </div>
            </div>
        `;
        
        document.body.appendChild(modal);
        return modal;
    }
    
    rateArticle(articleId, helpful) {
        const message = helpful ? 'Thank you for your feedback!' : 'We\'ll work to improve this article.';
        this.showToast(message, helpful ? 'success' : 'info');
        
        console.log(`Article ${articleId} rated as ${helpful ? 'helpful' : 'not helpful'}`);
    }
    
    openLiveChat() {
        const chatWidget = document.getElementById('liveChatWidget');
        if (chatWidget) {
            chatWidget.style.display = 'flex';
            
            setTimeout(() => {
                const chatInput = document.getElementById('chatInput');
                if (chatInput) chatInput.focus();
            }, 300);
            
            if (this.chatMessages.length == 0) {
                this.addBotMessage('Hello! How can I help you today?');
            }
        }
    }
    
    closeLiveChat() {
        const chatWidget = document.getElementById('liveChatWidget');
        if (chatWidget) {
            chatWidget.style.display = 'none';
        }
    }
    
    sendChatMessage() {
        const chatInput = document.getElementById('chatInput');
        const message = chatInput.value.trim();
        
        if (!message) return;
        
        this.addUserMessage(message);
        chatInput.value = '';
        
        this.showTypingIndicator();
        
        setTimeout(() => {
            this.hideTypingIndicator();
            this.generateBotResponse(message);
        }, 1500 + Math.random() * 1000);
    }
    
    addUserMessage(message) {
        const chatBody = document.getElementById('chatBody');
        if (!chatBody) return;
        
        const messageElement = document.createElement('div');
        messageElement.className = 'chat-message user-message';
        messageElement.innerHTML = `<p>${message}</p>`;
        
        chatBody.appendChild(messageElement);
        this.chatMessages.push({ type: 'user', message });
        this.scrollChatToBottom();
    }
    
    addBotMessage(message) {
        const chatBody = document.getElementById('chatBody');
        if (!chatBody) return;
        
        const messageElement = document.createElement('div');
        messageElement.className = 'chat-message bot-message';
        messageElement.innerHTML = `<p>${message}</p>`;
        
        chatBody.appendChild(messageElement);
        this.chatMessages.push({ type: 'bot', message });
        this.scrollChatToBottom();
    }
    
    generateBotResponse(userMessage) {
        const lowerMessage = userMessage.toLowerCase();
        let response = '';
        
        if (lowerMessage.includes('booking') || lowerMessage.includes('reservation')) {
            response = 'I can help you with booking questions! You can manage your bookings in the "My Account" section, or I can guide you through making a new reservation. What specifically do you need help with?';
        } else if (lowerMessage.includes('payment') || lowerMessage.includes('refund')) {
            response = 'For payment and refund questions, I can explain our policies and help with transaction issues. What payment-related question do you have?';
        } else if (lowerMessage.includes('cancel')) {
            response = 'You can cancel your booking up to 48 hours before departure for a full refund. Would you like me to help you with the cancellation process?';
        } else if (lowerMessage.includes('hello') || lowerMessage.includes('hi')) {
            response = 'Hello! I\'m here to help with any questions about your travel plans. What can I assist you with today?';
        } else {
            response = 'I understand you\'re asking about "' + userMessage + '". Let me connect you with a specialist who can provide detailed assistance. In the meantime, you might find helpful information in our FAQ section above.';
        }
        
        this.addBotMessage(response);
        
        if (this.chatMessages.length > 4) {
            setTimeout(() => {
                this.addBotMessage('Here are some helpful articles that might answer your questions: <br><a href="#" onclick="window.helpCenter.showCategory(\'booking\')">Booking Guide</a> | <a href="#" onclick="window.helpCenter.showCategory(\'payment\')">Payment Help</a>');
            }, 1000);
        }
    }
    
    showTypingIndicator() {
        if (this.isTyping) return;
        
        this.isTyping = true;
        const chatBody = document.getElementById('chatBody');
        if (!chatBody) return;
        
        const typingElement = document.createElement('div');
        typingElement.id = 'typingIndicator';
        typingElement.className = 'chat-message bot-message';
        typingElement.innerHTML = `
            <p>
                <span class="typing-dots">
                    <span></span><span></span><span></span>
                </span>
                Support agent is typing...
            </p>
        `;
        
        chatBody.appendChild(typingElement);
        this.scrollChatToBottom();
    }
    
    hideTypingIndicator() {
        const typingElement = document.getElementById('typingIndicator');
        if (typingElement) {
            typingElement.remove();
        }
        this.isTyping = false;
    }
    
    scrollChatToBottom() {
        const chatBody = document.getElementById('chatBody');
        if (chatBody) {
            chatBody.scrollTop = chatBody.scrollHeight;
        }
    }
    
    showToast(message, type = 'info') {
        const toast = document.createElement('div');
        toast.style.cssText = `
            position: fixed; top: 20px; right: 20px; z-index: 1060;
            background: ${type === 'success' ? '#28a745' : type === 'error' ? '#dc3545' : '#17a2b8'};
            color: white; padding: 12px 20px; border-radius: 8px;
            transform: translateX(100%); transition: transform 0.3s ease;
            box-shadow: 0 4px 12px rgba(0,0,0,0.2);
        `;
        toast.textContent = message;
        
        document.body.appendChild(toast);
        
        setTimeout(() => toast.style.transform = 'translateX(0)', 100);
        
        setTimeout(() => {
            toast.style.transform = 'translateX(100%)';
            setTimeout(() => toast.remove(), 300);
        }, 3000);
    }
}

function searchHelp(query = '') {
    const searchInput = document.getElementById('helpSearch');
    if (searchInput) {
        if (query) {
            searchInput.value = query;
        }
        window.helpCenter.performSearch(searchInput.value);
    }
}

function showCategory(category) {
    if (window.helpCenter) {
        window.helpCenter.showCategory(category);
    }
}

function hideArticles() {
    if (window.helpCenter) {
        window.helpCenter.hideArticles();
    }
}

function openLiveChat() {
    if (window.helpCenter) {
        window.helpCenter.openLiveChat();
    }
}

function closeLiveChat() {
    if (window.helpCenter) {
        window.helpCenter.closeLiveChat();
    }
}

function sendChatMessage() {
    if (window.helpCenter) {
        window.helpCenter.sendChatMessage();
    }
}

document.addEventListener('DOMContentLoaded', function() {
    window.helpCenter = new HelpCenterManager();
    
    const firstFaqItem = document.querySelector('.faq-item:first-child .faq-question');
    if (firstFaqItem) {
        setTimeout(() => {
            firstFaqItem.click();
        }, 1000);
    }
    
    const helpCategoryCards = document.querySelectorAll('.help-category-card');
    helpCategoryCards.forEach((card, index) => {
        card.style.animationDelay = `${index * 0.1}s`;
    });
    
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.animationPlayState = 'running';
            }
        });
    });
    
    document.querySelectorAll('.faq-section, .contact-support-section').forEach(section => {
        observer.observe(section);
    });
    
    document.addEventListener('click', (e) => {
        if (!e.target.closest('.help-search-container') && !e.target.closest('#searchResults')) {
            const searchResults = document.getElementById('searchResults');
            if (searchResults) {
                searchResults.style.display = 'none';
            }
        }
    });
});

const helpCenterStyles = `
    .typing-dots {
        display: inline-block;
    }
    
    .typing-dots span {
        display: inline-block;
        width: 8px;
        height: 8px;
        border-radius: 50%;
        background: #ccc;
        margin: 0 2px;
        animation: typing 1.4s infinite ease-in-out;
    }
    
    .typing-dots span:nth-child(1) { animation-delay: -0.32s; }
    .typing-dots span:nth-child(2) { animation-delay: -0.16s; }
    .typing-dots span:nth-child(3) { animation-delay: 0s; }
    
    @keyframes typing {
        0%, 80%, 100% { transform: scale(0.8); opacity: 0.5; }
        40% { transform: scale(1); opacity: 1; }
    }
    
    .search-results-container {
        padding: 1rem;
    }
    
    .search-result-item {
        padding: 1rem;
        border-bottom: 1px solid #eee;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    
    .search-result-item:hover {
        background-color: #f8f9fa;
    }
    
    .search-result-item:last-child {
        border-bottom: none;
    }
    
    .search-result-item h5 {
        margin-bottom: 0.5rem;
        color: #333;
    }
    
    .search-result-item p {
        margin-bottom: 0.25rem;
        line-height: 1.4;
    }
    
    .no-results {
        text-align: center;
        padding: 2rem;
        color: #6c757d;
    }
    
    .category-articles-container .category-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 1.5rem;
        padding-bottom: 1rem;
        border-bottom: 2px solid #DAA520;
    }
    
    .articles-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 1.5rem;
    }
    
    .article-card {
        background: #f8f9fa;
        border-radius: 12px;
        padding: 1.5rem;
        cursor: pointer;
        transition: all 0.3s ease;
        border: 2px solid transparent;
    }
    
    .article-card:hover {
        background: white;
        border-color: #DAA520;
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0,0,0,0.1);
    }
    
    .article-card h5 {
        color: #333;
        margin-bottom: 0.75rem;
        font-weight: 600;
    }
    
    .article-card p {
        color: #6c757d;
        margin-bottom: 0.5rem;
        line-height: 1.5;
    }
    
    .article-content {
        line-height: 1.7;
    }
    
    .article-category {
        margin-bottom: 1rem;
    }
    
    .article-text {
        font-size: 1.1rem;
        margin-bottom: 1.5rem;
    }
    
    mark {
        background-color: #fff3cd;
        padding: 0.1em 0.2em;
        border-radius: 3px;
    }
    
    @media (max-width: 768px) {
        .articles-grid {
            grid-template-columns: 1fr;
        }
        
        .category-articles-container .category-header {
            flex-direction: column;
            gap: 1rem;
            text-align: center;
        }
        
        .search-results-container {
            max-height: 300px;
        }
    }
`;

const helpStyleSheet = document.createElement('style');
helpStyleSheet.textContent = helpCenterStyles;
document.head.appendChild(helpStyleSheet);