package com.example.SalesProject.Service.ProductService;

import com.example.SalesProject.DTOs.CustomerDTO;
import com.example.SalesProject.DTOs.ProductDTO;
import com.example.SalesProject.Entity.Customer;
import com.example.SalesProject.Entity.Product;
import com.example.SalesProject.Repository.CustomerRepository;
import com.example.SalesProject.Repository.ProductRepository;
import com.example.SalesProject.Service.ProductService.ProductService;
import lombok.NoArgsConstructor;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.HashMap;
import java.util.Map;


@Service
public class ProductServiceImplementation implements ProductService {

    private final ProductRepository productRepository;

    public ProductServiceImplementation(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    @Override
    public Map<String, Object> getProductsPage(int page, int length, int draw,String search) {

        System.out.println("DB HIT (PRODUCT)");

        Pageable pageable = PageRequest.of(page, length);
        Page<ProductDTO> productPage = productRepository.getProductsPage(search,pageable);

        Map<String, Object> response = new HashMap<>();
        response.put("draw", draw);
        response.put("recordsTotal", productPage.getTotalElements());
        response.put("recordsFiltered", productPage.getTotalElements());
        response.put("data", productPage.getContent()); // List only → Redis safe

        return response;
    }

    @Override
    @CacheEvict(value = "productsPage", allEntries = true)
    public void save(Product product) {
        productRepository.save(product);
    }

    @Override
    @Transactional                                    // ← was missing
    @CacheEvict(value = "productsPage", allEntries = true)  // ← was missing
    public void update(Long id, Product product) {
        Product existingProduct = productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        if(!existingProduct.getSku().equals(product.getSku())) {
            existingProduct.setSku(product.getSku());
        }
        existingProduct.setName(product.getName());
        existingProduct.setCategory(product.getCategory());
        existingProduct.setCurrentPrice(product.getCurrentPrice());
        existingProduct.setStockQuantity(product.getStockQuantity());

        productRepository.save(existingProduct);
    }
    @Override
    public void patch(Long id, Product newProduct) {

        Product existingProduct = productRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        if (newProduct.getName() != null) {
            existingProduct.setName(newProduct.getName());
        }

        if (newProduct.getCurrentPrice() != null) {
            existingProduct.setCurrentPrice(newProduct.getCurrentPrice());
        }

        if (newProduct.getStockQuantity() != null) {
            existingProduct.setStockQuantity(newProduct.getStockQuantity());
        }

        if (newProduct.getDescription() != null) {
            existingProduct.setDescription(newProduct.getDescription());
        }

        if (newProduct.getCategory() != null) {
            existingProduct.setCategory(newProduct.getCategory());
        }

        productRepository.save(existingProduct);
    }

    @Override
    public void deleteById(Long id) {
        if (!productRepository.existsById(id)) {
            throw new RuntimeException("Product not found");
        }
        productRepository.deleteById(id);
    }

}