package com.example.SalesProject.Service.ProductService;

import com.example.SalesProject.Entity.Product;
import jakarta.validation.Valid;

import java.util.Map;

public interface ProductService {

    Map<String, Object> getProductsPage(int page, int length, int draw,String search);

    void save(Product product);

    void update(Long id, Product product);

    void patch(Long id, Product product);

    void deleteById(Long id);
}