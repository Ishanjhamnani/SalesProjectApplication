package com.example.SalesProject.DTOs;

/**
 * Projection DTO for dashboard stats.
 * Not a Spring Data projection (no DB projection needed here —
 * each stat is a scalar query). Used as a plain carrier in the service layer.
 */
public class DashboardStatsDTO {

    private String  revenue;
    private String  revenueGrowth;
    private Integer pendingOrders;
    private Integer activeCustomers;
    private String  customerGrowth;
    private Integer lowStockCount;

    public DashboardStatsDTO(String revenue, String revenueGrowth,
                             Integer pendingOrders, Integer activeCustomers,
                             String customerGrowth, Integer lowStockCount) {
        this.revenue         = revenue;
        this.revenueGrowth   = revenueGrowth;
        this.pendingOrders   = pendingOrders;
        this.activeCustomers = activeCustomers;
        this.customerGrowth  = customerGrowth;
        this.lowStockCount   = lowStockCount;
    }

    public String  getRevenue()         { return revenue; }
    public String  getRevenueGrowth()   { return revenueGrowth; }
    public Integer getPendingOrders()   { return pendingOrders; }
    public Integer getActiveCustomers() { return activeCustomers; }
    public String  getCustomerGrowth()  { return customerGrowth; }
    public Integer getLowStockCount()   { return lowStockCount; }
}