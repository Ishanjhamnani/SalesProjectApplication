package com.example.SalesProject.Controller;

import com.example.SalesProject.CustomAnnotations.CustomExceptionScope;
import com.example.SalesProject.Entity.Customer;
import com.example.SalesProject.Service.CustomerService.CustomerService;
import jakarta.validation.Valid;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@RestController
@RequestMapping("/api")
public class CustomerController {

    private final CustomerService customerService;

    public CustomerController(CustomerService customerService) {
        this.customerService = customerService;
    }

    @PostMapping("/show-customers")
    public Map<String, Object> getCustomersForDataTable(
            @RequestParam(defaultValue = "1")  int draw,
            @RequestParam(defaultValue = "0")  int start,
            @RequestParam(defaultValue = "10") int length,
            @RequestParam(defaultValue = "")   String search
    ) {
        int page = start / length;
        return customerService.getCustomersPage(page, length, draw, search);
    }
@CustomExceptionScope
    @PostMapping("/customer-save")
    public ResponseEntity<Map<String, Object>> save(@Valid @RequestBody Customer customer) {
        customerService.save(customer);

        Map<String, Object> res = new HashMap<>();
        res.put("status", "success");
        res.put("message", "Customer created successfully");

        return ResponseEntity.status(201).body(res);
    }

    @PutMapping("/customer-update/{id}")
    public ResponseEntity<Map<String, Object>> update(
            @PathVariable Long id,
             @RequestBody Customer customer
    ) {
        customerService.update(id, customer);

        Map<String, Object> res = new HashMap<>();
        res.put("status", "success");
        res.put("message", "Customer updated successfully");
        res.put("customerId", id);

        return ResponseEntity.ok(res);
    }
    @PatchMapping("/customer-patch/{id}")
    public ResponseEntity<Map<String, Object>> patch(
            @PathVariable Long id,
            @RequestBody Customer customer
    ) {
        customerService.patch(id, customer);

        Map<String, Object> res = new HashMap<>();
        res.put("status", "success");
        res.put("message", "Customer patched successfully");
        res.put("customerId", id);

        return ResponseEntity.ok(res);
    }


    @DeleteMapping("/customer-delete/{id}")
    public ResponseEntity<Map<String, Object>> delete(@PathVariable Long id) {
        log.info("Customer Deleted Successfully with id {}", id);
        customerService.deleteById(id);

        Map<String, Object> res = new HashMap<>();
        res.put("status", "success");
        res.put("message", "Customer deleted successfully");
        res.put("customerId", id);

        return ResponseEntity.ok(res);
    }
}