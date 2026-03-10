package com.example.SalesProject.DTOs;

import lombok.Data;

@Data
public class OrderItemRequestDTO {
    private Long productId;
    private Integer quantity;
}