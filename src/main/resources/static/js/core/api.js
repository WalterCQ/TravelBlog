/**
 * Modern API Client (2025)
 * Fetch-based API wrapper with error handling and caching
 */

class APIClient {
    constructor(baseURL = '/api/v1') {
        this.baseURL = baseURL;
        this.defaultHeaders = {
            'Content-Type': 'application/json',
            'Accept': 'application/json'
        };
        this.cache = new Map();
        this.cacheTimeout = 5 * 60 * 1000; // 5 minutes
    }

    /**
     * Make HTTP request
     */
    async request(endpoint, options = {}) {
        const url = `${this.baseURL}${endpoint}`;
        const config = {
            ...options,
            headers: {
                ...this.defaultHeaders,
                ...options.headers
            }
        };

        try {
            const response = await fetch(url, config);
            
            if (!response.ok) {
                const error = await this.handleError(response);
                throw error;
            }

            const contentType = response.headers.get('content-type');
            if (contentType && contentType.includes('application/json')) {
                return await response.json();
            }
            
            return await response.text();
        } catch (error) {
            console.error('API request failed:', error);
            throw error;
        }
    }

    /**
     * Handle API errors
     */
    async handleError(response) {
        const error = new Error();
        error.status = response.status;
        error.statusText = response.statusText;

        try {
            const data = await response.json();
            error.message = data.message || response.statusText;
            error.details = data.details || null;
        } catch (e) {
            error.message = response.statusText;
        }

        return error;
    }

    /**
     * GET request with caching
     */
    async get(endpoint, useCache = true) {
        const cacheKey = `GET:${endpoint}`;
        
        if (useCache && this.cache.has(cacheKey)) {
            const cached = this.cache.get(cacheKey);
            if (Date.now() - cached.timestamp < this.cacheTimeout) {
                console.log('📦 Using cached data for:', endpoint);
                return cached.data;
            }
        }

        const data = await this.request(endpoint, { method: 'GET' });
        
        if (useCache) {
            this.cache.set(cacheKey, {
                data,
                timestamp: Date.now()
            });
        }

        return data;
    }

    /**
     * POST request
     */
    async post(endpoint, data) {
        return await this.request(endpoint, {
            method: 'POST',
            body: JSON.stringify(data)
        });
    }

    /**
     * PUT request
     */
    async put(endpoint, data) {
        return await this.request(endpoint, {
            method: 'PUT',
            body: JSON.stringify(data)
        });
    }

    /**
     * PATCH request
     */
    async patch(endpoint, data) {
        return await this.request(endpoint, {
            method: 'PATCH',
            body: JSON.stringify(data)
        });
    }

    /**
     * DELETE request
     */
    async delete(endpoint) {
        return await this.request(endpoint, {
            method: 'DELETE'
        });
    }

    /**
     * Clear cache
     */
    clearCache(endpoint = null) {
        if (endpoint) {
            const cacheKey = `GET:${endpoint}`;
            this.cache.delete(cacheKey);
        } else {
            this.cache.clear();
        }
    }

    /**
     * Upload file
     */
    async uploadFile(endpoint, file, additionalData = {}) {
        const formData = new FormData();
        formData.append('file', file);
        
        Object.keys(additionalData).forEach(key => {
            formData.append(key, additionalData[key]);
        });

        const headers = { ...this.defaultHeaders };
        delete headers['Content-Type']; // Let browser set it with boundary

        return await this.request(endpoint, {
            method: 'POST',
            body: formData,
            headers
        });
    }
}

// Create and export singleton instance
export const api = new APIClient();
export default api;



