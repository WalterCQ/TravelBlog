<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="Discover Amazing Destinations - MyTour" />
    <jsp:param name="currentPage" value="home" />
</jsp:include>

<jsp:include page="../includes/navigation.jsp">
    <jsp:param name="currentPage" value="home" />
</jsp:include>

<main id="main-content" class="homepage-content" role="main">

	<!-- Hero Carousel Section -->
	<section class="hero-section" aria-label="Featured Destinations">
	  <div class="w-100">
	    <div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel" data-bs-interval="5000" role="region" aria-label="Video carousel">
	      <div class="carousel-indicators">
	        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
	        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
	        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
	      </div>
	      <div class="carousel-inner">
	        <div class="carousel-item active">
	          <video class="d-block w-100" autoplay muted loop playsinline preload="metadata">
	            <source src="${pageContext.request.contextPath}/videos/Aurora.mp4" type="video/mp4">
	            <img src="${pageContext.request.contextPath}/images/Norway.jpg" class="d-block w-100" alt="Arctic Aurora Borealis" loading="eager">
	          </video>
              <div class="carousel-caption d-block">
	            <h3 data-translate="hero1-title">Arctic Aurora - Nature's Light Show</h3>
	            <p class="custom-paragraph" data-translate="hero1-desc">Witness the mesmerizing dance of Northern Lights across pristine Arctic skies in Norway's dramatic landscapes.</p>
	          </div>
	        </div>
	        <div class="carousel-item">
	          <video class="d-block w-100" autoplay muted loop playsinline preload="metadata">
	            <source src="${pageContext.request.contextPath}/videos/BelowTheClouds.mp4" type="video/mp4">
	            <img src="${pageContext.request.contextPath}/images/SeiserAlm.jpg" class="d-block w-100" alt="Alpine Paradise Above Clouds" loading="lazy">
	          </video>
              <div class="carousel-caption d-block">
	            <h3 data-translate="hero2-title">Alpine Paradise - Above the Clouds</h3>
	            <p class="custom-paragraph" data-translate="hero2-desc">Soar above cloud-covered valleys in the majestic Alps, where mountain peaks touch the sky.</p>
	          </div>
	        </div>
	        <div class="carousel-item">
	          <video class="d-block w-100" autoplay muted loop playsinline preload="metadata">
	            <source src="${pageContext.request.contextPath}/videos/FancyBeach.mp4" type="video/mp4">
	            <img src="${pageContext.request.contextPath}/images/Indonesia.jpg" class="d-block w-100" alt="Tropical Beach Paradise" loading="lazy">
	          </video>
              <div class="carousel-caption d-block">
	            <h3 data-translate="hero3-title">Tropical Paradise - Crystal Waters</h3>
	            <p class="custom-paragraph" data-translate="hero3-desc">Escape to pristine beaches with turquoise waters and powdery white sand in exotic Indonesian islands.</p>
	          </div>
	        </div>
	      </div>
          <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
	        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden" data-i18n="carousel.prev">Previous</span>
	      </button>
	      <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
	        <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden" data-i18n="carousel.next">Next</span>
	      </button>
	    </div>
	  </div>
	</section>

	<section class="travel-stories-section" aria-labelledby="travel-stories-heading">
		    <div class="container py-5">
		        <header class="text-center mb-5">
		            <h2 id="travel-stories-heading" data-translate="travel-stories-title">Explore World Attractions</h2>
		            <p class="lead" data-translate="travel-stories-subtitle">Discover the most fascinating destinations and hidden gems from around the globe</p>
		            <hr class="w-25 mx-auto">
		        </header>
		        
		        <div class="row g-4">
		            <div class="col-lg-6 mb-4">
		                <article class="card h-100 shadow-sm">
		                    <img src="https://images.unsplash.com/photo-1587139223877-04cb899fa3e8?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" 
		                         class="card-img-top" data-tilt data-tilt-scale="1.05" alt="Tropical Paradise Islands" 
		                         style="height: 250px; object-fit: cover;" loading="lazy">
		                    <div class="card-body d-flex flex-column">
		                        <div class="mb-2">
                                    <small class="text-muted"><i data-lucide="globe-2"></i> <span data-translate="location-oceania">Oceania</span></small>
		                            <span class="badge bg-primary ms-2" data-translate="tag-nature">Nature</span>
		                        </div>
		                        <h5 class="card-title" data-translate="story1-title">Tropical Paradise Islands</h5>
		                        <p class="card-text" data-translate="story1-desc">Escape to pristine coral atolls where turquoise waters meet white sandy beaches. Experience the ultimate tropical getaway in some of the world's most beautiful islands.</p>
		                        <div class="mt-auto">
		                            <a href="attractions" class="btn btn-outline-primary" data-translate="explore-more">Explore More</a>
		                        </div>
		                    </div>
		                </article>
		            </div>
		            
		            <div class="col-lg-6 mb-4">
		                <article class="card h-100 shadow-sm">
		                    <img src="https://images.unsplash.com/photo-1526392060635-9d6019884377?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" 
		                         class="card-img-top" data-tilt data-tilt-scale="1.05" alt="Majestic Mountain Ranges" 
		                         style="height: 250px; object-fit: cover;" loading="lazy">
		                    <div class="card-body d-flex flex-column">
		                        <div class="mb-2">
                                    <small class="text-muted"><i data-lucide="compass"></i> <span data-translate="location-south-america">South America</span></small>
		                            <span class="badge bg-success ms-2" data-translate="tag-adventure">Adventure</span>
		                        </div>
		                        <h5 class="card-title" data-translate="story2-title">Majestic Mountain Ranges</h5>
		                        <p class="card-text" data-translate="story2-desc">Challenge yourself with breathtaking alpine adventures. From snow-capped peaks to scenic trails, discover the world's most spectacular mountain destinations.</p>
		                        <div class="mt-auto">
		                            <a href="attractions" class="btn btn-outline-primary" data-translate="explore-more">Explore More</a>
		                        </div>
		                    </div>
		                </article>
		            </div>
		            
		            <div class="col-lg-6 mb-4">
		                <article class="card h-100 shadow-sm">
		                    <img src="https://images.unsplash.com/photo-1449824913935-59a10b8d2000?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" 
		                         class="card-img-top" data-tilt data-tilt-scale="1.05" alt="World's Greatest Cities" 
		                         style="height: 250px; object-fit: cover;" loading="lazy">
		                    <div class="card-body d-flex flex-column">
		                        <div class="mb-2">
                                    <small class="text-muted"><i data-lucide="navigation"></i> <span data-translate="location-europe">Europe</span></small>
		                            <span class="badge bg-warning ms-2" data-translate="tag-culture">Culture</span>
		                        </div>
		                        <h5 class="card-title" data-translate="story3-title">World's Greatest Cities</h5>
		                        <p class="card-text" data-translate="story3-desc">Immerse yourself in the energy of global metropolises. From ancient capitals to modern megacities, explore urban wonders that never sleep.</p>
		                        <div class="mt-auto">
		                            <a href="attractions" class="btn btn-outline-primary" data-translate="explore-more">Explore More</a>
		                        </div>
		                    </div>
		                </article>
		            </div>
		            
		            <div class="col-lg-6 mb-4">
		                <article class="card h-100 shadow-sm">
		                    <!-- Fix Ancient Wonders & Heritage image - use project image -->
		                    <img src="${pageContext.request.contextPath}/images/Colosseum.jpg" 
		                         class="card-img-top" data-tilt data-tilt-scale="1.05" alt="Ancient Wonders Heritage" 
		                         style="height: 250px; object-fit: cover;" loading="lazy">
		                    <div class="card-body d-flex flex-column">
		                        <div class="mb-2">
                                    <small class="text-muted"><i data-lucide="landmark"></i> <span data-translate="location-heritage">Europe</span></small>
		                            <span class="badge bg-info ms-2" data-translate="tag-history">History</span>
		                        </div>
		                        <h5 class="card-title" data-translate="story4-title">Ancient Wonders & Heritage</h5>
		                        <p class="card-text" data-translate="story4-desc">Step back in time at UNESCO World Heritage sites and ancient monuments. Discover civilizations that shaped our world through their architectural marvels.</p>
		                        <div class="mt-auto">
		                            <a href="attractions" class="btn btn-outline-primary" data-translate="explore-more">Explore More</a>
		                        </div>
		                    </div>
		                </article>
		            </div>
		        </div>
		        
		        <div class="text-center mt-5">
		            <a href="attractions" class="btn btn-primary btn-lg" data-translate="discover-all-attractions">Discover All Attractions</a>
		        </div>
		    </div>
		</section>
	
	<!-- World Connection Section -->
	    <section class="bg-secondary-subtle world-section" aria-labelledby="world-heading">
	        <div class="container py-5">
	            <div class="row align-items-center">
	                <div class="col-lg-6 mb-4 mb-lg-0">
	                    <h1 id="world-heading" data-translate="world-title">Bringing the World Closer</h1>
	                    <p class="lead fs-5 py-4" data-translate="world-desc">
	                        From local innovators to global changemakers, discover stories and insights that transcend borders. Dive into live updates, on-demand interviews, and community-driven projects—no matter where you are.
	                    </p>
	                    <ul class="list-unstyled mb-5">
	                        <li class="mb-2"><i data-lucide="globe" style="width: 20px; height: 20px; display: inline-block; vertical-align: middle;"></i> <span data-translate="world-feature1">24/7 live map of contributors</span></li>
	                        <li class="mb-2"><i data-lucide="file-text" style="width: 20px; height: 20px; display: inline-block; vertical-align: middle;"></i> <span data-translate="world-feature2">Curated articles & interviews</span></li>
	                        <li class="mb-2"><i data-lucide="handshake" style="width: 20px; height: 20px; display: inline-block; vertical-align: middle;"></i> <span data-translate="world-feature3">Connect with like-minded peers</span></li>
	                    </ul>
	                    <a href="attractions" class="btn btn-primary btn-lg rounded-pill px-4">
	                        <span data-translate="explore-now">Explore Now</span>
	                    </a>
	                    <small class="d-block mt-3" data-translate="world-members">
	                        Join 15,000+ members across 120 countries—free forever.
	                    </small>
	                </div>
	                <div class="col-lg-6 text-center">
	                    <div class="liquid-glass-image-container">
	                        <img src="${pageContext.request.contextPath}/images/back_main.png" alt="Global Network Visualization" class="img-fluid" loading="lazy">
	                    </div>
	                </div>
	            </div>
	        </div>
	    </section>

	<section class="services-section" aria-labelledby="services-heading">
	    <div class="container">
	        <header class="text-center my-5">
	            <h2 id="services-heading" data-translate="what-we-offer-title">What We Offer</h2>
	            <p class="lead" data-translate="services-subtitle">Comprehensive travel services designed to make your journey unforgettable</p>
	            <hr class="w-25 mx-auto">
	        </header>
	    </div>

	    <div class="services-3d-shell">
	        <div class="services-3d-box">
	            <div class="service-images">
	                <i data-lucide="home" style="width: 60px; height: 60px;" aria-hidden="true"></i>
	            </div>
	            <div class="service-content">
	                <h2 data-translate="info1-title">Value Accommodation</h2>
	                <p data-translate="info1-desc">From luxury resorts to budget-friendly hotels, we provide ideal accommodations for your global adventures.</p>
	            </div>
	        </div>
	        
	        <div class="services-3d-box">
	            <div class="service-images">
	                <i data-lucide="coffee" style="width: 60px; height: 60px;" aria-hidden="true"></i>
	            </div>
	            <div class="service-content">
	                <h2 data-translate="info2-title">Food & Drink</h2>
	                <p data-translate="info2-desc">Explore authentic flavors from around the world, from street food to Michelin-starred restaurants.</p>
	            </div>
	        </div>
	        
	        <div class="services-3d-box">
	            <div class="service-images">
	                <i data-lucide="shield-check" style="width: 60px; height: 60px;" aria-hidden="true"></i>
	            </div>
	            <div class="service-content">
	                <h2 data-translate="info3-title">Safety Guide</h2>
	                <p data-translate="info3-desc">Travel with confidence using our comprehensive safety guides and real-time travel advisories.</p>
	            </div>
	        </div>
	        
	        <div class="services-3d-box">
	            <div class="service-images">
	                <i data-lucide="globe" style="width: 60px; height: 60px;" aria-hidden="true"></i>
	            </div>
	            <div class="service-content">
	                <h2 data-translate="info4-title">Around the World</h2>
	                <p data-translate="info4-desc">Explore all seven continents with our extensive network of destinations and local expertise.</p>
	            </div>
	        </div>
	        
	        <div class="services-3d-box">
	            <div class="service-images">
	                <i data-lucide="plane" style="width: 60px; height: 60px;" aria-hidden="true"></i>
	            </div>
	            <div class="service-content">
	                <h2 data-translate="info5-title">Easy Travel</h2>
	                <p data-translate="info5-desc">Seamless booking, visa assistance, and 24/7 support make your journey smooth and worry-free.</p>
	            </div>
	        </div>
	        
		    <div class="services-3d-box">
		        <div class="service-images">
		            <i data-lucide="mountain" style="width: 60px; height: 60px;" aria-hidden="true"></i>
		        </div>
		        <div class="service-content">
		            <h2 data-translate="info6-title">Adventures</h2>
		            <p data-translate="info6-desc">From mountain climbing to deep-sea diving, discover thrilling adventures tailored to your spirit.</p>
		        </div>
		    </div>
			</div>
	</section>

	<section class="destinations-section" aria-labelledby="destinations-heading">
	    <div class="container" id="attractions">
	        <header class="text-center my-5">
	            <div class="title">
	                <p data-translate="discover-title">Hello! &#x1F44B;&#x1F3FE; Where do you want to go today?</p>
	            </div>
	            <h1 id="destinations-heading" data-translate="discover-subtitle">Discover The World</h1>
	            <hr />
	        </header>
	    </div>

    <div id="banner">
        <div class="img-list img-wrapper">
            <!-- Clone last image and place at front for seamless loop -->
            <div class="img-box clone-last">
                <div class="info">
                    <h3 data-translate="destination12-title">Christ the Redeemer</h3>
                </div>
                <img src="${pageContext.request.contextPath}/images/Christ-the-Redeemer.jpg" alt="Christ the Redeemer Brazil" onclick="location.href='${pageContext.request.contextPath}/destinations?category=religious'" />
            </div>
            
            <!-- Real image list - 12 world-class attractions -->
            <div class="img-box">
                <div class="info">
                    <h3 data-translate="destination1-title">Eiffel Tower Experience</h3>
                </div>
                <img src="${pageContext.request.contextPath}/images/Eiffel-Tower.jpg" alt="Eiffel Tower Paris France" onclick="location.href='${pageContext.request.contextPath}/destinations?category=cities'" />
            </div>
            <div class="img-box">
                <div class="info">
                    <h3 data-translate="destination2-title">Taj Mahal Wonder</h3>
                </div>
                <img src="${pageContext.request.contextPath}/images/Taj-Mahal.jpg" alt="Taj Mahal India Wonder" onclick="location.href='${pageContext.request.contextPath}/destinations?category=historical'" />
            </div>
            <div class="img-box">
                <div class="info">
                    <h3 data-translate="destination3-title">Great Barrier Reef</h3>
                </div>
                <img src="${pageContext.request.contextPath}/images/Great-Barrier-Reef.jpg" alt="Great Barrier Reef Australia" onclick="location.href='${pageContext.request.contextPath}/destinations?category=marine'" />
            </div>
            <div class="img-box">
                <div class="info">
                    <h3 data-translate="destination4-title">Machu Picchu Adventure</h3>
                </div>
                <img src="${pageContext.request.contextPath}/images/MachuPicchu.jpg" alt="Machu Picchu Peru Mountains" onclick="location.href='${pageContext.request.contextPath}/destinations?category=adventure'" />
            </div>
            <div class="img-box">
                <div class="info">
                    <h3 data-translate="destination5-title">Sydney Opera House</h3>
                </div>
                <img src="${pageContext.request.contextPath}/images/Sydney-Opera-House.jpg" alt="Sydney Opera House Australia" onclick="location.href='${pageContext.request.contextPath}/destinations?category=culture'" />
            </div>
            <div class="img-box">
                <div class="info">
                    <h3 data-translate="destination6-title">Corsica Paradise</h3>
                </div>
                <img src="${pageContext.request.contextPath}/images/Corsica.jpg" alt="Corsica Island Mediterranean" onclick="location.href='${pageContext.request.contextPath}/destinations?category=islands'" />
            </div>
            <div class="img-box">
                <div class="info">
                    <h3 data-translate="destination7-title">Colosseum Rome</h3>
                </div>
                <img src="${pageContext.request.contextPath}/images/Colosseum.jpg" alt="Colosseum Rome Italy" onclick="location.href='${pageContext.request.contextPath}/destinations?category=historical'" />
            </div>
            <div class="img-box">
                <div class="info">
                    <h3 data-translate="destination8-title">Great Wall China</h3>
                </div>
                <img src="${pageContext.request.contextPath}/images/The-Great-Wall.jpg" alt="Great Wall of China" onclick="location.href='${pageContext.request.contextPath}/destinations?category=monuments'" />
            </div>
            <div class="img-box">
                <div class="info">
                    <h3 data-translate="destination9-title">Mount Fuji</h3>
                </div>
                <img src="${pageContext.request.contextPath}/images/Mount-Fuji.jpg" alt="Mount Fuji Japan" onclick="location.href='${pageContext.request.contextPath}/destinations?category=nature'" />
            </div>
            <div class="img-box">
                <div class="info">
                    <h3 data-translate="destination10-title">Pyramids of Giza</h3>
                </div>
                <img src="${pageContext.request.contextPath}/images/Pyramids-of-Giza.jpg" alt="Pyramids of Giza Egypt" onclick="location.href='${pageContext.request.contextPath}/destinations?category=ancient'" />
            </div>
            <div class="img-box">
                <div class="info">
                    <h3 data-translate="destination11-title">Statue of Liberty</h3>
                </div>
                <img src="${pageContext.request.contextPath}/images/StatueofLiberty.jpg" alt="Statue of Liberty New York" onclick="location.href='${pageContext.request.contextPath}/destinations?category=landmarks'" />
            </div>
            <div class="img-box">
                <div class="info">
                    <h3 data-translate="destination12-title">Christ the Redeemer</h3>
                </div>
                <img src="${pageContext.request.contextPath}/images/Christ-the-Redeemer.jpg" alt="Christ the Redeemer Brazil" onclick="location.href='${pageContext.request.contextPath}/destinations?category=religious'" />
            </div>
            
            <!-- Clone first image and place at end for seamless loop -->
            <div class="img-box clone-first">
                <div class="info">
                    <h3 data-translate="destination1-title">Eiffel Tower Experience</h3>
                </div>
                <img src="${pageContext.request.contextPath}/images/Eiffel-Tower.jpg" alt="Eiffel Tower Paris France" onclick="location.href='${pageContext.request.contextPath}/destinations?category=cities'" />
            </div>
        </div>
    </div>
	    
	    <div class="btn-group">
	        <button class="last btn" aria-label="Previous destination">
	            <svg t="1686471404424" class="icon left" viewBox="0 0 1024 1024" version="1.1"
	                xmlns="http://www.w3.org/2000/svg" p-id="2373" width="128" height="128">
	                <path
	                    d="M862.485 481.154H234.126l203.3-203.3c12.497-12.497 12.497-32.758 0-45.255s-32.758-12.497-45.255 0L135.397 489.373c-12.497 12.497-12.497 32.758 0 45.254l256.774 256.775c6.249 6.248 14.438 9.372 22.627 9.372s16.379-3.124 22.627-9.372c12.497-12.497 12.497-32.759 0-45.255l-203.3-203.301h628.36c17.036 0 30.846-13.81 30.846-30.846s-13.81-30.846-30.846-30.846z"
	                    fill="" p-id="2374"></path>
	            </svg>
	        </button>
	        <button class="next btn" aria-label="Next destination">
	            <svg t="1686471404424" class="icon right" viewBox="0 0 1024 1024" version="1.1"
	                xmlns="http://www.w3.org/2000/svg" p-id="2373" width="128" height="128">
	                <path
	                    d="M862.485 481.154H234.126l203.3-203.3c12.497-12.497 12.497-32.758 0-45.255s-32.758-12.497-45.255 0L135.397 489.373c-12.497 12.497-12.497 32.758 0 45.254l256.774 256.775c6.249 6.248 14.438 9.372 22.627 9.372s16.379-3.124 22.627-9.372c12.497-12.497 12.497-32.759 0-45.255l-203.3-203.301h628.36c17.036 0 30.846-13.81 30.846-30.846s-13.81-30.846-30.846-30.846z"
	                    fill="" p-id="2374"></path>
	            </svg>
	        </button>
	    </div>
	</section>

</main>

<jsp:include page="../includes/footer.jsp" />

<script src="${pageContext.request.contextPath}/js/pages/homepage.js"></script>