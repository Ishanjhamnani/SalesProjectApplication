package com.example.SalesProject.DTOs;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
public class PlaceOrderRequestDTO {
    private Long customerId;
    private List<OrderItemRequestDTO> items;
}