package com.example.SalesProject.JWT;

import com.example.SalesProject.DTOs.LoginRequestDTO;
import com.example.SalesProject.DTOs.LoginResponseDTO;
import com.example.SalesProject.Entity.AppUser;
import com.example.SalesProject.Entity.RefreshToken;
import com.example.SalesProject.Service.RefreshTokenService.RefreshTokenServiceImplementation;
import com.example.SalesProject.Service.AuthService.AuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequiredArgsConstructor
public class AuthController {

    private final AuthService authService;
    private final RefreshTokenServiceImplementation refreshTokenService;
    private final JwtUtil jwtUtil;

    @PostMapping("/auth/login")
    public ResponseEntity<LoginResponseDTO> login(@RequestBody LoginRequestDTO loginRequestDTO) {
        return ResponseEntity.ok(authService.login(loginRequestDTO));
    }

    @PostMapping("/auth/refresh")
    public ResponseEntity<Map<String, String>> refresh(@RequestBody Map<String, String> body) {
        String refreshToken = body.get("refreshToken");
        RefreshToken rt = refreshTokenService.validate(refreshToken);
        AppUser user = rt.getUser();
        String newAccessToken = jwtUtil.generateToken(user);
        return ResponseEntity.ok(Map.of("accessToken", newAccessToken));
    }

    @GetMapping("/api/validate")
    public ResponseEntity<Void> validateToken() {
        return ResponseEntity.ok().build();
    }
}
