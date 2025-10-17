package com.example.travelblog.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * Modern TravelPackage Entity with Lombok and JPA annotations (2025 Best Practices)
 */
@Entity
@Table(name = "packages",
    indexes = {
        @Index(name = "idx_package_destination", columnList = "destination_id"),
        @Index(name = "idx_package_type", columnList = "package_type"),
        @Index(name = "idx_package_featured", columnList = "featured"),
        @Index(name = "idx_package_active", columnList = "active")
    }
)
@Getter
@Setter
@NoArgsConstructor
@ToString
@EqualsAndHashCode(of = "id")
public class TravelPackage {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @NotBlank(message = "Package name is required")
    @Size(max = 200, message = "Name must not exceed 200 characters")
    @Column(nullable = false, length = 200)
    private String name;
    
    @Column(columnDefinition = "TEXT")
    private String description;
    
    @NotNull(message = "Destination is required")
    @Column(name = "destination_id", nullable = false)
    private Long destinationId;
    
    @NotNull(message = "Price is required")
    @DecimalMin(value = "0.0", inclusive = false, message = "Price must be greater than 0")
    @Column(nullable = false, precision = 10, scale = 2)
    private BigDecimal price;
    
    @Size(max = 3)
    @Column(length = 3, columnDefinition = "VARCHAR(3) DEFAULT 'MYR'")
    private String currency = "MYR";
    
    @Min(1)
    @Column(name = "duration_days", columnDefinition = "INT DEFAULT 1")
    private Integer durationDays = 1;
    
    @Min(0)
    @Column(name = "duration_nights", columnDefinition = "INT DEFAULT 0")
    private Integer durationNights = 0;
    
    @Min(1)
    @Column(name = "max_participants", columnDefinition = "INT DEFAULT 10")
    private Integer maxParticipants = 10;
    
    @Min(1)
    @Column(name = "min_participants", columnDefinition = "INT DEFAULT 1")
    private Integer minParticipants = 1;
    
    @Size(max = 50)
    @Column(name = "package_type", length = 50, columnDefinition = "VARCHAR(50) DEFAULT 'STANDARD'")
    private String type = "STANDARD";
    
    @Column(columnDefinition = "TEXT")
    private String inclusions;
    
    @Column(columnDefinition = "TEXT")
    private String exclusions;
    
    @Column(columnDefinition = "TEXT")
    private String itinerary;
    
    @Size(max = 500)
    @Column(name = "image_path", length = 500)
    private String imagePath;
    
    @Column(columnDefinition = "BOOLEAN DEFAULT FALSE")
    private Boolean featured = false;
    
    @Column(name = "available_from")
    private LocalDateTime availableFrom;
    
    @Column(name = "available_to")
    private LocalDateTime availableTo;
    
    @Column(columnDefinition = "BOOLEAN DEFAULT TRUE")
    private Boolean active = true;
    
    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;
    
    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    // Transient fields for joined data
    @Transient
    private String destinationName;
    
    @Transient
    private String destinationCountry;
    
    @Transient
    private String destinationCity;
    
    // Custom constructor for backward compatibility
    public TravelPackage(String name, String description, Long destinationId, BigDecimal price) {
        this.name = name;
        this.description = description;
        this.destinationId = destinationId;
        this.price = price;
    }
    
    /**
     * Business logic methods
     */
    public String getDisplayType() {
        if (type == null) return "Standard";
        
        return switch (type.toUpperCase()) {
            case "BUDGET" -> "Budget";
            case "STANDARD" -> "Standard";
            case "PREMIUM" -> "Premium";
            case "LUXURY" -> "Luxury";
            case "DELUXE" -> "Deluxe";
            case "ADVENTURE" -> "Adventure";
            case "CULTURAL" -> "Cultural";
            case "FAMILY" -> "Family";
            case "ROMANTIC" -> "Romantic";
            default -> "Standard";
        };
    }
    
    public String getTypeColorClass() {
        if (type == null) return "secondary";
        
        return switch (type.toUpperCase()) {
            case "BUDGET" -> "secondary";
            case "STANDARD" -> "primary";
            case "PREMIUM" -> "success";
            case "LUXURY" -> "warning";
            case "DELUXE" -> "danger";
            case "ADVENTURE" -> "info";
            case "CULTURAL" -> "dark";
            case "FAMILY" -> "light";
            case "ROMANTIC" -> "danger";
            default -> "secondary";
        };
    }
    
    public String getFormattedPrice() {
        if (price == null) return "Price TBD";
        // Always display in Malaysian Ringgit for UI consistency
        return "RM " + String.format("%,.2f", price);
    }
    
    public String getDurationDisplay() {
        if (durationDays == null) return "Duration TBD";
        
        StringBuilder duration = new StringBuilder();
        duration.append(durationDays).append(" day");
        if (durationDays > 1) duration.append("s");
        
        if (durationNights != null && durationNights > 0) {
            duration.append(" / ").append(durationNights).append(" night");
            if (durationNights > 1) duration.append("s");
        }
        
        return duration.toString();
    }
    
    public String getParticipantsDisplay() {
        if (minParticipants == null) return "Flexible group size";
        
        if (maxParticipants == null || minParticipants.equals(maxParticipants)) {
            return minParticipants == 1 ? "1 person" : minParticipants + " people";
        }
        
        return minParticipants + "-" + maxParticipants + " people";
    }
    
    public boolean isAvailableNow() {
        if (!Boolean.TRUE.equals(active)) return false;
        
        LocalDateTime now = LocalDateTime.now();
        
        if (availableFrom != null && now.isBefore(availableFrom)) return false;
        if (availableTo != null && now.isAfter(availableTo)) return false;
        
        return true;
    }
    
    public String getAvailabilityStatus() {
        if (!Boolean.TRUE.equals(active)) return "INACTIVE";
        if (!isAvailableNow()) return "UNAVAILABLE";
        return "AVAILABLE";
    }
    
    public String getAvailabilityMessage() {
        if (!Boolean.TRUE.equals(active)) return "Package is currently inactive";
        
        LocalDateTime now = LocalDateTime.now();
        
        if (availableFrom != null && now.isBefore(availableFrom)) {
            return "Available from " + availableFrom.format(DateTimeFormatter.ofPattern("MMM dd, yyyy"));
        }
        
        if (availableTo != null && now.isAfter(availableTo)) {
            return "Booking period ended " + availableTo.format(DateTimeFormatter.ofPattern("MMM dd, yyyy"));
        }
        
        return "Available for booking";
    }
    
    public String getShortDescription() {
        if (description == null) return "";
        return description.length() <= 150 ? description : description.substring(0, 147) + "...";
    }
    
    public List<String> getInclusionsList() {
        if (inclusions == null || inclusions.trim().isEmpty()) {
            return List.of(
                "Professional tour guide",
                "Transportation as per itinerary", 
                "Entrance fees to attractions",
                "Travel insurance"
            );
        }
        
        return List.of(inclusions.split(","))
            .stream()
            .map(String::trim)
            .filter(s -> !s.isEmpty())
            .toList();
    }
    
    public List<String> getExclusionsList() {
        if (exclusions == null || exclusions.trim().isEmpty()) {
            return List.of(
                "International flights",
                "Personal expenses",
                "Optional activities",
                "Tips and gratuities"
            );
        }
        
        return List.of(exclusions.split(","))
            .stream()
            .map(String::trim)
            .filter(s -> !s.isEmpty())
            .toList();
    }
    
    public String getImageUrl() {
        if (imagePath != null && !imagePath.trim().isEmpty()) {
            return imagePath;
        }
        return "https://images.unsplash.com/photo-1488646953014-85cb44e25828?w=600&h=400&fit=crop&auto=format";
    }
    
    public int getPopularityScore() {
        int score = 0;
        
        if (Boolean.TRUE.equals(featured)) score += 20;
        if (Boolean.TRUE.equals(active)) score += 10;
        if (price != null && price.compareTo(BigDecimal.valueOf(1000)) < 0) score += 15;
        if (durationDays != null && durationDays >= 3 && durationDays <= 7) score += 10;
        
        return Math.min(100, score);
    }
}
