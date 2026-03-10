package com.example.SalesProject.JWT;

import com.example.SalesProject.Entity.AppUser;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.util.Date;

@Component
public class JwtUtil {

    // ⚠️ CRITICAL: Ensure your application.properties has a jwt.secretKey that is AT LEAST 32 characters long!
    @Value("${jwt.secretKey}")
    private String SECRET;

    private Key getSigningKey() {
        return Keys.hmacShaKeyFor(SECRET.getBytes(StandardCharsets.UTF_8));
    }

    // Changed parameter name from 'username' to 'user' for clarity
    public String generateToken(AppUser user) {
        long EXPIRATION = 1000 * 60 * 10; // 10 minutes
        return Jwts.builder()
                .setSubject(user.getUsername())
                .setIssuedAt(new Date())
                .claim("userID", user.getId())
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION))
                .signWith(getSigningKey(), SignatureAlgorithm.HS256)
                .compact();
    }

    // This method now handles both validation AND extraction in one go.
    // If it fails (expired, altered, bad signature), it returns null.
    public String extractUsername(String token) {
        try {
            return Jwts.parserBuilder()
                    .setSigningKey(getSigningKey())
                    .build()
                    .parseClaimsJws(token)
                    .getBody()
                    .getSubject();
        } catch (Exception e) {
            System.out.println("<<<<<<<< Invalid or Expired Token >>>>>>>>>>>: " + e.getMessage());
            return null;
        }
    }
}