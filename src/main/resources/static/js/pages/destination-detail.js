document.addEventListener('DOMContentLoaded', function() {
    initializeTooltips();
    initializeModalEvents();
    initializeScrollEffects();
    initializeWeatherAnimation();
    initializeWeatherWidget();
    initializePackageInteractions();
    initializeGalleryCarousel();
    initializeSmoothScrolling();
    startWeatherUpdateInterval();
});

function initializeTooltips() {
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    const tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
}

function initializeModalEvents() {
    const galleryModal = document.getElementById('galleryModal');
    if (galleryModal) {
        galleryModal.addEventListener('shown.bs.modal', function () {
            const carousel = document.querySelector('#galleryCarousel');
            if (carousel) {
                bootstrap.Carousel.getInstance(carousel).cycle();
            }
        });
    }
    
    const shareModal = document.getElementById('shareModal');
    if (shareModal) {
        shareModal.addEventListener('shown.bs.modal', function () {
            const shareUrlInput = document.getElementById('shareUrl');
            if (shareUrlInput) {
                shareUrlInput.focus();
                shareUrlInput.select();
            }
        });
    }
}

function copyToClipboard() {
    const shareUrl = document.getElementById('shareUrl');
    if (!shareUrl) return;
    
    try {
        shareUrl.select();
        shareUrl.setSelectionRange(0, 99999);
        document.execCommand('copy');
        
        const button = event.target.closest('button');
        if (button) {
            const originalHTML = button.innerHTML;
            button.innerHTML = '<i data-lucide="check"></i>';
            button.classList.add('btn-success');
            button.classList.remove('btn-outline-secondary');
            
            setTimeout(() => {
                button.innerHTML = originalHTML;
                button.classList.remove('btn-success');
                button.classList.add('btn-outline-secondary');
            }, 2000);
        }
        
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
    
    const animatedElements = document.querySelectorAll('.content-section, .package-card, .review-card');
    animatedElements.forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(20px)';
        el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(el);
    });
}

function initializeWeatherAnimation() {
    const weatherIcon = document.querySelector('.weather-icon');
    if (weatherIcon) {
        weatherIcon.addEventListener('mouseenter', function() {
            this.style.animationPlayState = 'paused';
        });
        
        weatherIcon.addEventListener('mouseleave', function() {
            this.style.animationPlayState = 'running';
        });
    }
}

function bookPackage(packageId) {
    if (packageId) {
        window.location.href = `${window.location.origin}/booking?packageId=${packageId}`;
    }
}

function viewPackageDetails(packageId) {
    if (packageId) {
        window.location.href = `${window.location.origin}/packages/${packageId}`;
    }
}

function shareToSocial(platform) {
    const url = encodeURIComponent(window.location.href);
    const title = encodeURIComponent(document.title);
    const description = encodeURIComponent(document.querySelector('meta[name="description"]')?.content || '');
    
    let shareUrl = '';
    
    switch(platform) {
        case 'facebook':
            shareUrl = `https://www.facebook.com/sharer/sharer.php?u=${url}`;
            break;
        case 'twitter':
            shareUrl = `https://twitter.com/intent/tweet?url=${url}&text=${title}`;
            break;
        case 'whatsapp':
            shareUrl = `https://wa.me/?text=${title}%20${url}`;
            break;
        case 'email':
            shareUrl = `mailto:?subject=${title}&body=${description}%20${url}`;
            break;
    }
    
    if (shareUrl) {
        window.open(shareUrl, '_blank', 'width=600,height=400');
    }
}

function initializeGalleryCarousel() {
    const carousel = document.getElementById('galleryCarousel');
    if (carousel) {
        carousel.addEventListener('keydown', function(e) {
            if (e.key == 'ArrowLeft') {
                bootstrap.Carousel.getInstance(carousel).prev();
            } else if (e.key == 'ArrowRight') {
                bootstrap.Carousel.getInstance(carousel).next();
            }
        });
        
        let startX = 0;
        let endX = 0;
        
        carousel.addEventListener('touchstart', function(e) {
            startX = e.touches[0].clientX;
        });
        
        carousel.addEventListener('touchend', function(e) {
            endX = e.changedTouches[0].clientX;
            handleSwipe();
        });
        
        function handleSwipe() {
            const threshold = 50;
            const diff = startX - endX;
            
            if (Math.abs(diff) > threshold) {
                if (diff > 0) {
                    bootstrap.Carousel.getInstance(carousel).next();
                } else {
                    bootstrap.Carousel.getInstance(carousel).prev();
                }
            }
        }
    }
}

function initializeSmoothScrolling() {
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
}

function initializeWeatherWidget() {
    const weatherCard = document.querySelector('.weather-card');
    if (!weatherCard) {
        console.log('Weather card not found');
        return;
    }

    // Use only city name for weather search
    const cityName = getDestinationCity();
    const countryName = getDestinationCountry();

    console.log('🌤️ Weather search - City:', cityName, 'Country:', countryName);

    if (cityName) {
        // Use only city name
        loadWeatherForDestination(cityName, countryName);
    } else {
        console.warn('No city name found, cannot load weather');
        showWeatherError('City information not available');
    }
}

function getDestinationName() {
    const titleElements = [
        '.destination-title',
        '.hero-title h1',
        'h1',
        '[data-destination-name]'
    ];

    for (const selector of titleElements) {
        const element = document.querySelector(selector);
        if (element) {
            return element.textContent?.trim() || element.dataset?.destinationName;
        }
    }

    const metaElement = document.querySelector('meta[name="destination-name"]');
    return metaElement?.getAttribute('content') || null;
}

function getDestinationCountry() {
    // First try to get from weather card
    const weatherCard = document.querySelector('.weather-card[data-country]');
    if (weatherCard && weatherCard.dataset.country) {
        return weatherCard.dataset.country;
    }
    
    // Then try to get from other elements
    const countryElement = document.querySelector('[data-country]');
    if (countryElement && countryElement.dataset.country) {
        return countryElement.dataset.country;
    }

    // Try to extract from page location information
    const locationElement = document.querySelector('.destination-location span');
    if (locationElement) {
        const locationText = locationElement.textContent.trim();
        // Extract country name after comma
        const parts = locationText.split(',');
        if (parts.length > 0) {
            return parts[parts.length - 1].trim();
        }
    }

    const metaElement = document.querySelector('meta[name="destination-country"]');
    return metaElement?.getAttribute('content') || null;
}

function getDestinationCity() {
    // Method 1: Get from weather-card's data-city attribute
    const weatherCard = document.querySelector('.weather-card');
    if (weatherCard && weatherCard.dataset.city) {
        const city = weatherCard.dataset.city.trim();
        if (city) {
            console.log('✅ Got city from data-city:', city);
            return city;
        }
    }
    
    // Method 2: Extract city from page location information
    const locationElement = document.querySelector('.destination-location span');
    if (locationElement) {
        const locationText = locationElement.textContent.trim();
        const parts = locationText.split(',').map(p => p.trim());
        
        if (parts.length > 1) {
            // If there's a comma, first part is city
            const cityName = parts[0];
            console.log('✅ Extracted city from location:', cityName);
            return cityName;
        }
    }
    
    console.warn('⚠️ No city found');
    return null;
}

/**
 * Clean destination name, remove landmark/building keywords, extract city name
 */
function cleanDestinationName(name) {
    if (!name) return null;
    
    // Common landmark/building keywords (to be removed)
    const landmarkKeywords = [
        'Tower', 'Building', 'Bridge', 'Palace', 'Temple', 'Museum', 
        'Park', 'Garden', 'Stadium', 'Arena', 'Castle', 'Fort',
        'Cathedral', 'Church', 'Mosque', 'Shrine', 'Monument',
        'Square', 'Plaza', 'Market', 'Beach', 'Island', 'Mountain',
        'Lake', 'River', 'Falls', 'Canyon', 'Valley', 'Desert',
        'National', 'State', 'Royal', 'Grand', 'Great', 'The',
        'Statue of', 'House of', 'Bay of'
    ];
    
    // Remove these keywords
    let cleaned = name;
    landmarkKeywords.forEach(keyword => {
        const regex = new RegExp(`\\b${keyword}\\b`, 'gi');
        cleaned = cleaned.replace(regex, '');
    });
    
    // Remove extra spaces
    cleaned = cleaned.replace(/\s+/g, ' ').trim();
    
    // If cleaned name is too short or empty, return first word of original name
    if (cleaned.length < 3) {
        const words = name.split(/\s+/);
        // Return last word (usually city name comes after landmark name, e.g. "CN Tower Toronto")
        if (words.length > 1) {
            return words[words.length - 1];
        }
        return name;
    }
    
    console.log(`Cleaned destination name: "${name}" -> "${cleaned}"`);
    return cleaned;
}

async function loadWeatherForDestination(cityName, countryName) {
    console.log('🌍 Loading weather for city:', cityName);
    
    if (!cityName) {
        console.error('No city name provided');
        showWeatherError('City name not available');
        return;
    }
    
    // Simplified strategy: prioritize city+country, fallback to city name only
    let coordinates = null;
    
    // Try 1: City + Country
    if (countryName) {
        console.log('📍 Trying:', `${cityName}, ${countryName}`);
        coordinates = await getLocationCoordinates(cityName, countryName);
    }
    
    // Try 2: City name only (if first attempt failed)
    if (!coordinates) {
        console.log('📍 Trying city only:', cityName);
        coordinates = await getLocationCoordinates(cityName, null);
    }
    
    if (coordinates) {
        console.log('✅ Found:', coordinates.name, coordinates.country);
        await loadWeatherData(coordinates.lat, coordinates.lon, coordinates.name);
    } else {
        console.error('❌ Could not find:', cityName);
        showWeatherError(`Weather unavailable for ${cityName}`);
    }
}

/**
 * Get country capital (common countries)
 */
function getCountryCapital(countryName) {
    const capitals = {
        'Canada': 'Ottawa',
        'United States': 'Washington',
        'USA': 'Washington',
        'United Kingdom': 'London',
        'UK': 'London',
        'France': 'Paris',
        'Germany': 'Berlin',
        'Italy': 'Rome',
        'Spain': 'Madrid',
        'Japan': 'Tokyo',
        'China': 'Beijing',
        'Australia': 'Canberra',
        'India': 'New Delhi',
        'Brazil': 'Brasília',
        'Mexico': 'Mexico City',
        'Argentina': 'Buenos Aires',
        'Egypt': 'Cairo',
        'South Africa': 'Pretoria',
        'Russia': 'Moscow',
        'Netherlands': 'Amsterdam',
        'Belgium': 'Brussels',
        'Sweden': 'Stockholm',
        'Norway': 'Oslo',
        'Denmark': 'Copenhagen',
        'Finland': 'Helsinki',
        'Greece': 'Athens',
        'Portugal': 'Lisbon',
        'Switzerland': 'Bern',
        'Austria': 'Vienna',
        'Poland': 'Warsaw',
        'Turkey': 'Ankara',
        'South Korea': 'Seoul',
        'Thailand': 'Bangkok',
        'Singapore': 'Singapore',
        'Malaysia': 'Kuala Lumpur',
        'Indonesia': 'Jakarta',
        'Vietnam': 'Hanoi',
        'Philippines': 'Manila',
        'New Zealand': 'Wellington',
        'Ireland': 'Dublin',
        'Iceland': 'Reykjavik'
    };
    
    return capitals[countryName] || null;
}

async function getLocationCoordinates(cityName, countryName) {
    if (!cityName) {
        console.error('No city name provided');
        return null;
    }
    
    try {
        // Build query string
        const query = countryName ? `${cityName}, ${countryName}` : cityName;
        console.log('Geocoding query:', query);
        
        const url = `https://geocoding-api.open-meteo.com/v1/search?name=${encodeURIComponent(query)}&count=5&language=en&format=json`;
        console.log('Fetching from:', url);
        
        const response = await fetch(url);
        
        if (!response.ok) {
            console.error('Geocoding API request failed with status:', response.status);
            throw new Error(`Geocoding API request failed: ${response.status}`);
        }
        
        const data = await response.json();
        console.log('Geocoding response:', data);
        
        if (data.results && data.results.length > 0) {
            // If country is specified, prioritize matching results
            let location = data.results[0];
            
            if (countryName && data.results.length > 1) {
                const matchingLocation = data.results.find(r => 
                    r.country && r.country.toLowerCase().includes(countryName.toLowerCase())
                );
                if (matchingLocation) {
                    location = matchingLocation;
                }
            }
            
            console.log('Selected location:', location);
            
            return {
                lat: location.latitude,
                lon: location.longitude,
                name: location.name,
                country: location.country || countryName
            };
        } else {
            console.warn('No results found for location:', query);
            return null;
        }
    } catch (error) {
        console.error('Error getting coordinates:', error);
        return null;
    }
}

async function loadWeatherData(lat, lon, cityName) {
    const weatherCard = document.querySelector('.weather-card');
    if (!weatherCard) {
        console.error('❌ Weather card element not found');
        return;
    }
    
    // Use more precise selectors
    const weatherIcon = weatherCard.querySelector('.weather-icon i');
    const tempElement = weatherCard.querySelector('.weather-temp');
    const descElement = weatherCard.querySelector('.weather-desc');
    const messageElement = weatherCard.querySelector('.weather-message');
    
    // Check if necessary elements exist
    if (!weatherIcon || !tempElement || !descElement || !messageElement) {
        console.error('❌ Weather card elements missing:', {
            icon: !!weatherIcon, 
            temp: !!tempElement, 
            desc: !!descElement, 
            message: !!messageElement
        });
        console.log('Weather card HTML:', weatherCard.innerHTML);
        return;
    }
    
    try {
        weatherCard.classList.add('loading');
        
        const url = `https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lon}&current_weather=true&hourly=temperature_2m,relativehumidity_2m,windspeed_10m&timezone=auto`;
        console.log('🌐 Fetching weather from API...');
        
        const response = await fetch(url);
        
        if (!response.ok) {
            throw new Error(`Weather API failed: ${response.status}`);
        }
        
        const data = await response.json();
        console.log('📦 Weather data received:', data);
        
        const currentWeather = data.current_weather;
        const hourlyData = data.hourly;
        
        if (!currentWeather) {
            throw new Error('No current weather data in response');
        }
        
        const temperature = Math.round(currentWeather.temperature);
        const weatherCode = currentWeather.weathercode;
        const windSpeed = Math.round(currentWeather.windspeed);
        const humidity = hourlyData?.relativehumidity_2m?.[0] || 50;
        
        const weatherInfo = getWeatherInfo(weatherCode);
        
        // Update UI
        console.log('🎨 Updating weather UI...');
        weatherIcon.setAttribute('data-lucide', weatherInfo.icon);
        weatherIcon.className = `fs-1 ${weatherInfo.color}`;
        if (typeof lucide !== 'undefined') { try { lucide.createIcons(); } catch(e){} }
        tempElement.textContent = `${temperature}°C`;
        descElement.textContent = weatherInfo.description;
        
        const weatherMessage = getWeatherMessage(weatherCode, temperature);
        messageElement.textContent = weatherMessage;
        
        updateWeatherDetails(weatherCard, windSpeed, humidity, temperature);
        
        console.log('✅ Weather display updated successfully');
        
    } catch (error) {
        console.error('❌ Error loading weather:', error);
        showWeatherError('Unable to load weather data');
    } finally {
        weatherCard.classList.remove('loading');
        console.log('🏁 Weather loading complete');
    }
}

function updateWeatherDetails(weatherCard, windSpeed, humidity, temperature) {
    const detailsHtml = `
        <div class="weather-details mt-3">
            <div class="row text-center">
                <div class="col-4">
                    <i data-lucide="wind" class="text-primary"></i>
                    <div class="small text-muted">Wind</div>
                    <div class="fw-bold">${windSpeed} km/h</div>
                </div>
                <div class="col-4">
                    <i data-lucide="droplets" class="text-info"></i>
                    <div class="small text-muted">Humidity</div>
                    <div class="fw-bold">${humidity}%</div>
                </div>
                <div class="col-4">
                    <i data-lucide="thermometer" class="text-warning"></i>
                    <div class="small text-muted">Feels like</div>
                    <div class="fw-bold">${temperature}°C</div>
                </div>
            </div>
        </div>
    `;
    
    const existingDetails = weatherCard.querySelector('.weather-details');
    if (existingDetails) {
        existingDetails.outerHTML = detailsHtml;
    } else {
        weatherCard.insertAdjacentHTML('beforeend', detailsHtml);
    }
}

function showWeatherError(message) {
    const weatherCard = document.querySelector('.weather-card');
    if (!weatherCard) {
        console.error('Weather card not found for error display');
        return;
    }
    
    const weatherIcon = weatherCard.querySelector('.weather-icon i');
    const tempElement = weatherCard.querySelector('.weather-temp');
    const descElement = weatherCard.querySelector('.weather-desc');
    const messageElement = weatherCard.querySelector('.weather-message');
    
    console.log('⚠️ Showing weather error:', message);
    
    if (weatherIcon) { weatherIcon.setAttribute('data-lucide', 'cloud'); weatherIcon.className = 'fs-1 text-secondary'; }
    if (tempElement) tempElement.textContent = 'N/A';
    if (descElement) descElement.textContent = 'Weather Unavailable';
    if (messageElement) messageElement.textContent = message || 'Unable to fetch weather';
    
    // Remove loading state
    weatherCard.classList.remove('loading');
}

function getWeatherInfo(weatherCode) {
    const weatherCodes = {
        0: { icon: 'sun', color: 'text-warning', description: 'Clear sky' },
        1: { icon: 'sun', color: 'text-warning', description: 'Mainly clear' },
        2: { icon: 'cloud-sun', color: 'text-warning', description: 'Partly cloudy' },
        3: { icon: 'cloud', color: 'text-secondary', description: 'Overcast' },
        45: { icon: 'wind', color: 'text-muted', description: 'Fog' },
        48: { icon: 'wind', color: 'text-muted', description: 'Depositing rime fog' },
        51: { icon: 'cloud-rain', color: 'text-primary', description: 'Light drizzle' },
        53: { icon: 'cloud-rain', color: 'text-primary', description: 'Moderate drizzle' },
        55: { icon: 'cloud-rain', color: 'text-primary', description: 'Dense drizzle' },
        61: { icon: 'cloud-rain', color: 'text-primary', description: 'Slight rain' },
        63: { icon: 'cloud-rain', color: 'text-primary', description: 'Moderate rain' },
        65: { icon: 'cloud-rain', color: 'text-primary', description: 'Heavy rain' },
        71: { icon: 'snowflake', color: 'text-light', description: 'Slight snowfall' },
        73: { icon: 'snowflake', color: 'text-light', description: 'Moderate snowfall' },
        75: { icon: 'snowflake', color: 'text-light', description: 'Heavy snowfall' },
        80: { icon: 'cloud-rain', color: 'text-primary', description: 'Slight rain showers' },
        81: { icon: 'cloud-rain', color: 'text-primary', description: 'Moderate rain showers' },
        82: { icon: 'cloud-rain', color: 'text-primary', description: 'Violent rain showers' },
        95: { icon: 'bolt', color: 'text-danger', description: 'Thunderstorm' },
        96: { icon: 'bolt', color: 'text-danger', description: 'Thunderstorm with hail' },
        99: { icon: 'bolt', color: 'text-danger', description: 'Thunderstorm with heavy hail' }
    };
    
    return weatherCodes[weatherCode] || { icon: 'help-circle', color: 'text-muted', description: 'Unknown' };
}

function getWeatherMessage(weatherCode, temperature) {
    if (weatherCode === 0 || weatherCode === 1) {
        if (temperature >= 20) {
            return 'Perfect weather for visiting!';
        } else if (temperature >= 10) {
            return 'Great weather for outdoor activities!';
        } else {
            return 'Cool but clear weather.';
        }
    } else if (weatherCode === 2 || weatherCode === 3) {
        return 'Good weather for sightseeing!';
    } else if (weatherCode >= 51 && weatherCode <= 67) {
        return 'Pack an umbrella for your visit!';
    } else if (weatherCode >= 71 && weatherCode <= 86) {
        return 'Winter weather - dress warmly!';
    } else if (weatherCode >= 95) {
        return 'Stormy weather - stay safe indoors!';
    } else {
        return 'Check current conditions before heading out!';
    }
}

function initializePackageInteractions() {
    const packageCards = document.querySelectorAll('.package-card');
    
    packageCards.forEach(card => {
        card.addEventListener('mouseenter', () => {
            card.style.transform = 'translateY(-2px)';
            card.style.boxShadow = '0 8px 25px rgba(0,0,0,0.15)';
        });
        
        card.addEventListener('mouseleave', () => {
            card.style.transform = 'translateY(0)';
            card.style.boxShadow = '0 2px 15px rgba(0,0,0,0.08)';
        });
    });

    const bookingButtons = document.querySelectorAll('.package-actions .btn-primary');
    bookingButtons.forEach(button => {
        button.addEventListener('click', (e) => {
            trackPackageBooking(e.target.closest('.package-card'));
        });
    });
}

function trackPackageBooking(packageCard) {
    const packageName = packageCard.querySelector('.package-title h3')?.textContent;
    const packagePrice = packageCard.querySelector('.package-price')?.textContent;
    
    console.log('Package booking initiated:', {
        package: packageName,
        price: packagePrice,
        timestamp: new Date().toISOString()
    });
}

let weatherUpdateInterval;

function startWeatherUpdateInterval() {
    if (document.querySelector('.weather-card')) {
        weatherUpdateInterval = setInterval(() => {
            initializeWeatherWidget();
        }, 600000);
    }
}

function destroyWeatherInterval() {
    if (weatherUpdateInterval) {
        clearInterval(weatherUpdateInterval);
    }
}

window.addEventListener('beforeunload', function() {
    destroyWeatherInterval();
});

window.copyToClipboard = copyToClipboard;
window.shareToSocial = shareToSocial;
window.bookPackage = bookPackage;
window.viewPackageDetails = viewPackageDetails;
window.loadWeatherForDestination = loadWeatherForDestination;
window.showNotification = showNotification;