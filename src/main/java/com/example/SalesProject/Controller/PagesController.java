package com.example.SalesProject.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/pages")
public class PagesController {


    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }


    @GetMapping("/dashboard")
    public String dashboard() {
        return "dashboard";
    }

    @GetMapping("/customers")
    public String customersPage() {
        return "customers";
    }

    @GetMapping("/products")
    public String productsPage() {
        return "products";
    }

    @GetMapping("/orders")
    public String ordersPage() {
        return "orders";
    }

    @GetMapping("/place-order")
    public String placeOrderPage() {
        return "placeOrder";
    }
}
