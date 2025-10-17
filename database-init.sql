DROP DATABASE IF EXISTS mytour_travel;
CREATE DATABASE mytour_travel 
CHARACTER SET utf8mb4 
COLLATE utf8mb4_unicode_ci;

USE mytour_travel;

CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    phone VARCHAR(20),
    role VARCHAR(20) DEFAULT 'USER',
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_email (email),
    INDEX idx_role (role)
);

CREATE TABLE destinations (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    country VARCHAR(50) NOT NULL,
    city VARCHAR(50),
    continent VARCHAR(30),
    base_price DECIMAL(10,2),
    currency VARCHAR(3) DEFAULT 'MYR',
    image_path VARCHAR(255),
    video_path VARCHAR(255),
    category ENUM('NATURE', 'CITY', 'BEACH', 'HERITAGE', 'ADVENTURE') DEFAULT 'NATURE',
    rating INT DEFAULT 5 CHECK (rating >= 1 AND rating <= 5),
    total_reviews INT DEFAULT 0,
    featured BOOLEAN DEFAULT FALSE,
    highlights TEXT,
    best_time_to_visit VARCHAR(100),
    average_duration INT,
    difficulty_level ENUM('EASY', 'MODERATE', 'CHALLENGING') DEFAULT 'EASY',
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_country (country),
    INDEX idx_category (category),
    INDEX idx_featured (featured),
    INDEX idx_active (active),
    INDEX idx_featured_active (featured, active)
);

CREATE TABLE packages (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    destination_id BIGINT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'MYR',
    duration_days INT NOT NULL DEFAULT 1,
    duration_nights INT NOT NULL DEFAULT 0,
    max_participants INT DEFAULT 10,
    min_participants INT DEFAULT 1,
    package_type ENUM('STANDARD', 'PREMIUM', 'LUXURY') DEFAULT 'STANDARD',
    inclusions TEXT,
    exclusions TEXT,
    itinerary TEXT,
    image_path VARCHAR(255),
    featured BOOLEAN DEFAULT FALSE,
    active BOOLEAN DEFAULT TRUE,
    available_from TIMESTAMP,
    available_to TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (destination_id) REFERENCES destinations(id) ON DELETE CASCADE,
    INDEX idx_destination_id (destination_id),
    INDEX idx_featured (featured),
    INDEX idx_active (active),
    INDEX idx_featured_active (featured, active),
    INDEX idx_price (price)
);

CREATE TABLE bookings (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    booking_number VARCHAR(50) UNIQUE NOT NULL,
    booking_reference VARCHAR(50),
    user_id BIGINT NOT NULL,
    package_id BIGINT NOT NULL,
    departure_date DATE,
    return_date DATE,
    travel_date DATE,
    booking_date DATE,
    confirmation_date DATE,
    cancellation_date DATE,
    cancellation_reason VARCHAR(500),
    number_of_participants INT DEFAULT 1,
    number_of_travelers INT DEFAULT 1,
    adult_count INT DEFAULT 0,
    child_count INT DEFAULT 0,
    total_price DECIMAL(10,2) NOT NULL,
    currency VARCHAR(3) DEFAULT 'MYR',
    status VARCHAR(20) DEFAULT 'PENDING',
    payment_status VARCHAR(20) DEFAULT 'PENDING',
    payment_method VARCHAR(50),
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100) NOT NULL,
    customer_phone VARCHAR(20),
    special_requests TEXT,
    emergency_contact VARCHAR(100),
    emergency_phone VARCHAR(20),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (package_id) REFERENCES packages(id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_package_id (package_id),
    INDEX idx_status (status),
    INDEX idx_departure_date (departure_date),
    INDEX idx_booking_number (booking_number)
);

CREATE TABLE contact_messages (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    subject VARCHAR(200) NOT NULL,
    message TEXT NOT NULL,
    status ENUM('NEW', 'READ', 'REPLIED') DEFAULT 'NEW',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_status (status),
    INDEX idx_email (email),
    INDEX idx_created_at (created_at)
);

INSERT INTO users (username, password, email, first_name, last_name, role, active) VALUES
('admin', 'admin123', 'admin@mytour.com', 'Admin', 'User', 'ADMIN', TRUE),
('john_doe', 'password123', 'john@example.com', 'John', 'Doe', 'USER', TRUE),
('mary_smith', 'password123', 'mary@example.com', 'Mary', 'Smith', 'USER', TRUE),
('david_wilson', 'password123', 'david@example.com', 'David', 'Wilson', 'USER', TRUE),
('sarah_jones', 'password123', 'sarah@example.com', 'Sarah', 'Jones', 'USER', TRUE);

INSERT INTO destinations (name, description, country, city, continent, base_price, currency, image_path, category, rating, total_reviews, featured, highlights, best_time_to_visit, average_duration, difficulty_level, active) VALUES

('Christ the Redeemer', 'Experience one of the New Seven Wonders of the World atop Corcovado Mountain in Rio de Janeiro. This iconic 30-meter tall Art Deco statue of Jesus Christ with outstretched arms overlooks the entire city from 710 meters above sea level.', 'Brazil', 'Rio de Janeiro', 'South America', 1899.99, 'USD', 'images/Christ-the-Redeemer.jpg', 'HERITAGE', 5, 2847, TRUE, 'Panoramic city views, Train ride through Atlantic Forest, Art Deco architecture, Chapel visit', 'April to September', 4, 'EASY', TRUE),

('CN Tower Toronto', 'Discover Toronto\'s most iconic landmark, standing at 553.33 meters tall as the world\'s 6th tallest free-standing structure. Experience breathtaking 360-degree views from multiple observation decks including the famous Glass Floor.', 'Canada', 'Toronto', 'North America', 1599.99, 'USD', 'images/CN-Tower.jpg', 'CITY', 5, 1923, TRUE, 'Glass Floor experience, EdgeWalk adventure, 360 Restaurant, Panoramic views', 'May to October', 3, 'EASY', TRUE),

('Roman Colosseum', 'Step into ancient Rome at the magnificent Colosseum, the largest amphitheater ever built and one of the New Seven Wonders of the World. This iconic 2,000-year-old structure once hosted gladiator battles.', 'Italy', 'Rome', 'Europe', 1299.99, 'USD', 'images/Colosseum.jpg', 'HERITAGE', 5, 3456, TRUE, 'Underground chambers, Arena floor, Roman history, Architectural marvel', 'April to June, September to October', 3, 'EASY', TRUE),

('Corsica Island Paradise', 'Discover the rugged beauty of Corsica, the Mediterranean jewel offering pristine beaches, dramatic mountain landscapes, and rich cultural heritage. Known as the "Island of Beauty".', 'France', 'Ajaccio', 'Europe', 1199.99, 'USD', 'images/Corsica.jpg', 'BEACH', 4, 856, FALSE, 'Pristine beaches, Mountain landscapes, Cultural heritage, Local cuisine', 'May to September', 5, 'EASY', TRUE),

('Dolomites Night Photography', 'Experience the dramatic beauty of the Italian Dolomites under starlit skies, perfect for photography enthusiasts and nature lovers. These UNESCO World Heritage mountains offer spectacular alpine scenery.', 'Italy', 'South Tyrol', 'Europe', 1599.99, 'USD', 'images/DolomitesNight.jpg', 'NATURE', 4, 654, FALSE, 'Night photography, Alpine scenery, UNESCO World Heritage, Stargazing', 'June to September', 4, 'MODERATE', TRUE),

('Dordogne Valley Romance', 'Experience the romantic charm of France\'s Dordogne region with medieval castles, prehistoric caves, and gastronomic delights. This picturesque valley features over 1,000 castles.', 'France', 'Sarlat-la-Canéda', 'Europe', 1399.99, 'USD', 'images/DordogneValley.jpg', 'HERITAGE', 4, 743, FALSE, 'Medieval castles, Prehistoric caves, Gourmet cuisine, River cruises', 'April to October', 4, 'EASY', TRUE),

('Eiffel Tower Paris', 'Experience the romance and elegance of Paris with visits to the iconic Eiffel Tower, the "Iron Lady" standing 330 meters tall. Ascend to multiple viewing levels for breathtaking views of the City of Light.', 'France', 'Paris', 'Europe', 1799.99, 'USD', 'images/Eiffel-Tower.jpg', 'CITY', 5, 4521, TRUE, 'Iconic landmark, City views, Light show, Romantic atmosphere', 'Year-round, best April to October', 3, 'EASY', TRUE),

('Grand Canyon Arizona', 'Witness one of the world\'s most spectacular natural wonders at the Grand Canyon, carved by the Colorado River over millions of years. This UNESCO World Heritage Site stretches 277 miles long.', 'USA', 'Arizona', 'North America', 2199.99, 'USD', 'images/GrandCanyonArizona.webp', 'NATURE', 5, 5234, TRUE, 'Natural wonder, Geological formations, Hiking trails, Sunrise/sunset views', 'March to May, September to November', 4, 'MODERATE', TRUE),

('Great Barrier Reef', 'Dive into one of the world\'s most spectacular coral reef systems and experience incredible marine biodiversity. This UNESCO World Heritage Site stretches over 2,300 kilometers.', 'Australia', 'Cairns', 'Oceania', 2599.99, 'USD', 'images/Great-Barrier-Reef.jpg', 'NATURE', 5, 3876, TRUE, 'Coral reef diving, Marine life, Underwater photography, Boat excursions', 'May to October', 5, 'EASY', TRUE),

('Iguazu Falls', 'Experience the thundering power of Iguazu Falls, one of the world\'s most spectacular waterfall systems spanning the Argentina-Brazil border. With 275 individual falls cascading over 80 meters high.', 'Argentina', 'Puerto Iguazu', 'South America', 1499.99, 'USD', 'images/IguazuFalls.jpg', 'NATURE', 5, 2134, TRUE, 'Waterfall systems, Devil\'s Throat, Wildlife spotting, Rainbow views', 'March to May, August to October', 3, 'EASY', TRUE),

('Tropical Indonesia Paradise', 'Discover the enchanting beauty of Indonesia\'s tropical islands, featuring pristine beaches, vibrant coral reefs, and rich cultural heritage. From Bali\'s terraced rice paddies to ancient temples.', 'Indonesia', 'Bali', 'Asia', 1399.99, 'USD', 'images/Indonesia.jpg', 'BEACH', 5, 4567, TRUE, 'Tropical beaches, Cultural temples, Marine life, Traditional cuisine', 'April to October', 7, 'EASY', TRUE),

('Kamenjak Cape Croatia', 'Discover Croatia\'s stunning Adriatic coastline at Kamenjak Cape, the southernmost point of Istria peninsula. This protected natural park features pristine beaches and crystal-clear waters.', 'Croatia', 'Pula', 'Europe', 999.99, 'USD', 'images/KamenjakCape.jpg', 'BEACH', 4, 567, FALSE, 'Pristine beaches, Hidden coves, Sunset views, Coastal trails', 'May to September', 3, 'EASY', TRUE),

('Machu Picchu Ancient Wonder', 'Journey to the legendary Inca citadel of Machu Picchu, the "Lost City of the Incas" perched dramatically on a mountain ridge 2,430 meters above sea level.', 'Peru', 'Cusco', 'South America', 2299.99, 'USD', 'images/MachuPicchu.jpg', 'HERITAGE', 5, 6789, TRUE, 'Inca architecture, Mountain trekking, Sunrise views, Archaeological site', 'May to September', 4, 'CHALLENGING', TRUE),

('Meili Snow Mountain', 'Experience the pristine beauty of Meili Snow Mountain, part of the Three Parallel Rivers UNESCO World Heritage area in Yunnan Province. This sacred Tibetan mountain range features 13 peaks over 6,000 meters.', 'China', 'Deqin', 'Asia', 1699.99, 'USD', 'images/MeiliSnowmount.png', 'NATURE', 4, 892, FALSE, 'Sacred mountains, Tibetan culture, Sunrise views, Alpine landscapes', 'October to April', 5, 'CHALLENGING', TRUE),

('Mount Fuji Cultural Journey', 'Experience Japan\'s iconic Mount Fuji and immerse yourself in traditional Japanese culture, temples, and natural hot springs. This sacred mountain, standing at 3,776 meters, is Japan\'s highest peak.', 'Japan', 'Fujikawaguchiko', 'Asia', 2199.99, 'USD', 'images/Mount-Fuji.jpg', 'NATURE', 5, 3245, TRUE, 'Sacred mountain, Traditional culture, Hot springs, Lake views', 'March to November', 4, 'MODERATE', TRUE),

('Mount Kilimanjaro Expedition', 'Conquer Africa\'s highest peak and stand on the "Roof of Africa" at 5,895 meters above sea level. Mount Kilimanjaro offers a unique opportunity to experience diverse ecosystems.', 'Tanzania', 'Moshi', 'Africa', 3299.99, 'USD', 'images/MountKilimanjaro.webp', 'ADVENTURE', 4, 1876, TRUE, 'Summit climbing, Diverse ecosystems, Sunrise views, Personal achievement', 'June to October, December to March', 7, 'CHALLENGING', TRUE),

('Northern Lights Norway', 'Experience the magical Aurora Borealis in the pristine wilderness of Northern Norway. Witness the dancing lights across the Arctic sky in this breathtaking natural phenomenon.', 'Norway', 'Tromsø', 'Europe', 2299.99, 'USD', 'images/Norway.jpg', 'NATURE', 5, 4321, TRUE, 'Aurora Borealis, Dog sledding, Arctic wildlife, Cultural experiences', 'October to March', 5, 'EASY', TRUE),

('Pyramids of Giza', 'Explore the last remaining Wonder of the Ancient World and uncover the mysteries of ancient Egyptian civilization. The Great Pyramid of Giza, built over 4,500 years ago.', 'Egypt', 'Giza', 'Africa', 1799.99, 'USD', 'images/Pyramids-of-Giza.jpg', 'HERITAGE', 5, 5432, TRUE, 'Ancient wonders, Pyramid exploration, Sphinx visit, Egyptian history', 'October to April', 4, 'EASY', TRUE),

('Eternal City Rome', 'Walk through 2,000 years of history in Rome, the "Eternal City" where ancient ruins stand alongside Renaissance masterpieces. Explore the Roman Forum, Pantheon, and Vatican City.', 'Italy', 'Rome', 'Europe', 1599.99, 'USD', 'images/Rome.jpg', 'HERITAGE', 5, 6543, TRUE, 'Ancient ruins, Vatican City, Italian cuisine, Historical sites', 'April to June, September to October', 4, 'EASY', TRUE),

('Sagrada Família Barcelona', 'Marvel at Antoni Gaudí\'s architectural masterpiece, the Sagrada Família, Barcelona\'s most iconic landmark and UNESCO World Heritage Site. This extraordinary basilica, under construction since 1882.', 'Spain', 'Barcelona', 'Europe', 1499.99, 'USD', 'images/SagradaFamília.jpg', 'HERITAGE', 5, 4987, TRUE, 'Gaudí architecture, Modernist design, Stained glass, Spiritual experience', 'Year-round, best April to October', 3, 'EASY', TRUE),

('Seiser Alm Alpine Paradise', 'Discover Europe\'s largest high-altitude alpine meadow at Seiser Alm in South Tyrol, offering spectacular mountain vistas and pristine natural beauty.', 'Italy', 'South Tyrol', 'Europe', 1699.99, 'USD', 'images/SeiserAlm.jpg', 'NATURE', 4, 1234, FALSE, 'Alpine meadows, Dolomite peaks, Traditional culture, Mountain activities', 'May to October', 4, 'MODERATE', TRUE),

('Statue of Liberty', 'Visit America\'s symbol of freedom and democracy on Liberty Island in New York Harbor. This iconic 151-foot copper statue, a gift from France in 1886.', 'USA', 'New York', 'North America', 1199.99, 'USD', 'images/StatueofLiberty.jpg', 'HERITAGE', 5, 3876, TRUE, 'Symbol of freedom, Immigration history, Harbor views, Museum visits', 'Year-round, best May to October', 3, 'EASY', TRUE),

('Sydney Opera House', 'Experience Australia\'s architectural icon and UNESCO World Heritage Site overlooking Sydney Harbour. This masterpiece of 20th-century architecture features distinctive sail-shaped shells.', 'Australia', 'Sydney', 'Oceania', 1899.99, 'USD', 'images/Sydney-Opera-House.jpg', 'CITY', 5, 4567, TRUE, 'Architectural icon, Cultural performances, Harbor views, Guided tours', 'Year-round, best September to November', 3, 'EASY', TRUE),

('Taj Mahal Heritage', 'Witness the breathtaking beauty of the Taj Mahal, the "Crown of Palaces" and UNESCO World Heritage Site in Agra. This ivory-white marble mausoleum represents the finest example of Mughal architecture.', 'India', 'Agra', 'Asia', 1299.99, 'USD', 'images/Taj-Mahal.jpg', 'HERITAGE', 5, 7654, TRUE, 'Mughal architecture, Symbol of love, Marble craftsmanship, Garden complex', 'October to March', 3, 'EASY', TRUE),

('Great Wall of China', 'Walk along one of humanity\'s most magnificent achievements, the Great Wall of China stretching over 13,000 miles across northern China. This UNESCO World Heritage Site represents over 2,000 years of construction.', 'China', 'Beijing', 'Asia', 1699.99, 'USD', 'images/The-Great-Wall.jpg', 'HERITAGE', 5, 8765, TRUE, 'Ancient fortification, Historical significance, Mountain views, Engineering marvel', 'March to May, September to November', 4, 'MODERATE', TRUE),

('Uluru Sacred Rock', 'Experience the spiritual heart of Australia at Uluru (Ayers Rock), the world\'s largest monolith rising 348 meters from the Red Centre desert. This UNESCO World Heritage Site holds deep cultural significance.', 'Australia', 'Uluru', 'Oceania', 2199.99, 'USD', 'images/Uluru.jpg', 'NATURE', 5, 2345, TRUE, 'Sacred Aboriginal site, Desert landscapes, Sunrise/sunset, Cultural heritage', 'April to September', 3, 'EASY', TRUE),

('Underwater World Paradise', 'Explore the magnificent underwater realms of the world\'s most pristine marine environments. Experience vibrant coral reefs, encounter diverse marine life including tropical fish, rays, and sea turtles.', 'Multiple', 'Various', 'Multiple', 3499.99, 'USD', 'images/UnderTheSea.jpg', 'ADVENTURE', 4, 1456, FALSE, 'Marine life encounters, Coral reefs, Underwater photography, Diving adventures', 'Year-round (destination dependent)', 10, 'MODERATE', TRUE),

('Victoria Falls Sunset', 'Experience the thundering majesty of Victoria Falls, one of the world\'s largest waterfalls spanning the Zambia-Zimbabwe border. Known locally as "Mosi-oa-Tunya" (The Smoke That Thunders).', 'Zambia', 'Livingstone', 'Africa', 1999.99, 'USD', 'images/victoria_falls_sunset.jpg', 'NATURE', 5, 3456, TRUE, 'Spectacular waterfalls, Sunset views, Helicopter flights, Adventure activities', 'April to October', 4, 'EASY', TRUE),

('Xinjiang Cultural Dance', 'Discover the rich cultural heritage of Xinjiang, China\'s westernmost province, through traditional dance, music, and ancient Silk Road history. Experience diverse ethnic cultures including Uyghur, Kazakh, and Kyrgyz traditions.', 'China', 'Urumqi', 'Asia', 1599.99, 'USD', 'images/XinjiangDance.png', 'HERITAGE', 4, 876, FALSE, 'Cultural performances, Silk Road history, Ethnic diversity, Traditional cuisine', 'May to October', 6, 'EASY', TRUE);

INSERT INTO packages (name, description, destination_id, price, currency, duration_days, duration_nights, max_participants, min_participants, package_type, inclusions, exclusions, itinerary, image_path, featured, active, available_from, available_to) VALUES

('Christ Redeemer Standard Package A', 'Experience the iconic Christ the Redeemer statue with comfortable accommodations and guided tours.', 1, 1299.99, 'USD', 4, 3, 15, 2, 'STANDARD', 'Hotel accommodation, Daily breakfast, Train tickets, Professional guide, City tour, Airport transfers', 'International flights, Lunch and dinner, Personal expenses, Travel insurance', 'Day 1: Arrival Rio, city tour\nDay 2: Christ the Redeemer visit, Sugarloaf Mountain\nDay 3: Copacabana Beach, local markets\nDay 4: Departure', 'images/Christ-the-Redeemer.jpg', FALSE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Christ Redeemer Premium Package B', 'Enhanced experience with luxury hotel, private guide, and exclusive access to special viewing areas.', 1, 2199.99, 'USD', 5, 4, 10, 2, 'PREMIUM', 'Luxury hotel, All meals, Private guide, Helicopter tour, VIP train access, Exclusive viewpoints, Airport transfers', 'International flights, Personal expenses, Travel insurance, Alcoholic beverages', 'Day 1: Arrival, welcome dinner\nDay 2: Private Christ the Redeemer tour\nDay 3: Helicopter city tour, premium beach experience\nDay 4: Cultural immersion, local experiences\nDay 5: Departure', 'images/Christ-the-Redeemer.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Christ Redeemer Luxury Package C', 'Ultimate luxury experience with 5-star accommodations, private helicopter transfers, exclusive dining, and personalized service.', 1, 3599.99, 'USD', 6, 5, 6, 2, 'LUXURY', '5-star hotel suite, All meals and beverages, Private helicopter transfers, Personal concierge, Exclusive experiences, Private tours, Spa treatments', 'International flights, Personal shopping, Tips, Travel insurance', 'Day 1: VIP arrival, luxury welcome\nDay 2: Private helicopter to Christ the Redeemer\nDay 3: Exclusive cultural experiences\nDay 4: Private yacht experience\nDay 5: Personalized activities\nDay 6: VIP departure', 'images/Christ-the-Redeemer.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('CN Tower Explorer Package A', 'Experience Toronto\'s iconic CN Tower with general admission, glass floor experience, and city exploration tours.', 2, 899.99, 'USD', 3, 2, 20, 1, 'STANDARD', 'Hotel accommodation, Daily breakfast, CN Tower admission, Glass floor access, City tour, Public transport passes', 'International flights, Lunch and dinner, Personal expenses, EdgeWalk experience', 'Day 1: Arrival, CN Tower visit\nDay 2: Toronto city tour, Harbourfront\nDay 3: Departure', 'images/CN-Tower.jpg', FALSE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('CN Tower Premium Package B', 'Enhanced Toronto experience with EdgeWalk adventure, 360 Restaurant dining, and premium accommodations.', 2, 1699.99, 'USD', 4, 3, 12, 2, 'PREMIUM', 'Luxury hotel, All meals, EdgeWalk experience, 360 Restaurant dinner, Premium attractions, Private guide, Airport transfers', 'International flights, Personal expenses, Travel insurance, Additional activities', 'Day 1: Arrival, premium accommodation\nDay 2: CN Tower EdgeWalk, 360 Restaurant\nDay 3: Toronto attractions, Niagara Falls day trip\nDay 4: Departure', 'images/CN-Tower.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('CN Tower Luxury Package C', 'Ultimate CN Tower experience with private helicopter tour, exclusive dining, luxury accommodations, and personalized Toronto discovery.', 2, 2899.99, 'USD', 5, 4, 8, 2, 'LUXURY', '5-star hotel suite, All meals and beverages, Private helicopter tour, Exclusive CN Tower access, Personal concierge, Luxury transportation', 'International flights, Personal shopping, Tips, Travel insurance', 'Day 1: VIP arrival, luxury welcome\nDay 2: Private CN Tower experience\nDay 3: Helicopter city tour, exclusive dining\nDay 4: Personalized Toronto exploration\nDay 5: VIP departure', 'images/CN-Tower.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Roman Colosseum Classic Package A', 'Discover ancient Rome with standard Colosseum tour, Roman Forum visit, and essential historical sites.', 3, 999.99, 'USD', 3, 2, 18, 2, 'STANDARD', 'Hotel accommodation, Daily breakfast, Colosseum tickets, Roman Forum access, Professional guide, City walking tour', 'International flights, Lunch and dinner, Personal expenses, Vatican tickets', 'Day 1: Arrival, Colosseum tour\nDay 2: Roman Forum, Palatine Hill\nDay 3: Vatican City, departure', 'images/Colosseum.jpg', FALSE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Roman Colosseum Premium Package B', 'Enhanced Roman experience with skip-the-line access, underground chambers tour, and premium cultural immersion.', 3, 1899.99, 'USD', 4, 3, 12, 2, 'PREMIUM', 'Luxury hotel, All meals, Skip-the-line tickets, Underground Colosseum access, Private guide, Vatican tours, Cooking class', 'International flights, Personal expenses, Travel insurance, Shopping', 'Day 1: Arrival, premium welcome\nDay 2: Exclusive Colosseum underground tour\nDay 3: Vatican private tour, Roman cuisine\nDay 4: Cultural activities, departure', 'images/Colosseum.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Roman Colosseum Luxury Package C', 'Ultimate Roman experience with private archaeologist guide, exclusive after-hours access, luxury accommodations.', 3, 3299.99, 'USD', 5, 4, 6, 2, 'LUXURY', '5-star hotel suite, All meals and wines, Private archaeologist guide, After-hours Colosseum access, Exclusive Vatican tour, Personal driver', 'International flights, Personal shopping, Tips, Travel insurance', 'Day 1: VIP arrival, private orientation\nDay 2: Exclusive Colosseum experience\nDay 3: Private Vatican tour, papal audience\nDay 4: Hidden Rome discoveries\nDay 5: VIP departure', 'images/Colosseum.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Corsica Island Escape Package A', 'Discover Corsica\'s natural beauty with beach activities, coastal exploration, and cultural visits.', 4, 799.99, 'USD', 4, 3, 16, 2, 'STANDARD', 'Hotel accommodation, Daily breakfast, Car rental, Beach access, Village tours, Local guide', 'International flights, Lunch and dinner, Personal expenses, Activities', 'Day 1: Arrival, coastal orientation\nDay 2: Beach exploration, swimming\nDay 3: Mountain villages, local culture\nDay 4: Departure', 'images/Corsica.jpg', FALSE, TRUE, '2024-05-01 00:00:00', '2024-09-30 23:59:59'),

('Corsica Island Premium Package B', 'Enhanced Corsica experience with luxury coastal resort, private boat excursions, gourmet dining.', 4, 1599.99, 'USD', 5, 4, 10, 2, 'PREMIUM', 'Luxury resort, All meals, Private boat trips, Wine tastings, Exclusive beaches, Personal guide, Airport transfers', 'International flights, Personal expenses, Travel insurance, Spa treatments', 'Day 1: Arrival, luxury welcome\nDay 2: Private boat coastal tour\nDay 3: Wine country exploration\nDay 4: Cultural immersion, gourmet dining\nDay 5: Departure', 'images/Corsica.jpg', TRUE, TRUE, '2024-05-01 00:00:00', '2024-09-30 23:59:59'),

('Corsica Island Luxury Package C', 'Ultimate Corsican experience with private villa, yacht charter, helicopter tours, and personalized island discovery.', 4, 2899.99, 'USD', 6, 5, 6, 2, 'LUXURY', 'Private villa, All meals and beverages, Private yacht charter, Helicopter tours, Personal chef, Luxury transportation, Concierge service', 'International flights, Personal shopping, Tips, Travel insurance', 'Day 1: VIP arrival, private villa welcome\nDay 2: Private yacht exploration\nDay 3: Helicopter island tour\nDay 4: Exclusive cultural experiences\nDay 5: Personalized activities\nDay 6: VIP departure', 'images/Corsica.jpg', TRUE, TRUE, '2024-05-01 00:00:00', '2024-09-30 23:59:59'),

('Dolomites Night Photography Package A', 'Photography-focused tour with standard accommodations, guided photo sessions, and access to prime locations.', 5, 1199.99, 'USD', 4, 3, 12, 2, 'STANDARD', 'Mountain hotel, Daily breakfast, Photography guide, Night session access, Equipment rental, Transportation', 'International flights, Lunch and dinner, Personal camera gear, Travel insurance', 'Day 1: Arrival, photo orientation\nDay 2: Day photography, night session\nDay 3: Sunrise shoot, alpine exploration\nDay 4: Final session, departure', 'images/DolomitesNight.jpg', FALSE, TRUE, '2024-06-01 00:00:00', '2024-09-30 23:59:59'),

('Dolomites Night Photography Premium Package B', 'Enhanced photography experience with luxury mountain resort, professional workshops, and exclusive location access.', 5, 2199.99, 'USD', 5, 4, 8, 2, 'PREMIUM', 'Luxury mountain resort, All meals, Professional photo workshops, Exclusive locations, Premium equipment, Private guide, Cable car access', 'International flights, Personal expenses, Travel insurance, Photo printing', 'Day 1: Arrival, equipment setup\nDay 2: Professional workshop, night photography\nDay 3: Exclusive location shoots\nDay 4: Advanced techniques, portfolio review\nDay 5: Departure', 'images/DolomitesNight.jpg', TRUE, TRUE, '2024-06-01 00:00:00', '2024-09-30 23:59:59'),

('Dolomites Night Photography Luxury Package C', 'Ultimate photography experience with private photographer mentor, helicopter access, luxury accommodations.', 5, 3499.99, 'USD', 6, 5, 4, 2, 'LUXURY', '5-star mountain lodge, All meals and beverages, Private photographer mentor, Helicopter access, Professional equipment, Personal instruction, Photo processing', 'International flights, Personal gear, Tips, Travel insurance', 'Day 1: VIP arrival, private consultation\nDay 2: Helicopter photo locations\nDay 3: Master class sessions\nDay 4: Exclusive sunrise/sunset shoots\nDay 5: Portfolio development\nDay 6: VIP departure', 'images/DolomitesNight.jpg', TRUE, TRUE, '2024-06-01 00:00:00', '2024-09-30 23:59:59'),

('Dordogne Valley Romance Package A', 'Romantic getaway with castle visits, charming village exploration, and wine tastings.', 6, 1099.99, 'USD', 4, 3, 14, 2, 'STANDARD', 'Countryside hotel, Daily breakfast, Castle entries, Village tours, Wine tastings, Car rental, Local guide', 'International flights, Lunch and dinner, Personal expenses, Activities', 'Day 1: Arrival, village exploration\nDay 2: Castle visits, river cruise\nDay 3: Wine region tour, local markets\nDay 4: Departure', 'images/DordogneValley.jpg', FALSE, TRUE, '2024-04-01 00:00:00', '2024-10-31 23:59:59'),

('Dordogne Valley Romance Premium Package B', 'Enhanced romantic experience with luxury château stay, private tours, gourmet dining.', 6, 2099.99, 'USD', 5, 4, 8, 2, 'PREMIUM', 'Luxury château, All meals, Private tours, Gourmet dining experiences, Wine master classes, Personal guide, Luxury transportation', 'International flights, Personal expenses, Travel insurance, Spa treatments', 'Day 1: Arrival, château welcome\nDay 2: Private castle tours, fine dining\nDay 3: Wine estate visits, cooking class\nDay 4: Cultural immersion, truffle hunting\nDay 5: Departure', 'images/DordogneValley.jpg', TRUE, TRUE, '2024-04-01 00:00:00', '2024-10-31 23:59:59'),

('Dordogne Valley Romance Luxury Package C', 'Ultimate romantic luxury with private château, helicopter tours, Michelin dining.', 6, 3799.99, 'USD', 6, 5, 4, 2, 'LUXURY', 'Private château suite, All meals and fine wines, Helicopter tours, Michelin-starred dining, Personal sommelier, Luxury experiences, Concierge service', 'International flights, Personal shopping, Tips, Travel insurance', 'Day 1: VIP arrival, private château tour\nDay 2: Helicopter valley exploration\nDay 3: Exclusive wine experiences\nDay 4: Michelin dining, cultural experiences\nDay 5: Romantic personalized activities\nDay 6: VIP departure', 'images/DordogneValley.jpg', TRUE, TRUE, '2024-04-01 00:00:00', '2024-10-31 23:59:59'),

('Eiffel Tower Paris Classic Package A', 'Classic Paris experience with Eiffel Tower visits, Seine cruise, and major attractions.', 7, 1299.99, 'USD', 4, 3, 16, 2, 'STANDARD', 'Hotel accommodation, Daily breakfast, Eiffel Tower tickets, Seine cruise, Museum passes, Metro cards, City guide', 'International flights, Lunch and dinner, Personal expenses, Shopping', 'Day 1: Arrival, Eiffel Tower visit\nDay 2: Louvre, Notre-Dame, Seine cruise\nDay 3: Versailles day trip\nDay 4: Departure', 'images/Eiffel-Tower.jpg', FALSE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Eiffel Tower Paris Premium Package B', 'Enhanced Parisian experience with luxury hotel, skip-the-line access, gourmet dining.', 7, 2499.99, 'USD', 5, 4, 10, 2, 'PREMIUM', 'Luxury hotel, All meals, Skip-the-line tickets, Gourmet dining, Private Seine cruise, Cultural performances, Personal guide', 'International flights, Personal expenses, Travel insurance, Shopping', 'Day 1: Arrival, luxury welcome\nDay 2: VIP Eiffel Tower, gourmet dining\nDay 3: Private Louvre tour, cultural evening\nDay 4: Exclusive Versailles experience\nDay 5: Departure', 'images/Eiffel-Tower.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Eiffel Tower Paris Luxury Package C', 'Ultimate Parisian luxury with 5-star accommodations, private helicopter tours, Michelin dining.', 7, 4299.99, 'USD', 6, 5, 6, 2, 'LUXURY', '5-star hotel suite, All meals and champagne, Private helicopter tours, Michelin-starred dining, Exclusive tower access, Personal concierge, Luxury shopping', 'International flights, Personal purchases, Tips, Travel insurance', 'Day 1: VIP arrival, champagne welcome\nDay 2: Private Eiffel Tower experience\nDay 3: Helicopter Paris tour, Michelin dining\nDay 4: Exclusive Versailles, private shopping\nDay 5: Cultural masterpieces, luxury experiences\nDay 6: VIP departure', 'images/Eiffel-Tower.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Grand Canyon Explorer Package A', 'Standard Grand Canyon experience with rim trail hiking, visitor center tours, and comfortable lodge accommodations.', 8, 1599.99, 'USD', 4, 3, 15, 2, 'STANDARD', 'Lodge accommodation, Daily breakfast, Park entry fees, Guided rim walks, Visitor center tours, Shuttle transportation', 'International flights, Lunch and dinner, Personal expenses, Helicopter tours', 'Day 1: Arrival, South Rim exploration\nDay 2: Rim Trail hiking, sunset viewing\nDay 3: Desert View, cultural center\nDay 4: Departure', 'images/GrandCanyonArizona.webp', FALSE, TRUE, '2024-03-01 00:00:00', '2024-11-30 23:59:59'),

('Grand Canyon Premium Package B', 'Enhanced canyon experience with luxury lodge, helicopter tours, river rafting.', 8, 2999.99, 'USD', 5, 4, 10, 2, 'PREMIUM', 'Luxury lodge, All meals, Helicopter tours, Colorado River rafting, Private guide, Exclusive viewpoints, Photography workshops', 'International flights, Personal expenses, Travel insurance, Gratuities', 'Day 1: Arrival, premium orientation\nDay 2: Helicopter canyon tour\nDay 3: Colorado River adventure\nDay 4: Photography workshop, exclusive access\nDay 5: Departure', 'images/GrandCanyonArizona.webp', TRUE, TRUE, '2024-03-01 00:00:00', '2024-11-30 23:59:59'),

('Grand Canyon Luxury Package C', 'Ultimate canyon luxury with private helicopter charter, multi-day river expedition, luxury camping.', 8, 4899.99, 'USD', 7, 6, 6, 2, 'LUXURY', 'Luxury accommodation, All meals and beverages, Private helicopter charter, Multi-day river expedition, Luxury camping, Personal guide, Photography equipment', 'International flights, Personal gear, Tips, Travel insurance', 'Day 1: VIP arrival, private orientation\nDay 2: Private helicopter exploration\nDay 3-5: Luxury river expedition\nDay 6: Exclusive experiences, spa treatments\nDay 7: VIP departure', 'images/GrandCanyonArizona.webp', TRUE, TRUE, '2024-03-01 00:00:00', '2024-11-30 23:59:59'),

('Great Barrier Reef Snorkel Package A', 'Standard reef experience with snorkeling tours, marine life encounters, and comfortable beachside accommodations.', 9, 1899.99, 'USD', 5, 4, 16, 2, 'STANDARD', 'Beachside hotel, Daily breakfast, Snorkeling tours, Equipment rental, Marine park fees, Boat transfers, Marine guide', 'International flights, Lunch and dinner, Personal expenses, Diving certification', 'Day 1: Arrival, reef orientation\nDay 2: Outer reef snorkeling\nDay 3: Inner reef exploration\nDay 4: Marine life encounters\nDay 5: Departure', 'images/Great-Barrier-Reef.jpg', FALSE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Great Barrier Reef Diving Package B', 'Enhanced reef experience with certified diving, luxury resort, and exclusive reef locations.', 9, 3299.99, 'USD', 6, 5, 10, 2, 'PREMIUM', 'Luxury resort, All meals, Certified diving tours, Exclusive reef sites, Marine biologist guide, Underwater photography, Equipment included', 'International flights, Personal expenses, Travel insurance, Certification courses', 'Day 1: Arrival, diving orientation\nDay 2: Certified reef diving\nDay 3: Exclusive outer reef sites\nDay 4: Marine research participation\nDay 5: Underwater photography\nDay 6: Departure', 'images/Great-Barrier-Reef.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Great Barrier Reef Luxury Package C', 'Ultimate reef luxury with private yacht charter, helicopter access, luxury accommodations.', 9, 5499.99, 'USD', 7, 6, 6, 2, 'LUXURY', 'Luxury resort suite, All meals and beverages, Private yacht charter, Helicopter reef access, Personal marine biologist, Professional diving equipment, Luxury spa', 'International flights, Personal purchases, Tips, Travel insurance', 'Day 1: VIP arrival, private yacht welcome\nDay 2: Helicopter reef exploration\nDay 3: Private yacht diving\nDay 4: Exclusive marine encounters\nDay 5: Research expedition participation\nDay 6: Luxury relaxation, spa\nDay 7: VIP departure', 'images/Great-Barrier-Reef.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Iguazu Falls Adventure Package A', 'Standard waterfall experience with walkway tours, both Argentina and Brazil sides.', 10, 1099.99, 'USD', 3, 2, 18, 2, 'STANDARD', 'Hotel accommodation, Daily breakfast, Park entry fees both sides, Walkway tours, Shuttle transportation, Professional guide', 'International flights, Lunch and dinner, Personal expenses, Helicopter flights', 'Day 1: Arrival, Argentina side tour\nDay 2: Brazil side, panoramic views\nDay 3: Devil\'s Throat, departure', 'images/IguazuFalls.jpg', FALSE, TRUE, '2024-03-01 00:00:00', '2024-10-31 23:59:59'),

('Iguazu Falls Premium Package B', 'Enhanced waterfall experience with luxury lodge, helicopter flights, boat adventures.', 10, 2199.99, 'USD', 4, 3, 12, 2, 'PREMIUM', 'Luxury lodge, All meals, Helicopter flights, Boat adventures, Exclusive walkways, Wildlife tours, Personal guide, Photography sessions', 'International flights, Personal expenses, Travel insurance, Souvenirs', 'Day 1: Arrival, premium orientation\nDay 2: Helicopter waterfall tour\nDay 3: Boat adventure, wildlife exploration\nDay 4: Photography session, departure', 'images/IguazuFalls.jpg', TRUE, TRUE, '2024-03-01 00:00:00', '2024-10-31 23:59:59'),

('Iguazu Falls Luxury Package C', 'Ultimate waterfall luxury with private helicopter charter, exclusive accommodations, personalized adventures.', 10, 3799.99, 'USD', 5, 4, 6, 2, 'LUXURY', 'Luxury resort suite, All meals and beverages, Private helicopter charter, Exclusive access, Personal guide, Adventure activities, Spa treatments, VIP transfers', 'International flights, Personal shopping, Tips, Travel insurance', 'Day 1: VIP arrival, private orientation\nDay 2: Private helicopter exploration\nDay 3: Exclusive boat adventures\nDay 4: Personalized activities, spa\nDay 5: VIP departure', 'images/IguazuFalls.jpg', TRUE, TRUE, '2024-03-01 00:00:00', '2024-10-31 23:59:59'),

('Indonesia Island Paradise Package A', 'Standard tropical experience with beach activities, cultural tours, and comfortable resort accommodations.', 11, 1199.99, 'USD', 7, 6, 16, 2, 'STANDARD', 'Resort accommodation, Daily breakfast, Island transfers, Cultural tours, Snorkeling equipment, Local guides, Airport transfers', 'International flights, Lunch and dinner, Personal expenses, Diving courses', 'Day 1: Arrival Bali, cultural orientation\nDay 2-3: Temple tours, beach relaxation\nDay 4-5: Gili Islands snorkeling\nDay 6: Traditional performances\nDay 7: Departure', 'images/Indonesia.jpg', FALSE, TRUE, '2024-04-01 00:00:00', '2024-10-31 23:59:59'),

('Indonesia Island Premium Package B', 'Enhanced tropical experience with luxury resorts, private boat tours, cultural immersion.', 11, 2399.99, 'USD', 8, 7, 10, 2, 'PREMIUM', 'Luxury resort, All meals, Private boat tours, Cultural workshops, Spa treatments, Personal guide, Diving experiences, Exclusive beaches', 'International flights, Personal expenses, Travel insurance, Shopping', 'Day 1: Arrival, luxury welcome\nDay 2-3: Private cultural immersion\nDay 4-5: Exclusive island hopping\nDay 6-7: Diving adventures, spa\nDay 8: Departure', 'images/Indonesia.jpg', TRUE, TRUE, '2024-04-01 00:00:00', '2024-10-31 23:59:59'),

('Indonesia Island Luxury Package C', 'Ultimate tropical luxury with private villa, yacht charter, helicopter transfers.', 11, 4299.99, 'USD', 10, 9, 6, 2, 'LUXURY', 'Private villa, All meals and beverages, Private yacht charter, Helicopter transfers, Personal butler, Exclusive experiences, Luxury spa, Cultural master classes', 'International flights, Personal purchases, Tips, Travel insurance', 'Day 1: VIP arrival, private villa welcome\nDay 2-3: Private yacht exploration\nDay 4-5: Helicopter island tours\nDay 6-8: Exclusive cultural experiences\nDay 9: Personalized relaxation\nDay 10: VIP departure', 'images/Indonesia.jpg', TRUE, TRUE, '2024-04-01 00:00:00', '2024-10-31 23:59:59'),

('Kamenjak Cape Croatia Package A', 'Standard coastal experience with beach exploration, hiking trails, and comfortable seaside accommodations.', 12, 699.99, 'USD', 3, 2, 15, 2, 'STANDARD', 'Seaside hotel, Daily breakfast, Park entry, Beach access, Hiking guides, Snorkeling equipment, Local transportation', 'International flights, Lunch and dinner, Personal expenses, Water sports', 'Day 1: Arrival, coastal orientation\nDay 2: Beach exploration, snorkeling\nDay 3: Hiking trails, departure', 'images/KamenjakCape.jpg', FALSE, TRUE, '2024-05-01 00:00:00', '2024-09-30 23:59:59'),

('Kamenjak Cape Croatia Premium Package B', 'Enhanced coastal experience with luxury seaside resort, private boat tours, and exclusive beach access.', 12, 1399.99, 'USD', 4, 3, 10, 2, 'PREMIUM', 'Luxury seaside resort, All meals, Private boat tours, Exclusive beaches, Water sports equipment, Personal guide, Wine tastings, Sunset cruises', 'International flights, Personal expenses, Travel insurance, Spa treatments', 'Day 1: Arrival, luxury welcome\nDay 2: Private boat coastal tour\nDay 3: Exclusive beach experiences\nDay 4: Sunset cruise, departure', 'images/KamenjakCape.jpg', TRUE, TRUE, '2024-05-01 00:00:00', '2024-09-30 23:59:59'),

('Kamenjak Cape Croatia Luxury Package C', 'Ultimate coastal luxury with private villa, yacht charter, and personalized Adriatic experiences.', 12, 2599.99, 'USD', 5, 4, 6, 2, 'LUXURY', 'Private coastal villa, All meals and beverages, Private yacht charter, Personal skipper, Exclusive access, Luxury amenities, Personal chef, Concierge service', 'International flights, Personal shopping, Tips, Travel insurance', 'Day 1: VIP arrival, private villa welcome\nDay 2: Private yacht exploration\nDay 3: Exclusive coastal experiences\nDay 4: Personalized activities\nDay 5: VIP departure', 'images/KamenjakCape.jpg', TRUE, TRUE, '2024-05-01 00:00:00', '2024-09-30 23:59:59'),

('Machu Picchu Trek Package A', 'Standard Inca Trail experience with group trekking, basic camping, and guided historical tours.', 13, 1599.99, 'USD', 5, 4, 12, 2, 'STANDARD', 'Hotel and camping accommodation, All meals during trek, Professional guide, Porter service, Train tickets, Entrance fees', 'International flights, Cusco accommodation, Personal expenses, Tips', 'Day 1: Arrival Cusco, orientation\nDay 2: Sacred Valley tour\nDay 3-4: Inca Trail trek\nDay 5: Machu Picchu sunrise, departure', 'images/MachuPicchu.jpg', FALSE, TRUE, '2024-05-01 00:00:00', '2024-09-30 23:59:59'),

('Machu Picchu Premium Package B', 'Enhanced Inca experience with luxury accommodations, private guide, helicopter access.', 13, 2999.99, 'USD', 6, 5, 8, 2, 'PREMIUM', 'Luxury hotel, All meals, Private guide, Helicopter to Machu Picchu, Cultural experiences, Spa treatments, Premium train service', 'International flights, Personal expenses, Travel insurance, Shopping', 'Day 1: Arrival, luxury welcome\nDay 2: Sacred Valley cultural tour\nDay 3: Helicopter to Machu Picchu\nDay 4: Private archaeological tour\nDay 5: Cultural workshops\nDay 6: Departure', 'images/MachuPicchu.jpg', TRUE, TRUE, '2024-05-01 00:00:00', '2024-09-30 23:59:59'),

('Machu Picchu Luxury Package C', 'Ultimate Inca luxury with private helicopter charter, exclusive accommodations, personal archaeologist.', 13, 4799.99, 'USD', 7, 6, 4, 2, 'LUXURY', 'Luxury lodge suite, All meals and beverages, Private helicopter charter, Personal archaeologist, Exclusive site access, Cultural master classes, Luxury amenities', 'International flights, Personal purchases, Tips, Travel insurance', 'Day 1: VIP arrival, private orientation\nDay 2: Helicopter Sacred Valley tour\nDay 3: Private Machu Picchu access\nDay 4: Archaeological master class\nDay 5: Cultural immersion experiences\nDay 6: Personalized activities\nDay 7: VIP departure', 'images/MachuPicchu.jpg', TRUE, TRUE, '2024-05-01 00:00:00', '2024-09-30 23:59:59'),

('Meili Snow Mountain Package A', 'Standard mountain experience with basic trekking, cultural village visits, and simple mountain accommodations.', 14, 1199.99, 'USD', 5, 4, 14, 2, 'STANDARD', 'Mountain guesthouse, Daily meals, Trekking guide, Cultural village tours, Transportation, Basic equipment', 'International flights, Personal expenses, Travel insurance, Advanced equipment', 'Day 1: Arrival, acclimatization\nDay 2: Village cultural tour\nDay 3: Mountain trekking\nDay 4: Sunrise viewing\nDay 5: Departure', 'images/MeiliSnowmount.png', FALSE, TRUE, '2024-10-01 00:00:00', '2024-04-30 23:59:59'),

('Meili Snow Mountain Premium Package B', 'Enhanced mountain experience with comfortable lodges, photography workshops, and cultural immersion.', 14, 2199.99, 'USD', 6, 5, 10, 2, 'PREMIUM', 'Mountain lodge, All meals, Professional guide, Photography workshops, Cultural experiences, Premium equipment, Transportation', 'International flights, Personal expenses, Travel insurance, Gratuities', 'Day 1: Arrival, premium orientation\nDay 2: Cultural immersion\nDay 3: Advanced trekking\nDay 4: Photography workshop\nDay 5: Sacred site visits\nDay 6: Departure', 'images/MeiliSnowmount.png', TRUE, TRUE, '2024-10-01 00:00:00', '2024-04-30 23:59:59'),

('Meili Snow Mountain Luxury Package C', 'Ultimate mountain luxury with private expedition, helicopter access, luxury mountain retreat.', 14, 3799.99, 'USD', 7, 6, 6, 2, 'LUXURY', 'Luxury mountain retreat, All meals and beverages, Private expedition guide, Helicopter access, Spiritual master classes, Premium equipment, Personal services', 'International flights, Personal gear, Tips, Travel insurance', 'Day 1: VIP arrival, private retreat welcome\nDay 2: Helicopter mountain exploration\nDay 3: Private spiritual journey\nDay 4: Exclusive cultural experiences\nDay 5: Advanced mountain activities\nDay 6: Personalized retreat\nDay 7: VIP departure', 'images/MeiliSnowmount.png', TRUE, TRUE, '2024-10-01 00:00:00', '2024-04-30 23:59:59'),

('Mount Fuji Experience Package A', 'Standard Mount Fuji experience with viewing tours, cultural activities, and comfortable accommodations.', 15, 1599.99, 'USD', 4, 3, 16, 2, 'STANDARD', 'Hotel accommodation, Daily breakfast, Mount Fuji tours, Cultural activities, Hot spring access, Local transportation, Professional guide', 'International flights, Lunch and dinner, Personal expenses, Climbing permits', 'Day 1: Arrival, Fuji orientation\nDay 2: Five Lakes tour, cultural sites\nDay 3: Hot springs, traditional activities\nDay 4: Departure', 'images/Mount-Fuji.jpg', FALSE, TRUE, '2024-03-01 00:00:00', '2024-11-30 23:59:59'),

('Mount Fuji Premium Package B', 'Enhanced Fuji experience with traditional ryokan, private cultural lessons, and exclusive mountain access.', 15, 2899.99, 'USD', 5, 4, 10, 2, 'PREMIUM', 'Traditional ryokan, All meals, Private cultural lessons, Tea ceremony, Exclusive mountain tours, Hot spring treatments, Personal guide', 'International flights, Personal expenses, Travel insurance, Shopping', 'Day 1: Arrival, ryokan welcome\nDay 2: Private Mount Fuji tour\nDay 3: Cultural master classes\nDay 4: Exclusive experiences\nDay 5: Departure', 'images/Mount-Fuji.jpg', TRUE, TRUE, '2024-03-01 00:00:00', '2024-11-30 23:59:59'),

('Mount Fuji Luxury Package C', 'Ultimate Fuji luxury with private helicopter tours, exclusive cultural experiences, luxury accommodations.', 15, 4599.99, 'USD', 6, 5, 6, 2, 'LUXURY', 'Luxury resort suite, All meals and sake, Private helicopter tours, Cultural master classes, Exclusive temple access, Personal tea master, Luxury amenities', 'International flights, Personal purchases, Tips, Travel insurance', 'Day 1: VIP arrival, private cultural welcome\nDay 2: Helicopter Mount Fuji tour\nDay 3: Exclusive temple experiences\nDay 4: Private cultural master classes\nDay 5: Personalized Japanese experiences\nDay 6: VIP departure', 'images/Mount-Fuji.jpg', TRUE, TRUE, '2024-03-01 00:00:00', '2024-11-30 23:59:59'),

('Kilimanjaro Base Camp Package A', 'Standard Kilimanjaro trekking experience with group climbing, basic camping, and professional guide support.', 16, 2399.99, 'USD', 7, 6, 12, 2, 'STANDARD', 'Camping accommodation, All meals during trek, Professional guide, Porter service, Climbing equipment, Park fees, Medical support', 'International flights, Accommodation before/after trek, Personal equipment, Tips', 'Day 1: Arrival, trek preparation\nDay 2-6: Kilimanjaro climb\nDay 7: Summit attempt, descent', 'images/MountKilimanjaro.webp', FALSE, TRUE, '2024-06-01 00:00:00', '2024-10-31 23:59:59'),

('Kilimanjaro Premium Package B', 'Enhanced climbing experience with luxury pre/post accommodations, premium equipment, and extended acclimatization.', 16, 3899.99, 'USD', 9, 8, 8, 2, 'PREMIUM', 'Luxury lodge accommodation, All meals, Premium equipment, Extended acclimatization, Private guide, Medical support, Spa treatments', 'International flights, Personal expenses, Travel insurance, Gratuities', 'Day 1: Arrival, luxury preparation\nDay 2: Extended acclimatization\nDay 3-7: Premium climb experience\nDay 8: Summit attempt\nDay 9: Celebration, departure', 'images/MountKilimanjaro.webp', TRUE, TRUE, '2024-06-01 00:00:00', '2024-10-31 23:59:59'),

('Kilimanjaro Luxury Package C', 'Ultimate climbing luxury with private expedition, helicopter support, luxury accommodations.', 16, 6299.99, 'USD', 10, 9, 4, 2, 'LUXURY', 'Luxury safari lodge, All meals and beverages, Private expedition team, Helicopter support, Premium equipment, Medical team, Celebration dinner', 'International flights, Personal gear, Tips, Travel insurance', 'Day 1: VIP arrival, luxury preparation\nDay 2: Private acclimatization\nDay 3-8: Luxury expedition climb\nDay 9: VIP summit experience\nDay 10: Celebration, VIP departure', 'images/MountKilimanjaro.webp', TRUE, TRUE, '2024-06-01 00:00:00', '2024-10-31 23:59:59'),

('Northern Lights Basic Package A', 'Standard Aurora experience with group tours, basic accommodations, and northern lights hunting activities.', 17, 1599.99, 'USD', 4, 3, 16, 2, 'STANDARD', 'Hotel accommodation, Daily breakfast, Aurora hunting tours, City tours, Warm clothing rental, Professional guide', 'International flights, Lunch and dinner, Personal expenses, Additional activities', 'Day 1: Arrival, city orientation\nDay 2: Aurora hunting, cultural tour\nDay 3: Dog sledding, evening aurora\nDay 4: Departure', 'images/Norway.jpg', FALSE, TRUE, '2024-10-01 00:00:00', '2025-03-31 23:59:59'),

('Northern Lights Premium Package B', 'Enhanced Aurora experience with luxury accommodations, exclusive viewing locations, and cultural immersion activities.', 17, 2999.99, 'USD', 5, 4, 10, 2, 'PREMIUM', 'Luxury hotel, All meals, Exclusive aurora locations, Dog sledding, Reindeer encounters, Ice hotel stay, Photography guidance', 'International flights, Personal expenses, Travel insurance, Shopping', 'Day 1: Arrival, luxury welcome\nDay 2: Exclusive aurora hunting\nDay 3: Cultural experiences, ice hotel\nDay 4: Reindeer farm, aurora photography\nDay 5: Departure', 'images/Norway.jpg', TRUE, TRUE, '2024-10-01 00:00:00', '2025-03-31 23:59:59'),

('Northern Lights Luxury Package C', 'Ultimate Aurora luxury with private helicopter tours, exclusive lodges, and personalized Arctic experiences.', 17, 4899.99, 'USD', 6, 5, 6, 2, 'LUXURY', 'Luxury Arctic lodge, All meals and beverages, Private helicopter tours, Exclusive aurora locations, Personal guide, Luxury amenities, Arctic spa', 'International flights, Personal purchases, Tips, Travel insurance', 'Day 1: VIP arrival, luxury Arctic welcome\nDay 2: Private helicopter aurora tour\nDay 3: Exclusive Arctic experiences\nDay 4: Personalized cultural activities\nDay 5: Luxury relaxation, spa\nDay 6: VIP departure', 'images/Norway.jpg', TRUE, TRUE, '2024-10-01 00:00:00', '2025-03-31 23:59:59'),

('Pyramids of Giza Explorer Package A', 'Standard pyramid experience with guided tours, museum visits, and comfortable Cairo accommodations.', 18, 1299.99, 'USD', 4, 3, 18, 2, 'STANDARD', 'Hotel accommodation, Daily breakfast, Pyramid entry fees, Museum tickets, Professional guide, Transportation, Sphinx visit', 'International flights, Lunch and dinner, Personal expenses, Camel rides', 'Day 1: Arrival, Giza complex tour\nDay 2: Egyptian Museum, Khan el-Khalili\nDay 3: Saqqara pyramids, Memphis\nDay 4: Departure', 'images/Pyramids-of-Giza.jpg', FALSE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Pyramids of Giza Premium Package B', 'Enhanced Egyptian experience with luxury accommodations, private guide, and exclusive pyramid access.', 18, 2599.99, 'USD', 5, 4, 12, 2, 'PREMIUM', 'Luxury hotel, All meals, Private Egyptologist guide, Exclusive pyramid access, Nile dinner cruise, Sound and light show, Camel ride experience', 'International flights, Personal expenses, Travel insurance, Shopping', 'Day 1: Arrival, luxury welcome\nDay 2: Private pyramid tour, camel experience\nDay 3: Exclusive museum tour, Nile cruise\nDay 4: Cultural workshops, sound and light\nDay 5: Departure', 'images/Pyramids-of-Giza.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Pyramids of Giza Luxury Package C', 'Ultimate Egyptian luxury with private archaeological tours, helicopter access, and exclusive cultural experiences.', 18, 4199.99, 'USD', 6, 5, 6, 2, 'LUXURY', 'Luxury resort, All meals and beverages, Private helicopter tours, Personal Egyptologist, Exclusive site access, Cultural master classes, Luxury Nile cruise', 'International flights, Personal purchases, Tips, Travel insurance', 'Day 1: VIP arrival, private orientation\nDay 2: Helicopter pyramid tour\nDay 3: Exclusive archaeological experiences\nDay 4: Private Nile luxury cruise\nDay 5: Cultural master classes\nDay 6: VIP departure', 'images/Pyramids-of-Giza.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Eternal Rome Discovery Package A', 'Standard Roman experience with major historical sites, guided walking tours, and comfortable city accommodations.', 19, 1199.99, 'USD', 4, 3, 16, 2, 'STANDARD', 'Hotel accommodation, Daily breakfast, Major site entries, Walking tours, Professional guide, Public transport passes', 'International flights, Lunch and dinner, Personal expenses, Vatican tours', 'Day 1: Arrival, ancient Rome tour\nDay 2: Vatican City, St. Peter\'s\nDay 3: Trastevere, local experiences\nDay 4: Departure', 'images/Rome.jpg', FALSE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Eternal Rome Premium Package B', 'Enhanced Roman experience with luxury accommodations, skip-the-line access, and exclusive cultural experiences.', 19, 2399.99, 'USD', 5, 4, 10, 2, 'PREMIUM', 'Luxury hotel, All meals, Skip-the-line tickets, Private Vatican tour, Cooking classes, Wine tastings, Cultural performances', 'International flights, Personal expenses, Travel insurance, Shopping', 'Day 1: Arrival, luxury welcome\nDay 2: Private Vatican experience\nDay 3: Exclusive Roman sites, cooking class\nDay 4: Cultural immersion, wine tasting\nDay 5: Departure', 'images/Rome.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Eternal Rome Luxury Package C', 'Ultimate Roman luxury with private archaeological guides, exclusive access, and personalized cultural journey.', 19, 3999.99, 'USD', 6, 5, 6, 2, 'LUXURY', 'Luxury palazzo suite, All meals and wines, Private archaeological guide, Exclusive site access, Cultural master classes, Personal shopping guide, Luxury transfers', 'International flights, Personal purchases, Tips, Travel insurance', 'Day 1: VIP arrival, private palazzo welcome\nDay 2: Exclusive Vatican private tour\nDay 3: Private archaeological experiences\nDay 4: Cultural master classes\nDay 5: Personalized shopping, dining\nDay 6: VIP departure', 'images/Rome.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Sagrada Família Barcelona Package A', 'Standard Barcelona experience with Gaudí architecture tours, cultural visits, and comfortable city accommodations.', 20, 1099.99, 'USD', 3, 2, 16, 2, 'STANDARD', 'Hotel accommodation, Daily breakfast, Sagrada Família tickets, Gaudí tour, City walking tours, Metro passes, Professional guide', 'International flights, Lunch and dinner, Personal expenses, Additional attractions', 'Day 1: Arrival, Sagrada Família tour\nDay 2: Park Güell, Gothic Quarter\nDay 3: Cultural experiences, departure', 'images/SagradaFamília.jpg', FALSE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Sagrada Família Barcelona Premium Package B', 'Enhanced Barcelona experience with luxury accommodations, exclusive access, and comprehensive Gaudí exploration.', 20, 2099.99, 'USD', 4, 3, 10, 2, 'PREMIUM', 'Luxury hotel, All meals, Exclusive Sagrada Família access, Private Gaudí tour, Flamenco show, Tapas tours, Cultural workshops', 'International flights, Personal expenses, Travel insurance, Shopping', 'Day 1: Arrival, luxury welcome\nDay 2: Private Sagrada Família experience\nDay 3: Exclusive Gaudí sites, flamenco\nDay 4: Cultural workshops, departure', 'images/SagradaFamília.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Sagrada Família Barcelona Luxury Package C', 'Ultimate Barcelona luxury with private architectural tours, exclusive experiences, and personalized cultural journey.', 20, 3599.99, 'USD', 5, 4, 6, 2, 'LUXURY', 'Luxury hotel suite, All meals and cava, Private architectural guide, Exclusive access tours, Cultural master classes, Personal shopping, Luxury experiences', 'International flights, Personal purchases, Tips, Travel insurance', 'Day 1: VIP arrival, private architectural welcome\nDay 2: Exclusive Sagrada Família experience\nDay 3: Private Gaudí masterpiece tour\nDay 4: Cultural master classes, luxury dining\nDay 5: VIP departure', 'images/SagradaFamília.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Seiser Alm Alpine Package A', 'Standard Alpine experience with hiking tours, mountain activities, and comfortable mountain accommodations.', 21, 1199.99, 'USD', 4, 3, 14, 2, 'STANDARD', 'Mountain hotel, Daily breakfast, Cable car passes, Hiking guides, Alpine activities, Local transportation', 'International flights, Lunch and dinner, Personal expenses, Equipment rental', 'Day 1: Arrival, Alpine orientation\nDay 2: Seiser Alm exploration\nDay 3: Mountain hiking, cultural sites\nDay 4: Departure', 'images/SeiserAlm.jpg', FALSE, TRUE, '2024-05-01 00:00:00', '2024-10-31 23:59:59'),

('Seiser Alm Alpine Premium Package B', 'Enhanced Alpine experience with luxury mountain resort, exclusive activities, and cultural immersion.', 21, 2299.99, 'USD', 5, 4, 10, 2, 'PREMIUM', 'Luxury mountain resort, All meals, Exclusive alpine tours, Cultural experiences, Spa treatments, Professional guide, Premium activities', 'International flights, Personal expenses, Travel insurance, Equipment', 'Day 1: Arrival, luxury alpine welcome\nDay 2: Exclusive Seiser Alm tour\nDay 3: Cultural immersion, spa\nDay 4: Premium mountain activities\nDay 5: Departure', 'images/SeiserAlm.jpg', TRUE, TRUE, '2024-05-01 00:00:00', '2024-10-31 23:59:59'),

('Seiser Alm Alpine Luxury Package C', 'Ultimate Alpine luxury with private mountain experiences, helicopter tours, and personalized Dolomites discovery.', 21, 3799.99, 'USD', 6, 5, 6, 2, 'LUXURY', 'Luxury mountain lodge, All meals and beverages, Private helicopter tours, Personal mountain guide, Exclusive experiences, Luxury amenities, Spa treatments', 'International flights, Personal purchases, Tips, Travel insurance', 'Day 1: VIP arrival, luxury mountain welcome\nDay 2: Private helicopter Alpine tour\nDay 3: Exclusive mountain experiences\nDay 4: Personalized alpine activities\nDay 5: Luxury relaxation, spa\nDay 6: VIP departure', 'images/SeiserAlm.jpg', TRUE, TRUE, '2024-05-01 00:00:00', '2024-10-31 23:59:59'),

('Statue of Liberty Heritage Package A', 'Standard Liberty experience with ferry rides, island tours, and museum visits with comfortable NYC accommodations.', 22, 899.99, 'USD', 3, 2, 20, 1, 'STANDARD', 'Hotel accommodation, Daily breakfast, Ferry tickets, Museum entries, Audio guides, NYC transport passes', 'International flights, Lunch and dinner, Personal expenses, Crown access', 'Day 1: Arrival, Statue of Liberty tour\nDay 2: Ellis Island, Brooklyn Bridge\nDay 3: NYC exploration, departure', 'images/StatueofLiberty.jpg', FALSE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Statue of Liberty Heritage Premium Package B', 'Enhanced Liberty experience with crown access, private tours, and comprehensive immigration history exploration.', 22, 1699.99, 'USD', 4, 3, 12, 2, 'PREMIUM', 'Luxury hotel, All meals, Crown access tickets, Private guide, Immigration museum, Cultural experiences, Premium ferry service', 'International flights, Personal expenses, Travel insurance, Shopping', 'Day 1: Arrival, premium welcome\nDay 2: Private Liberty Island tour, crown visit\nDay 3: Ellis Island comprehensive tour\nDay 4: NYC cultural experiences, departure', 'images/StatueofLiberty.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Statue of Liberty Heritage Luxury Package C', 'Ultimate Liberty luxury with private yacht access, exclusive experiences, and personalized American history journey.', 22, 2999.99, 'USD', 5, 4, 6, 2, 'LUXURY', 'Luxury hotel suite, All meals and beverages, Private yacht charter, Exclusive island access, Personal historian guide, Cultural master classes, VIP experiences', 'International flights, Personal purchases, Tips, Travel insurance', 'Day 1: VIP arrival, private yacht welcome\nDay 2: Exclusive Liberty Island experience\nDay 3: Private Ellis Island tour, historian guide\nDay 4: Cultural master classes, VIP NYC\nDay 5: VIP departure', 'images/StatueofLiberty.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Sydney Opera House Experience Package A', 'Standard Sydney experience with Opera House tours, harbor activities, and comfortable city accommodations.', 23, 1399.99, 'USD', 4, 3, 16, 2, 'STANDARD', 'Hotel accommodation, Daily breakfast, Opera House tour, Harbor cruise, City attractions, Public transport passes, Professional guide', 'International flights, Lunch and dinner, Personal expenses, Show tickets', 'Day 1: Arrival, harbor orientation\nDay 2: Opera House tour, harbor cruise\nDay 3: Blue Mountains day trip\nDay 4: Departure', 'images/Sydney-Opera-House.jpg', FALSE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Sydney Opera House Premium Package B', 'Enhanced Sydney experience with performance tickets, luxury accommodations, and exclusive cultural experiences.', 23, 2599.99, 'USD', 5, 4, 10, 2, 'PREMIUM', 'Luxury hotel, All meals, Opera performance tickets, Private harbor cruise, Exclusive tours, Wine region trip, Cultural workshops', 'International flights, Personal expenses, Travel insurance, Additional shows', 'Day 1: Arrival, luxury welcome\nDay 2: Private Opera House experience\nDay 3: Exclusive harbor activities, performance\nDay 4: Wine region exploration\nDay 5: Departure', 'images/Sydney-Opera-House.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Sydney Opera House Luxury Package C', 'Ultimate Sydney luxury with private performances, yacht charter, and personalized Australian cultural journey.', 23, 4299.99, 'USD', 6, 5, 6, 2, 'LUXURY', 'Luxury harbor suite, All meals and beverages, Private performance access, Yacht charter, Personal cultural guide, Exclusive experiences, VIP services', 'International flights, Personal purchases, Tips, Travel insurance', 'Day 1: VIP arrival, luxury harbor welcome\nDay 2: Private Opera House performance\nDay 3: Exclusive yacht harbor tour\nDay 4: Personal cultural experiences\nDay 5: Luxury relaxation, VIP activities\nDay 6: VIP departure', 'images/Sydney-Opera-House.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Taj Mahal Heritage Classic Package A', 'Standard Taj Mahal experience with guided tours, cultural visits, and comfortable Agra accommodations.', 24, 999.99, 'USD', 3, 2, 18, 2, 'STANDARD', 'Hotel accommodation, Daily breakfast, Taj Mahal entry, Agra Fort visit, Professional guide, Transportation', 'International flights, Lunch and dinner, Personal expenses, Delhi accommodation', 'Day 1: Arrival Agra, Taj Mahal sunset\nDay 2: Taj Mahal sunrise, Agra Fort\nDay 3: Local markets, departure', 'images/Taj-Mahal.jpg', FALSE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Taj Mahal Heritage Premium Package B', 'Enhanced Taj Mahal experience with luxury accommodations, exclusive access, and cultural immersion.', 24, 1999.99, 'USD', 4, 3, 12, 2, 'PREMIUM', 'Luxury hotel, All meals, Exclusive Taj access, Private guide, Cultural performances, Cooking classes, Spa treatments', 'International flights, Personal expenses, Travel insurance, Shopping', 'Day 1: Arrival, luxury welcome\nDay 2: Private Taj Mahal experience\nDay 3: Cultural workshops, performances\nDay 4: Local experiences, departure', 'images/Taj-Mahal.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Taj Mahal Heritage Luxury Package C', 'Ultimate Taj Mahal luxury with private palace stays, helicopter tours, and personalized Mughal heritage journey.', 24, 3599.99, 'USD', 5, 4, 6, 2, 'LUXURY', 'Palace hotel suite, All meals and beverages, Private helicopter tours, Exclusive Taj access, Personal historian, Cultural master classes, Royal experiences', 'International flights, Personal purchases, Tips, Travel insurance', 'Day 1: VIP arrival, palace welcome\nDay 2: Private helicopter Taj tour\nDay 3: Exclusive Mughal heritage tour\nDay 4: Royal cultural experiences\nDay 5: VIP departure', 'images/Taj-Mahal.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Great Wall Adventure Package A', 'Standard Great Wall experience with hiking tours, cultural visits, and comfortable Beijing accommodations.', 25, 1299.99, 'USD', 4, 3, 16, 2, 'STANDARD', 'Hotel accommodation, Daily breakfast, Great Wall entry, Cultural sites, Professional guide, Transportation, Museum visits', 'International flights, Lunch and dinner, Personal expenses, Cable car', 'Day 1: Arrival Beijing, orientation\nDay 2: Mutianyu Great Wall hiking\nDay 3: Forbidden City, Temple of Heaven\nDay 4: Departure', 'images/The-Great-Wall.jpg', FALSE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Great Wall Premium Package B', 'Enhanced Great Wall experience with luxury accommodations, exclusive sections, and comprehensive cultural immersion.', 25, 2399.99, 'USD', 5, 4, 10, 2, 'PREMIUM', 'Luxury hotel, All meals, Exclusive Wall sections, Private guide, Cultural workshops, Acrobatic shows, Hutong experiences', 'International flights, Personal expenses, Travel insurance, Shopping', 'Day 1: Arrival, luxury welcome\nDay 2: Private Great Wall exclusive tour\nDay 3: Cultural immersion, workshops\nDay 4: Beijing cultural experiences\nDay 5: Departure', 'images/The-Great-Wall.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Great Wall Luxury Package C', 'Ultimate Great Wall luxury with private helicopter access, exclusive accommodations, and personalized historical journey.', 25, 3899.99, 'USD', 6, 5, 6, 2, 'LUXURY', 'Luxury hotel suite, All meals and beverages, Private helicopter tours, Exclusive Wall access, Personal historian, Cultural master classes, VIP experiences', 'International flights, Personal purchases, Tips, Travel insurance', 'Day 1: VIP arrival, private historical welcome\nDay 2: Helicopter Great Wall tour\nDay 3: Exclusive Wall sections, historian guide\nDay 4: Cultural master classes, VIP Beijing\nDay 5: Personalized experiences\nDay 6: VIP departure', 'images/The-Great-Wall.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Uluru Sacred Experience Package A', 'Standard Uluru experience with cultural tours, sunrise/sunset viewing, and comfortable resort accommodations.', 26, 1599.99, 'USD', 3, 2, 16, 2, 'STANDARD', 'Resort accommodation, Daily breakfast, Uluru base walks, Cultural center, Sunrise/sunset viewing, Aboriginal guide', 'International flights, Lunch and dinner, Personal expenses, Helicopter tours', 'Day 1: Arrival, Uluru orientation\nDay 2: Base walk, cultural center\nDay 3: Sunrise viewing, departure', 'images/Uluru.jpg', FALSE, TRUE, '2024-04-01 00:00:00', '2024-09-30 23:59:59'),

('Uluru Sacred Premium Package B', 'Enhanced Uluru experience with luxury accommodations, exclusive cultural activities, and helicopter tours.', 26, 2899.99, 'USD', 4, 3, 10, 2, 'PREMIUM', 'Luxury resort, All meals, Helicopter tours, Exclusive cultural experiences, Camel tours, Star gazing, Aboriginal art workshops', 'International flights, Personal expenses, Travel insurance, Shopping', 'Day 1: Arrival, luxury welcome\nDay 2: Helicopter Uluru tour, cultural immersion\nDay 3: Exclusive experiences, star gazing\nDay 4: Departure', 'images/Uluru.jpg', TRUE, TRUE, '2024-04-01 00:00:00', '2024-09-30 23:59:59'),

('Uluru Sacred Luxury Package C', 'Ultimate Uluru luxury with private helicopter charter, exclusive access, and personalized Aboriginal cultural journey.', 26, 4199.99, 'USD', 5, 4, 6, 2, 'LUXURY', 'Luxury desert lodge, All meals and beverages, Private helicopter charter, Exclusive Aboriginal experiences, Personal cultural guide, Luxury amenities, VIP access', 'International flights, Personal purchases, Tips, Travel insurance', 'Day 1: VIP arrival, luxury desert welcome\nDay 2: Private helicopter exploration\nDay 3: Exclusive Aboriginal cultural experiences\nDay 4: Personalized desert activities\nDay 5: VIP departure', 'images/Uluru.jpg', TRUE, TRUE, '2024-04-01 00:00:00', '2024-09-30 23:59:59'),

('Underwater World Explorer Package A', 'Standard underwater experience with snorkeling tours, marine life encounters, and comfortable dive resort accommodations.', 27, 1999.99, 'USD', 6, 5, 14, 2, 'STANDARD', 'Dive resort accommodation, Daily breakfast, Snorkeling tours, Equipment rental, Marine guide, Boat transfers, Underwater photography session', 'International flights, Lunch and dinner, Personal expenses, Diving certification', 'Day 1: Arrival, underwater orientation\nDay 2-4: Multi-location snorkeling\nDay 5: Marine life encounters\nDay 6: Departure', 'images/UnderTheSea.jpg', FALSE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Underwater World Premium Package B', 'Enhanced underwater experience with certified diving, luxury accommodations, and exclusive marine locations.', 27, 3599.99, 'USD', 8, 7, 10, 2, 'PREMIUM', 'Luxury dive resort, All meals, Certified diving tours, Exclusive dive sites, Marine biologist guide, Professional equipment, Underwater photography', 'International flights, Personal expenses, Travel insurance, Certification courses', 'Day 1: Arrival, diving preparation\nDay 2-6: Multi-destination diving\nDay 7: Marine research participation\nDay 8: Departure', 'images/UnderTheSea.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Underwater World Luxury Package C', 'Ultimate underwater luxury with private yacht expedition, helicopter access, and personalized marine discoveries.', 27, 6299.99, 'USD', 10, 9, 6, 2, 'LUXURY', 'Luxury yacht accommodation, All meals and beverages, Private yacht expedition, Helicopter transfers, Personal marine biologist, Professional equipment, Luxury amenities', 'International flights, Personal purchases, Tips, Travel insurance', 'Day 1: VIP arrival, private yacht welcome\nDay 2-8: Luxury yacht diving expedition\nDay 9: Exclusive marine experiences\nDay 10: VIP departure', 'images/UnderTheSea.jpg', TRUE, TRUE, '2024-01-01 00:00:00', '2024-12-31 23:59:59'),

('Victoria Falls Safari Package A', 'Standard Victoria Falls experience with waterfall tours, wildlife activities, and comfortable lodge accommodations.', 28, 1499.99, 'USD', 4, 3, 16, 2, 'STANDARD', 'Lodge accommodation, Daily breakfast, Waterfall tours, Wildlife safari, Sunset cruise, Local transportation, Professional guide', 'International flights, Lunch and dinner, Personal expenses, Helicopter flights', 'Day 1: Arrival, waterfall orientation\nDay 2: Full waterfall tour, sunset cruise\nDay 3: Wildlife safari, local culture\nDay 4: Departure', 'images/victoria_falls_sunset.jpg', FALSE, TRUE, '2024-04-01 00:00:00', '2024-10-31 23:59:59'),

('Victoria Falls Premium Package B', 'Enhanced Victoria Falls experience with luxury lodge, helicopter tours, and exclusive adventure activities.', 28, 2699.99, 'USD', 5, 4, 10, 2, 'PREMIUM', 'Luxury lodge, All meals, Helicopter tours, White water rafting, Exclusive sunset cruise, Wildlife experiences, Adventure activities', 'International flights, Personal expenses, Travel insurance, Additional activities', 'Day 1: Arrival, luxury welcome\nDay 2: Helicopter waterfall tour\nDay 3: Adventure activities, rafting\nDay 4: Exclusive wildlife experiences\nDay 5: Departure', 'images/victoria_falls_sunset.jpg', TRUE, TRUE, '2024-04-01 00:00:00', '2024-10-31 23:59:59'),

('Victoria Falls Luxury Package C', 'Ultimate Victoria Falls luxury with private helicopter charter, exclusive lodge, and personalized African adventure.', 28, 4499.99, 'USD', 6, 5, 6, 2, 'LUXURY', 'Luxury safari lodge, All meals and beverages, Private helicopter charter, Exclusive experiences, Personal ranger, Luxury amenities, VIP adventures', 'International flights, Personal purchases, Tips, Travel insurance', 'Day 1: VIP arrival, luxury safari welcome\nDay 2: Private helicopter exploration\nDay 3: Exclusive adventure experiences\nDay 4: Personalized wildlife encounters\nDay 5: Luxury relaxation, spa\nDay 6: VIP departure', 'images/victoria_falls_sunset.jpg', TRUE, TRUE, '2024-04-01 00:00:00', '2024-10-31 23:59:59'),

('Xinjiang Cultural Discovery Package A', 'Standard Xinjiang experience with cultural performances, historical sites, and comfortable local accommodations.', 29, 1199.99, 'USD', 6, 5, 16, 2, 'STANDARD', 'Local hotel accommodation, Daily breakfast, Cultural performances, Historical site visits, Local transportation, Professional guide', 'International flights, Lunch and dinner, Personal expenses, Shopping', 'Day 1: Arrival, cultural orientation\nDay 2-3: Silk Road historical sites\nDay 4-5: Cultural performances, local experiences\nDay 6: Departure', 'images/XinjiangDance.png', FALSE, TRUE, '2024-05-01 00:00:00', '2024-10-31 23:59:59'),

('Xinjiang Cultural Premium Package B', 'Enhanced Xinjiang experience with luxury accommodations, exclusive cultural access, and comprehensive Silk Road exploration.', 29, 2199.99, 'USD', 7, 6, 10, 2, 'PREMIUM', 'Luxury hotel, All meals, Exclusive cultural performances, Private guide, Silk Road tours, Cultural workshops, Traditional experiences', 'International flights, Personal expenses, Travel insurance, Handicrafts', 'Day 1: Arrival, luxury welcome\nDay 2-4: Comprehensive Silk Road tour\nDay 5-6: Cultural immersion, workshops\nDay 7: Departure', 'images/XinjiangDance.png', TRUE, TRUE, '2024-05-01 00:00:00', '2024-10-31 23:59:59'),

('Xinjiang Cultural Luxury Package C', 'Ultimate Xinjiang luxury with private cultural experiences, helicopter tours, and personalized Silk Road journey.', 29, 3599.99, 'USD', 8, 7, 6, 2, 'LUXURY', 'Luxury resort, All meals and beverages, Private cultural experiences, Helicopter tours, Personal cultural guide, Exclusive access, Master classes', 'International flights, Personal purchases, Tips, Travel insurance', 'Day 1: VIP arrival, private cultural welcome\nDay 2-3: Helicopter Silk Road exploration\nDay 4-6: Exclusive cultural experiences\nDay 7: Cultural master classes\nDay 8: VIP departure', 'images/XinjiangDance.png', TRUE, TRUE, '2024-05-01 00:00:00', '2024-10-31 23:59:59');

INSERT INTO bookings (booking_number, user_id, package_id, departure_date, return_date, number_of_participants, total_price, status, payment_status, customer_name, customer_email, customer_phone) VALUES
('BK2025001', 2, 2, '2025-08-15', '2025-08-19', 2, 4399.98, 'CONFIRMED', 'PAID', 'John Doe', 'john@example.com', '+1-555-0123'),
('BK2025002', 3, 5, '2025-09-10', '2025-09-14', 2, 3399.98, 'PENDING', 'PENDING', 'Mary Smith', 'mary@example.com', '+1-555-0124'),
('BK2025003', 4, 8, '2025-07-20', '2025-07-24', 4, 7599.96, 'CONFIRMED', 'PAID', 'David Wilson', 'david@example.com', '+1-555-0125'),
('BK2025004', 5, 11, '2025-06-05', '2025-06-09', 2, 3199.98, 'COMPLETED', 'PAID', 'Sarah Jones', 'sarah@example.com', '+1-555-0126'),
('BK2025005', 2, 14, '2025-12-12', '2025-12-17', 2, 4399.98, 'CONFIRMED', 'PAID', 'John Doe', 'john@example.com', '+1-555-0123'),
('BK2025006', 3, 17, '2025-05-22', '2025-05-26', 3, 8999.97, 'PENDING', 'PENDING', 'Mary Smith', 'mary@example.com', '+1-555-0124'),
('BK2025007', 4, 20, '2025-04-15', '2025-04-19', 2, 6299.98, 'CONFIRMED', 'PAID', 'David Wilson', 'david@example.com', '+1-555-0125'),
('BK2025008', 5, 23, '2025-03-08', '2025-03-12', 2, 5199.98, 'COMPLETED', 'PAID', 'Sarah Jones', 'sarah@example.com', '+1-555-0126'),
('BK2025009', 2, 26, '2025-07-01', '2025-07-08', 2, 7799.98, 'CONFIRMED', 'PAID', 'John Doe', 'john@example.com', '+1-555-0123'),
('BK2025010', 3, 29, '2025-06-15', '2025-06-22', 2, 4399.98, 'PENDING', 'PENDING', 'Mary Smith', 'mary@example.com', '+1-555-0124');

INSERT INTO contact_messages (name, email, phone, subject, message, status) VALUES
('Alice Johnson', 'alice.johnson@email.com', '+1-555-0127', 'Christ the Redeemer tour inquiry', 'Hi, I would like to know more about the premium package for Christ the Redeemer. What are the best months to visit and is the helicopter tour weather dependent?', 'NEW'),
('Robert Chen', 'robert.chen@email.com', '+1-555-0128', 'Group booking discount for CN Tower', 'Hello, we are a group of 15 people interested in the CN Tower Premium Package. Do you offer any group discounts for bookings of this size?', 'READ'),
('Lisa Anderson', 'lisa.anderson@email.com', '+1-555-0129', 'Custom Indonesia package request', 'I\'m interested in a custom package combining Indonesia islands with Great Barrier Reef. Can you provide more details about diving requirements and weather conditions?', 'NEW'),
('Mike Brown', 'mike.brown@email.com', '+1-555-0130', 'Northern Lights photography tour', 'We are photographers interested in the Northern Lights Luxury Package. What camera equipment is provided and what are the success rates for aurora viewing?', 'READ'),
('Emma Davis', 'emma.davis@email.com', '+1-555-0131', 'Booking modification request', 'I need to change my departure date for booking BK2025001 from August 15 to August 22. Is this possible and are there any fees involved?', 'REPLIED'),
('James Wilson', 'james.wilson@email.com', '+1-555-0132', 'Kilimanjaro expedition preparation', 'What level of fitness is required for the Kilimanjaro Premium Package? Do you provide training recommendations and equipment lists?', 'NEW'),
('Sophie Martinez', 'sophie.martinez@email.com', '+1-555-0133', 'Luxury package availability', 'Are there any luxury packages available for Machu Picchu in September? We are celebrating our 25th anniversary and want something special.', 'READ'),
('Daniel Kim', 'daniel.kim@email.com', '+1-555-0134', 'Travel insurance options', 'What travel insurance options do you recommend for the Great Barrier Reef diving packages? We want comprehensive coverage for diving activities.', 'NEW'),
('Maria Garcia', 'maria.garcia@email.com', '+1-555-0135', 'Family-friendly destinations', 'Which destinations and packages would be most suitable for a family with two children aged 8 and 12? We prefer easier difficulty levels.', 'NEW'),
('Thomas Lee', 'thomas.lee@email.com', '+1-555-0136', 'Xinjiang cultural tour details', 'Can you provide more information about the cultural performances included in the Xinjiang packages? Are there specific festivals or events we should time our visit around?', 'READ');

CREATE INDEX idx_destinations_featured_active ON destinations(featured, active);
CREATE INDEX idx_packages_featured_active ON packages(featured, active);
CREATE INDEX idx_packages_destination_active ON packages(destination_id, active);
CREATE INDEX idx_bookings_user_status ON bookings(user_id, status);
CREATE INDEX idx_bookings_departure_date ON bookings(departure_date);
CREATE INDEX idx_contact_status_created ON contact_messages(status, created_at);

SELECT 'Database initialization completed successfully' as status;

SELECT 'Users' as table_name, COUNT(*) as record_count FROM users
UNION ALL
SELECT 'Destinations', COUNT(*) FROM destinations
UNION ALL
SELECT 'Packages', COUNT(*) FROM packages
UNION ALL
SELECT 'Bookings', COUNT(*) FROM bookings
UNION ALL
SELECT 'Contact Messages', COUNT(*) FROM contact_messages;

SELECT 'Featured destinations with packages available:' as info;
SELECT d.name as destination, d.country, d.category, d.base_price, 
       COUNT(p.id) as total_packages,
       COUNT(CASE WHEN p.package_type = 'STANDARD' THEN 1 END) as standard_packages,
       COUNT(CASE WHEN p.package_type = 'PREMIUM' THEN 1 END) as premium_packages,
       COUNT(CASE WHEN p.package_type = 'LUXURY' THEN 1 END) as luxury_packages
FROM destinations d 
LEFT JOIN packages p ON d.id = p.destination_id AND p.active = TRUE
WHERE d.featured = TRUE AND d.active = TRUE
GROUP BY d.id, d.name, d.country, d.category, d.base_price
ORDER BY d.name;

SELECT 'Package distribution by destination:' as info;
SELECT d.name as destination, 
       COUNT(CASE WHEN p.package_type = 'STANDARD' THEN 1 END) as package_a_count,
       COUNT(CASE WHEN p.package_type = 'PREMIUM' THEN 1 END) as package_b_count,
       COUNT(CASE WHEN p.package_type = 'LUXURY' THEN 1 END) as package_c_count,
       COUNT(p.id) as total_packages
FROM destinations d 
LEFT JOIN packages p ON d.id = p.destination_id AND p.active = TRUE
WHERE d.active = TRUE
GROUP BY d.id, d.name
ORDER BY d.name;

SELECT 'Image path verification:' as info;
SELECT name, image_path, 
       CASE 
           WHEN image_path LIKE 'images/%' THEN 'Valid Path'
           ELSE 'Invalid Path'
       END as path_status
FROM destinations 
WHERE active = TRUE
ORDER BY name;

SELECT 'Booking status summary:' as info;
SELECT status, payment_status, COUNT(*) as count
FROM bookings
GROUP BY status, payment_status
ORDER BY status, payment_status;

SELECT 'Contact message status:' as info;
SELECT status, COUNT(*) as count
FROM contact_messages
GROUP BY status
ORDER BY status;

SELECT 'Price range analysis:' as info;
SELECT 
    CASE 
        WHEN base_price < 1000 THEN 'Budget (< $1000)'
        WHEN base_price BETWEEN 1000 AND 2000 THEN 'Mid-range ($1000-$2000)'
        WHEN base_price > 2000 THEN 'Luxury (> $2000)'
    END as price_category,
    COUNT(*) as destination_count,
    AVG(base_price) as avg_price
FROM destinations 
WHERE active = TRUE
GROUP BY 
    CASE 
        WHEN base_price < 1000 THEN 'Budget (< $1000)'
        WHEN base_price BETWEEN 1000 AND 2000 THEN 'Mid-range ($1000-$2000)'
        WHEN base_price > 2000 THEN 'Luxury (> $2000)'
    END
ORDER BY avg_price;

SELECT 'Database integrity check:' as info;
SELECT 'All destinations have packages' as check_name,
       CASE 
           WHEN COUNT(*) = 0 THEN 'PASS'
           ELSE CONCAT('FAIL - ', COUNT(*), ' destinations without packages')
       END as result
FROM destinations d
LEFT JOIN packages p ON d.id = p.destination_id AND p.active = TRUE
WHERE d.active = TRUE AND p.id IS NULL

UNION ALL

SELECT 'All packages have valid destinations' as check_name,
       CASE 
           WHEN COUNT(*) = 0 THEN 'PASS'
           ELSE CONCAT('FAIL - ', COUNT(*), ' orphaned packages')
       END as result
FROM packages p
LEFT JOIN destinations d ON p.destination_id = d.id
WHERE p.active = TRUE AND d.id IS NULL

UNION ALL

SELECT 'All image paths are valid format' as check_name,
       CASE 
           WHEN COUNT(*) = 0 THEN 'PASS'
           ELSE CONCAT('FAIL - ', COUNT(*), ' invalid image paths')
       END as result
FROM destinations
WHERE active = TRUE AND (image_path IS NULL OR image_path NOT LIKE 'images/%');

SELECT 'Admin user verification:' as info;
SELECT username, email, role FROM users WHERE role = 'ADMIN';

COMMIT;
