package com.example.SalesProject.Service.RefreshTokenService;

import com.example.SalesProject.Entity.AppUser;
import com.example.SalesProject.Entity.RefreshToken;

public interface RefreshTokenService {

    RefreshToken createRefreshToken(AppUser user);

    RefreshToken validate(String token);

    void deleteByUser(AppUser user);
}