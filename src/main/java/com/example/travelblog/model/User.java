package com.example.travelblog.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

/**
 * Modern User Entity with Lombok and JPA annotations (2025 Best Practices)
 */
@Entity
@Table(name = "users", 
    indexes = {
        @Index(name = "idx_user_username", columnList = "username", unique = true),
        @Index(name = "idx_user_email", columnList = "email", unique = true),
        @Index(name = "idx_user_role", columnList = "role"),
        @Index(name = "idx_user_active", columnList = "active")
    }
)
@Getter
@Setter
@NoArgsConstructor
@ToString
@EqualsAndHashCode(of = {"id", "username"})
public class User {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @NotBlank(message = "Username is required")
    @Size(min = 3, max = 50, message = "Username must be between 3 and 50 characters")
    @Column(nullable = false, unique = true, length = 50)
    private String username;
    
    @NotBlank(message = "Password is required")
    @Size(min = 6, message = "Password must be at least 6 characters")
    @Column(nullable = false, length = 255)
    @ToString.Exclude
    private String password;
    
    @NotBlank(message = "Email is required")
    @Email(message = "Email should be valid")
    @Column(nullable = false, unique = true, length = 100)
    private String email;
    
    @Size(max = 50)
    @Column(name = "first_name", length = 50)
    private String firstName;
    
    @Size(max = 50)
    @Column(name = "last_name", length = 50)
    private String lastName;
    
    @Size(max = 20)
    @Column(length = 20)
    private String phone;
    
    @NotBlank
    @Size(max = 20)
    @Column(nullable = false, length = 20, columnDefinition = "VARCHAR(20) DEFAULT 'USER'")
    private String role = "USER";
    
    @Column(columnDefinition = "BOOLEAN DEFAULT TRUE")
    private Boolean active = true;
    
    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;
    
    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    // Commented out: database table doesn't have this column yet
    // @Column(name = "last_login")
    // private LocalDateTime lastLogin;
    
    // Custom constructor for backward compatibility
    public User(String username, String password, String email, String firstName, String lastName) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
    }
    
    /**
     * Business logic methods
     */
    public String getFullName() {
        if (firstName == null && lastName == null) return username;
        if (firstName == null) return lastName;
        if (lastName == null) return firstName;
        return firstName + " " + lastName;
    }
    
    public void setFullName(String fullName) {
        if (fullName == null || fullName.trim().isEmpty()) {
            this.firstName = null;
            this.lastName = null;
            return;
        }
        
        String[] parts = fullName.trim().split(" ", 2);
        this.firstName = parts[0];
        this.lastName = parts.length > 1 ? parts[1] : "";
    }
    
    public boolean isActive() {
        return active != null && active;
    }
    
    public boolean isAdmin() {
        return "ADMIN".equals(role);
    }
    
    public boolean isUser() {
        return "USER".equals(role);
    }
    
    // Backward compatibility methods for JSP
    public LocalDateTime getLastLoginAt() {
        return null; // lastLogin field is commented out
    }
    
    public void setLastLoginAt(LocalDateTime lastLoginAt) {
        // lastLogin field is commented out
    }
    
    public Date getCreatedAtAsDate() {
        if (createdAt == null) return null;
        return Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public Date getUpdatedAtAsDate() {
        if (updatedAt == null) return null;
        return Date.from(updatedAt.atZone(ZoneId.systemDefault()).toInstant());
    }
    
    public Date getLastLoginAsDate() {
        return null; // lastLogin field is commented out
    }
}
