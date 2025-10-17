package com.example.travelblog;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;

import jakarta.annotation.PostConstruct;

/**
 * Modern Travel Blog Application (2025)
 * Spring Boot 3.x with Java 21, Jakarta EE, and modern best practices
 */
@Slf4j
@SpringBootApplication
@EnableCaching
public class TravelBlogApplication {

    public static void main(String[] args) {
        log.info("==========================================");
        log.info("    MyTour Travel Blog Application v2.1");
        log.info("    Modern Architecture - 2025");
        log.info("    Starting up...");
        log.info("==========================================");
        
        SpringApplication.run(TravelBlogApplication.class, args);
        
        log.info("==========================================");
        log.info("    Application started successfully!");
        log.info("    Visit: http://localhost:8080");
        log.info("    API Docs: http://localhost:8080/swagger-ui.html");
        log.info("    Actuator: http://localhost:8080/actuator");
        log.info("==========================================");
    }

    @PostConstruct
    public void init() {
        log.info("Initializing Travel Blog Application...");
        log.info("Using modern architecture with:");
        log.info("  - Spring Boot 3.5.3");
        log.info("  - Java 21");
        log.info("  - Jakarta EE");
        log.info("  - Lombok for code simplification");
        log.info("  - Caffeine for high-performance caching");
        log.info("  - OpenAPI/Swagger for API documentation");
        log.info("  - Spring Actuator for monitoring");
        log.info("Initialization complete.");
    }
}
