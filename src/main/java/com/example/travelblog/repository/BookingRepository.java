package com.example.travelblog.repository;

import com.example.travelblog.model.Booking;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface BookingRepository extends JpaRepository<Booking, Long> {
    
    List<Booking> findByUserIdOrderByCreatedAtDesc(Long userId);
    
    // Backward compatibility method
    default List<Booking> findByUserId(Long userId) {
        return findByUserIdOrderByCreatedAtDesc(userId);
    }
    
    List<Booking> findByPackageIdOrderByCreatedAtDesc(Long packageId);
    
    List<Booking> findByStatusOrderByCreatedAtDesc(String status);
    
    Optional<Booking> findByBookingNumber(String bookingNumber);
    
    long countByUserId(Long userId);
    
    long countByStatus(String status);
    
    boolean existsByBookingNumber(String bookingNumber);
}

