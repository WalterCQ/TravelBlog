package com.example.travelblog.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * JPA Configuration (2025 Best Practices)
 * Enables JPA repositories and transaction management
 */
@Configuration
@EnableJpaRepositories(basePackages = "com.example.travelblog.repository")
@EnableTransactionManagement
public class JpaConfig {
    // JPA repositories will be automatically scanned
}



