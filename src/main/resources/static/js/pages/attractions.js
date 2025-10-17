document.addEventListener('DOMContentLoaded', function () {  
   	const attractionsByContinent = {
   		    "Africa": [
   		        {
   		            id: "africa_giza",
   		            name: "Pyramids of Giza, Egypt",
   		            image: "https://images.unsplash.com/photo-1503177119275-0aa32b3a9368?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
   		            description: "Iconic ancient tombs and the Great Sphinx.",
   		            longDescription: "The Giza pyramid complex, also called the Giza necropolis, is the site on the Giza Plateau in Greater Cairo, Egypt that includes the Great Pyramid of Giza, the Pyramid of Khafre, and the Pyramid of Menkaure, along with their associated pyramid complexes and the Great Sphinx of Giza. All were built during the Fourth Dynasty of the Old Kingdom of Ancient Egypt.",
   		            location: "Giza Necropolis, Al Haram, Giza Governorate, Egypt",
   		            bestTimeToVisit: "October to April",
   		            funFact: "The Great Pyramid was the tallest man-made structure for over 3,800 years.",
   		            officialWebsite: "#",
   		            detailsUrl: "#giza"
   		        },
   		        {
   		            id: "africa_vicfalls",
   		            name: "Victoria Falls, Zambia",
   		            image: "https://images.unsplash.com/photo-1618811308896-d279d72fdf4d?q=80&w=2072&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
   		            description: "One of the world's largest and most spectacular waterfalls.",
   		            longDescription: "Victoria Falls is a waterfall on the Zambezi River in southern Africa, which provides habitat for several unique species of plants and animals. It is located on the border between Zambia and Zimbabwe and is one of the world's largest waterfalls, with a width of 1,708 m (5,604 ft).",
   		            location: "Mosi-oa-Tunya Road, Livingstone, Zambia",
   		            bestTimeToVisit: "February to May (peak flow)",
   		            funFact: "Known locally as 'Mosi-oa-Tunya' – 'The Smoke That Thunders'.",
   		            officialWebsite: "#",
   		            detailsUrl: "#vicfalls"
   		        },
   		        {
   		            id: "africa_kilimanjaro",
   		            name: "Mount Kilimanjaro, Tanzania",
   		            image: "https://cdn.britannica.com/33/153433-050-F76BDF75/Sunrise-Mount-Kilimanjaro-Tanzania.jpg",
   		            description: "Africa's highest peak and a popular trekking destination.",
   		            longDescription: "Mount Kilimanjaro is a dormant volcano in Tanzania. It has three volcanic cones: Kibo, Mawenzi, and Shira. It is the highest mountain in Africa and the highest single free-standing mountain in the world: 5,895 metres (19,341 ft) above sea level and about 4,900 metres (16,100 ft) above its plateau base.",
   		            location: "Kilimanjaro National Park, Tanzania",
   		            bestTimeToVisit: "January-March or June-October (dry seasons)",
   		            funFact: "It's possible to experience five different climate zones when climbing Kilimanjaro.",
   		            officialWebsite: "#",
   		            detailsUrl: "#serengeti"
   		        }
   		    ],
   		    "Asia": [
   		        {
   		            id: "asia_greatwall",
   		            name: "Great Wall of China, China",
   		            image: "https://images.unsplash.com/flagged/photo-1552553030-837c9c2b0fac?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
   		            description: "A series of fortifications along China's northern borders.",
   		            longDescription: "The Great Wall of China is a series of fortifications that were built across the historical northern borders of ancient Chinese states and Imperial China as protection against various nomadic groups from the Eurasian Steppe. Several walls were built from as early as the 7th century BC.",
   		            location: "Various locations across northern China",
   		            bestTimeToVisit: "Spring (April-May) and Autumn (September-October)",
   		            funFact: "Contrary to popular belief, it is not visible from the Moon with the naked eye.",
   		            officialWebsite: "#",
   		            detailsUrl: "#greatwall"
   		        },
   		        {
   		            id: "asia_tajmahal",
   		            name: "Taj Mahal, India",
   		            image: "https://plus.unsplash.com/premium_photo-1661885523029-fc960a2bb4f3?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
   		            description: "An ivory-white marble mausoleum, an icon of love.",
   		            longDescription: "The Taj Mahal is an ivory-white marble mausoleum on the right bank of the river Yamuna in the Indian city of Agra. It was commissioned in 1631 by the Mughal emperor Shah Jahan to house the tomb of his favourite wife, Mumtaz Mahal; it also houses the tomb of Shah Jahan himself.",
   		            location: "Agra, Uttar Pradesh, India",
   		            bestTimeToVisit: "October to March (cooler, dry weather)",
   		            funFact: "The color of the Taj Mahal appears to change depending on the time of day and whether there's a moon.",
   		            officialWebsite: "https://www.tajmahal.gov.in/",
   		            detailsUrl: "#tajmahal"
   		        },
   		        {
   		            id: "asia_fuji",
   		            name: "Mount Fuji, Japan",
   		            image: "https://images.unsplash.com/photo-1570459027562-4a916cc6113f?q=80&w=1976&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
   		            description: "Japan's tallest peak, an active stratovolcano.",
   		            longDescription: "Mount Fuji is an active stratovolcano that is the tallest peak in Japan, standing 3,776.24 m (12,389 ft). It is a renowned symbol of Japan and is frequently depicted in art and photographs, as well as visited by sightseers and climbers.",
   		            location: "Honshu, Japan",
   		            bestTimeToVisit: "July to August (official climbing season)",
   		            funFact: "Mount Fuji is one of Japan's 'Three Holy Mountains'.",
   		            officialWebsite: "#",
   		            detailsUrl: "#fuji"
   		        }
   		    ],
   		    "Europe": [
   		        {
   		            id: "europe_eiffel",
   		            name: "Eiffel Tower, France",
   		            image: "https://media.architecturaldigest.com/photos/66a951edce728792a48166e6/3:2/w_7950,h_5300,c_limit/GettyImages-955441104.jpg",
   		            description: "Iconic wrought-iron lattice tower in Paris.",
   		            longDescription: "The Eiffel Tower is a wrought-iron lattice tower on the Champ de Mars in Paris, France. It is named after the engineer Gustave Eiffel, whose company designed and built the tower. Locally nicknamed 'La dame de fer' (French for 'Iron Lady'), it was constructed from 1887 to 1889 as the centerpiece of the 1889 World's Fair.",
   		            location: "Champ de Mars, 5 Avenue Anatole France, 75007 Paris, France",
   		            bestTimeToVisit: "Spring or Fall for pleasant weather and fewer crowds.",
   		            funFact: "The tower is repainted every seven years, using 60 tons of paint.",
   		            officialWebsite: "https://www.toureiffel.paris/",
   		            detailsUrl: "#eiffel"
   		        },
   		        {
   		            id: "europe_colosseum",
   		            name: "Colosseum, Italy",
   		            image: "https://plus.unsplash.com/premium_photo-1675975706513-9daba0ec12a8?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
   		            description: "An ancient Roman amphitheater in the center of Rome.",
   		            longDescription: "The Colosseum is an oval amphitheatre in the centre of the city of Rome, Italy, just east of the Roman Forum. It is the largest ancient amphitheatre ever built, and is still the largest standing amphitheatre in the world today, despite its age.",
   		            location: "Piazza del Colosseo, 1, 00184 Roma RM, Italy",
   		            bestTimeToVisit: "Shoulder seasons (April-June, September-October) to avoid extreme heat and crowds.",
   		            funFact: "The Colosseum could hold an estimated 50,000 to 80,000 spectators.",
   		            officialWebsite: "#",
   		            detailsUrl: "#colosseum"
   		        },
   		        {
   		            id: "europe_sagrada",
   		            name: "Sagrada Família, Spain",
   		            image: "https://cdn.britannica.com/15/194815-050-08B5E7D1/Nativity-facade-Sagrada-Familia-cathedral-Barcelona-Spain.jpg",
   		            description: "A large unfinished Roman Catholic minor basilica in Barcelona.",
   		            longDescription: "The Basílica de la Sagrada Família, also known as the Sagrada Família, is a large unfinished Roman Catholic minor basilica in the Eixample district of Barcelona, Catalonia, Spain. Designed by the Catalan architect Antoni Gaudí (1852–1926), his work on the building is part of a UNESCO World Heritage Site.",
   		            location: "C/ de Mallorca, 401, 08013 Barcelona, Spain",
   		            bestTimeToVisit: "Book tickets online in advance, any time of year.",
   		            funFact: "Construction started in 1882 and is still ongoing, with a projected completion in 2026.",
   		            officialWebsite: "https://sagradafamilia.org/",
   		            detailsUrl: "#sagrada"
   		        }
   		    ],
   		    "North America": [
   		        {
   		            id: "na_liberty",
   		            name: "Statue of Liberty, USA",
   		            image: "https://cdn.mos.cms.futurecdn.net/XsbvTN6PRi6PZtgEGvRsiE-1200-80.jpg",
   		            description: "A colossal neoclassical sculpture on Liberty Island.",
   		            longDescription: "The Statue of Liberty is a colossal neoclassical sculpture on Liberty Island in New York Harbor in New York City, in the United States. The copper statue, a gift from the people of France, was designed by French sculptor Frédéric Auguste Bartholdi and its metal framework was built by Gustave Eiffel.",
   		            location: "Liberty Island, New York, NY 10004, USA",
   		            bestTimeToVisit: "Early morning or late afternoon to avoid crowds; book ferry tickets in advance.",
   		            funFact: "The statue's full name is 'Liberty Enlightening the World'.",
   		            officialWebsite: "https://www.nps.gov/stli/index.htm",
   		            detailsUrl: "#liberty"
   		        },
   		        {
   		            id: "na_grandcanyon",
   		            name: "Grand Canyon, USA",
   		            image: "https://images.unsplash.com/photo-1608226891932-28adc7d39eea?q=80&w=2010&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
   		            description: "A steep-sided canyon carved by the Colorado River.",
   		            longDescription: "The Grand Canyon is a steep-sided canyon carved by the Colorado River in Arizona, United States. The Grand Canyon is 277 miles (446 km) long, up to 18 miles (29 km) wide and attains a depth of over a mile (6,093 feet or 1,857 meters).",
   		            location: "Grand Canyon National Park, Arizona, USA",
   		            bestTimeToVisit: "Spring and Fall for moderate temperatures.",
   		            funFact: "It's not the deepest canyon in the world, but it's known for its overwhelming size and intricate, colorful landscape.",
   		            officialWebsite: "https://www.nps.gov/grca/index.htm",
   		            detailsUrl: "#grandcanyon"
   		        },
   		        {
   		            id: "na_cntower",
   		            name: "CN Tower, Canada",
   		            image: "https://assets.simpleviewinc.com/simpleview/image/upload/c_fill,f_jpg,h_640,q_65,w_640/v1/clients/toronto/cn_tower_toronto_276bdc20-b872-4384-ad01-f68bb28d6c2d.jpg",
   		            description: "A 553.3 m-high concrete communications and observation tower.",
   		            longDescription: "The CN Tower is a 553.3 m-high (1,815.3 ft) concrete communications and observation tower in downtown Toronto, Ontario, Canada. Built on the former Railway Lands, it was completed in 1976. Its name 'CN' originally referred to Canadian National, the railway company that built the tower.",
   		            location: "290 Bremner Blvd, Toronto, ON M5V 3L9, Canada",
   		            bestTimeToVisit: "Clear days for best views, consider weekdays to avoid crowds.",
   		            funFact: "The CN Tower held the record for the world's tallest freestanding structure for 32 years until 2007.",
   		            officialWebsite: "https://www.cntower.ca/",
   		            detailsUrl: "#cntower"
   		        }
   		    ],
   		    "South America": [
   		        {
   		            id: "sa_machupicchu",
   		            name: "Machu Picchu, Peru",
   		            image: "https://images.unsplash.com/photo-1526392060635-9d6019884377?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
   		            description: "An Incan citadel set high in the Andes Mountains.",
   		            longDescription: "Machu Picchu is an Incan citadel set high in the Andes Mountains in Peru, above the Urubamba River valley. Built in the 15th century and later abandoned, it’s renowned for its sophisticated dry-stone walls that fuse huge blocks without the use of mortar, intriguing buildings that play on astronomical alignments and panoramic views.",
   		            location: "Aguas Calientes, Peru",
   		            bestTimeToVisit: "May to September (dry season), book tickets and train well in advance.",
   		            funFact: "It was 'rediscovered' by Hiram Bingham in 1911 and is often referred to as the 'Lost City of the Incas'.",
   		            officialWebsite: "https://www.machupicchu.gob.pe/",
   		            detailsUrl: "#machupicchu"
   		        },
   		        {
   		            id: "sa_christredeemer",
   		            name: "Christ the Redeemer, Brazil",
   		            image: "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/0c/e4/12/c9/visao-privilegiada.jpg?w=1200&h=1200&s=1",
   		            description: "An Art Deco statue of Jesus Christ in Rio de Janeiro.",
   		            longDescription: "Christ the Redeemer is an Art Deco statue of Jesus Christ in Rio de Janeiro, Brazil, created by French sculptor Paul Landowski and built by Brazilian engineer Heitor da Silva Costa, in collaboration with French engineer Albert Caquot. Romanian sculptor Gheorghe Leonida fashioned the face.",
   		            location: "Parque Nacional da Tijuca - Alto da Boa Vista, Rio de Janeiro - RJ, Brazil",
   		            bestTimeToVisit: "Early morning or late afternoon for fewer crowds and better light.",
   		            funFact: "The statue is struck by lightning several times a year but is rarely damaged due to its lightning rods.",
   		            officialWebsite: "#",
   		            detailsUrl: "#christredeemer"
   		        },
   		        {
   		            id: "sa_iguazu",
   		            name: "Iguazu Falls, Argentina/Brazil",
   		            image: "https://plus.unsplash.com/premium_photo-1697729955700-6004e5402a74?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
   		            description: "The largest waterfall system in the world.",
   		            longDescription: "Iguazu Falls are waterfalls of the Iguazu River on the border of the Argentine province of Misiones and the Brazilian state of Paraná. Together, they make up the largest waterfall system in the world. The falls divide the river into the upper and lower Iguazu.",
   		            location: "Border of Argentina and Brazil",
   		            bestTimeToVisit: "December to February (rainy season for fullest falls) or March-April/August-September (pleasant weather).",
   		            funFact: "It consists of hundreds of individual waterfalls, with the 'Devil's Throat' being the largest.",
   		            officialWebsite: "#",
   		            detailsUrl: "#iguazu"
   		        }
   		    ],
   		    "Australia": [
   		        {
   		            id: "aus_operahouse",
   		            name: "Sydney Opera House, Australia",
   		            image: "https://images.unsplash.com/photo-1540448051910-09cfadd5df61?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
   		            description: "A multi-venue performing arts centre in Sydney.",
   		            longDescription: "The Sydney Opera House is a multi-venue performing arts centre at Sydney Harbour in Sydney, New South Wales, Australia. It is one of the 20th century's most famous and distinctive buildings. Designed by Danish architect Jørn Utzon, the building was formally opened on 20 October 1973.",
   		            location: "Bennelong Point, Sydney NSW 2000, Australia",
   		            bestTimeToVisit: "Any time of year; check performance schedules for tours or shows.",
   		            funFact: "The design was chosen from 233 entries in an international design competition.",
   		            officialWebsite: "https://www.sydneyoperahouse.com/",
   		            detailsUrl: "#operahouse"
   		        },
   		        {
   		            id: "aus_barrierreef",
   		            name: "Great Barrier Reef, Australia",
   		            image: "https://images.unsplash.com/photo-1587139223877-04cb899fa3e8?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
   		            description: "The world's largest coral reef system.",
   		            longDescription: "The Great Barrier Reef is the world's largest coral reef system composed of over 2,900 individual reefs and 900 islands stretching for over 2,300 kilometres (1,400 mi) over an area of approximately 344,400 square kilometres (133,000 sq mi). The reef is located in the Coral Sea, off the coast of Queensland, Australia.",
   		            location: "Off the coast of Queensland, Australia",
   		            bestTimeToVisit: "May to October (dry season, good visibility for diving/snorkeling).",
   		            funFact: "It's the only living thing on Earth visible from space.",
   		            officialWebsite: "https://www.gbrmpa.gov.au/",
   		            detailsUrl: "#barrierreef"
   		        },
   		        {
   		            id: "aus_uluru",
   		            name: "Uluru (Ayers Rock), Australia",
   		            image: "https://images.unsplash.com/photo-1532481242684-bb1161831cd5?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
   		            description: "A massive sandstone monolith in the heart of the Northern Territory.",
   		            longDescription: "Uluru, also known as Ayers Rock and officially gazetted as Uluru / Ayers Rock, is a large sandstone formation in the southern part of the Northern Territory in central Australia. It lies 335 km (208 mi) south west of the nearest large town, Alice Springs.",
   		            location: "Uluru-Kata Tjuta National Park, Northern Territory, Australia",
   		            bestTimeToVisit: "May to September (cooler months). Sunrise and sunset are spectacular.",
   		            funFact: "Uluru is sacred to the local Anangu Aboriginal people.",
   		            officialWebsite: "https://parksaustralia.gov.au/uluru/",
   		            detailsUrl: "#uluru"
   		        }
   		    ]
   		};
   	const attractionDetailModal = document.getElementById('attractionDetailModal');
       const modalAttractionImage = document.getElementById('modalAttractionImage');
       const modalAttractionName = document.getElementById('modalAttractionName');
       const modalAttractionDescription = document.getElementById('modalAttractionDescription');
       const modalAttractionLocation = document.getElementById('modalAttractionLocation');
       const modalAttractionBestTime = document.getElementById('modalAttractionBestTime');
       const modalAttractionFunFact = document.getElementById('modalAttractionFunFact');
       const modalAttractionOfficialLink = document.getElementById('modalAttractionOfficialLink');

       if (attractionDetailModal) {
           attractionDetailModal.addEventListener('show.bs.modal', function (event) {
               const button = event.relatedTarget;
               
               const continent = button.getAttribute('data-continent');
               const attractionId = button.getAttribute('data-attraction-id');
               let attractionData = null;

               console.log("Modal triggered for continent:", continent, "attraction ID:", attractionId);

               if (attractionsByContinent[continent]) {
                   attractionData = attractionsByContinent[continent].find(attr => attr.id == attractionId);
               }

               if (attractionData) {
                   console.log("Found attraction data for modal:", attractionData);
                   document.getElementById('attractionDetailModalLabel').textContent = attractionData.name || 'Attraction Details';
                   if (modalAttractionImage) modalAttractionImage.src = attractionData.image || 'images/placeholder.jpg';
                   if (modalAttractionName) modalAttractionName.textContent = attractionData.name || 'N/A';
                   if (modalAttractionDescription) modalAttractionDescription.textContent = attractionData.longDescription || attractionData.description || 'More details coming soon.';
                   
                   if (modalAttractionLocation) modalAttractionLocation.textContent = attractionData.location || 'N/A';
                   if (modalAttractionBestTime) modalAttractionBestTime.textContent = attractionData.bestTimeToVisit || 'N/A';
                   if (modalAttractionFunFact) modalAttractionFunFact.textContent = attractionData.funFact || 'N/A';
                   
                   if (modalAttractionOfficialLink) {
                       const parentP = modalAttractionOfficialLink.closest('p');
                       if (attractionData.officialWebsite && attractionData.officialWebsite != '#') {
                           modalAttractionOfficialLink.href = attractionData.officialWebsite;
                           modalAttractionOfficialLink.textContent = 'Visit Official Site'; 
                           if(parentP) parentP.style.display = 'block';
                       } else {
                           if(parentP) parentP.style.display = 'none';
                       }
                   }

               } else {
                   console.error("Could not find attraction data for modal. Continent:", continent, "ID:", attractionId);
                   document.getElementById('attractionDetailModalLabel').textContent = 'Details Not Found';
                   if (modalAttractionImage) modalAttractionImage.src = 'images/placeholder.jpg';
                   if (modalAttractionName) modalAttractionName.textContent = 'Error';
                   if (modalAttractionDescription) modalAttractionDescription.textContent = 'Could not load attraction details.';
                   if (modalAttractionLocation) modalAttractionLocation.textContent = 'N/A';
                   if (modalAttractionBestTime) modalAttractionBestTime.textContent = 'N/A';
                   if (modalAttractionFunFact) modalAttractionFunFact.textContent = 'N/A';
                   if (modalAttractionOfficialLink) {
                        const websiteParagraph = modalAttractionOfficialLink.closest('p');
                        if(websiteParagraph) websiteParagraph.style.display = 'none';
                   }
               }
           });

           attractionDetailModal.addEventListener('hidden.bs.modal', function () {
               document.getElementById('attractionDetailModalLabel').textContent = 'Attraction Details';
               if (modalAttractionImage) modalAttractionImage.src = '';
               if (modalAttractionName) modalAttractionName.textContent = '';
               if (modalAttractionDescription) modalAttractionDescription.textContent = '';
               if (modalAttractionLocation) modalAttractionLocation.textContent = 'N/A';
               if (modalAttractionBestTime) modalAttractionBestTime.textContent = 'N/A';
               if (modalAttractionFunFact) modalAttractionFunFact.textContent = 'N/A';
               if (modalAttractionOfficialLink) {
                   modalAttractionOfficialLink.href = '#';
                   modalAttractionOfficialLink.innerHTML = '<img src="images/icons/world-cyan.svg" alt="Website" class="modal-info-icon" style="width:16px; height:16px;"> Visit Official Site';
                   const websiteParagraph = modalAttractionOfficialLink.closest('p');
                   if(websiteParagraph) websiteParagraph.style.display = 'block';
               }
           });
       }
   
       const continentElements = document.querySelectorAll('#worldMap .continent'); 
       const attractionsDisplayArea = document.getElementById('attractionsDisplayArea');
       const attractionsSection = document.getElementById('attractionsSection');
       const selectedContinentNameElement = document.getElementById('selectedContinentName');
       let currentlySelectedMapElement = null;

       const mapInstructionTextElement = document.getElementById('mapInstructionText');
       let originalMapInstructionText = "";
       if (mapInstructionTextElement) {
           originalMapInstructionText = mapInstructionTextElement.textContent;
       }
       
       continentElements.forEach(element => { 
           element.addEventListener('click', function() {
           	const continentName = (this.dataset.continentName || 'Selected Area');
               
               console.log("Clicked continent:", continentName);
               
               if (currentlySelectedMapElement) {
                   currentlySelectedMapElement.classList.remove('active-continent');
               }
               this.classList.add('active-continent');
               currentlySelectedMapElement = this;

               let headingText = "Top Attractions in " + continentName;
			selectedContinentNameElement.textContent = headingText;
			selectedContinentNameElement.style.display = 'block';
               
               attractionsDisplayArea.innerHTML = ''; 

               
               const currentAttractions = attractionsByContinent[continentName] || [];

               const numCardsToShow = Math.min(currentAttractions.length, 9);

               if (numCardsToShow == 0) {
                   attractionsDisplayArea.innerHTML = '<p class="text-center text-muted">No attractions listed for this continent yet.</p>';
               } else {
                   for (let i = 0; i < numCardsToShow; i++) {
                       const attraction = currentAttractions[i];

                       const cardCol = document.createElement('div');
                       cardCol.className = 'col-lg-4 col-md-6 mb-4';

                       const card = document.createElement('div');
                       card.className = 'card h-100 shadow-sm';

                       const cardImage = document.createElement('img');
                       cardImage.className = 'card-img-top';
                       cardImage.src = attraction.image || 'images/placeholder.jpg';
                       cardImage.alt = attraction.name || 'Attraction Image';
                       cardImage.style.height = '200px';
                       cardImage.style.objectFit = 'cover';


                       const cardBody = document.createElement('div');
                       cardBody.className = 'card-body d-flex flex-column';

                       const cardTitle = document.createElement('h5');
                       cardTitle.className = 'card-title';
                       cardTitle.textContent = attraction.name || 'Attraction Name';
                       
                       const cardText = document.createElement('p');
                       cardText.className = 'card-text';
                       cardText.textContent = attraction.description || 'No description available.';
                       
                       const cardButton = document.createElement('button');
                       cardButton.type = 'button';
                       cardButton.className = 'btn btn-outline-primary mt-auto learn-more-btn';
                       cardButton.textContent = 'Learn More';
                       cardButton.setAttribute('data-bs-toggle', 'modal');
                       cardButton.setAttribute('data-bs-target', '#attractionDetailModal');
                       cardButton.setAttribute('data-continent', continentName);
                       cardButton.setAttribute('data-attraction-id', attraction.id);

                       cardBody.appendChild(cardTitle);
                       cardBody.appendChild(cardText);
                       cardBody.appendChild(cardButton);
                       
                       card.appendChild(cardImage);
                       card.appendChild(cardBody);
                       cardCol.appendChild(card);
                       attractionsDisplayArea.appendChild(cardCol);
                   }
               }
               selectedContinentNameElement.scrollIntoView({ behavior: 'smooth', block: 'start' });
           });
           
           element.addEventListener('mouseenter', function() {
               const continentName = (this.dataset.continentName || 'this area').replace(/[\s\u00A0]+/g, ' ').trim();
               if (mapInstructionTextElement) {
                   mapInstructionTextElement.textContent = 'Explore attractions in ' 
                   	+ continentName + '. Click to see more!';
               }
           });

           element.addEventListener('mouseleave', function() {
               if (mapInstructionTextElement) {
                   mapInstructionTextElement.textContent = originalMapInstructionText;
               }
           });
       });
   });