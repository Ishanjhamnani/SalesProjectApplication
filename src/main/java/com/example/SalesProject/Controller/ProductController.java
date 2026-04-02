package com.example.SalesProject.Controller;

import com.example.SalesProject.Entity.Product;
import com.example.SalesProject.Service.ProductService.ProductServiceImplementation;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api")
public class ProductController {

    private final ProductServiceImplementation productService;

    public ProductController(ProductServiceImplementation productService) {
        this.productService = productService;
    }

    @GetMapping("/show-products")
    public Map<String, Object >getProductsForDataTable(
            @RequestParam(defaultValue = "1") int draw,
            @RequestParam(defaultValue = "0") int start,
            @RequestParam(defaultValue = "10") int length,
            @RequestParam(defaultValue = "")   String search

    ) {
        int page = start / length;
        return
                productService.getProductsPage(page, length, draw,search)
        ;
    }

    @PostMapping("/product-save")
    public ResponseEntity<Map<String, Object>> save(@Valid @RequestBody Product product) {
        productService.save(product);

        Map<String, Object> res = new HashMap<>();
        res.put("status", "success");
        res.put("message", "Product created successfully");

        return ResponseEntity.status(201).body(res);
    }

    @PutMapping("/product-update/{id}")
    public ResponseEntity<Map<String, Object>> update(
            @PathVariable Long id,
             @RequestBody Product product
    ) {
        productService.update(id, product);

        Map<String, Object> res = new HashMap<>();
        res.put("status", "success");
        res.put("message", "Product updated successfully");
        res.put("productId", id);

        return ResponseEntity.ok(res);
    }

    @PatchMapping("/product-patch/{id}")
    public ResponseEntity<Map<String, Object>> patch(
            @PathVariable Long id,
            @RequestBody Product product
    ) {
        productService.patch(id, product);

        Map<String, Object> res = new HashMap<>();
        res.put("status", "success");
        res.put("message", "Product patched successfully");
        res.put("productId", id);

        return ResponseEntity.ok(res);
    }


    @DeleteMapping("/product-delete/{id}")
    public ResponseEntity<Map<String, Object>> delete(@PathVariable Long id) {
        productService.deleteById(id);

        Map<String, Object> res = new HashMap<>();
        res.put("status", "success");
        res.put("message", "Product deleted successfully");
        res.put("productId", id);

        return ResponseEntity.ok(res);
    }
}