package com.example.SalesProject.Service.AuthService;

import com.example.SalesProject.DTOs.LoginRequestDTO;
import com.example.SalesProject.DTOs.LoginResponseDTO;
import com.example.SalesProject.Entity.AppUser;
import com.example.SalesProject.Entity.RefreshToken;
import com.example.SalesProject.JWT.JwtUtil;
import com.example.SalesProject.Service.RefreshTokenService.RefreshTokenServiceImplementation;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthServiceImplementation implements AuthService {

    private final JwtUtil jwtUtil;
    private final AuthenticationManager authenticationManager;
    private final RefreshTokenServiceImplementation refreshTokenService;

    public LoginResponseDTO login(LoginRequestDTO dto) {

        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(dto.getUsername(), dto.getPassword())
        );

        AppUser user = (AppUser) authentication.getPrincipal();

        String accessToken = jwtUtil.generateToken(user);
        RefreshToken refreshToken = refreshTokenService.createRefreshToken(user);

        return new LoginResponseDTO(
                accessToken,
                refreshToken.getToken(),
                user.getId()
        );
    }
}