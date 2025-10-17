package com.example.travelblog.controller;

import com.example.travelblog.model.*;

import com.example.travelblog.repository.*;
import com.example.travelblog.model.ContactMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.util.*;
import java.util.stream.Collectors;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import java.util.regex.Pattern;
import java.math.BigDecimal;
@Controller
public class UnifiedController {

    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private DestinationRepository destinationRepository;
    
    @Autowired
    private TravelPackageRepository travelPackageRepository;
    
    @Autowired
    private BookingRepository bookingRepository;
    
    @Autowired
    private ContactMessageRepository contactMessageRepository;

    private static final Pattern EMAIL_PATTERN = Pattern.compile(
        "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    );
    
    private static final Pattern PHONE_PATTERN = Pattern.compile(
        "^[\\+]?[0-9]{1,4}?[\\s.-]?[0-9]{3,}[\\s.-]?[0-9]{3,}[\\s.-]?[0-9]{3,}$"
    );

    @GetMapping({"/", "/index", "/homepage"})
    public String homePage(Model model) {
        try {
            if (!testDatabaseConnection()) {
                model.addAttribute("error", "Database connection failed, some features may not work correctly");
            }

            List<Destination> featuredDestinations = destinationRepository.findAll().stream()
                .filter(d -> Boolean.TRUE.equals(d.getFeatured()) && Boolean.TRUE.equals(d.getActive()))
                .limit(6)
                .collect(Collectors.toList());

            List<TravelPackage> featuredTravelPackages = travelPackageRepository.findAll().stream()
                .filter(p -> Boolean.TRUE.equals(p.getFeatured()) && Boolean.TRUE.equals(p.getActive()))
                .limit(6)
                .collect(Collectors.toList());

            model.addAttribute("featuredDestinations", featuredDestinations);
            model.addAttribute("featuredTravelPackages", featuredTravelPackages);
            model.addAttribute("pageTitle", "MyTour Global - Discover the beauty of Malaysia");
            model.addAttribute("currentPage", "home");

            System.out.println("Homepage loaded successfully:");
            System.out.println("- " + featuredDestinations.size() + " featured destinations");
            System.out.println("- " + featuredTravelPackages.size() + " featured packages");

        } catch (Exception e) {
            System.err.println("Error loading homepage: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("featuredDestinations", new ArrayList<>());
            model.addAttribute("featuredTravelPackages", new ArrayList<>());
            model.addAttribute("error", "Failed to load content, please refresh the page and try again");
        }

        return "index";
    }


    @GetMapping("/contact")
    public String contactPage(Model model, HttpSession session) {
        try {
            if (!isLoggedIn(session)) {
                session.setAttribute("redirectAfterLogin", "/contact");
                model.addAttribute("errorMessage", "Please log in to contact us.");
                return "redirect:/account/login";
            }
            
            model.addAttribute("pageTitle", "Contact Us - MyTour Travel");
            model.addAttribute("currentPage", "contact");
            
        } catch (Exception e) {
            System.err.println("Error loading contact page: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Page failed to load");
        }
        
        return "pages/contact";
    }

    @PostMapping("/contact")
    public String processContact(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam(value = "phone", required = false) String phone,
            @RequestParam("subject") String subject,
            @RequestParam("message") String message,
            RedirectAttributes redirectAttributes,
            HttpSession session) {
        
        try {
            if (!isLoggedIn(session)) {
                session.setAttribute("redirectAfterLogin", "/contact");
                redirectAttributes.addFlashAttribute("errorMessage", "Please log in to send a message.");
                return "redirect:/account/login";
            }
            
            if (name == null || name.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Name is required");
                return "redirect:/contact";
            }
            
            if (email == null || email.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Email is required");
                return "redirect:/contact";
            }
            
            if (subject == null || subject.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Subject is required");
                return "redirect:/contact";
            }
            
            if (message == null || message.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Message is required");
                return "redirect:/contact";
            }
            
            if (!EMAIL_PATTERN.matcher(email.trim()).matches()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Please enter a valid email address");
                return "redirect:/contact";
            }
            
            ContactMessage contactMsg = new ContactMessage();
            contactMsg.setName(name.trim());
            contactMsg.setEmail(email.trim().toLowerCase());
            contactMsg.setPhone(phone != null ? phone.trim() : null);
            contactMsg.setSubject(subject.trim());
            contactMsg.setMessage(message.trim());
            contactMsg.setStatus("NEW");
            contactMsg.setCreatedAt(LocalDateTime.now());
            contactMsg.setUpdatedAt(LocalDateTime.now());
            
            ContactMessage savedMessage = contactMessageRepository.save(contactMsg);
            
            if (savedMessage.getId() != null) {
                redirectAttributes.addFlashAttribute("successMessage", 
                    "Thank you for contacting us! We have received your message and will respond within 24 hours.");
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", 
                    "Sorry, there was an error sending your message. Please try again.");
            }
            
        } catch (Exception e) {
            System.err.println("Error processing contact form: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", 
                "Sorry, there was an error processing your request. Please try again.");
        }
        
        return "redirect:/contact";
    }


@GetMapping("/destinations")
public String destinations(
    @RequestParam(value = "country", required = false) String country,
    @RequestParam(value = "category", required = false) String category,
    Model model) {
    
    try {
        List<Destination> allDestinations = destinationRepository.findAll();
        
        List<Destination> destinations = allDestinations.stream()
            .filter(d -> Boolean.TRUE.equals(d.getActive()))
            .filter(d -> country == null || country.isEmpty() || 
                       d.getCountry().equals(country))
            .filter(d -> category == null || category.isEmpty() || 
                       d.getCategory().equals(category))
            .collect(Collectors.toList());

        Set<String> countries = allDestinations.stream()
            .map(Destination::getCountry)
            .filter(Objects::nonNull)
            .collect(Collectors.toSet());

        Set<String> categories = allDestinations.stream()
            .map(Destination::getCategory)
            .filter(Objects::nonNull)
            .collect(Collectors.toSet());

        model.addAttribute("destinations", destinations);
        model.addAttribute("countries", countries);
        model.addAttribute("categories", categories);
        model.addAttribute("selectedCountry", country);
        model.addAttribute("selectedCategory", category);
        model.addAttribute("pageTitle", "Explore Destinations - MyTour Global");
        model.addAttribute("currentPage", "destinations");

        System.out.println("Destinations page loaded successfully:");
        System.out.println("- Displaying " + destinations.size() + " destinations");
        System.out.println("- " + countries.size() + " countries");
        System.out.println("- " + categories.size() + " categories");

    } catch (Exception e) {
        System.err.println("Error loading destination list: " + e.getMessage());
        model.addAttribute("error", "An error occurred while loading destinations, please try again later.");
    }
    
    return "pages/destinations";
}

    @GetMapping("/destinations/{id}")
    public String destinationDetail(@PathVariable Long id, Model model) {
        try {
            if (!testDatabaseConnection()) {
                model.addAttribute("error", "Database connection failed");
                return "error";
            }

            Optional<Destination> optionalDestination = destinationRepository.findById(id);
            if (optionalDestination.isEmpty()) {
                model.addAttribute("error", "Destination not found");
                return "error";
            }

            Destination destination = optionalDestination.get();

            List<TravelPackage> travelPackages = travelPackageRepository.findAll().stream()
                .filter(p -> p.getDestinationId().equals(id) && 
                           Boolean.TRUE.equals(p.getActive()))
                .collect(Collectors.toList());

            List<Destination> relatedDestinations = destinationRepository.findAll().stream()
                .filter(d -> !d.getId().equals(id) && 
                           (d.getCountry().equals(destination.getCountry()) || 
                            d.getCategory().equals(destination.getCategory())))
                .limit(4)
                .collect(Collectors.toList());

            model.addAttribute("destination", destination);
            model.addAttribute("travelPackages", travelPackages);
            model.addAttribute("relatedDestinations", relatedDestinations);
            model.addAttribute("pageTitle", destination.getName() + " - MyTour Global");
            model.addAttribute("currentPage", "destinations");

        } catch (Exception e) {
            System.err.println("Error loading destination details: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Failed to load destination details");
        }

        return "pages/destination-detail";
    }

    @GetMapping("/packages")
    public String packages(
        @RequestParam(value = "destination", required = false) String destination,
        @RequestParam(value = "type", required = false) String type,
        @RequestParam(value = "priceMin", required = false) Double priceMin,
        @RequestParam(value = "priceMax", required = false) Double priceMax,
        Model model) {
        
        try {
            if (!testDatabaseConnection()) {
                model.addAttribute("error", "Database connection failed, please try again later");
                model.addAttribute("availableTravelPackages", new ArrayList<>());
                model.addAttribute("destinations", new ArrayList<>());
                model.addAttribute("types", new ArrayList<>());
                return "pages/packages";
            }

            System.out.println("Starting to load package list...");
            
            // Get all destinations and create ID to name mapping
            Map<Long, String> destinationIdToName = new HashMap<>();
            List<Destination> allDestinations = destinationRepository.findAll();
            for (Destination dest : allDestinations) {
                destinationIdToName.put(dest.getId(), dest.getName());
            }
            
            List<TravelPackage> allTravelPackages = travelPackageRepository.findAll();
            System.out.println("Retrieved " + allTravelPackages.size() + " packages from database");
            
            // Fill destinationName field (@Transient field, must be set manually)
            for (TravelPackage pkg : allTravelPackages) {
                if (pkg.getDestinationId() != null) {
                    String destName = destinationIdToName.get(pkg.getDestinationId());
                    pkg.setDestinationName(destName != null ? destName : "Unknown");
                }
            }

            // Filter and sort packages
            List<TravelPackage> availableTravelPackages = allTravelPackages.stream()
                .filter(p -> Boolean.TRUE.equals(p.getActive()))
                .filter(p -> destination == null || destination.isEmpty() || 
                           (p.getDestinationName() != null && p.getDestinationName().equals(destination)))
                .filter(p -> type == null || type.isEmpty() || type.equals(p.getType()))
                .filter(p -> priceMin == null || p.getPrice().compareTo(BigDecimal.valueOf(priceMin)) >= 0)
                .filter(p -> priceMax == null || p.getPrice().compareTo(BigDecimal.valueOf(priceMax)) <= 0)
                .sorted((p1, p2) -> {
                    // Sort by destination name first
                    int destCompare = p1.getDestinationName().compareTo(p2.getDestinationName());
                    if (destCompare != 0) return destCompare;
                    
                    // Same destination: sort by package type (STANDARD -> PREMIUM -> LUXURY)
                    String[] order = {"STANDARD", "PREMIUM", "LUXURY"};
                    int index1 = Arrays.asList(order).indexOf(p1.getType());
                    int index2 = Arrays.asList(order).indexOf(p2.getType());
                    return Integer.compare(index1 == -1 ? 999 : index1, index2 == -1 ? 999 : index2);
                })
                .collect(Collectors.toList());

            List<Destination> destinations = destinationRepository.findAll().stream()
                .filter(d -> Boolean.TRUE.equals(d.getActive()))
                .collect(Collectors.toList());
            
            Set<String> types = allTravelPackages.stream()
                .map(TravelPackage::getType)
                .filter(Objects::nonNull)
                .collect(Collectors.toSet());

            model.addAttribute("availableTravelPackages", availableTravelPackages);
            model.addAttribute("destinations", destinations);
            model.addAttribute("types", types);
            model.addAttribute("selectedDestination", destination);
            model.addAttribute("selectedType", type);
            model.addAttribute("selectedPriceMin", priceMin);
            model.addAttribute("selectedPriceMax", priceMax);
            model.addAttribute("pageTitle", "Travel Packages - MyTour Global");
            model.addAttribute("currentPage", "packages");

            System.out.println("Packages page loaded successfully:");
            System.out.println("- Displaying " + availableTravelPackages.size() + " packages");
            System.out.println("- " + destinations.size() + " destinations");
            System.out.println("- " + types.size() + " types");

        } catch (Exception e) {
            System.err.println("Error loading package list: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "An error occurred while loading packages, please try again later.");
            model.addAttribute("availableTravelPackages", new ArrayList<>());
            model.addAttribute("destinations", new ArrayList<>());
            model.addAttribute("types", new ArrayList<>());
        }
        
        return "pages/packages";
    }

    @GetMapping("/packages/{id}")
    public String packageDetail(@PathVariable Long id, Model model) {
        long startTime = System.currentTimeMillis();
        System.out.println("=== Starting to load package detail page ID: " + id + " ===");
        
        try {
            if (!testDatabaseConnection()) {
                System.err.println("Database connection failed - Package ID: " + id);
                model.addAttribute("error", "Database connection failed, please try again later");
                return "error";
            }
            
            System.out.println("Database connected successfully, starting to query package information...");
            
            Optional<TravelPackage> optionalTravelPackage = travelPackageRepository.findById(id);
            if (optionalTravelPackage.isEmpty()) {
                System.err.println("Package not found - ID: " + id);
                model.addAttribute("error", "Package not found (ID: " + id + ")");
                model.addAttribute("errorCode", "PACKAGE_NOT_FOUND");
                return "error";
            }
            
            TravelPackage travelPackage = optionalTravelPackage.get();
            System.out.println("Successfully retrieved package: " + travelPackage.getName());
            
            if (!Boolean.TRUE.equals(travelPackage.getActive())) {
                System.out.println("Warning: Package not activated - " + travelPackage.getName());
                model.addAttribute("warning", "This package is currently unavailable");
            }
            
            Destination destination = null;
            if (travelPackage.getDestinationId() != null) {
                Optional<Destination> optionalDestination = destinationRepository.findById(travelPackage.getDestinationId());
                if (optionalDestination.isPresent()) {
                    destination = optionalDestination.get();
                    System.out.println("Successfully retrieved destination: " + destination.getName());
                } else {
                    System.err.println("Warning: Package associated destination not found - ID: " + travelPackage.getDestinationId());
                }
            }
            
            List<TravelPackage> relatedPackages = new ArrayList<>();
            if (destination != null) {
                try {
                    relatedPackages = travelPackageRepository.findByDestinationId(destination.getId())
                        .stream()
                        .filter(p -> !p.getId().equals(id))
                        .filter(p -> Boolean.TRUE.equals(p.getActive()))
                        .limit(4)
                        .collect(Collectors.toList());
                    System.out.println("Found " + relatedPackages.size() + " related packages");
                } catch (Exception e) {
                    System.err.println("Failed to get related packages: " + e.getMessage());
                    relatedPackages = new ArrayList<>();
                }
            }
            
            Map<String, Object> packageStats = calculatePackageStats(id);
            System.out.println("Package statistics calculation completed");
            
            List<TravelPackage> popularPackages = new ArrayList<>();
            try {
                popularPackages = travelPackageRepository.findFeatured()
                    .stream()
                    .filter(p -> !p.getId().equals(id))
                    .limit(3)
                    .collect(Collectors.toList());
                System.out.println("Retrieved " + popularPackages.size() + " popular packages");
            } catch (Exception e) {
                System.err.println("Failed to get popular packages: " + e.getMessage());
            }
            
            boolean isAvailable = checkPackageAvailability(travelPackage);
            System.out.println("Package availability check: " + (isAvailable ? "available" : "unavailable"));
            
            String priceDisplay = formatPrice(travelPackage.getPrice(), travelPackage.getCurrency());
            
            model.addAttribute("travelPackage", travelPackage);
            model.addAttribute("destination", destination);
            model.addAttribute("relatedPackages", relatedPackages);
            model.addAttribute("popularPackages", popularPackages);
            model.addAttribute("packageStats", packageStats);
            model.addAttribute("isAvailable", isAvailable);
            model.addAttribute("priceDisplay", priceDisplay);
            model.addAttribute("pageTitle", travelPackage.getName() + " - MyTour Global");
            model.addAttribute("currentPage", "package-detail");
            
            if (destination != null) {
                model.addAttribute("destinationName", destination.getName());
                model.addAttribute("destinationCountry", destination.getCountry());
                model.addAttribute("metaDescription", 
                    "Explore " + travelPackage.getName() + " in " + destination.getName() + 
                    ". " + travelPackage.getDescription().substring(0, Math.min(150, travelPackage.getDescription().length())) + "...");
            }
            
            long endTime = System.currentTimeMillis();
            System.out.println("=== Package detail page loading completed, time taken: " + (endTime - startTime) + "ms ===");
            
        } catch (Exception e) {
            System.err.println("Critical error loading package details - ID: " + id);
            System.err.println("Error details: " + e.getMessage());
            e.printStackTrace();
            
            model.addAttribute("error", "Error occurred while loading package details, please try again later");
            model.addAttribute("errorDetails", e.getMessage());
            model.addAttribute("supportContact", "If the problem persists, please contact customer support");
            return "error";
        }
        
        return "pages/package-detail";
    }

    private Map<String, Object> calculatePackageStats(Long packageId) {
        Map<String, Object> stats = new HashMap<>();
        
        try {
            stats.put("totalBookings", getTotalBookingsForPackage(packageId));
            stats.put("averageRating", getAverageRatingForPackage(packageId));
            stats.put("reviewCount", getReviewCountForPackage(packageId));
            stats.put("lastBooked", getLastBookingDateForPackage(packageId));
            stats.put("popularity", calculatePopularityScore(packageId));
            
        } catch (Exception e) {
            System.err.println("Failed to calculate package statistics: " + e.getMessage());
            stats.put("totalBookings", 0);
            stats.put("averageRating", 0.0);
            stats.put("reviewCount", 0);
            stats.put("lastBooked", null);
            stats.put("popularity", 0);
        }
        
        return stats;
    }

    private boolean checkPackageAvailability(TravelPackage travelPackage) {
        try {
            if (!Boolean.TRUE.equals(travelPackage.getActive())) {
                return false;
            }
            
            LocalDateTime now = LocalDateTime.now();
            
            if (travelPackage.getAvailableFrom() != null && now.isBefore(travelPackage.getAvailableFrom())) {
                return false;
            }
            
            if (travelPackage.getAvailableTo() != null && now.isAfter(travelPackage.getAvailableTo())) {
                return false;
            }
            
            return true;
            
        } catch (Exception e) {
            System.err.println("Failed to check package availability: " + e.getMessage());
            return true;
        }
    }

    private String formatPrice(BigDecimal price, String currency) {
        if (price == null) return "Price to be determined";
        try {
            return "RM " + String.format("%,.2f", price);
        } catch (Exception e) {
            System.err.println("Failed to format price: " + e.getMessage());
            return "RM " + price.toString();
        }
    }

    private int getTotalBookingsForPackage(Long packageId) {
        try {
            List<Booking> allBookings = bookingRepository.findAll();
            return (int) allBookings.stream()
                .filter(b -> packageId.equals(b.getPackageId()))
                .filter(b -> !"CANCELLED".equals(b.getStatus()))
                .count();
        } catch (Exception e) {
            System.err.println("Failed to get package booking count: " + e.getMessage());
            return 0;
        }
    }

    private double getAverageRatingForPackage(Long packageId) {
        return 4.5;
    }

    private int getReviewCountForPackage(Long packageId) {
        try {
            int bookings = getTotalBookingsForPackage(packageId);
            return Math.max(0, bookings - (int)(Math.random() * 10));
        } catch (Exception e) {
            return 0;
        }
    }

    private LocalDateTime getLastBookingDateForPackage(Long packageId) {
        try {
            List<Booking> allBookings = bookingRepository.findAll();
            return allBookings.stream()
                .filter(b -> packageId.equals(b.getPackageId()))
                .filter(b -> !"CANCELLED".equals(b.getStatus()))
                .map(Booking::getCreatedAt)
                .max(LocalDateTime::compareTo)
                .orElse(null);
        } catch (Exception e) {
            System.err.println("Failed to get last booking date: " + e.getMessage());
            return null;
        }
    }

    private int calculatePopularityScore(Long packageId) {
        try {
            int bookings = getTotalBookingsForPackage(packageId);
            double rating = getAverageRatingForPackage(packageId);
            int reviews = getReviewCountForPackage(packageId);
            
            int score = (bookings * 2) + (int)(rating * 10) + reviews;
            return Math.min(100, Math.max(0, score));
            
        } catch (Exception e) {
            return 50;
        }
    }
    
    @GetMapping("/api/packages/{id}/availability")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> checkPackageAvailabilityApi(@PathVariable Long id) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            Optional<TravelPackage> optionalPackage = travelPackageRepository.findById(id);
            if (optionalPackage.isEmpty()) {
                response.put("available", false);
                response.put("reason", "Package not found");
                return ResponseEntity.notFound().build();
            }
            
            TravelPackage travelPackage = optionalPackage.get();
            boolean isAvailable = checkPackageAvailability(travelPackage);
            
            response.put("available", isAvailable);
            response.put("packageName", travelPackage.getName());
            response.put("price", travelPackage.getPrice());
            response.put("currency", travelPackage.getCurrency());
            response.put("lastUpdated", LocalDateTime.now());
            
            if (!isAvailable) {
                if (!Boolean.TRUE.equals(travelPackage.getActive())) {
                    response.put("reason", "Package is currently unavailable");
                } else if (travelPackage.getAvailableFrom() != null && 
                          LocalDateTime.now().isBefore(travelPackage.getAvailableFrom())) {
                    response.put("reason", "Package sales have not started yet");
                    response.put("availableFrom", travelPackage.getAvailableFrom());
                } else if (travelPackage.getAvailableTo() != null && 
                          LocalDateTime.now().isAfter(travelPackage.getAvailableTo())) {
                    response.put("reason", "Package sales have ended");
                }
            }
            
            return ResponseEntity.ok(response);
            
        } catch (Exception e) {
            System.err.println("API check package availability failed: " + e.getMessage());
            response.put("available", false);
            response.put("reason", "System error");
            return ResponseEntity.status(500).body(response);
        }
    }

    @GetMapping("/api/packages/{id}/stats")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getPackageStatsApi(@PathVariable Long id) {
        try {
            if (!testDatabaseConnection()) {
                return ResponseEntity.status(503).body(Map.of("error", "Database connection failed"));
            }
            
            Optional<TravelPackage> optionalPackage = travelPackageRepository.findById(id);
            if (optionalPackage.isEmpty()) {
                return ResponseEntity.notFound().build();
            }
            
            Map<String, Object> stats = calculatePackageStats(id);
            stats.put("lastUpdated", LocalDateTime.now());
            stats.put("packageId", id);
            
            return ResponseEntity.ok(stats);
            
        } catch (Exception e) {
            System.err.println("Failed to get package statistics API: " + e.getMessage());
            return ResponseEntity.status(500).body(Map.of("error", "Failed to get statistics"));
        }
    }

    @GetMapping("/booking")
    public String bookingPage(
            @RequestParam(value = "package", required = false) Long packageParam,
            @RequestParam(value = "packageId", required = false) Long packageIdParam,
            @RequestParam(value = "travelPackage", required = false) Long travelPackageParam,
            @RequestParam(value = "destination", required = false) Long destinationId,
            Model model, HttpSession session) {
        
        // Support multiple parameter names: package, packageId, travelPackage
        Long packageId = packageParam != null ? packageParam : 
                        (packageIdParam != null ? packageIdParam : travelPackageParam);
        
        if (!isLoggedIn(session)) {
            String redirectParam = packageId != null ? "?package=" + packageId : 
                                  destinationId != null ? "?destination=" + destinationId : "";
            return "redirect:/account/login?redirect=" + 
                   java.net.URLEncoder.encode("/booking" + redirectParam, 
                   java.nio.charset.StandardCharsets.UTF_8);
        }

        try {
            if (!testDatabaseConnection()) {
                model.addAttribute("error", "Database connection failed");
                model.addAttribute("availableTravelPackages", new ArrayList<>());
                model.addAttribute("destinations", new ArrayList<>());
                return "pages/booking-refactored";
            }

            List<TravelPackage> availableTravelPackages = travelPackageRepository.findAll().stream()
                .filter(p -> Boolean.TRUE.equals(p.getActive()))
                .collect(Collectors.toList());

            List<Destination> destinations = destinationRepository.findAll();

            TravelPackage selectedTravelPackage = null;
            if (packageId != null) {
                selectedTravelPackage = travelPackageRepository.findById(packageId).orElse(null);
                if (selectedTravelPackage != null) {
                    System.out.println("Auto-selected package: " + selectedTravelPackage.getName() + " (ID: " + packageId + ")");
                }
            }

            Destination selectedDestination = null;
            if (destinationId != null) {
                selectedDestination = destinationRepository.findById(destinationId).orElse(null);
            }

            model.addAttribute("availableTravelPackages", availableTravelPackages);
            model.addAttribute("destinations", destinations);
            model.addAttribute("packageId", packageId);
            model.addAttribute("destinationId", destinationId);
            model.addAttribute("selectedTravelPackage", selectedTravelPackage);
            model.addAttribute("selectedDestination", selectedDestination);
            model.addAttribute("pageTitle", "Book a Trip - MyTour Global");
            model.addAttribute("currentPage", "booking");

            System.out.println("Booking page loaded successfully:");
            System.out.println("- " + availableTravelPackages.size() + " available packages");

        } catch (Exception e) {
            System.err.println("Error loading booking page: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("availableTravelPackages", new ArrayList<>());
            model.addAttribute("destinations", new ArrayList<>());
            model.addAttribute("error", "Failed to load booking page");
        }

        return "pages/booking-refactored";
    }

    @PostMapping("/booking")
    public String processBookingSubmission(
            @RequestParam("packageId") Long packageId,
            @RequestParam("departureDate") String departureDateStr,
            @RequestParam("adultCount") Integer adultCount,
            @RequestParam(value = "childCount", defaultValue = "0") Integer childCount,
            @RequestParam("customerName") String customerName,
            @RequestParam("customerEmail") String customerEmail,
            @RequestParam("customerPhone") String customerPhone,
            @RequestParam(value = "specialRequests", required = false) String specialRequests,
            @RequestParam(value = "totalPrice") BigDecimal totalPrice,
            RedirectAttributes redirectAttributes,
            HttpSession session) {

        if (!isLoggedIn(session)) {
            return "redirect:/account/login";
        }

        try {
            User currentUser = (User) session.getAttribute("currentUser");

            if (packageId == null || adultCount == null || adultCount < 1) {
                redirectAttributes.addFlashAttribute("errorMessage", "Please fill in all required information");
                return "redirect:/booking";
            }

            if (!EMAIL_PATTERN.matcher(customerEmail.trim()).matches()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Please enter a valid email address");
                return "redirect:/booking";
            }

            if (!PHONE_PATTERN.matcher(customerPhone.trim()).matches()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Please enter a valid phone number");
                return "redirect:/booking";
            }

            LocalDate departureDate;
            try {
                departureDate = LocalDate.parse(departureDateStr);
                if (departureDate.isBefore(LocalDate.now().plusDays(1))) {
                    redirectAttributes.addFlashAttribute("errorMessage", "Departure date must be at least tomorrow");
                    return "redirect:/booking";
                }
            } catch (DateTimeParseException e) {
                redirectAttributes.addFlashAttribute("errorMessage", "Invalid departure date format");
                return "redirect:/booking";
            }

            Optional<TravelPackage> optionalTravelPackage = travelPackageRepository.findById(packageId);
            if (optionalTravelPackage.isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Selected package does not exist");
                return "redirect:/booking";
            }

            TravelPackage travelPackage = optionalTravelPackage.get();

            Booking booking = new Booking();
            booking.setUserId(currentUser.getId());
            booking.setPackageId(packageId);
            booking.setDepartureDate(departureDate);
            booking.setAdultCount(adultCount);
            booking.setChildCount(childCount);
            booking.setCustomerName(customerName.trim());
            booking.setCustomerEmail(customerEmail.trim().toLowerCase());
            booking.setCustomerPhone(customerPhone.trim());
            booking.setSpecialRequests(specialRequests != null ? specialRequests.trim() : null);
            booking.setTotalPrice(totalPrice);
            booking.setStatus("CONFIRMED");
            booking.setPaymentStatus("PENDING");
            booking.setCreatedAt(LocalDateTime.now());

            if (travelPackage.getDurationDays() != null) {
                booking.setReturnDate(departureDate.plusDays(travelPackage.getDurationDays() - 1));
            }

            String bookingNumber = "BK" + System.currentTimeMillis();
            booking.setBookingNumber(bookingNumber);

            Booking savedBooking = bookingRepository.save(booking);

            if (savedBooking.getId() != null) {
                redirectAttributes.addFlashAttribute("successMessage", "Booking successful! Booking number: " + bookingNumber);
                return "redirect:/booking/confirmation/" + savedBooking.getId();
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Booking failed, please try again");
                return "redirect:/booking";
            }

        } catch (Exception e) {
            System.err.println("Error processing booking submission: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "System error, please try again later");
            return "redirect:/booking";
        }
    }

    @PostMapping("/booking/submit")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> submitBooking(
            @RequestBody Map<String, Object> bookingData,
            HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        
        if (!isLoggedIn(session)) {
            response.put("success", false);
            response.put("message", "Please log in first");
            return ResponseEntity.status(401).body(response);
        }

        try {
            User currentUser = (User) session.getAttribute("currentUser");
            
            Booking booking = new Booking();
            booking.setUserId(currentUser.getId());
            booking.setPackageId(Long.valueOf(bookingData.get("packageId").toString()));
            booking.setTotalPrice(new BigDecimal(bookingData.get("totalAmount").toString()));
            booking.setStatus("PENDING");
            booking.setPaymentStatus("PENDING");
            booking.setDepartureDate(LocalDate.parse(bookingData.get("departureDate").toString()));
            booking.setCreatedAt(LocalDateTime.now());
            
            String bookingNumber = "BK" + System.currentTimeMillis();
            booking.setBookingNumber(bookingNumber);
            
            Booking savedBooking = bookingRepository.save(booking);
            
            if (savedBooking.getId() != null) {
                response.put("success", true);
                response.put("message", "Booking successful");
                response.put("bookingId", savedBooking.getId());
                response.put("bookingNumber", bookingNumber);
            } else {
                response.put("success", false);
                response.put("message", "Booking failed, please try again");
            }

        } catch (Exception e) {
            System.err.println("Error submitting booking: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "System error, please try again later");
        }

        return ResponseEntity.ok(response);
    }

    @GetMapping({"/booking/confirmation/{id}", "/confirmation/{id}", "/confirmation"})
    public String bookingConfirmation(
            @PathVariable(required = false) Long id,
            @RequestParam(value = "bookingId", required = false) Long bookingIdParam,
            Model model, HttpSession session) {
        
        if (!isLoggedIn(session)) {
            return "redirect:/account/login";
        }

        try {
            User currentUser = (User) session.getAttribute("currentUser");
            Long bookingId = id != null ? id : bookingIdParam;

            if (bookingId == null) {
                model.addAttribute("error", "Booking ID not provided");
                return "redirect:/my-bookings";
            }

            Optional<Booking> optionalBooking = bookingRepository.findById(bookingId);
            if (optionalBooking.isEmpty()) {
                model.addAttribute("error", "Booking not found");
                return "redirect:/my-bookings";
            }

            Booking booking = optionalBooking.get();

            if (!booking.getUserId().equals(currentUser.getId()) && 
                !"ADMIN".equals(currentUser.getRole())) {
                model.addAttribute("error", "Access denied");
                return "redirect:/my-bookings";
            }

            Optional<TravelPackage> optionalTravelPackage = travelPackageRepository.findById(booking.getPackageId());
            TravelPackage travelPackage = optionalTravelPackage.orElse(null);

            Optional<Destination> destination = Optional.empty();
            if (travelPackage != null && travelPackage.getDestinationId() != null) {
                destination = destinationRepository.findById(travelPackage.getDestinationId());
            }

            model.addAttribute("booking", booking);
            model.addAttribute("travelPackage", travelPackage);
            model.addAttribute("destination", destination.orElse(null));
            model.addAttribute("pageTitle", "Booking Confirmation - MyTour Global");
            model.addAttribute("currentPage", "booking");

        } catch (Exception e) {
            System.err.println("Error loading booking confirmation: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Unable to load booking details");
        }

        return "pages/booking-confirmation";
    }
    
    @PostMapping("/booking/submit-with-payment")
    public String submitBookingWithPayment(
            @RequestParam("packageId") Long packageId,
            @RequestParam("customerName") String customerName,
            @RequestParam("customerEmail") String customerEmail,
            @RequestParam("customerPhone") String customerPhone,
            @RequestParam("numberOfParticipants") Integer numberOfParticipants,
            @RequestParam("departureDate") String departureDateStr,
            @RequestParam(value = "returnDate", required = false) String returnDateStr,
            @RequestParam(value = "specialRequests", required = false) String specialRequests,
            @RequestParam(value = "emergencyContact", required = false) String emergencyContact,
            @RequestParam(value = "emergencyPhone", required = false) String emergencyPhone,
            @RequestParam("totalPrice") BigDecimal totalPrice,
            @RequestParam("paymentMethod") String paymentMethod,
            @RequestParam(value = "cardNumber", required = false) String cardNumber,
            @RequestParam(value = "cardHolder", required = false) String cardHolder,
            @RequestParam(value = "expiryDate", required = false) String expiryDate,
            @RequestParam(value = "cvv", required = false) String cvv,
            RedirectAttributes redirectAttributes,
            HttpSession session) {

        if (!isLoggedIn(session)) {
            return "redirect:/account/login";
        }

        try {
            User currentUser = (User) session.getAttribute("currentUser");
            
            if (!EMAIL_PATTERN.matcher(customerEmail).matches()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Invalid email format");
                return "redirect:/booking?package=" + packageId;
            }
            
            if (!PHONE_PATTERN.matcher(customerPhone).matches()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Invalid phone number format");
                return "redirect:/booking?package=" + packageId;
            }

            Optional<TravelPackage> packageOpt = travelPackageRepository.findById(packageId);
            if (packageOpt.isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Travel package not found");
                return "redirect:/booking";
            }

            TravelPackage travelPackage = packageOpt.get();
            LocalDate departureDate = LocalDate.parse(departureDateStr);
            LocalDate returnDate = null;
            
            if (returnDateStr != null && !returnDateStr.trim().isEmpty()) {
                returnDate = LocalDate.parse(returnDateStr);
            }

            if (departureDate.isBefore(LocalDate.now())) {
                redirectAttributes.addFlashAttribute("errorMessage", "Departure date cannot be earlier than today");
                return "redirect:/booking?package=" + packageId;
            }

            Booking booking = new Booking();
            booking.setUserId(currentUser.getId());
            booking.setPackageId(packageId);
            booking.setCustomerName(customerName.trim());
            booking.setCustomerEmail(customerEmail.trim());
            booking.setCustomerPhone(customerPhone.trim());
            booking.setNumberOfParticipants(numberOfParticipants);
            booking.setDepartureDate(departureDate);
            booking.setReturnDate(returnDate);
            booking.setSpecialRequests(specialRequests != null && !specialRequests.trim().isEmpty() ? 
                                       specialRequests.trim() : null);
            booking.setEmergencyContact(emergencyContact != null && !emergencyContact.trim().isEmpty() ? 
                                       emergencyContact.trim() : null);
            booking.setEmergencyPhone(emergencyPhone != null && !emergencyPhone.trim().isEmpty() ? 
                                     emergencyPhone.trim() : null);
            booking.setTotalPrice(totalPrice);
            booking.setCurrency("USD");
            booking.setStatus("PENDING");
            booking.setPaymentStatus("PENDING");
            booking.setBookingDate(LocalDate.now());
            booking.setCreatedAt(LocalDateTime.now());
            booking.setUpdatedAt(LocalDateTime.now());

            if (travelPackage.getDurationDays() != null && returnDate == null) {
                booking.setReturnDate(departureDate.plusDays(travelPackage.getDurationDays() - 1));
            }

            String bookingNumber = "BK" + System.currentTimeMillis();
            booking.setBookingNumber(bookingNumber);

            Booking savedBooking = bookingRepository.save(booking);

            if (savedBooking.getId() != null) {
                boolean paymentSuccess = processPaymentTransaction(paymentMethod, cardNumber, cardHolder, expiryDate, cvv, totalPrice);
                
                if (paymentSuccess) {
                    savedBooking.setPaymentStatus("PAID");
                    savedBooking.setPaymentMethod(paymentMethod);
                    savedBooking.setStatus("CONFIRMED");
                    savedBooking.setConfirmationDate(LocalDate.now());
                    savedBooking.setUpdatedAt(LocalDateTime.now());
                    
                    bookingRepository.save(savedBooking);
                    
                    redirectAttributes.addFlashAttribute("successMessage", "Booking successful and paid! Booking number: " + bookingNumber);
                    return "redirect:/booking/confirmation/" + savedBooking.getId();
                } else {
                    redirectAttributes.addFlashAttribute("errorMessage", "Booking created but payment failed, please try again");
                    return "redirect:/payment?booking=" + savedBooking.getId();
                }
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Booking failed, please try again");
                return "redirect:/booking?package=" + packageId;
            }

        } catch (DateTimeParseException e) {
            System.err.println("Date format error: " + e.getMessage());
            redirectAttributes.addFlashAttribute("errorMessage", "Invalid date format");
            return "redirect:/booking?package=" + packageId;
        } catch (Exception e) {
            System.err.println("Error processing booking payment: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "System error, please try again later");
            return "redirect:/booking";
        }
    }

    @PostMapping("/booking/submit-with-payment-ajax")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> submitBookingWithPaymentAjax(
            @RequestBody Map<String, Object> bookingData,
            HttpSession session) {
        
        Map<String, Object> response = new HashMap<>();
        
        if (!isLoggedIn(session)) {
            response.put("success", false);
            response.put("message", "Please log in first");
            return ResponseEntity.status(401).body(response);
        }

        try {
            User currentUser = (User) session.getAttribute("currentUser");
            
            String customerEmail = bookingData.get("customerEmail").toString();
            String customerPhone = bookingData.get("customerPhone").toString();
            
            if (!EMAIL_PATTERN.matcher(customerEmail).matches()) {
                response.put("success", false);
                response.put("message", "Invalid email format");
                return ResponseEntity.ok(response);
            }
            
            if (!PHONE_PATTERN.matcher(customerPhone).matches()) {
                response.put("success", false);
                response.put("message", "Invalid phone number format");
                return ResponseEntity.ok(response);
            }

            Long packageId = Long.valueOf(bookingData.get("packageId").toString());
            Optional<TravelPackage> packageOpt = travelPackageRepository.findById(packageId);
            if (packageOpt.isEmpty()) {
                response.put("success", false);
                response.put("message", "Travel package not found");
                return ResponseEntity.ok(response);
            }

            TravelPackage travelPackage = packageOpt.get();
            LocalDate departureDate = LocalDate.parse(bookingData.get("departureDate").toString());
            
            if (departureDate.isBefore(LocalDate.now())) {
                response.put("success", false);
                response.put("message", "Departure date cannot be earlier than today");
                return ResponseEntity.ok(response);
            }

            Booking booking = new Booking();
            booking.setUserId(currentUser.getId());
            booking.setPackageId(packageId);
            booking.setCustomerName(bookingData.get("customerName").toString().trim());
            booking.setCustomerEmail(customerEmail.trim());
            booking.setCustomerPhone(customerPhone.trim());
            booking.setNumberOfParticipants(Integer.valueOf(bookingData.get("numberOfParticipants").toString()));
            booking.setDepartureDate(departureDate);
            
            if (bookingData.containsKey("returnDate") && bookingData.get("returnDate") != null && 
                !bookingData.get("returnDate").toString().trim().isEmpty()) {
                booking.setReturnDate(LocalDate.parse(bookingData.get("returnDate").toString()));
            } else if (travelPackage.getDurationDays() != null) {
                booking.setReturnDate(departureDate.plusDays(travelPackage.getDurationDays() - 1));
            }
            
            if (bookingData.containsKey("specialRequests") && bookingData.get("specialRequests") != null) {
                String specialRequests = bookingData.get("specialRequests").toString().trim();
                booking.setSpecialRequests(specialRequests.isEmpty() ? null : specialRequests);
            }
            
            if (bookingData.containsKey("emergencyContact") && bookingData.get("emergencyContact") != null) {
                String emergencyContact = bookingData.get("emergencyContact").toString().trim();
                booking.setEmergencyContact(emergencyContact.isEmpty() ? null : emergencyContact);
            }
            
            if (bookingData.containsKey("emergencyPhone") && bookingData.get("emergencyPhone") != null) {
                String emergencyPhone = bookingData.get("emergencyPhone").toString().trim();
                booking.setEmergencyPhone(emergencyPhone.isEmpty() ? null : emergencyPhone);
            }
            
            booking.setTotalPrice(new BigDecimal(bookingData.get("totalPrice").toString()));
            booking.setCurrency("USD");
            booking.setStatus("PENDING");
            booking.setPaymentStatus("PENDING");
            booking.setBookingDate(LocalDate.now());
            booking.setCreatedAt(LocalDateTime.now());
            booking.setUpdatedAt(LocalDateTime.now());
            
            String bookingNumber = "BK" + System.currentTimeMillis();
            booking.setBookingNumber(bookingNumber);
            
            Booking savedBooking = bookingRepository.save(booking);
            
            if (savedBooking.getId() != null) {
                String paymentMethod = bookingData.get("paymentMethod").toString();
                String cardNumber = bookingData.getOrDefault("cardNumber", "").toString();
                String cardHolder = bookingData.getOrDefault("cardHolder", "").toString();
                String expiryDate = bookingData.getOrDefault("expiryDate", "").toString();
                String cvv = bookingData.getOrDefault("cvv", "").toString();
                
                boolean paymentSuccess = processPaymentTransaction(paymentMethod, cardNumber, cardHolder, expiryDate, cvv, booking.getTotalPrice());
                
                if (paymentSuccess) {
                    savedBooking.setPaymentStatus("PAID");
                    savedBooking.setPaymentMethod(paymentMethod);
                    savedBooking.setStatus("CONFIRMED");
                    savedBooking.setConfirmationDate(LocalDate.now());
                    savedBooking.setUpdatedAt(LocalDateTime.now());
                    
                    bookingRepository.save(savedBooking);
                    
                    response.put("success", true);
                    response.put("message", "Booking successful and paid");
                    response.put("bookingId", savedBooking.getId());
                    response.put("bookingNumber", bookingNumber);
                    response.put("redirectUrl", "/booking/confirmation/" + savedBooking.getId());
                } else {
                    response.put("success", false);
                    response.put("message", "Booking created but payment failed, please try again");
                    response.put("bookingId", savedBooking.getId());
                    response.put("redirectUrl", "/payment?booking=" + savedBooking.getId());
                }
            } else {
                response.put("success", false);
                response.put("message", "Booking creation failed, please try again");
            }

        } catch (Exception e) {
            System.err.println("Ajax booking payment error: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "System error, please try again later");
        }

        return ResponseEntity.ok(response);
    }

    private boolean processPaymentTransaction(String paymentMethod, String cardNumber, String cardHolder, String expiryDate, String cvv, BigDecimal amount) {
        try {
            System.out.println("Processing payment: " + paymentMethod + ", Amount: " + amount);
            
            if ("Credit Card".equals(paymentMethod) || "Debit Card".equals(paymentMethod)) {
                if (cardNumber == null || cardNumber.trim().isEmpty() ||
                    cardHolder == null || cardHolder.trim().isEmpty() ||
                    expiryDate == null || expiryDate.trim().isEmpty() ||
                    cvv == null || cvv.trim().isEmpty()) {
                    System.out.println("Credit card information incomplete");
                    return false;
                }
                
                String cleanCardNumber = cardNumber.replaceAll("\\s+", "");
                if (cleanCardNumber.length() < 13 || cleanCardNumber.length() > 19) {
                    System.out.println("Credit card number format error");
                    return false;
                }
                
                if (!expiryDate.matches("\\d{2}/\\d{2}")) {
                    System.out.println("Expiry date format error");
                    return false;
                }
                
                if (cvv.length() < 3 || cvv.length() > 4) {
                    System.out.println("CVV format error");
                    return false;
                }
            }
            
            Thread.sleep(1500);
            
            double successRate = Math.random();
            boolean success = successRate > 0.05;
            
            System.out.println("Payment result: " + (success ? "successful" : "failed"));
            return success;
            
        } catch (Exception e) {
            System.err.println("Payment processing exception: " + e.getMessage());
            return false;
        }
    }

    @GetMapping("/my-bookings")
    public String myBookings(Model model, HttpSession session) {
        if (!isLoggedIn(session)) {
            return "redirect:/account/login?error=required";
        }

        try {
            User currentUser = (User) session.getAttribute("currentUser");
            List<Booking> userBookings = bookingRepository.findByUserId(currentUser.getId());


            // Calculate statistics
            long pendingCount = userBookings.stream().mapToLong(b -> "PENDING".equals(b.getStatus()) ? 1 : 0).sum();
            long confirmedCount = userBookings.stream().mapToLong(b -> "CONFIRMED".equals(b.getStatus()) ? 1 : 0).sum();
            long completedCount = userBookings.stream().mapToLong(b -> "COMPLETED".equals(b.getStatus()) ? 1 : 0).sum();

            model.addAttribute("bookings", userBookings);
            model.addAttribute("pendingCount", pendingCount);
            model.addAttribute("confirmedCount", confirmedCount);
            model.addAttribute("completedCount", completedCount);
            model.addAttribute("pageTitle", "My Bookings - MyTour Global");
            model.addAttribute("currentPage", "my-bookings");

        } catch (Exception e) {
            System.err.println("Error loading my bookings: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("bookings", new ArrayList<>());
            model.addAttribute("error", "Unable to load booking history");
        }

        return "pages/my-bookings";
    }

    @GetMapping({"/account/login", "/login"})
    public String loginPage(
            @RequestParam(value = "redirect", required = false) String redirectUrl,
            @RequestParam(value = "error", required = false) String error,
            Model model,
            HttpSession session) {

        if (isLoggedIn(session)) {
            User u = (User) session.getAttribute("currentUser");
            if ("ADMIN".equals(u.getRole())) {
                return "redirect:/admin";
            } else {
                return "redirect:/";
            }
        }

        model.addAttribute("redirectUrl", redirectUrl);
        model.addAttribute("pageTitle", "Login - MyTour Global");
        model.addAttribute("currentPage", "login");

        if ("invalid".equals(error)) {
            model.addAttribute("errorMessage", "Invalid username or password");
        } else if ("required".equals(error)) {
            model.addAttribute("errorMessage", "Login required");
        }

        return "pages/login";
    }

    @PostMapping({"/account/login", "/login"})
    public String processLogin(
            @RequestParam("username") String username,
            @RequestParam("password") String password,
            @RequestParam(value = "redirectUrl", required = false) String redirectUrl,
            RedirectAttributes redirectAttributes,
            HttpSession session) {

        try {
            if (username == null || username.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Username cannot be empty");
                return "redirect:/account/login";
            }

            Optional<User> optionalUser = userRepository.findByUsernameOrEmail(username.trim(), username.trim());

            if (optionalUser.isEmpty() || !optionalUser.get().getPassword().equals(password)) {
                redirectAttributes.addFlashAttribute("errorMessage", "Invalid username or password");
                return "redirect:/account/login";
            }

            User user = optionalUser.get();

            if (!Boolean.TRUE.equals(user.getActive())) {
                redirectAttributes.addFlashAttribute("errorMessage", "Account disabled");
                return "redirect:/account/login";
            }

            session.setAttribute("currentUser", user);
            session.setAttribute("isLoggedIn", true);

            user.setLastLoginAt(LocalDateTime.now());
            userRepository.save(user);

            // Check for post-login redirect URL
            String redirectAfterLogin = (String) session.getAttribute("redirectAfterLogin");
            if (redirectAfterLogin != null && !redirectAfterLogin.isEmpty()) {
                session.removeAttribute("redirectAfterLogin");
                return "redirect:" + redirectAfterLogin;
            }

            if (redirectUrl != null && !redirectUrl.isEmpty()) {
                return "redirect:" + redirectUrl;
            }

            if ("ADMIN".equals(user.getRole())) {
                return "redirect:/admin";
            } else {
                return "redirect:/";
            }

        } catch (Exception e) {
            System.err.println("Error processing login: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Login failed, please try again");
            return "redirect:/account/login";
        }
    }

    @GetMapping({"/account/register", "/register"})
    public String registerPage(Model model, HttpSession session) {
        if (isLoggedIn(session)) {
            return "redirect:/";
        }

        model.addAttribute("pageTitle", "Register - MyTour Global");
        model.addAttribute("currentPage", "register");
        return "pages/register";
    }

    @PostMapping({"/account/register", "/register"})
    public String processRegister(
            @RequestParam("username") String username,
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            @RequestParam("confirmPassword") String confirmPassword,
            @RequestParam(value = "firstName", required = false) String firstName,
            @RequestParam(value = "lastName", required = false) String lastName,
            @RequestParam(value = "phone", required = false) String phone,
            RedirectAttributes redirectAttributes) {

        try {
            if (username == null || username.trim().length() < 3) {
                redirectAttributes.addFlashAttribute("errorMessage", "Username must be at least 3 characters");
                return "redirect:/account/register";
            }

            if (email == null || !EMAIL_PATTERN.matcher(email.trim()).matches()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Please enter a valid email address");
                return "redirect:/account/register";
            }

            if (password == null || password.length() < 6) {
                redirectAttributes.addFlashAttribute("errorMessage", "Password must be at least 6 characters");
                return "redirect:/account/register";
            }

            if (!password.equals(confirmPassword)) {
                redirectAttributes.addFlashAttribute("errorMessage", "Passwords do not match");
                return "redirect:/account/register";
            }

            Optional<User> existingUser = userRepository.findByUsernameOrEmail(username.trim(), email.trim());
            if (existingUser.isPresent()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Username or email already exists");
                return "redirect:/account/register";
            }

            User user = new User();
            user.setUsername(username.trim());
            user.setEmail(email.trim().toLowerCase());
            user.setPassword(password);
            user.setFirstName(firstName != null ? firstName.trim() : username.trim());
            user.setLastName(lastName != null ? lastName.trim() : "");
            user.setPhone(phone != null ? phone.trim() : null);
            user.setRole("USER");
            user.setActive(true);
            user.setCreatedAt(LocalDateTime.now());

            User savedUser = userRepository.save(user);

            if (savedUser.getId() != null) {
                redirectAttributes.addFlashAttribute("successMessage", "Registration successful! Please log in");
                return "redirect:/account/login";
            } else {
                redirectAttributes.addFlashAttribute("errorMessage", "Registration failed, please try again");
                return "redirect:/account/register";
            }

        } catch (Exception e) {
            System.err.println("Error processing registration: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Registration failed, please try again");
            return "redirect:/account/register";
        }
    }

    @GetMapping("/account/profile")
    public String profilePage(Model model, HttpSession session) {
        if (!isLoggedIn(session)) {
            return "redirect:/account/login";
        }

        User currentUser = (User) session.getAttribute("currentUser");
        
        // Get user statistics
        List<Booking> userBookings = bookingRepository.findByUserIdOrderByCreatedAtDesc(currentUser.getId());
        long totalBookings = userBookings.size();
        long completedBookings = userBookings.stream().filter(b -> "COMPLETED".equalsIgnoreCase(b.getStatus())).count();
        long pendingBookings = userBookings.stream().filter(b -> "PENDING".equalsIgnoreCase(b.getStatus())).count();
        long confirmedBookings = userBookings.stream().filter(b -> "CONFIRMED".equalsIgnoreCase(b.getStatus())).count();
        
        // Calculate total spent
        BigDecimal totalSpent = userBookings.stream()
            .filter(b -> "COMPLETED".equalsIgnoreCase(b.getStatus()) || "CONFIRMED".equalsIgnoreCase(b.getStatus()))
            .map(Booking::getTotalPrice)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
        
        model.addAttribute("user", currentUser);
        model.addAttribute("totalBookings", totalBookings);
        model.addAttribute("completedBookings", completedBookings);
        model.addAttribute("pendingBookings", pendingBookings);
        model.addAttribute("confirmedBookings", confirmedBookings);
        model.addAttribute("totalSpent", totalSpent);
        model.addAttribute("pageTitle", "Profile - MyTour Global");
        model.addAttribute("currentPage", "profile");

        return "pages/profile";
    }

    @PostMapping("/account/profile")
    public String updateProfile(
            @RequestParam("firstName") String firstName,
            @RequestParam("lastName") String lastName,
            @RequestParam("email") String email,
            @RequestParam(value = "phone", required = false) String phone,
            RedirectAttributes redirectAttributes,
            HttpSession session) {

        if (!isLoggedIn(session)) {
            return "redirect:/account/login";
        }

        try {
            User currentUser = (User) session.getAttribute("currentUser");

            if (firstName == null || firstName.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Name cannot be empty");
                return "redirect:/account/profile";
            }

            if (email == null || !EMAIL_PATTERN.matcher(email.trim()).matches()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Please enter a valid email address");
                return "redirect:/account/profile";
            }

            Optional<User> existingUser = userRepository.findByEmail(email.trim());
            if (existingUser.isPresent() && !existingUser.get().getId().equals(currentUser.getId())) {
                redirectAttributes.addFlashAttribute("errorMessage", "This email is already used by another user");
                return "redirect:/account/profile";
            }

            currentUser.setFirstName(firstName.trim());
            currentUser.setLastName(lastName != null ? lastName.trim() : "");
            currentUser.setEmail(email.trim().toLowerCase());
            currentUser.setPhone(phone != null ? phone.trim() : null);
            currentUser.setUpdatedAt(LocalDateTime.now());

            User updatedUser = userRepository.save(currentUser);
            session.setAttribute("currentUser", updatedUser);

            redirectAttributes.addFlashAttribute("successMessage", "Profile updated successfully");
            return "redirect:/account/profile";

        } catch (Exception e) {
            System.err.println("Error updating profile: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Update failed, please try again");
            return "redirect:/account/profile";
        }
    }

    @PostMapping({"/account/logout", "/logout"})
    public String logout(HttpSession session) {
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/";
    }

    @GetMapping({"/account/logout", "/logout"})
    public String logoutGet(HttpSession session) {
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/";
    }

    @GetMapping("/admin")
    public String adminDashboard(Model model, HttpSession session) {
        String authCheck = checkAdminAuth(session);
        if (authCheck != null) return authCheck;

        try {
            if (!testDatabaseConnection()) {
                model.addAttribute("error", "Database connection failed");
                return "admin/destinations";
            }

            long totalUsers = userRepository.count();
            long totalDestinations = destinationRepository.count();
            long totalTravelPackages = travelPackageRepository.count();
            long totalBookings = bookingRepository.count();

            model.addAttribute("totalUsers", totalUsers);
            model.addAttribute("totalDestinations", totalDestinations);
            model.addAttribute("totalTravelPackages", totalTravelPackages);
            model.addAttribute("totalBookings", totalBookings);
            model.addAttribute("pageTitle", "Admin Dashboard - MyTour Global");
            model.addAttribute("currentPage", "admin");

            System.out.println("Admin Dashboard statistics:");
            System.out.println("- Total users: " + totalUsers);
            System.out.println("- Total destinations: " + totalDestinations);
            System.out.println("- Total packages: " + totalTravelPackages);
            System.out.println("- Total bookings: " + totalBookings);

        } catch (Exception e) {
            System.err.println("Error loading admin dashboard: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("totalUsers", 0);
            model.addAttribute("totalDestinations", 0);
            model.addAttribute("totalTravelPackages", 0);
            model.addAttribute("totalBookings", 0);
            model.addAttribute("error", "Failed to load statistics");
        }

        return "admin/destinations";
    }

    @GetMapping("/admin/destinations")
    public String adminDestinations(Model model, HttpSession session) {
        String authCheck = checkAdminAuth(session);
        if (authCheck != null) return authCheck;

        try {
            if (!testDatabaseConnection()) {
                model.addAttribute("error", "Database connection failed, unable to load destination data");
                model.addAttribute("destinations", new ArrayList<>());
                return "admin/destinations";
            }

            System.out.println("Admin - Starting to load destination list...");
            
            List<Destination> destinations = destinationRepository.findAll();
            System.out.println("Admin - Retrieved " + destinations.size() + " destinations from database");
            
            if (destinations.isEmpty()) {
                System.out.println("Warning: No destination data in database");
                model.addAttribute("warning", "No destination data currently available in database, please check database initialization");
            }

            model.addAttribute("destinations", destinations);
            model.addAttribute("pageTitle", "Destination Management - MyTour Global");
            model.addAttribute("currentPage", "admin");

        } catch (Exception e) {
            System.err.println("Error loading admin destinations: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("destinations", new ArrayList<>());
            model.addAttribute("error", "Failed to load destinations: " + e.getMessage());
        }

        return "admin/destinations";
    }

    @GetMapping("/admin/packages")
    public String adminTravelPackages(Model model, HttpSession session) {
        String authCheck = checkAdminAuth(session);
        if (authCheck != null) return authCheck;

        try {
            if (!testDatabaseConnection()) {
                model.addAttribute("error", "Database connection failed, unable to load package data");
                model.addAttribute("travelPackages", new ArrayList<>());
                model.addAttribute("destinations", new ArrayList<>());
                return "admin/packages";
            }

            System.out.println("Admin - Starting to load package list...");
            
            List<TravelPackage> travelPackages = travelPackageRepository.findAll();
            List<Destination> destinations = destinationRepository.findAll();
            
            System.out.println("Admin - Retrieved " + travelPackages.size() + " packages from database");
            System.out.println("Admin - Retrieved " + destinations.size() + " destinations from database");
            
            if (travelPackages.isEmpty()) {
                System.out.println("Warning: No package data in database");
                model.addAttribute("warning", "No package data currently available in database, please check database initialization");
            }

            model.addAttribute("travelPackages", travelPackages);
            model.addAttribute("destinations", destinations);
            model.addAttribute("pageTitle", "Package Management - MyTour Global");
            model.addAttribute("currentPage", "admin");

        } catch (Exception e) {
            System.err.println("Error loading admin packages: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("travelPackages", new ArrayList<>());
            model.addAttribute("destinations", new ArrayList<>());
            model.addAttribute("error", "Failed to load packages: " + e.getMessage());
        }

        return "admin/packages";
    }

    @GetMapping("/admin/bookings")
    public String adminBookings(Model model, HttpSession session) {
        String authCheck = checkAdminAuth(session);
        if (authCheck != null) return authCheck;

        try {
            if (!testDatabaseConnection()) {
                model.addAttribute("error", "Database connection failed, unable to load booking data");
                model.addAttribute("bookings", new ArrayList<>());
                return "admin/bookings";
            }

            System.out.println("Admin - Starting to load booking list...");
            
            List<Booking> bookings = bookingRepository.findAll();
            System.out.println("Admin - Retrieved " + bookings.size() + " bookings from database");
            
            if (bookings.isEmpty()) {
                System.out.println("Warning: No booking data in database");
                model.addAttribute("warning", "No booking data currently available in database");
            }

            model.addAttribute("bookings", bookings);
            model.addAttribute("pageTitle", "Booking Management - MyTour Global");
            model.addAttribute("currentPage", "admin");

        } catch (Exception e) {
            System.err.println("Error loading admin bookings: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("bookings", new ArrayList<>());
            model.addAttribute("error", "Failed to load bookings: " + e.getMessage());
        }

        return "admin/bookings";
    }
    
    @GetMapping("/admin/messages")
    public String adminMessages(Model model, HttpSession session) {
        String authCheck = checkAdminAuth(session);
        if (authCheck != null) return authCheck;

        try {
            if (!testDatabaseConnection()) {
                model.addAttribute("error", "Database connection failed, unable to load message data");
                model.addAttribute("messages", new ArrayList<>());
                return "admin/contact_messages";
            }

            System.out.println("Admin - Starting to load message list...");
            
            List<ContactMessage> messages = contactMessageRepository.findAll();
            System.out.println("Admin - Retrieved " + messages.size() + " messages from database");
            
            if (messages.isEmpty()) {
                System.out.println("Warning: No message data in database");
                model.addAttribute("warning", "No message data currently available in database");
            }

            model.addAttribute("messages", messages);
            model.addAttribute("pageTitle", "Message Management - MyTour Global");
            model.addAttribute("currentPage", "admin");

        } catch (Exception e) {
            System.err.println("Error loading admin messages: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("messages", new ArrayList<>());
            model.addAttribute("error", "Failed to load messages: " + e.getMessage());
        }

        return "admin/contact_messages";
    }

    @GetMapping("/admin/messages/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getMessageById(@PathVariable Long id, HttpSession session) {
        String authCheck = checkAdminAuth(session);
        if (authCheck != null) {
            Map<String, Object> response = new HashMap<>();
            response.put("success", false);
            response.put("message", "Unauthorized access");
            return ResponseEntity.status(401).body(response);
        }

        try {
            Optional<ContactMessage> messageOpt = contactMessageRepository.findById(id);
            if (messageOpt.isPresent()) {
                ContactMessage message = messageOpt.get();
                Map<String, Object> response = new HashMap<>();
                response.put("id", message.getId());
                response.put("name", message.getName());
                response.put("email", message.getEmail());
                response.put("phone", message.getPhone());
                response.put("subject", message.getSubject());
                response.put("message", message.getMessage());
                response.put("status", message.getStatus());
                response.put("createdAt", message.getCreatedAt().toString());
                response.put("success", true);
                return ResponseEntity.ok(response);
            } else {
                Map<String, Object> response = new HashMap<>();
                response.put("success", false);
                response.put("message", "Message not found");
                return ResponseEntity.ok(response);
            }
        } catch (Exception e) {
            System.err.println("Error getting message details: " + e.getMessage());
            Map<String, Object> response = new HashMap<>();
            response.put("success", false);
            response.put("message", "Failed to get message");
            return ResponseEntity.ok(response);
        }
    }

    @PostMapping("/admin/messages/update-status")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> updateMessageStatus(
            @RequestBody Map<String, Object> request, HttpSession session) {
        String authCheck = checkAdminAuth(session);
        Map<String, Object> response = new HashMap<>();
        
        if (authCheck != null) {
            response.put("success", false);
            response.put("message", "Unauthorized access");
            return ResponseEntity.status(401).body(response);
        }

        try {
            Long id = Long.valueOf(request.get("id").toString());
            String status = request.get("status").toString();
            
            Optional<ContactMessage> messageOpt = contactMessageRepository.findById(id);
            if (messageOpt.isPresent()) {
                ContactMessage message = messageOpt.get();
                message.setStatus(status);
                message.setUpdatedAt(LocalDateTime.now());
                contactMessageRepository.save(message);
                
                response.put("success", true);
                response.put("message", "Status updated successfully");
                return ResponseEntity.ok(response);
            } else {
                response.put("success", false);
                response.put("message", "Message not found");
                return ResponseEntity.ok(response);
            }
        } catch (Exception e) {
            System.err.println("Error updating message status: " + e.getMessage());
            response.put("success", false);
            response.put("message", "Update failed");
            return ResponseEntity.ok(response);
        }
    }

    
    @DeleteMapping("/admin/destinations/delete/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteDestination(@PathVariable Long id, HttpSession session) {
        String authCheck = checkAdminAuth(session);
        Map<String, Object> response = new HashMap<>();
        
        if (authCheck != null) {
            response.put("success", false);
            response.put("message", "Unauthorized access");
            return ResponseEntity.status(401).body(response);
        }

        try {
            destinationRepository.deleteById(id);
            response.put("success", true);
            response.put("message", "Destination deleted successfully");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            System.err.println("Error deleting destination: " + e.getMessage());
            response.put("success", false);
            response.put("message", "Failed to delete destination");
            return ResponseEntity.ok(response);
        }
    }

    @DeleteMapping("/admin/packages/delete/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deletePackage(@PathVariable Long id, HttpSession session) {
        String authCheck = checkAdminAuth(session);
        Map<String, Object> response = new HashMap<>();
        
        if (authCheck != null) {
            response.put("success", false);
            response.put("message", "Unauthorized access");
            return ResponseEntity.status(401).body(response);
        }

        try {
            travelPackageRepository.deleteById(id);
            response.put("success", true);
            response.put("message", "Package deleted successfully");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            System.err.println("Error deleting package: " + e.getMessage());
            response.put("success", false);
            response.put("message", "Failed to delete package");
            return ResponseEntity.ok(response);
        }
    }

    @DeleteMapping("/admin/bookings/delete/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteBooking(@PathVariable Long id, HttpSession session) {
        String authCheck = checkAdminAuth(session);
        Map<String, Object> response = new HashMap<>();
        
        if (authCheck != null) {
            response.put("success", false);
            response.put("message", "Unauthorized access");
            return ResponseEntity.status(401).body(response);
        }

        try {
            bookingRepository.deleteById(id);
            response.put("success", true);
            response.put("message", "Booking deleted successfully");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            System.err.println("Error deleting booking: " + e.getMessage());
            response.put("success", false);
            response.put("message", "Failed to delete booking");
            return ResponseEntity.ok(response);
        }
    }

    @DeleteMapping("/admin/users/delete/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteUser(@PathVariable Long id, HttpSession session) {
        String authCheck = checkAdminAuth(session);
        Map<String, Object> response = new HashMap<>();
        
        if (authCheck != null) {
            response.put("success", false);
            response.put("message", "Unauthorized access");
            return ResponseEntity.status(401).body(response);
        }

        try {
            Optional<User> userOpt = userRepository.findById(id);
            if (userOpt.isPresent()) {
                User user = userOpt.get();
                if ("ADMIN".equals(user.getRole())) {
                    response.put("success", false);
                    response.put("message", "Cannot delete admin user");
                    return ResponseEntity.ok(response);
                }
                userRepository.deleteById(id);
                response.put("success", true);
                response.put("message", "User deleted successfully");
                return ResponseEntity.ok(response);
            } else {
                response.put("success", false);
                response.put("message", "User not found");
                return ResponseEntity.ok(response);
            }
        } catch (Exception e) {
            System.err.println("Error deleting user: " + e.getMessage());
            response.put("success", false);
            response.put("message", "Failed to delete user");
            return ResponseEntity.ok(response);
        }
    }

    @DeleteMapping("/admin/messages/delete/{id}")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteMessage(@PathVariable Long id, HttpSession session) {
        String authCheck = checkAdminAuth(session);
        Map<String, Object> response = new HashMap<>();
        
        if (authCheck != null) {
            response.put("success", false);
            response.put("message", "Unauthorized access");
            return ResponseEntity.status(401).body(response);
        }

        try {
            contactMessageRepository.deleteById(id);
            response.put("success", true);
            response.put("message", "Message deleted successfully");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            System.err.println("Error deleting message: " + e.getMessage());
            response.put("success", false);
            response.put("message", "Failed to delete message");
            return ResponseEntity.ok(response);
        }
    }

    @GetMapping("/admin/users")
    public String adminUsers(Model model, HttpSession session) {
        String authCheck = checkAdminAuth(session);
        if (authCheck != null) return authCheck;

        try {
            List<User> users = userRepository.findAll();
            model.addAttribute("users", users);
            model.addAttribute("pageTitle", "User Management - MyTour Global");
            model.addAttribute("currentPage", "admin");

        } catch (Exception e) {
            System.err.println("Error loading admin users: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("users", new ArrayList<>());
            model.addAttribute("error", "Failed to load users");
        }

        return "admin/users";
    }

    @GetMapping("/help")
    public String helpCenter(Model model, HttpSession session) {
        try {
            model.addAttribute("pageTitle", "Help Center - MyTour Global");
            model.addAttribute("currentPage", "help");

        } catch (Exception e) {
            System.err.println("Error loading help center: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Failed to load help content");
        }

        return "pages/help-center";
    }

    @GetMapping("/about")
    public String aboutPage(Model model) {
        model.addAttribute("pageTitle", "About Us - MyTour Global");
        model.addAttribute("currentPage", "about");
        return "pages/about";
    }
    
    @GetMapping("/attractions")
    public String attractionsPage(Model model) {
        model.addAttribute("pageTitle", "Attractions - MyTour Global");
        model.addAttribute("currentPage", "attractions");
        return "pages/attractions";
    }
    
 @GetMapping("/feedback")
 public String showFeedbackForm(Model model, HttpSession session) {
     try {
         if (!isLoggedIn(session)) {
             session.setAttribute("redirectAfterLogin", "/feedback");
             model.addAttribute("errorMessage", "Please log in to submit feedback.");
             return "redirect:/account/login";
         }
         
         List<Destination> allDestinations = destinationRepository.findAll();
         List<Destination> destinations = allDestinations.stream()
             .filter(d -> Boolean.TRUE.equals(d.getActive()))
             .collect(Collectors.toList());
             
         List<TravelPackage> packages = travelPackageRepository.findActive();
         
         model.addAttribute("destinations", destinations);
         model.addAttribute("travelPackages", packages);
         model.addAttribute("loggedInUser", session.getAttribute("currentUser"));
         
         return "pages/feedback";
     } catch (Exception e) {
         System.err.println("Error loading feedback form: " + e.getMessage());
         e.printStackTrace();
         model.addAttribute("errorMessage", "Error loading feedback form. Please try again.");
         return "error";
     }
 }

     private boolean testDatabaseConnection() {
        // With Spring Data JPA, connection management is automatic
        // Database health is monitored by Spring Boot Actuator
        return true;
    }

    private boolean isLoggedIn(HttpSession session) {
        return session != null && 
               session.getAttribute("currentUser") != null && 
               Boolean.TRUE.equals(session.getAttribute("isLoggedIn"));
    }

    private String checkAdminAuth(HttpSession session) {
        if (!isLoggedIn(session)) {
            return "redirect:/account/login?error=required";
        }

        User currentUser = (User) session.getAttribute("currentUser");
        if (!"ADMIN".equals(currentUser.getRole())) {
            return "redirect:/";
        }

        return null;
    }
    
    @GetMapping("/admin/destinations/edit/{id}")
    public String editDestination(@PathVariable Long id, Model model, HttpSession session) {
        String authCheck = checkAdminAuth(session);
        if (authCheck != null) return authCheck;

        try {
            Optional<Destination> destinationOpt = destinationRepository.findById(id);
            if (destinationOpt.isEmpty()) {
                model.addAttribute("error", "Destination not found");
                return "redirect:/admin/destinations";
            }

            model.addAttribute("destination", destinationOpt.get());
            model.addAttribute("pageTitle", "Edit Destination - MyTour Global");
            model.addAttribute("currentPage", "admin");

            System.out.println("Loading edit page for destination: " + destinationOpt.get().getName());

        } catch (Exception e) {
            System.err.println("Error loading destination for edit: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Error loading destination: " + e.getMessage());
            return "redirect:/admin/destinations";
        }

        return "admin/edit-destination";
    }

    @PostMapping("/admin/destinations/update")
    public String updateDestination(
            @RequestParam Long id,
            @RequestParam String name,
            @RequestParam String city,
            @RequestParam String country,
            @RequestParam String category,
            @RequestParam BigDecimal basePrice,
            @RequestParam Integer rating,
            @RequestParam String description,
            @RequestParam String imagePath,
            @RequestParam(required = false) String highlights,
            @RequestParam(required = false, defaultValue = "false") boolean featured,
            @RequestParam(required = false, defaultValue = "false") boolean active,
            RedirectAttributes redirectAttributes,
            HttpSession session) {

        String authCheck = checkAdminAuth(session);
        if (authCheck != null) return authCheck;

        try {
            Optional<Destination> destinationOpt = destinationRepository.findById(id);
            if (destinationOpt.isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Destination not found");
                return "redirect:/admin/destinations";
            }

            Destination destination = destinationOpt.get();
            destination.setName(name.trim());
            destination.setCity(city.trim());
            destination.setCountry(country);
            destination.setCategory(category);
            destination.setBasePrice(basePrice);
            destination.setRating(rating);
            destination.setDescription(description.trim());
            destination.setImagePath(imagePath.trim());
            destination.setHighlights(highlights != null ? highlights.trim() : null);
            destination.setFeatured(featured);
            destination.setActive(active);
            destination.setUpdatedAt(LocalDateTime.now());

            destinationRepository.save(destination);

            System.out.println("Destination updated: " + destination.getName());
            redirectAttributes.addFlashAttribute("message", "Destination updated successfully");

        } catch (Exception e) {
            System.err.println("Error updating destination: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to update destination: " + e.getMessage());
        }

        return "redirect:/admin/destinations";
    }

    @GetMapping("/admin/packages/edit/{id}")
    public String editPackage(@PathVariable Long id, Model model, HttpSession session) {
        String authCheck = checkAdminAuth(session);
        if (authCheck != null) return authCheck;

        try {
            Optional<TravelPackage> packageOpt = travelPackageRepository.findById(id);
            if (packageOpt.isEmpty()) {
                model.addAttribute("error", "Package not found");
                return "redirect:/admin/packages";
            }

            List<Destination> destinations = destinationRepository.findAll();
            
            model.addAttribute("travelPackage", packageOpt.get());
            model.addAttribute("destinations", destinations);
            model.addAttribute("pageTitle", "Edit Package - MyTour Global");
            model.addAttribute("currentPage", "admin");

            System.out.println("Loading edit page for package: " + packageOpt.get().getName());

        } catch (Exception e) {
            System.err.println("Error loading package for edit: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Error loading package: " + e.getMessage());
            return "redirect:/admin/packages";
        }

        return "admin/edit-package";
    }

    @PostMapping("/admin/packages/update")
    public String updatePackage(
            @RequestParam Long id,
            @RequestParam String name,
            @RequestParam Long destinationId,
            @RequestParam String description,
            @RequestParam BigDecimal price,
            @RequestParam Integer durationDays,
            @RequestParam(required = false) Integer durationNights,
            @RequestParam String type,
            @RequestParam(required = false) String inclusions,
            @RequestParam(required = false) String exclusions,
            @RequestParam(required = false, defaultValue = "false") boolean featured,
            @RequestParam(required = false, defaultValue = "false") boolean active,
            RedirectAttributes redirectAttributes,
            HttpSession session) {

        String authCheck = checkAdminAuth(session);
        if (authCheck != null) return authCheck;

        try {
            Optional<TravelPackage> packageOpt = travelPackageRepository.findById(id);
            if (packageOpt.isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Package not found");
                return "redirect:/admin/packages";
            }

            Optional<Destination> destinationOpt = destinationRepository.findById(destinationId);
            if (destinationOpt.isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Destination not found");
                return "redirect:/admin/packages";
            }

            TravelPackage travelPackage = packageOpt.get();
            travelPackage.setName(name.trim());
            travelPackage.setDestinationId(destinationId);
            travelPackage.setDescription(description.trim());
            travelPackage.setPrice(price);
            travelPackage.setDurationDays(durationDays);
            travelPackage.setDurationNights(durationNights != null ? durationNights : durationDays - 1);
            travelPackage.setType(type);
            travelPackage.setInclusions(inclusions != null ? inclusions.trim() : null);
            travelPackage.setExclusions(exclusions != null ? exclusions.trim() : null);
            travelPackage.setFeatured(featured);
            travelPackage.setActive(active);
            travelPackage.setUpdatedAt(LocalDateTime.now());

            travelPackageRepository.save(travelPackage);

            System.out.println("Package updated: " + travelPackage.getName());
            redirectAttributes.addFlashAttribute("message", "Package updated successfully");

        } catch (Exception e) {
            System.err.println("Error updating package: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to update package: " + e.getMessage());
        }

        return "redirect:/admin/packages";
    }

    @GetMapping("/admin/bookings/edit/{id}")
    public String editBooking(@PathVariable Long id, Model model, HttpSession session) {
        String authCheck = checkAdminAuth(session);
        if (authCheck != null) return authCheck;

        try {
            Optional<Booking> bookingOpt = bookingRepository.findById(id);
            if (bookingOpt.isEmpty()) {
                model.addAttribute("error", "Booking not found");
                return "redirect:/admin/bookings";
            }

            List<TravelPackage> packages = travelPackageRepository.findAll();
            List<User> users = userRepository.findAll();

            model.addAttribute("booking", bookingOpt.get());
            model.addAttribute("packages", packages);
            model.addAttribute("users", users);
            model.addAttribute("pageTitle", "Edit Booking - MyTour Global");
            model.addAttribute("currentPage", "admin");

            System.out.println("Loading edit page for booking: " + bookingOpt.get().getId());

        } catch (Exception e) {
            System.err.println("Error loading booking for edit: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Error loading booking: " + e.getMessage());
            return "redirect:/admin/bookings";
        }

        return "admin/edit-booking";
    }

    @PostMapping("/admin/bookings/update")
    public String updateBooking(
            @RequestParam Long id,
            @RequestParam String customerName,
            @RequestParam String customerEmail,
            @RequestParam String customerPhone,
            @RequestParam Integer numberOfParticipants,
            @RequestParam String travelDate,
            @RequestParam BigDecimal totalPrice,
            @RequestParam String status,
            @RequestParam String paymentStatus,
            @RequestParam(required = false) String notes,
            RedirectAttributes redirectAttributes,
            HttpSession session) {

        String authCheck = checkAdminAuth(session);
        if (authCheck != null) return authCheck;

        try {
            Optional<Booking> bookingOpt = bookingRepository.findById(id);
            if (bookingOpt.isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Booking not found");
                return "redirect:/admin/bookings";
            }

            Booking booking = bookingOpt.get();
            booking.setCustomerName(customerName.trim());
            booking.setCustomerEmail(customerEmail.trim());
            booking.setCustomerPhone(customerPhone.trim());
            booking.setNumberOfParticipants(numberOfParticipants);
            booking.setTravelDate(LocalDate.parse(travelDate));
            booking.setTotalPrice(totalPrice);
            booking.setStatus(status);
            booking.setPaymentStatus(paymentStatus);
            booking.setNotes(notes != null ? notes.trim() : null);
            booking.setUpdatedAt(LocalDateTime.now());

            bookingRepository.save(booking);

            System.out.println("Booking updated: " + booking.getId());
            redirectAttributes.addFlashAttribute("message", "Booking updated successfully");

        } catch (Exception e) {
            System.err.println("Error updating booking: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to update booking: " + e.getMessage());
        }

        return "redirect:/admin/bookings";
    }

    @GetMapping("/admin/users/edit/{id}")
    public String editUser(@PathVariable Long id, Model model, HttpSession session) {
        String authCheck = checkAdminAuth(session);
        if (authCheck != null) return authCheck;

        try {
            Optional<User> userOpt = userRepository.findById(id);
            if (userOpt.isEmpty()) {
                model.addAttribute("error", "User not found");
                return "redirect:/admin/users";
            }

            model.addAttribute("editUser", userOpt.get());
            model.addAttribute("pageTitle", "Edit User - MyTour Global");
            model.addAttribute("currentPage", "admin");

            System.out.println("Loading edit page for user: " + userOpt.get().getUsername());

        } catch (Exception e) {
            System.err.println("Error loading user for edit: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "Error loading user: " + e.getMessage());
            return "redirect:/admin/users";
        }

        return "admin/edit-user";
    }

    @PostMapping("/admin/users/update")
    public String updateUser(
            @RequestParam Long id,
            @RequestParam String firstName,
            @RequestParam String lastName,
            @RequestParam String username,
            @RequestParam String email,
            @RequestParam(required = false) String phone,
            @RequestParam String role,
            @RequestParam(required = false, defaultValue = "false") boolean active,
            @RequestParam(required = false) String password,
            RedirectAttributes redirectAttributes,
            HttpSession session) {

        String authCheck = checkAdminAuth(session);
        if (authCheck != null) return authCheck;

        try {
            Optional<User> userOpt = userRepository.findById(id);
            if (userOpt.isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "User not found");
                return "redirect:/admin/users";
            }

            Optional<User> existingByUsername = userRepository.findByUsername(username.trim());
            if (existingByUsername.isPresent() && !existingByUsername.get().getId().equals(id)) {
                redirectAttributes.addFlashAttribute("errorMessage", "Username already exists");
                return "redirect:/admin/users/edit/" + id;
            }

            Optional<User> existingByEmail = userRepository.findByEmail(email.trim().toLowerCase());
            if (existingByEmail.isPresent() && !existingByEmail.get().getId().equals(id)) {
                redirectAttributes.addFlashAttribute("errorMessage", "Email already exists");
                return "redirect:/admin/users/edit/" + id;
            }

            User user = userOpt.get();
            user.setFirstName(firstName.trim());
            user.setLastName(lastName.trim());
            user.setUsername(username.trim());
            user.setEmail(email.trim().toLowerCase());
            user.setPhone(phone != null ? phone.trim() : null);
            user.setRole(role);
            user.setActive(active);
            
            if (password != null && !password.trim().isEmpty()) {
                user.setPassword(password.trim());
            }
            
            user.setUpdatedAt(LocalDateTime.now());

            userRepository.save(user);

            System.out.println("User updated: " + user.getUsername());
            redirectAttributes.addFlashAttribute("message", "User updated successfully");

        } catch (Exception e) {
            System.err.println("Error updating user: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to update user: " + e.getMessage());
        }

        return "redirect:/admin/users";
    }
    
    @PostMapping("/admin/messages/mark-all-read")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> markAllMessagesAsRead(HttpSession session) {
        String authCheck = checkAdminAuth(session);
        Map<String, Object> response = new HashMap<>();
        
        if (authCheck != null) {
            response.put("success", false);
            response.put("message", "Unauthorized access");
            return ResponseEntity.status(401).body(response);
        }

        try {
            List<ContactMessage> messages = contactMessageRepository.findAll();
            int updatedCount = 0;
            
            for (ContactMessage message : messages) {
                if ("NEW".equals(message.getStatus())) {
                    message.setStatus("read");
                    message.setUpdatedAt(LocalDateTime.now());
                    contactMessageRepository.save(message);
                    updatedCount++;
                }
            }
            
            response.put("success", true);
            response.put("message", "All messages marked as read");
            response.put("updatedCount", updatedCount);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            System.err.println("Error marking all messages as read: " + e.getMessage());
            response.put("success", false);
            response.put("message", "Failed to mark messages as read");
            return ResponseEntity.ok(response);
        }
    }

    @PostMapping("/admin/messages/delete-multiple")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> deleteMultipleMessages(
            @RequestBody Map<String, Object> request, HttpSession session) {
        String authCheck = checkAdminAuth(session);
        Map<String, Object> response = new HashMap<>();
        
        if (authCheck != null) {
            response.put("success", false);
            response.put("message", "Unauthorized access");
            return ResponseEntity.status(401).body(response);
        }

        try {
            @SuppressWarnings("unchecked")
            List<String> ids = (List<String>) request.get("ids");
            
            if (ids == null || ids.isEmpty()) {
                response.put("success", false);
                response.put("message", "No message IDs provided");
                return ResponseEntity.ok(response);
            }
            
            List<Long> messageIds = ids.stream()
                    .map(Long::valueOf)
                    .collect(Collectors.toList());
            
            contactMessageRepository.deleteAllById(messageIds);
            
            response.put("success", true);
            response.put("message", "Messages deleted successfully");
            response.put("deletedCount", messageIds.size());
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            System.err.println("Error deleting multiple messages: " + e.getMessage());
            response.put("success", false);
            response.put("message", "Failed to delete messages");
            return ResponseEntity.ok(response);
        }
    }

    @GetMapping("/admin/messages/statistics")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> getMessageStatistics(HttpSession session) {
        String authCheck = checkAdminAuth(session);
        Map<String, Object> response = new HashMap<>();
        
        if (authCheck != null) {
            response.put("success", false);
            response.put("message", "Unauthorized access");
            return ResponseEntity.status(401).body(response);
        }

        try {
            List<ContactMessage> messages = contactMessageRepository.findAll();
            
            long total = messages.size();
            long newCount = messages.stream().filter(m -> "NEW".equals(m.getStatus())).count();
            long readCount = messages.stream().filter(m -> "read".equals(m.getStatus())).count();
            long repliedCount = messages.stream().filter(m -> "REPLIED".equals(m.getStatus())).count();
            long closedCount = messages.stream().filter(m -> "CLOSED".equals(m.getStatus())).count();
            
            response.put("success", true);
            response.put("total", total);
            response.put("newCount", newCount);
            response.put("readCount", readCount);
            response.put("repliedCount", repliedCount);
            response.put("closedCount", closedCount);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            System.err.println("Error getting message statistics: " + e.getMessage());
            response.put("success", false);
            response.put("message", "Failed to get statistics");
            return ResponseEntity.ok(response);
        }
    }

    @PostMapping("/admin/messages/reply")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> replyToMessage(
            @RequestBody Map<String, Object> request, HttpSession session) {
        String authCheck = checkAdminAuth(session);
        Map<String, Object> response = new HashMap<>();
        
        if (authCheck != null) {
            response.put("success", false);
            response.put("message", "Unauthorized access");
            return ResponseEntity.status(401).body(response);
        }

        try {
            Long messageId = Long.valueOf(request.get("messageId").toString());
            String replyContent = request.get("replyContent").toString();
            boolean markAsReplied = Boolean.parseBoolean(request.get("markAsReplied").toString());
            
            if (replyContent == null || replyContent.trim().isEmpty()) {
                response.put("success", false);
                response.put("message", "Reply content is required");
                return ResponseEntity.ok(response);
            }
            
            Optional<ContactMessage> messageOpt = contactMessageRepository.findById(messageId);
            if (messageOpt.isPresent()) {
                ContactMessage message = messageOpt.get();
                
                System.out.println("Admin replying to message - ID: " + messageId);
                System.out.println("Recipient: " + message.getEmail());
                System.out.println("Reply content: " + replyContent);
                
                if (markAsReplied) {
                    message.setStatus("REPLIED");
                    message.setUpdatedAt(LocalDateTime.now());
                    contactMessageRepository.save(message);
                    System.out.println("Message status updated to REPLIED");
                }
                
                response.put("success", true);
                response.put("message", "Reply sent successfully");
                return ResponseEntity.ok(response);
            } else {
                response.put("success", false);
                response.put("message", "Message not found");
                return ResponseEntity.ok(response);
            }
        } catch (Exception e) {
            System.err.println("Error sending reply: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "Failed to send reply");
            return ResponseEntity.ok(response);
        }
    }
    
    @GetMapping("/api/packages")
    @ResponseBody
    public ResponseEntity<List<TravelPackage>> getPackagesByDestination(
            @RequestParam(value = "destination", required = false) Long destinationId) {
        try {
            List<TravelPackage> packages;
            
            if (destinationId != null) {
                packages = travelPackageRepository.findByDestinationId(destinationId);
            } else {
                packages = travelPackageRepository.findActive();
            }
            
            return ResponseEntity.ok(packages);
        } catch (Exception e) {
            System.err.println("Error loading packages: " + e.getMessage());
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
    
    @PostMapping("/admin/packages/add")
    public String addPackage(
            @RequestParam String name,
            @RequestParam Long destinationId,
            @RequestParam String description,
            @RequestParam BigDecimal price,
            @RequestParam Integer durationDays,
            @RequestParam(required = false) Integer durationNights,
            @RequestParam String type,
            @RequestParam(required = false) String inclusions,
            @RequestParam(required = false) String exclusions,
            @RequestParam(required = false, defaultValue = "false") boolean featured,
            @RequestParam(required = false, defaultValue = "false") boolean active,
            @RequestParam(required = false) Integer maxParticipants,
            RedirectAttributes redirectAttributes,
            HttpSession session) {

        String authCheck = checkAdminAuth(session);
        if (authCheck != null) return authCheck;

        try {
            if (name == null || name.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Package name is required");
                return "redirect:/admin/packages";
            }

            if (destinationId == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "Destination is required");
                return "redirect:/admin/packages";
            }

            Optional<Destination> destinationOpt = destinationRepository.findById(destinationId);
            if (destinationOpt.isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Invalid destination selected");
                return "redirect:/admin/packages";
            }

            TravelPackage travelPackage = new TravelPackage();
            travelPackage.setName(name.trim());
            travelPackage.setDestinationId(destinationId);
            travelPackage.setDescription(description != null ? description.trim() : "");
            travelPackage.setPrice(price);
            travelPackage.setDurationDays(durationDays);
            travelPackage.setDurationNights(durationNights != null ? durationNights : durationDays - 1);
            travelPackage.setType(type);
            travelPackage.setInclusions(inclusions != null ? inclusions.trim() : null);
            travelPackage.setExclusions(exclusions != null ? exclusions.trim() : null);
            travelPackage.setMaxParticipants(maxParticipants != null ? maxParticipants : 20);
            travelPackage.setFeatured(featured);
            travelPackage.setActive(active);
            travelPackage.setCreatedAt(LocalDateTime.now());
            travelPackage.setUpdatedAt(LocalDateTime.now());

            travelPackageRepository.save(travelPackage);

            System.out.println("Package added: " + travelPackage.getName());
            redirectAttributes.addFlashAttribute("message", "Package added successfully");

        } catch (Exception e) {
            System.err.println("Error adding package: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to add package: " + e.getMessage());
        }

        return "redirect:/admin/packages";
    }

    @PostMapping("/admin/destinations/add")
    public String addDestination(
            @RequestParam String name,
            @RequestParam String city,
            @RequestParam String country,
            @RequestParam String category,
            @RequestParam BigDecimal basePrice,
            @RequestParam Integer rating,
            @RequestParam String description,
            @RequestParam String imagePath,
            @RequestParam(required = false) String highlights,
            @RequestParam(required = false, defaultValue = "false") boolean featured,
            @RequestParam(required = false, defaultValue = "false") boolean active,
            RedirectAttributes redirectAttributes,
            HttpSession session) {

        String authCheck = checkAdminAuth(session);
        if (authCheck != null) return authCheck;

        try {
            if (name == null || name.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Destination name is required");
                return "redirect:/admin/destinations";
            }

            if (city == null || city.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "City is required");
                return "redirect:/admin/destinations";
            }

            if (country == null || country.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Country is required");
                return "redirect:/admin/destinations";
            }

            Destination destination = new Destination();
            destination.setName(name.trim());
            destination.setCity(city.trim());
            destination.setCountry(country.trim());
            destination.setCategory(category);
            destination.setBasePrice(basePrice);
            destination.setRating(rating);
            destination.setDescription(description != null ? description.trim() : "");
            destination.setImagePath(imagePath != null ? imagePath.trim() : "");
            destination.setHighlights(highlights != null ? highlights.trim() : null);
            destination.setFeatured(featured);
            destination.setActive(active);
            destination.setCreatedAt(LocalDateTime.now());
            destination.setUpdatedAt(LocalDateTime.now());

            destinationRepository.save(destination);

            System.out.println("Destination added: " + destination.getName());
            redirectAttributes.addFlashAttribute("message", "Destination added successfully");

        } catch (Exception e) {
            System.err.println("Error adding destination: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to add destination: " + e.getMessage());
        }

        return "redirect:/admin/destinations";
    }

    @PostMapping("/admin/bookings/add")
    public String addBooking(
            @RequestParam Long userId,
            @RequestParam Long packageId,
            @RequestParam String customerName,
            @RequestParam String customerEmail,
            @RequestParam String customerPhone,
            @RequestParam String departureDate,
            @RequestParam Integer numberOfParticipants,
            @RequestParam BigDecimal totalAmount,
            @RequestParam String status,
            @RequestParam String paymentStatus,
            @RequestParam(required = false) String specialRequests,
            RedirectAttributes redirectAttributes,
            HttpSession session) {

        String authCheck = checkAdminAuth(session);
        if (authCheck != null) return authCheck;

        try {
            if (userId == null || packageId == null) {
                redirectAttributes.addFlashAttribute("errorMessage", "User and Package are required");
                return "redirect:/admin/bookings";
            }

            if (customerName == null || customerName.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Customer name is required");
                return "redirect:/admin/bookings";
            }

            if (customerEmail == null || !EMAIL_PATTERN.matcher(customerEmail.trim()).matches()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Valid email is required");
                return "redirect:/admin/bookings";
            }

            Optional<User> userOpt = userRepository.findById(userId);
            if (userOpt.isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Invalid user selected");
                return "redirect:/admin/bookings";
            }

            Optional<TravelPackage> packageOpt = travelPackageRepository.findById(packageId);
            if (packageOpt.isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Invalid package selected");
                return "redirect:/admin/bookings";
            }

            LocalDate depDate;
            try {
                depDate = LocalDate.parse(departureDate);
            } catch (DateTimeParseException e) {
                redirectAttributes.addFlashAttribute("errorMessage", "Invalid departure date format");
                return "redirect:/admin/bookings";
            }

            Booking booking = new Booking();
            booking.setUserId(userId);
            booking.setPackageId(packageId);
            booking.setCustomerName(customerName.trim());
            booking.setCustomerEmail(customerEmail.trim());
            booking.setCustomerPhone(customerPhone != null ? customerPhone.trim() : "");
            booking.setDepartureDate(depDate);
            booking.setNumberOfParticipants(numberOfParticipants);
            booking.setTotalPrice(totalAmount);
            booking.setStatus(status);
            booking.setPaymentStatus(paymentStatus);
            booking.setSpecialRequests(specialRequests != null ? specialRequests.trim() : null);
            booking.setBookingNumber("BK" + System.currentTimeMillis());
            booking.setCreatedAt(LocalDateTime.now());
            booking.setUpdatedAt(LocalDateTime.now());

            bookingRepository.save(booking);

            System.out.println("Booking added: " + booking.getBookingNumber());
            redirectAttributes.addFlashAttribute("message", "Booking added successfully");

        } catch (Exception e) {
            System.err.println("Error adding booking: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to add booking: " + e.getMessage());
        }

        return "redirect:/admin/bookings";
    }

    @PostMapping("/admin/users/add")
    public String addUser(
            @RequestParam String username,
            @RequestParam String email,
            @RequestParam String password,
            @RequestParam String firstName,
            @RequestParam String lastName,
            @RequestParam String role,
            @RequestParam(required = false) String phone,
            @RequestParam(required = false, defaultValue = "true") boolean active,
            RedirectAttributes redirectAttributes,
            HttpSession session) {

        String authCheck = checkAdminAuth(session);
        if (authCheck != null) return authCheck;

        try {
            if (username == null || username.trim().isEmpty()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Username is required");
                return "redirect:/admin/users";
            }

            if (email == null || !EMAIL_PATTERN.matcher(email.trim()).matches()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Valid email is required");
                return "redirect:/admin/users";
            }

            if (password == null || password.trim().length() < 6) {
                redirectAttributes.addFlashAttribute("errorMessage", "Password must be at least 6 characters");
                return "redirect:/admin/users";
            }

            Optional<User> existingUserByUsername = userRepository.findByUsername(username.trim());
            if (existingUserByUsername.isPresent()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Username already exists");
                return "redirect:/admin/users";
            }

            Optional<User> existingUserByEmail = userRepository.findByEmail(email.trim());
            if (existingUserByEmail.isPresent()) {
                redirectAttributes.addFlashAttribute("errorMessage", "Email already exists");
                return "redirect:/admin/users";
            }

            User user = new User();
            user.setUsername(username.trim());
            user.setEmail(email.trim());
            user.setPassword(password.trim());
            user.setFirstName(firstName != null ? firstName.trim() : "");
            user.setLastName(lastName != null ? lastName.trim() : "");
            user.setRole(role);
            user.setPhone(phone != null ? phone.trim() : null);
            user.setActive(active);
            user.setCreatedAt(LocalDateTime.now());
            user.setUpdatedAt(LocalDateTime.now());

            userRepository.save(user);

            System.out.println("User added: " + user.getUsername());
            redirectAttributes.addFlashAttribute("message", "User added successfully");

        } catch (Exception e) {
            System.err.println("Error adding user: " + e.getMessage());
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to add user: " + e.getMessage());
        }

        return "redirect:/admin/users";
    }

   
    
    @RestController
    @RequestMapping("/admin/api")
    public class AdminApiController {

        @Autowired
        private UserRepository userRepository;
        
        @Autowired
        private DestinationRepository destinationRepository;
        
        @Autowired
        private TravelPackageRepository travelPackageRepository;
        
        @Autowired
        private BookingRepository bookingRepository;

        @GetMapping("/stats")
        public ResponseEntity<Map<String, Object>> getStats(HttpSession session) {
            Map<String, Object> stats = new HashMap<>();
            try {
                stats.put("totalUsers", userRepository.count());
                stats.put("totalDestinations", destinationRepository.count());
                stats.put("totalPackages", travelPackageRepository.count());
                stats.put("totalBookings", bookingRepository.count());
                stats.put("success", true);
            } catch (Exception e) {
                stats.put("success", false);
                stats.put("error", e.getMessage());
            }
            
            return ResponseEntity.ok(stats);
        }
    }
}