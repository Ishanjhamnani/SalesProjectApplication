package com.example.SalesProject.Entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Entity
@Getter
@Setter
@Table(name = "product")

public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "SKU is required")
    @Size(max = 50, message = "SKU must be at most 50 characters")
    @Pattern(regexp = "^[A-Za-z0-9-]+$", message = "SKU can only contain letters, digits, and hyphens")
    @Column(nullable = false, unique = true)
    private String sku;

    @NotBlank(message = "Product name is required")
    @Size(max = 100, message = "Product name must be at most 100 characters")
    @Pattern(regexp = "^[A-Za-z0-9\\s'-]+$", message = "Product name contains invalid characters")
    @Column(nullable = false)
    private String name;

    @Size(max = 500, message = "Description too long")
    private String description;

    @NotNull(message = "Current price is required")
    @PositiveOrZero(message = "Price must be zero or positive")
    @Column(nullable = false)
    private Double currentPrice;

    @NotNull(message = "Stock quantity is required")
    @Min(value = 0, message = "Stock quantity cannot be negative")
    @Column(nullable = false)
    private Integer stockQuantity = 0;

    @Size(max = 50, message = "Category too long")
    private String category;

    @JsonIgnore
    @OneToMany(mappedBy = "product")
    private List<OrderItem> orderItems;
}