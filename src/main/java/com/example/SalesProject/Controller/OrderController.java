package com.example.SalesProject.Controller;

import com.example.SalesProject.DTOs.PlaceOrderRequestDTO;
import com.example.SalesProject.Service.OrderService.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/orders")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @PostMapping("/place")
    public ResponseEntity<?> placeOrder(@RequestBody PlaceOrderRequestDTO request) {
        Long orderId = orderService.placeOrder(request);
        return ResponseEntity.ok(Map.of(
                "message", "Order placed successfully",
                "orderId", orderId
        ));
    }
    @GetMapping("/show-orders")
    public Map<String, Object> getOrders(
            @RequestParam int start,
            @RequestParam int length,
            @RequestParam int draw,
            @RequestParam String search
    ) {
        int page = start / length;
        return orderService.getOrdersPage(page, length, draw,search);
    }

    @GetMapping("/view")
    public ResponseEntity<?> viewOrders() {
        return ResponseEntity.ok(orderService.viewOrders());
    }
}