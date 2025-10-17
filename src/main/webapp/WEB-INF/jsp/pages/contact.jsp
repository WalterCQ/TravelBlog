<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../includes/header.jsp">
	<jsp:param name="title" value="Contact Us" />
</jsp:include>

<!-- Contact Page Specific Styles -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/pages/contact.css">

<jsp:include page="../includes/navigation.jsp">
	<jsp:param name="currentPage" value="contact" />
</jsp:include>

<div class="container my-5">
	<div class="row">
		<div class="col-lg-8">
			<div class="contact-form">
				<img
					src="${pageContext.request.contextPath}/images/contact-image.jpg"
					alt="Contact Us" class="img-fluid mb-4 contact-image"
					style="max-height: 200px; object-fit: cover; width: 100%;">
				<h3 data-i18n="contact.form.title" class="form-title">Got a Question? Drop Us a Line!</h3>
				
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i data-lucide="check-circle" class="me-2"></i>
						${successMessage}
						<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
					</div>
				</c:if>
				
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i data-lucide="alert-circle" class="me-2"></i>
						${errorMessage}
						<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
					</div>
				</c:if>
				
				<form id="contactForm" action="${pageContext.request.contextPath}/contact" method="post" novalidate>
					<div class="row">
						<div class="col-md-6 mb-3">
                            <label class="form-label" data-i18n="contact.form.name"> <i
                                data-lucide="user" class="me-2"></i>Name
							</label> <input type="text" name="name" id="name" class="form-control"
								placeholder="Your awesome name" data-i18n="contact.form.name.placeholder" data-i18n-attr="placeholder" value="${requestScope.name}"
								required>
							<div class="invalid-feedback"></div>
						</div>
						<div class="col-md-6 mb-3">
                            <label class="form-label" data-i18n="contact.form.email"> <i
                                data-lucide="mail" class="me-2"></i>Email
							</label> <input type="email" name="email" id="email" class="form-control"
								placeholder="Your best email for replies" data-i18n="contact.form.email.placeholder" data-i18n-attr="placeholder"
								value="${requestScope.email}" required>
							<div class="invalid-feedback"></div>
						</div>
					</div>

					<div class="row">
							<div class="col-md-6 mb-3">
                            <label class="form-label" data-i18n="contact.form.phone"> <i
                                data-lucide="phone" class="me-2"></i>Phone
							</label> <input type="tel" name="phone" id="phone" class="form-control"
								placeholder="Your digits (optional)" data-i18n="contact.form.phone.placeholder" data-i18n-attr="placeholder"
								value="${requestScope.phone}">
							<div class="invalid-feedback"></div>
						</div>
						<div class="col-md-6 mb-3">
                            <label class="form-label" data-i18n="contact.form.subject">
                                <i data-lucide="tag" class="me-2"></i>Subject
							</label> <select name="subject" id="subject" class="form-select" required>
								<option value="" data-i18n="contact.form.subject.select">Select a subject</option>
								<option value="General Inquiry"
									${requestScope.subject == 'General Inquiry' ? 'selected' : ''} data-i18n="contact.form.subject.general">Just saying hi!</option>
								<option value="Booking Request"
									${requestScope.subject == 'Booking Request' ? 'selected' : ''} data-i18n="contact.form.subject.booking">Help me book something amazing!</option>
								<option value="Customer Support"
									${requestScope.subject == 'Customer Support' ? 'selected' : ''} data-i18n="contact.form.subject.support">I need a little help</option>
								<option value="Partnership"
									${requestScope.subject == 'Partnership' ? 'selected' : ''} data-i18n="contact.form.subject.partner">Let's be partners!</option>
							</select>
							<div class="invalid-feedback"></div>
						</div>
					</div>

					<div class="mb-3">
                        <label class="form-label" data-i18n="contact.form.message"> <i
                            data-lucide="message-square" class="me-2"></i>Message
						</label>
						<textarea name="message" id="message" class="form-control"
							rows="5" placeholder="What's on your mind? Don't be shy, we love a good story." data-i18n="contact.form.message.placeholder" data-i18n-attr="placeholder" required>${requestScope.message}</textarea>
						<div class="invalid-feedback"></div>
					</div>

                    <button type="submit" class="btn btn-submit" id="submitBtn">
                        <i data-lucide="send"></i> <span data-i18n="contact.form.submit">Launch Message</span>
					</button>
				</form>
			</div>
		</div>

		<div class="col-lg-4">
			<div class="contact-info-enhanced">
				<div class="contact-item-enhanced">
					<div class="contact-icon-enhanced address">
						<i data-lucide="map-pin"></i>
					</div>
					<div class="contact-content">
						<h5 data-translate="contact-address-title">Our Earth Base</h5>
						<p data-translate="contact-address">
							Xiamen University Maylaysia<br>Jalan Sunsuria <br> Bandar Sunsuria <br> 43900 Sepang, Selangor
						</p>
					</div>
				</div>

				<div class="contact-item-enhanced">
					<div class="contact-icon-enhanced phone">
						<i data-lucide="phone"></i>
					</div>
					<div class="contact-content">
						<h5 data-translate="contact-phone-title">Carrier Pigeon Broke? Call Us.</h5>
						<p data-translate="contact-phone-numbers">
							<a href="tel:+15551234567" class="contact-link">+60 123-4567</a><br>
							<a href="tel:+15559876543" class="contact-link">+60 987-6543</a>
						</p>
					</div>
				</div>

				<div class="contact-item-enhanced">
					<div class="contact-icon-enhanced email">
						<i data-lucide="mail"></i>
					</div>
					<div class="contact-content">
						<h5 data-translate="contact-email-title">Send Us an E-Postcard</h5>
						<p>
							<a href="mailto:info@mytourglobal.com" class="contact-link">info@mytourglobal.com</a><br>
							<a href="mailto:support@mytourglobal.com" class="contact-link">support@mytourglobal.com</a>
						</p>
					</div>
				</div>

				<div class="contact-item-enhanced">
					<div class="contact-icon-enhanced hours">
						<i data-lucide="clock"></i>
					</div>
					<div class="contact-content">
						<h5 data-translate="contact-hours-title">When We're Awake</h5>
						<p data-translate="contact-hours">
							Monday - Friday: 9:00 AM - 8:00 PM<br>Saturday: 10:00 AM -
							6:00 PM<br>Sunday: 12:00 PM - 5:00 PM
						</p>
					</div>
				</div>
			</div>


			<div class="location-map mt-4">
				<div class="card border-0 shadow-sm">
                    <div class="card-header bg-light">
                        <h6 class="mb-0">
                            <i data-lucide="map-pin" class="me-2"></i>Find Our Hideout
						</h6>
					</div>
					<div class="card-body p-0">
						<div class="map-placeholder" style="height: 200px; background: #f8f9fa; position: relative; overflow: hidden;">
							<iframe 
								src="https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d314.8914604048619!2d101.702260909336!3d2.8307615813070486!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e1!3m2!1szh-CN!2smy!4v1752164123021!5m2!1szh-CN!2smy"
								width="100%" 
								height="200" 
								style="border:0;" 
								allowfullscreen="" 
								loading="lazy" 
								referrerpolicy="no-referrer-when-downgrade">
							</iframe>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>


<script>
  // Ensure Lucide icons render after this page's DOM is parsed
  (function(){
    if (typeof lucide !== 'undefined') { try { lucide.createIcons(); } catch(e) {} }
  })();
</script>

<jsp:include page="../includes/footer.jsp" />