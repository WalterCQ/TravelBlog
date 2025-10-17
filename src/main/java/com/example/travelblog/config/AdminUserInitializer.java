package com.example.travelblog.config;

import com.example.travelblog.model.User;
import com.example.travelblog.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;


/**
 * Initialize default admin and test users
 */
@Slf4j
@Component
@RequiredArgsConstructor
public class AdminUserInitializer implements CommandLineRunner {
    
    private final UserRepository userRepository;
    
    @Override
    public void run(String... args) throws Exception {
        initializeAdminUser();
    }
    
    private void initializeAdminUser() {
        try {
            // Check if admin exists
            var existingAdmin = userRepository.findByUsername("admin");

            if (existingAdmin.isEmpty()) {
                User adminUser = new User();
                adminUser.setUsername("admin");
                adminUser.setPassword("admin123");
                adminUser.setEmail("admin@mytour.my");
                adminUser.setFirstName("System");
                adminUser.setLastName("Administrator");
                adminUser.setPhone("+60123456789");
                adminUser.setRole("ADMIN");
                adminUser.setActive(true);

                userRepository.save(adminUser);
                log.info("✅ Default admin user created successfully");
                log.info("   Username: admin");
                log.info("   Password: admin123");
                log.info("   Admin Panel: http://localhost:8080/admin");
            } else {
                log.info("ℹ️  Admin user already exists: {}", existingAdmin.get().getUsername());
            }

            // Create test user
            var testUser = userRepository.findByUsername("testuser");
            if (testUser.isEmpty()) {
                User regularUser = new User();
                regularUser.setUsername("testuser");
                regularUser.setPassword("password123");
                regularUser.setEmail("testuser@mytour.my");
                regularUser.setFirstName("Test");
                regularUser.setLastName("User");
                regularUser.setPhone("+60198765432");
                regularUser.setRole("USER");
                regularUser.setActive(true);

                userRepository.save(regularUser);
                log.info("✅ Test user created: testuser / password123");
            }

        } catch (Exception e) {
            log.error("❌ Error initializing admin user: {}", e.getMessage(), e);
        }
    }
}
