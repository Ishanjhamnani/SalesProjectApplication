//package com.example.SalesProject.Service;
//import org.springframework.data.domain.Pageable;
//
//import com.example.SalesProject.DTOs.DateWiseSalesReportDTO;
//import com.example.SalesProject.Repository.CustomerRepository;
//import com.example.SalesProject.Repository.ProductReportRepository;
//import com.example.SalesProject.Repository.SalesOrderRepository;
//import lombok.AllArgsConstructor;
//import org.springframework.stereotype.Service;
//
//import java.time.LocalDate;
//import java.util.ArrayList;
//import java.util.List;
//
//@Service
//@AllArgsConstructor
//public class ReportService {
//
//    private final SalesOrderRepository orderRepo;
//    public List<DateWiseSalesReportDTO> dateWiseSalesReport(LocalDate startDate, LocalDate endDate) {
//
//        if (startDate == null) {
//            throw new IllegalArgumentException("startDate is required");
//        }
//
//        if (endDate == null) {
//            throw new IllegalArgumentException("endDate is required");
//        }
//
//        if (startDate.isAfter(endDate)) {
//            throw new IllegalArgumentException("startDate cannot be after endDate");
//        }
//
//        List<Object[]> rows = orderRepo.dateWiseSalesReportRaw(startDate, endDate);
//
//        List<DateWiseSalesReportDTO> result = new ArrayList<>();
//
//        for (Object[] r : rows) {
//
//            LocalDate orderDate = (LocalDate) r[0];
//            Double dailyTotalRevenue = ((Number) r[1]).doubleValue();
//            Long totalOrders = ((Number) r[2]).longValue();
//            Double avgOrderValue = ((Number) r[3]).doubleValue();
//            Long itemsSold = ((Number) r[4]).longValue();
//            Long uniqueCustomers = ((Number) r[5]).longValue();
//            String ordersStatus = (String) r[6];
//
//            DateWiseSalesReportDTO dto = new DateWiseSalesReportDTO(
//                    orderDate,
//                    dailyTotalRevenue,
//                    totalOrders,
//                    avgOrderValue,
//                    itemsSold,
//                    uniqueCustomers,
//                    ordersStatus
//            );
//
//            result.add(dto);
//        }
//
//        return result;
//    }
//
//
//
//
//
//
//
//}
