package com.example.SalesProject.Entity;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.validation.constraints.*;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDate;
import java.util.List;

@Getter
@Setter
@Entity
@Table(name = "customers")
public class Customer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "First name is required")
    @Size(min = 2, max = 50)
    @Pattern(
            regexp = "^[A-Za-z]+(?:[\\s'-][A-Za-z]+)*$",
            message = "First name contains invalid characters"
    )
    private String firstName;

    @NotBlank(message = "Last name is required")
    @Size(min = 2, max = 50)
    @Pattern(
            regexp = "^[A-Za-z]+(?:[\\s'-][A-Za-z]+)*$",
            message = "Last name contains invalid characters"
    )
    private String lastName;


    @NotBlank(message = "Email is required")
    @Email(message = "Invalid email format")
    @Column(unique = true)
    private String email;


    @NotBlank(message = "Phone number is required")
    @Pattern(
            regexp = "^[6-9][0-9]{9}$",
            message = "Invalid Indian phone number"
    )
    private String phoneNumber;

    @Size(max = 255, message = "Address too long")
    @NotBlank(message = "Address is required")
    @Pattern(
            regexp = "^[A-Za-z0-9\\s,./-]{5,255}$",
            message = "Address contains invalid characters"
    )
    private String address;

    @CreationTimestamp
    private LocalDate createdDate;

    @JsonIgnore
    @OneToMany(mappedBy = "customer", cascade = CascadeType.ALL)
    private List<Order> orders;
}