package com.example.travelblog.service;

import com.example.travelblog.model.Destination;
import com.example.travelblog.repository.DestinationRepository;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import java.util.List;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * Modern Service layer for Destination management (2025 Best Practices)
 * Implements caching, transaction management, and logging
 */
@Slf4j
@Service
@RequiredArgsConstructor
@Transactional(readOnly = true)
public class DestinationService {

    private final DestinationRepository destinationRepository;

    /**
     * Get all active destinations (cached)
     */
    @Cacheable(value = "destinations", key = "'all-active'")
    public List<Destination> findAllActive() {
        log.debug("Fetching all active destinations from database");
        return destinationRepository.findAll().stream()
                .filter(d -> Boolean.TRUE.equals(d.getActive()))
                .collect(Collectors.toList());
    }

    /**
     * Get featured destinations with limit
     */
    public List<Destination> findFeaturedDestinations(int limit) {
        log.debug("Fetching {} featured destinations", limit);
        return destinationRepository.findAll().stream()
                .filter(d -> Boolean.TRUE.equals(d.getFeatured()) && Boolean.TRUE.equals(d.getActive()))
                .limit(limit)
                .collect(Collectors.toList());
    }

    /**
     * Get destination by ID (cached)
     */
    @Cacheable(value = "destinations", key = "#id")
    public Optional<Destination> findById(Long id) {
        log.debug("Fetching destination with ID: {} from database", id);
        return destinationRepository.findById(id);
    }

    /**
     * Filter destinations by country and category
     */
    public List<Destination> filterDestinations(String country, String category) {
        log.debug("Filtering destinations by country: {} and category: {}", country, category);
        return destinationRepository.findAll().stream()
                .filter(d -> Boolean.TRUE.equals(d.getActive()))
                .filter(d -> country == null || country.isEmpty() || d.getCountry().equals(country))
                .filter(d -> category == null || category.isEmpty() || d.getCategory().equals(category))
                .collect(Collectors.toList());
    }

    /**
     * Get all unique countries (cached)
     */
    @Cacheable(value = "countries")
    public Set<String> getAllCountries() {
        log.debug("Fetching all countries from database");
        return destinationRepository.findAll().stream()
                .map(Destination::getCountry)
                .filter(country -> country != null && !country.isEmpty())
                .collect(Collectors.toSet());
    }

    /**
     * Get all unique categories (cached)
     */
    @Cacheable(value = "categories")
    public Set<String> getAllCategories() {
        log.debug("Fetching all categories from database");
        return destinationRepository.findAll().stream()
                .map(Destination::getCategory)
                .filter(category -> category != null && !category.isEmpty())
                .collect(Collectors.toSet());
    }

    /**
     * Find related destinations by country or category
     */
    public List<Destination> findRelatedDestinations(Long excludeId, String country, String category, int limit) {
        log.debug("Finding related destinations excluding ID: {}", excludeId);
        return destinationRepository.findAll().stream()
                .filter(d -> !d.getId().equals(excludeId))
                .filter(d -> Boolean.TRUE.equals(d.getActive()))
                .filter(d -> d.getCountry().equals(country) || d.getCategory().equals(category))
                .limit(limit)
                .collect(Collectors.toList());
    }

    /**
     * Save or update destination (clears cache)
     */
    @Transactional
    @CacheEvict(value = {"destinations", "countries", "categories"}, allEntries = true)
    public Destination save(Destination destination) {
        log.info("Saving destination: {}", destination.getName());
        return destinationRepository.save(destination);
    }

    /**
     * Delete destination by ID (clears cache)
     */
    @Transactional
    @CacheEvict(value = {"destinations", "countries", "categories"}, allEntries = true)
    public void deleteById(Long id) {
        log.info("Deleting destination with ID: {}", id);
        destinationRepository.deleteById(id);
    }

    /**
     * Count total destinations
     */
    public long count() {
        return destinationRepository.count();
    }

    /**
     * Check if destination exists
     */
    public boolean existsById(Long id) {
        return destinationRepository.existsById(id);
    }
}
