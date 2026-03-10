package com.example.SalesProject.DTOs;

import java.time.LocalDate;
import java.time.LocalDateTime;

public interface OrderTableDTO {
    Long getId();
    LocalDateTime getOrderDate();
    String getStatus();
    Double getTotalAmount();
    String getCustomerName();
}