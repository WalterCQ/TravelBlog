package com.example.travelblog.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

/**
 * Modern Booking Entity with Lombok and JPA annotations (2025 Best Practices)
 */
@Entity
@Table(name = "bookings",
    indexes = {
        @Index(name = "idx_booking_user", columnList = "user_id"),
        @Index(name = "idx_booking_package", columnList = "package_id"),
        @Index(name = "idx_booking_number", columnList = "booking_number", unique = true),
        @Index(name = "idx_booking_status", columnList = "status"),
        @Index(name = "idx_booking_payment_status", columnList = "payment_status")
    }
)
@Getter
@Setter
@NoArgsConstructor
@ToString
@EqualsAndHashCode(of = {"id", "bookingNumber"})
public class Booking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Size(max = 50)
    @Column(name = "booking_number", unique = true, length = 50)
    private String bookingNumber;

    @Size(max = 50)
    @Column(name = "booking_reference", length = 50)
    private String bookingReference;

    @NotNull(message = "User ID is required")
    @Column(name = "user_id", nullable = false)
    private Long userId;

    @NotNull(message = "Package ID is required")
    @Column(name = "package_id", nullable = false)
    private Long packageId;

    @Column(name = "departure_date")
    private LocalDate departureDate;

    @Column(name = "return_date")
    private LocalDate returnDate;

    @Column(name = "travel_date")
    private LocalDate travelDate;

    @Column(name = "booking_date")
    private LocalDate bookingDate;

    @Column(name = "confirmation_date")
    private LocalDate confirmationDate;

    @Column(name = "cancellation_date")
    private LocalDate cancellationDate;

    @Size(max = 500)
    @Column(name = "cancellation_reason", length = 500)
    private String cancellationReason;

    @Min(1)
    @Column(name = "number_of_participants")
    private Integer numberOfParticipants;

    @Min(1)
    @Column(name = "number_of_travelers")
    private Integer numberOfTravelers;

    @Min(0)
    @Column(name = "adult_count")
    private Integer adultCount;

    @Min(0)
    @Column(name = "child_count")
    private Integer childCount;

    @NotNull(message = "Total price is required")
    @DecimalMin(value = "0.0", inclusive = true)
    @Column(name = "total_price", nullable = false, precision = 10, scale = 2)
    private BigDecimal totalPrice;

    @Size(max = 3)
    @Column(length = 3, columnDefinition = "VARCHAR(3) DEFAULT 'MYR'")
    private String currency = "MYR";

    @Size(max = 20)
    @Column(length = 20, columnDefinition = "VARCHAR(20) DEFAULT 'PENDING'")
    private String status = "PENDING";

    @Size(max = 20)
    @Column(name = "payment_status", length = 20, columnDefinition = "VARCHAR(20) DEFAULT 'PENDING'")
    private String paymentStatus = "PENDING";

    @Size(max = 50)
    @Column(name = "payment_method", length = 50)
    private String paymentMethod;

    @NotBlank(message = "Customer name is required")
    @Size(max = 100)
    @Column(name = "customer_name", nullable = false, length = 100)
    private String customerName;

    @NotBlank(message = "Customer email is required")
    @Email(message = "Email should be valid")
    @Size(max = 100)
    @Column(name = "customer_email", nullable = false, length = 100)
    private String customerEmail;

    @Size(max = 20)
    @Column(name = "customer_phone", length = 20)
    private String customerPhone;

    @Column(name = "special_requests", columnDefinition = "TEXT")
    private String specialRequests;

    @Size(max = 100)
    @Column(name = "emergency_contact", length = 100)
    private String emergencyContact;

    @Size(max = 20)
    @Column(name = "emergency_phone", length = 20)
    private String emergencyPhone;

    @Column(columnDefinition = "TEXT")
    private String notes;

    @CreationTimestamp
    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    // Transient fields for joined data
    @Transient
    private String packageName;

    @Transient
    private String destinationName;

    @Transient
    private String userName;

    @Transient
    private String userEmail;
    
    @Transient
    private String bookingDateTime;

    /**
     * Business logic methods with automatic participant calculation
     */
    public Integer getAdultCount() {
        return adultCount != null ? adultCount : numberOfParticipants;
    }

    public void setAdultCount(Integer adultCount) {
        this.adultCount = adultCount;
        updateNumberOfParticipants();
    }

    public Integer getChildCount() {
        return childCount != null ? childCount : 0;
    }

    public void setChildCount(Integer childCount) {
        this.childCount = childCount;
        updateNumberOfParticipants();
    }

    private void updateNumberOfParticipants() {
        Integer adults = this.adultCount != null ? this.adultCount : 0;
        Integer children = this.childCount != null ? this.childCount : 0;
        this.numberOfParticipants = adults + children;
        this.numberOfTravelers = adults + children;
    }

    public String getStatusBadgeClass() {
        if (status == null) return "bg-secondary text-white";
        
        return switch (status.toUpperCase()) {
            case "CONFIRMED" -> "bg-success text-white";
            case "PENDING" -> "bg-warning text-dark";
            case "CANCELLED", "FAILED" -> "bg-danger text-white";
            case "COMPLETED" -> "bg-primary text-white";
            default -> "bg-secondary text-white";
        };
    }

    public String getPaymentStatusBadgeClass() {
        if (paymentStatus == null) return "bg-secondary text-white";
        
        return switch (paymentStatus.toUpperCase()) {
            case "PAID", "COMPLETED" -> "bg-success text-white";
            case "PENDING", "UNPAID" -> "bg-warning text-dark";
            case "FAILED", "CANCELLED" -> "bg-danger text-white";
            case "REFUNDED" -> "bg-info text-dark";
            default -> "bg-secondary text-white";
        };
    }

    public boolean isPending() {
        return "PENDING".equalsIgnoreCase(this.status);
    }

    public boolean isCompleted() {
        return "COMPLETED".equalsIgnoreCase(this.status);
    }

    public String getFormattedTotalPrice() {
        if (totalPrice == null) return "N/A";
        if (currency == null) return "RM " + totalPrice.toString();
        // Display MYR as RM
        String currencySymbol = "MYR".equals(currency) ? "RM" : currency;
        return currencySymbol + " " + totalPrice.toString();
    }

    public String getStatusDisplay() {
        if (status == null) return "Unknown";
        return status.substring(0, 1).toUpperCase() + status.substring(1).toLowerCase();
    }

    public String getPaymentStatusDisplay() {
        if (paymentStatus == null) return "Unknown";
        return paymentStatus.substring(0, 1).toUpperCase() + paymentStatus.substring(1).toLowerCase();
    }

    public String getParticipantsDisplay() {
        Integer participants = this.numberOfParticipants != null ? this.numberOfParticipants : this.numberOfTravelers;
        if (participants == null) return "N/A";
        return participants + " participant" + (participants > 1 ? "s" : "");
    }

    public String getFormattedBookingDate() {
        if (createdAt == null) return "N/A";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM dd, yyyy");
        return createdAt.format(formatter);
    }

    public String getFormattedReturnDate() {
        if (returnDate == null) return "";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMMM dd, yyyy");
        return returnDate.format(formatter);
    }
    
    public String getBookingDateTime() {
        return bookingDateTime;
    }
    
    public void setBookingDateTime(String bookingDateTime) {
        this.bookingDateTime = bookingDateTime;
    }

    // Backward compatibility methods for JSP (Date conversion)
    public java.util.Date getCreatedAtAsDate() {
        if (createdAt == null) return null;
        return java.util.Date.from(createdAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public java.util.Date getUpdatedAtAsDate() {
        if (updatedAt == null) return null;
        return java.util.Date.from(updatedAt.atZone(ZoneId.systemDefault()).toInstant());
    }

    public java.util.Date getDepartureDateAsDate() {
        if (departureDate == null) return null;
        return java.util.Date.from(departureDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
    }

    public java.util.Date getReturnDateAsDate() {
        if (returnDate == null) return null;
        return java.util.Date.from(returnDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
    }

    public java.util.Date getTravelDateAsDate() {
        if (travelDate == null) return null;
        return java.util.Date.from(travelDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
    }

    public java.util.Date getBookingDateAsDate() {
        if (bookingDate == null) return null;
        return java.util.Date.from(bookingDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
    }

    public java.util.Date getConfirmationDateAsDate() {
        if (confirmationDate == null) return null;
        return java.util.Date.from(confirmationDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
    }

    public java.util.Date getCancellationDateAsDate() {
        if (cancellationDate == null) return null;
        return java.util.Date.from(cancellationDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
    }
}
