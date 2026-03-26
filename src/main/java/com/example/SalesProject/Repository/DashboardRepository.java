package com.example.SalesProject.Repository;

import com.example.SalesProject.Entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface DashboardRepository extends JpaRepository<Order, Long> {

    // ── Revenue: current month ────────────────────────────────────────
    @Query(value = """
        SELECT COALESCE(SUM(total_amount), 0)
        FROM orders
        WHERE status = 'PLACED'
          AND order_date >= DATE_TRUNC('month', CURRENT_DATE)
          AND order_date <  DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '1 month'
    """, nativeQuery = true)
    double getCurrentMonthRevenue();

    // ── Revenue: last month ───────────────────────────────────────────
    @Query(value = """
        SELECT COALESCE(SUM(total_amount), 0)
        FROM orders
        WHERE status = 'COMPLETED'
          AND order_date >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month'
          AND order_date <  DATE_TRUNC('month', CURRENT_DATE)
    """, nativeQuery = true)
    double getLastMonthRevenue();

    // ── Pending orders count ──────────────────────────────────────────
    @Query(value = """
        SELECT COUNT(*)
        FROM orders
        WHERE status = 'PENDING'
    """, nativeQuery = true)
    int getPendingOrdersCount();

    // ── Active customers: current month ───────────────────────────────
    @Query(value = """
        SELECT COUNT(DISTINCT customer_id)
        FROM orders
        WHERE order_date >= DATE_TRUNC('month', CURRENT_DATE)
          AND order_date <  DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '1 month'
    """, nativeQuery = true)
    int getCurrentMonthActiveCustomers();

    // ── Active customers: last month ──────────────────────────────────
    @Query(value = """
        SELECT COUNT(DISTINCT customer_id)
        FROM orders
        WHERE order_date >= DATE_TRUNC('month', CURRENT_DATE) - INTERVAL '1 month'
          AND order_date <  DATE_TRUNC('month', CURRENT_DATE)
    """, nativeQuery = true)
    int getLastMonthActiveCustomers();

    // ── Low stock count ───────────────────────────────────────────────
    @Query(value = """
        SELECT COUNT(*)
        FROM product
        WHERE stock_quantity <= 10
    """, nativeQuery = true)
    int getLowStockCount();
}