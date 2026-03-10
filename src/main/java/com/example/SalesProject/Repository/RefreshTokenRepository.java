package com.example.SalesProject.Repository;

import com.example.SalesProject.Entity.AppUser;
import com.example.SalesProject.Entity.RefreshToken;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.Optional;

public interface RefreshTokenRepository extends JpaRepository<RefreshToken, Long> {
    Optional<RefreshToken> findByToken(String token);

    void deleteByUser(AppUser user);
}