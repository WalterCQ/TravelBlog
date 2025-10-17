package com.example.travelblog.repository;

import com.example.travelblog.model.ContactMessage;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Modern ContactMessage Repository using Spring Data JPA (2025 Best Practices)
 */
@Repository
public interface ContactMessageRepository extends JpaRepository<ContactMessage, Long> {
    
    /**
     * Find all messages ordered by creation date (newest first)
     */
    List<ContactMessage> findAllByOrderByCreatedAtDesc();
    
    /**
     * Find messages by status
     */
    List<ContactMessage> findByStatusOrderByCreatedAtDesc(String status);
    
    /**
     * Find messages by email
     */
    List<ContactMessage> findByEmailOrderByCreatedAtDesc(String email);
    
    /**
     * Search messages by subject containing text
     */
    List<ContactMessage> findBySubjectContainingIgnoreCaseOrderByCreatedAtDesc(String subject);
    
    /**
     * Count messages by status
     */
    long countByStatus(String status);
    
    /**
     * Find unread messages (status = 'NEW')
     */
    default List<ContactMessage> findUnreadMessages() {
        return findByStatusOrderByCreatedAtDesc("NEW");
    }
    
    /**
     * Count unread messages
     */
    default long countUnreadMessages() {
        return countByStatus("NEW");
    }
}
