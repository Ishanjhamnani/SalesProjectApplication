package com.example.SalesProject.Entity;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.RequiredArgsConstructor;


import java.time.Instant;

@Entity
@AllArgsConstructor
@RequiredArgsConstructor
@Table(name = "refresh_tokens")
@Data
public class RefreshToken {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true, nullable = false, length = 500)
    private String token;

    private Instant expiryDate;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private AppUser user;
}