package com.example.travelblog.repository;

import com.example.travelblog.model.TravelPackage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

/**
 * Modern TravelPackage Repository using Spring Data JPA (2025 Best Practices)
 */
@Repository
public interface TravelPackageRepository extends JpaRepository<TravelPackage, Long> {
    
    /**
     * Find all packages by destination
     */
    List<TravelPackage> findByDestinationIdAndActiveTrue(Long destinationId);
    
    /**
     * Backward compatibility method
     */
    default List<TravelPackage> findByDestinationId(Long destinationId) {
        return findByDestinationIdAndActiveTrue(destinationId);
    }
    
    /**
     * Find all active packages
     */
    List<TravelPackage> findByActiveTrue();
    
    /**
     * Backward compatibility method
     */
    default List<TravelPackage> findActive() {
        return findByActiveTrue();
    }
    
    /**
     * Backward compatibility method
     */
    default List<TravelPackage> findFeatured() {
        return findByFeaturedTrueAndActiveTrueOrderByPriceAsc();
    }
    
    /**
     * Find featured packages ordered by price
     */
    List<TravelPackage> findByFeaturedTrueAndActiveTrueOrderByPriceAsc();
    
    /**
     * Find packages by type
     */
    List<TravelPackage> findByTypeAndActiveTrue(String type);
    
    /**
     * Find packages by destination and type
     */
    List<TravelPackage> findByDestinationIdAndTypeAndActiveTrue(Long destinationId, String type);
    
    /**
     * Find available packages (within date range)
     */
    @Query("SELECT p FROM TravelPackage p WHERE p.active = true AND " +
           "(p.availableFrom IS NULL OR p.availableFrom <= :now) AND " +
           "(p.availableTo IS NULL OR p.availableTo >= :now)")
    List<TravelPackage> findAvailablePackages(LocalDateTime now);
    
    /**
     * Search packages by name
     */
    List<TravelPackage> findByNameContainingIgnoreCaseAndActiveTrue(String name);
    
    /**
     * Find all packages ordered by featured and price
     */
    @Query("SELECT p FROM TravelPackage p ORDER BY p.featured DESC, p.price ASC")
    List<TravelPackage> findAllOrderedByFeaturedAndPrice();
    
    /**
     * Count packages by destination
     */
    long countByDestinationId(Long destinationId);
    
    /**
     * Count active packages
     */
    long countByActiveTrue();
    
    /**
     * Check if package exists by name
     */
    boolean existsByNameIgnoreCase(String name);
}
