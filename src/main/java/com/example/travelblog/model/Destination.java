package com.example.travelblog.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Modern Destination Entity with Lombok and JPA annotations (2025 Best Practices)
 */
@Entity
@Table(name = "destinations", indexes = {
    @Index(name = "idx_destination_country", columnList = "country"),
    @Index(name = "idx_destination_category", columnList = "category"),
    @Index(name = "idx_destination_featured", columnList = "featured"),
    @Index(name = "idx_destination_active", columnList = "active")
})
@Getter
@Setter
@NoArgsConstructor
@ToString
@EqualsAndHashCode(of = "id")
public class Destination {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @NotBlank(message = "Destination name is required")
    @Size(max = 200, message = "Name must not exceed 200 characters")
    @Column(nullable = false, length = 200)
    private String name;
    
    @Column(columnDefinition = "TEXT")
    private String description;
    
    @NotBlank(message = "Country is required")
    @Size(max = 100)
    @Column(nullable = false, length = 100)
    private String country;
    
    @Size(max = 100)
    @Column(length = 100)
    private String city;
    
    @Size(max = 50)
    @Column(length = 50)
    private String continent;
    
    @DecimalMin(value = "0.0", inclusive = false, message = "Price must be greater than 0")
    @Column(name = "base_price", precision = 10, scale = 2)
    private BigDecimal basePrice;
    
    @Size(max = 3)
    @Column(length = 3, columnDefinition = "VARCHAR(3) DEFAULT 'USD'")
    private String currency = "USD";
    
    @Size(max = 500)
    @Column(name = "image_path", length = 500)
    private String imagePath;
    
    @Size(max = 500)
    @Column(name = "video_path", length = 500)
    private String videoPath;
    
    @Size(max = 50)
    @Column(length = 50, columnDefinition = "VARCHAR(50) DEFAULT 'NATURE'")
    private String category = "NATURE";
    
    @Min(1)
    @Max(5)
    @Column(columnDefinition = "INT DEFAULT 5")
    private Integer rating = 5;
    
    @Min(0)
    @Column(name = "total_reviews", columnDefinition = "INT DEFAULT 0")
    private Integer totalReviews = 0;
    
    @Column(columnDefinition = "BOOLEAN DEFAULT FALSE")
    private Boolean featured = false;
    
    @Column(columnDefinition = "TEXT")
    private String highlights;
    
    @Size(max = 200)
    @Column(name = "best_time_to_visit", length = 200)
    private String bestTimeToVisit;
    
    @Min(1)
    @Column(name = "average_duration")
    private Integer averageDuration;
    
    @Size(max = 20)
    @Column(name = "difficulty_level", length = 20, columnDefinition = "VARCHAR(20) DEFAULT 'EASY'")
    private String difficultyLevel = "EASY";
    
    @Column(columnDefinition = "BOOLEAN DEFAULT TRUE")
    private Boolean active = true;
    
    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;
    
    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    @OneToMany(mappedBy = "destinationId", cascade = CascadeType.ALL, orphanRemoval = false, fetch = FetchType.LAZY)
    @ToString.Exclude
    private List<TravelPackage> packages = new ArrayList<>();
    
    // Custom constructor for backward compatibility
    public Destination(String name, String description, String country, String city) {
        this.name = name;
        this.description = description;
        this.country = country;
        this.city = city;
    }
    
    /**
     * Business logic method for display category
     */
    public String getDisplayCategory() {
        if (category == null) {
            return "Adventure";
        }
        
        return switch (category.toUpperCase()) {
            case "NATURE" -> "Nature & Wildlife";
            case "CITY" -> "City Experience";
            case "BEACH" -> "Beach Resort";
            case "HERITAGE", "CULTURAL" -> "Cultural Heritage";
            case "MOUNTAIN" -> "Mountain Adventure";
            case "ADVENTURE" -> "Adventure";
            default -> "Adventure";
        };
    }
}
