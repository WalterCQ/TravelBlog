<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="About Us" />
</jsp:include>

<jsp:include page="../includes/navigation.jsp">
    <jsp:param name="currentPage" value="about" />
</jsp:include>
<style>
    .stat-box,
    .team-member {
        background: var(--color-bg-secondary, #ffffff);
        border: 1px solid var(--color-border-primary, #e9ecef);
        border-radius: var(--radius-lg, 12px);
        padding: 1.25rem;
        box-shadow: var(--shadow-md, 0 4px 12px rgba(0,0,0,0.08));
    }

    [data-theme="dark"] .stat-box,
    body.dark-mode .stat-box,
    [data-theme="dark"] .team-member,
    body.dark-mode .team-member {
        background: rgba(255, 255, 255, 0.06);
        border-color: rgba(255, 255, 255, 0.12);
        box-shadow: 0 12px 32px rgba(0, 0, 0, 0.5);
        backdrop-filter: blur(10px) saturate(130%);
    }

    [data-theme="dark"] .team-member .text-muted,
    body.dark-mode .team-member .text-muted {
        color: var(--color-text-secondary, #adb5bd) !important;
    }
</style>
<body>
<div class="container my-5">
            <div class="row align-items-center">
                <div class="col-lg-6">
                <img src="${pageContext.request.contextPath}/images/about-image.jpg" 
                     alt="About Us" 
                     class="img-fluid mb-4" 
                     style="max-height: 200px; object-fit: cover; width: 100%;">
                    <h2 data-i18n="about-mission-title">Our Not-So-Secret Plan</h2>
                    <p data-i18n="about-mission-desc">We believe the world is a giant, amazing playground waiting to be explored. Our mission? To be that friend who convinces you to go on the epic trip, helps you pack, and knows all the best spots for snacks.</p>
                    <p data-i18n="about-mission-desc2">From your first 'I think I need a vacation' thought to your 'I can't believe we did that' return, we're here to handle the details so you can focus on making memories (and questionable choices).</p>
                </div>
                <div class="col-lg-6">
                    <div class="row">
                        <div class="col-6">
                            <div class="stat-box">
                                <h3 data-i18n="stat1-number">150+</h3>
                                <p data-i18n="stat1-text">Countries Explored</p>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="stat-box">
                                <h3 data-i18n="stat2-number">500K+</h3>
                                <p data-i18n="stat2-text">High-Fives from Travelers</p>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="stat-box">
                                <h3 data-i18n="stat3-number">15+</h3>
                                <p data-i18n="stat3-text">Years of Getting Lost (So You Don't Have To)</p>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="stat-box">
                                <h3 data-i18n="stat4-number">24/7</h3>
                                <p data-i18n="stat4-text">'Help, I'm Lost!' Support</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
			<div class="my-5">
                <h2 class="text-center mb-4" data-i18n="team-title">The Travel Wizards</h2>
			    <div class="row justify-content-center"> <div class="col-md-3">
			            <div class="team-member">
			                <img src="${pageContext.request.contextPath}/images/OL.jpg" alt="Head of Operations">
                            <h5 data-i18n="team2-name">Osamah Labeed</h5>
                            <p data-i18n="team2-role">Head of Operations</p>
                            <p class="text-muted" data-i18n="team2-desc">The master of logistics. He can untangle a flight plan faster than you can say 'are we there yet?'</p>
			            </div>
			        </div>
			        <div class="col-md-3">
			            <div class="team-member">
			                <img src="${pageContext.request.contextPath}/images/FR.jpg" alt="Travel Expert">
                            <h5 data-i18n="team3-name">Fayzirahmon Rohmanov</h5>
                            <p data-i18n="team3-role">Chief Tech Officer</p>
                             <p class="text-muted" data-i18n="team3-desc">The genius who makes our website work so smoothly. If the site is fast, thank him. If it's slow, it's probably your Wi-Fi.</p>
			            </div>
			        </div>
			        <div class="col-md-3">
			            <div class="team-member">
			                <img src="${pageContext.request.contextPath}/images/LZ.jpg" alt="Customer Success">
                            <h5 data-i18n="team4-name">Liu Zhenyu</h5>
                            <p data-i18n="team4-role">Lead Code Janitor</p>
                            <p class="text-muted" data-i18n="team4-desc">He finds and squashes bugs with the ferocity of a caffeine-fueled superhero. Our digital knight in shining armor.</p>
			            </div>
			        </div>
			    </div>
			</div>
            
            <div class="text-center my-5">
                <h2 data-i18n="why-choose-title">Why Hang With Us?</h2>
                <div class="row mt-4">
                    <div class="col-md-4">
                        <i data-lucide="award" style="width: 3rem; height: 3rem; color: goldenrod;"></i>
                        <h4 data-i18n="why1-title">We've Got the Medals</h4>
                        <p data-i18n="why1-desc">We've won a few fancy awards, which is nice. But the real prize is the happy-dance our customers do after a great trip.</p>
                    </div>
                    <div class="col-md-4">
                        <i data-lucide="users" style="width: 3rem; height: 3rem; color: goldenrod;"></i>
                        <h4 data-i18n="why2-title">We Know People</h4>
                        <p data-i18n="why2-desc">We've got a network of local guides who know their cities better than the back of their hand. Get ready for the real inside scoop.</p>
                    </div>
                    <div class="col-md-4">
                        <i data-lucide="shield-check" style="width: 3rem; height: 3rem; color: goldenrod;"></i>
                        <h4 data-i18n="why3-title">Your Adventure, Shielded</h4>
                        <p data-i18n="why3-desc">With full insurance and a 24/7 emergency line, we're like a superhero sidekick for your travels. We've always got your back.</p>
                    </div>
                </div>
            </div>
        </div>

<jsp:include page="../includes/footer.jsp" />
</body>
</html>