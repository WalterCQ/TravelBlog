package com.example.travelblog.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.LocalDateTime;
import java.time.ZoneId;

/**
 * Modern ContactMessage Entity with Lombok and JPA annotations (2025 Best Practices)
 */
@Entity
@Table(name = "contact_messages",
    indexes = {
        @Index(name = "idx_contact_status", columnList = "status"),
        @Index(name = "idx_contact_email", columnList = "email"),
        @Index(name = "idx_contact_created", columnList = "created_at")
    }
)
@Getter
@Setter
@NoArgsConstructor
@ToString
@EqualsAndHashCode(of = "id")
public class ContactMessage {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @NotBlank(message = "Name is required")
    @Size(max = 100, message = "Name must not exceed 100 characters")
    @Column(nullable = false, length = 100)
    private String name;
    
    @NotBlank(message = "Email is required")
    @Email(message = "Email should be valid")
    @Size(max = 100)
    @Column(nullable = false, length = 100)
    private String email;
    
    @Size(max = 20)
    @Column(length = 20)
    private String phone;
    
    @NotBlank(message = "Subject is required")
    @Size(max = 200, message = "Subject must not exceed 200 characters")
    @Column(nullable = false, length = 200)
    private String subject;
    
    @NotBlank(message = "Message is required")
    @Size(min = 10, message = "Message must be at least 10 characters")
    @Column(nullable = false, columnDefinition = "TEXT")
    private String message;
    
    @Size(max = 20)
    @Column(length = 20, columnDefinition = "VARCHAR(20) DEFAULT 'NEW'")
    private String status = "NEW";
    
    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;
    
    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;
    
    // Custom constructor for backward compatibility
    public ContactMessage(String name, String email, String phone, String subject, String message) {
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.subject = subject;
        this.message = message;
        this.status = "NEW";
    }
    
    /**
     * Backward compatibility methods for JSP
     */
    public java.util.Date getCreatedAtAsDate() {
        if (createdAt == null) return null;
        return java.util.Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public java.util.Date getUpdatedAtAsDate() {
        if (updatedAt == null) return null;
        return java.util.Date.from(updatedAt.atZone(ZoneId.systemDefault()).toInstant());
    }
}
