<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<jsp:include page="../includes/header.jsp">
    <jsp:param name="title" value="attractions" />
</jsp:include>

<jsp:include page="../includes/navigation.jsp">
    <jsp:param name="currentPage" value="attractions" />
</jsp:include>
<link href="${pageContext.request.contextPath}/css/pages/attractions.css" rel="stylesheet">
<script src="${pageContext.request.contextPath}/js/pages/attractions.js"></script>
<script>
  fetch('${pageContext.request.contextPath}/images/icons.svg')
    .then(response => response.text())
    .then(data => {
      const div = document.createElement('div');
      div.innerHTML = data;
      div.style.display = 'none';
      document.body.appendChild(div);
    });
</script>


<body>
	<div class="container">
	        <div class="text-center mt-5">
            <h1 data-i18n="attr.title">The World's Wonder Emporium</h1>
	            <hr class="mt-4 mb-0" />
            <p class="lead mt-4 mb-4" id="mapInstructionText" data-i18n="attr.lead">The world is your oyster... or in this case, a clickable map. Pick a continent and let's find your next great story.</p>
	        </div>
        
        <div id="worldMapContainer">
            <svg
                version="1.0"
                width="468pt" height="239pt" viewBox="0 0 468 239"
                preserveAspectRatio="xMidYMid meet"
                id="worldMap" class="img-fluid" xmlns="http://www.w3.org/2000/svg"
                xmlns:xlink="http://www.w3.org/1999/xlink">
              <defs id="defs45" />
              <!-- Africa -->
              <g id="africa" class="continent" data-continent-name="Africa">
                <use xlink:href="#continent-africa" />
              </g>
              
              <!-- Asia -->
              <g id="asia" class="continent" data-continent-name="Asia" >
                <use xlink:href="#continent-asia" />
              </g>
              
              <!-- Australia -->
              <g id="aus" class="continent" data-continent-name="Australia">
                <use xlink:href="#continent-australia" />
              </g>
              
              <!-- Europe -->
              <g id="europe" class="continent" data-continent-name="Europe">
                <use xlink:href="#continent-europe" />
              </g>
              
              <!-- South America -->
              <g id="sa" class="continent" data-continent-name="South America">
                <use xlink:href="#continent-south-america" />
              </g>
              
              <!-- North America -->
              <g id="na" class="continent" data-continent-name="North America">
                <use xlink:href="#continent-north-america" />
              </g>
            </svg>
        </div>

        <div id="attractionsSection" class="pt-5">
             <h2 id="selectedContinentName" class="text-center mb-4" style="display:none;"></h2>
            <div id="attractionsDisplayArea" class="row">
                </div>
        </div>
    </div>

<div class="modal fade" id="attractionDetailModal" tabindex="-1" aria-labelledby="attractionDetailModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg modal-dialog-scrollable">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="attractionDetailModalLabel" data-i18n="attr.modal.title">Unpacking the Awesome</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <img src="" id="modalAttractionImage" class="img-fluid mb-3 rounded shadow-sm" alt="Attraction Image" style="max-height: 350px; width: 100%; object-fit: cover;">
        <h3 id="modalAttractionName" class="mb-3"></h3>
        
        <p id="modalAttractionDescription"></p>
        
        <hr>
        <h5 data-i18n="attr.modal.scoop">The Inside Scoop:</h5>
        <p class="modal-info-row">
        	<svg width="28px" height="28px" class="modal-info-icon">
        		<use xlink:href="#icon-location" />
        	</svg>
        	<span id="modalAttractionLocation">N/A</span>
        </p>
        
        <p class="modal-info-row">
        	<svg width="28px" height="28px" class="modal-info-icon">
        		<use xlink:href="#icon-calendar" />
        	</svg>
        	<span id="modalAttractionBestTime">N/A</span>
        </p>
        
        <p class="modal-info-row">
        	<svg width="28px" height="28px" class="modal-info-icon">
        		<use xlink:href="#icon-lightbulb" />
        	</svg>
        	<span id="modalAttractionFunFact">N/A</span>
        </p>
        
        <p class="modal-info-row">
        	<svg width="28px" height="28px" class="modal-info-icon">
        		<use xlink:href="#icon-website" />
        	</svg>
        <a href="#" id="modalAttractionOfficialLink" target="_blank" rel="noopener noreferrer" data-i18n="attr.modal.official">See the Official Hype</a>
        </p>
        
      </div>
      
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" data-i18n="common.close">Close</button>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" xintegrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!-- Include footer -->
<jsp:include page="../includes/footer.jsp" />
</body>
</html>