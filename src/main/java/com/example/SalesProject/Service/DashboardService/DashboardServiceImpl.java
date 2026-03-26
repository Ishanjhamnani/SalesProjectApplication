package com.example.SalesProject.Service.DashboardService;

import com.example.SalesProject.DTOs.DashboardStatsDTO;
import com.example.SalesProject.Repository.DashboardRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.text.NumberFormat;
import java.util.Locale;

@Slf4j
@Service
public class DashboardServiceImpl implements DashboardService {

    private final DashboardRepository dashboardRepository;

    public DashboardServiceImpl(DashboardRepository dashboardRepository) {
        this.dashboardRepository = dashboardRepository;
    }

    @Override
    public DashboardStatsDTO getDashboardStats() {

        // ── 1. Fetch raw numbers from repository ─────────────────────
        double currentRevenue  = dashboardRepository.getCurrentMonthRevenue();
        double lastRevenue     = dashboardRepository.getLastMonthRevenue();

        int pendingOrders      = dashboardRepository.getPendingOrdersCount();

        int currentCustomers   = dashboardRepository.getCurrentMonthActiveCustomers();
        int lastCustomers      = dashboardRepository.getLastMonthActiveCustomers();

        int lowStockCount      = dashboardRepository.getLowStockCount();

        // ── 2. Format & compute ──────────────────────────────────────
        String revenue        = formatCurrency(currentRevenue);
        String revenueGrowth  = computeGrowth(currentRevenue, lastRevenue);
        String customerGrowth = computeGrowth(currentCustomers, lastCustomers);

        log.info("Dashboard stats fetched — Revenue: {}, Pending: {}, Customers: {}, LowStock: {}",
                revenue, pendingOrders, currentCustomers, lowStockCount);

        // ── 3. Build and return DTO ───────────────────────────────────
        // Jackson serializes getter names to JSON keys automatically:
        // getRevenue()         → "revenue"
        // getRevenueGrowth()   → "revenueGrowth"
        // getPendingOrders()   → "pendingOrders"
        // getActiveCustomers() → "activeCustomers"
        // getCustomerGrowth()  → "customerGrowth"
        // getLowStockCount()   → "lowStockCount"
        // — matches exactly what your jQuery $.ajax success handler reads
        return new DashboardStatsDTO(
                revenue,
                revenueGrowth,    // null → jQuery falls back to 'Current month earnings'
                pendingOrders,
                currentCustomers,
                customerGrowth,   // null → jQuery falls back to 'Purchased recently'
                lowStockCount
        );
    }

    // ── Helpers ───────────────────────────────────────────────────────

    private String formatCurrency(double amount) {
        NumberFormat nf = NumberFormat.getNumberInstance(new Locale("en", "IN"));
        nf.setMaximumFractionDigits(0);
        return "₹" + nf.format((long) amount);
    }

    private String computeGrowth(double current, double previous) {
        if (previous == 0) return null;
        double pct = ((current - previous) / previous) * 100;
        String sign = pct >= 0 ? "+" : "";
        return String.format("%s%.1f%%", sign, pct);
    }
}