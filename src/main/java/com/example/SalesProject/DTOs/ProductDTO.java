package com.example.SalesProject.DTOs;

public interface ProductDTO {
    Long getId();
    String getSku();
    String getName();
    String getCategory();
    String getDescription();
    Double getCurrentPrice();
    Integer getStockQuantity();
}