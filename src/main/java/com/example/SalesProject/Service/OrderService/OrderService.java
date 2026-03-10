package com.example.SalesProject.Service.OrderService;

import com.example.SalesProject.DTOs.PlaceOrderRequestDTO;

import java.util.List;
import java.util.Map;

public interface OrderService {

    Long placeOrder(PlaceOrderRequestDTO request);

    List<Map<String, Object>> viewOrders();
    Map<String, Object> getOrdersPage(int page, int length, int draw, String search);

}