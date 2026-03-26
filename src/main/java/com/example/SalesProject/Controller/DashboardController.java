package com.example.SalesProject.Controller;

import com.example.SalesProject.DTOs.DashboardStatsDTO;
import com.example.SalesProject.Service.DashboardService.DashboardService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/api")
public class DashboardController {

    private final DashboardService dashboardService;

    public DashboardController(DashboardService dashboardService) {
        this.dashboardService = dashboardService;
    }

    /**
     * GET /api/dashboard-stats
     * Called by your jQuery: $.ajax({ url: '/api/dashboard-stats', type: 'GET' })
     * Jackson serializes DashboardStatsDTO getters → JSON keys your frontend reads.
     */
    @GetMapping("/dashboard-stats")
    public ResponseEntity<DashboardStatsDTO> getDashboardStats() {
        log.info("Fetching dashboard stats");
        DashboardStatsDTO stats = dashboardService.getDashboardStats();
        return ResponseEntity.ok(stats);
    }
}
