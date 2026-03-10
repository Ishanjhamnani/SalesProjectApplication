package com.example.SalesProject.Repository;

import com.example.SalesProject.DTOs.OrderTableDTO;
import com.example.SalesProject.Entity.Order;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {

    @Query(value = """
        SELECT
            o.id          AS id,
            o.order_date  AS orderDate,
            o.status      AS status,
            o.total_amount AS totalAmount,
            CONCAT(c.first_name, ' ', c.last_name) AS customerName
        FROM orders o
        JOIN customers c ON o.customer_id = c.id
        WHERE (:search IS NULL OR :search = ''
            OR LOWER(CAST(o.status AS VARCHAR))                          LIKE LOWER(CONCAT('%', :search, '%'))
            OR LOWER(CONCAT(c.first_name, ' ', c.last_name))            LIKE LOWER(CONCAT('%', :search, '%'))
            OR LOWER(CAST(o.total_amount AS VARCHAR))                    LIKE LOWER(CONCAT('%', :search, '%')))
        ORDER BY o.order_date DESC
    """,
            countQuery = """
        SELECT COUNT(*) FROM orders o
        JOIN customers c ON o.customer_id = c.id
        WHERE (:search IS NULL OR :search = ''
            OR LOWER(CAST(o.status AS VARCHAR))                          LIKE LOWER(CONCAT('%', :search, '%'))
            OR LOWER(CONCAT(c.first_name, ' ', c.last_name))            LIKE LOWER(CONCAT('%', :search, '%'))
            OR LOWER(CAST(o.total_amount AS VARCHAR))                    LIKE LOWER(CONCAT('%', :search, '%')))
    """,
            nativeQuery = true)
    Page<OrderTableDTO> getOrdersPage(@Param("search") String search, Pageable pageable);
}