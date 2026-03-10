package com.example.SalesProject.Service.AuthService;

import com.example.SalesProject.DTOs.LoginRequestDTO;
import com.example.SalesProject.DTOs.LoginResponseDTO;

public interface AuthService {
    LoginResponseDTO login(LoginRequestDTO dto);
}