package com.example.travelblog.repository;

import com.example.travelblog.model.Destination;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Modern Destination Repository using Spring Data JPA (2025 Best Practices)
 * Eliminates boilerplate JDBC code
 */
@Repository
public interface DestinationRepository extends JpaRepository<Destination, Long> {
    
    /**
     * Find all active destinations
     */
    List<Destination> findByActiveTrue();
    
    /**
     * Find featured and active destinations
     */
    List<Destination> findByFeaturedTrueAndActiveTrueOrderByRatingDescNameAsc();
    
    /**
     * Find destinations by country
     */
    List<Destination> findByCountryAndActiveTrue(String country);
    
    /**
     * Find destinations by category
     */
    List<Destination> findByCategoryAndActiveTrue(String category);
    
    /**
     * Find destinations by country and category
     */
    List<Destination> findByCountryAndCategoryAndActiveTrue(String country, String category);
    
    /**
     * Search destinations by name containing text (case-insensitive)
     */
    List<Destination> findByNameContainingIgnoreCaseAndActiveTrue(String name);
    
    /**
     * Find destinations by continent
     */
    List<Destination> findByContinentAndActiveTrue(String continent);
    
    /**
     * Find all destinations ordered by featured status and name
     */
    @Query("SELECT d FROM Destination d ORDER BY d.featured DESC, d.name ASC")
    List<Destination> findAllOrderedByFeatured();
    
    /**
     * Find top N featured destinations
     */
    @Query("SELECT d FROM Destination d WHERE d.featured = true AND d.active = true ORDER BY d.rating DESC")
    List<Destination> findTopFeaturedDestinations();
    
    /**
     * Get distinct countries
     */
    @Query("SELECT DISTINCT d.country FROM Destination d WHERE d.country IS NOT NULL ORDER BY d.country")
    List<String> findDistinctCountries();
    
    /**
     * Get distinct categories
     */
    @Query("SELECT DISTINCT d.category FROM Destination d WHERE d.category IS NOT NULL ORDER BY d.category")
    List<String> findDistinctCategories();
    
    /**
     * Count active destinations
     */
    long countByActiveTrue();
    
    /**
     * Count featured destinations
     */
    long countByFeaturedTrueAndActiveTrue();
    
    /**
     * Check if destination exists by name
     */
    boolean existsByNameIgnoreCase(String name);
}
