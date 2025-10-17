package com.example.travelblog.repository;

import com.example.travelblog.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

/**
 * Modern User Repository using Spring Data JPA (2025 Best Practices)
 */
@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    
    /**
     * Find user by username
     */
    Optional<User> findByUsername(String username);
    
    /**
     * Backward compatibility - find user by username (returns User instead of Optional)
     */
    default User findByUsernameCompat(String username) {
        return findByUsername(username).orElse(null);
    }
    
    /**
     * Find user by email
     */
    Optional<User> findByEmail(String email);
    
    /**
     * Find user by username or email
     */
    Optional<User> findByUsernameOrEmail(String username, String email);
    
    /**
     * Find all users by role
     */
    List<User> findByRole(String role);
    
    /**
     * Find all active users
     */
    List<User> findByActiveTrue();
    
    /**
     * Find users by role and active status
     */
    List<User> findByRoleAndActiveTrue(String role);
    
    /**
     * Check if username exists
     */
    boolean existsByUsername(String username);
    
    /**
     * Check if email exists
     */
    boolean existsByEmail(String email);
    
    /**
     * Check if username or email exists
     */
    @Query("SELECT CASE WHEN COUNT(u) > 0 THEN true ELSE false END FROM User u WHERE u.username = ?1 OR u.email = ?2")
    boolean existsByUsernameOrEmail(String username, String email);
    
    /**
     * Count users by role
     */
    long countByRole(String role);
    
    /**
     * Count active users
     */
    long countByActiveTrue();
    
    /**
     * Find all users ordered by creation date (newest first)
     */
    List<User> findAllByOrderByCreatedAtDesc();
}
