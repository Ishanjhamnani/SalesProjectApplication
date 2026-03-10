package com.example.SalesProject.Repository;

import com.example.SalesProject.DTOs.ProductDTO;
import com.example.SalesProject.Entity.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.*;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {

    @Query(
            value = """
        SELECT id, sku, name, category, description, current_price, stock_quantity
        FROM product
        WHERE (:search IS NULL OR :search = ''
            OR LOWER(name)        LIKE LOWER(CONCAT('%', :search, '%'))
            OR LOWER(sku)         LIKE LOWER(CONCAT('%', :search, '%'))
            OR LOWER(category)    LIKE LOWER(CONCAT('%', :search, '%'))
            OR LOWER(description) LIKE LOWER(CONCAT('%', :search, '%')))
    """,
            countQuery = """
        SELECT COUNT(*) FROM product
        WHERE (:search IS NULL OR :search = ''
            OR LOWER(name)        LIKE LOWER(CONCAT('%', :search, '%'))
            OR LOWER(sku)         LIKE LOWER(CONCAT('%', :search, '%'))
            OR LOWER(category)    LIKE LOWER(CONCAT('%', :search, '%'))
            OR LOWER(description) LIKE LOWER(CONCAT('%', :search, '%')))
    """,
            nativeQuery = true
    )
    Page<ProductDTO> getProductsPage(@Param("search") String search, Pageable pageable);
    @Query(value = "SELECT stock_quantity FROM product WHERE id = :productId", nativeQuery = true)
    Integer getStock(@Param("productId") Long productId);

    @Query(value = "SELECT current_price FROM product WHERE id = :productId", nativeQuery = true)
    Double getPrice(@Param("productId") Long productId);

    @Modifying(clearAutomatically = true, flushAutomatically = true)
    @Transactional
    @Query(value = """
        UPDATE product 
        SET stock_quantity = stock_quantity - :qty 
        WHERE id = :productId
    """, nativeQuery = true)
    void reduceStock(@Param("productId") Long productId,
                     @Param("qty") Integer qty);
}