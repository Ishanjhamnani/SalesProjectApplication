package com.example.SalesProject.Service.RefreshTokenService;

import com.example.SalesProject.Entity.AppUser;
import com.example.SalesProject.Entity.RefreshToken;
import com.example.SalesProject.Repository.RefreshTokenRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class RefreshTokenServiceImplementation implements RefreshTokenService {

    private final RefreshTokenRepository refreshTokenRepository;

    public RefreshToken createRefreshToken(AppUser user) {
        RefreshToken rt = new RefreshToken();
        rt.setUser(user);
        rt.setToken(UUID.randomUUID().toString());
        rt.setExpiryDate(Instant.now().plus(7, ChronoUnit.DAYS));
        return refreshTokenRepository.save(rt);
    }

    public RefreshToken validate(String token) {
        RefreshToken refreshToken= refreshTokenRepository.findByToken(token)
                .orElseThrow(() -> new RuntimeException("Invalid refresh token"));

        if(refreshToken.getExpiryDate().isBefore(Instant.now())) {
            refreshTokenRepository.delete(refreshToken);
            throw new RuntimeException("Refresh token expired");
        }

        return refreshToken ;
    }

    public void deleteByUser(AppUser user) {
        refreshTokenRepository.deleteByUser(user);
    }
}