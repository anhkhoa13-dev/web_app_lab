package com.example.product_management.controller;

import com.example.product_management.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/dashboard")
public class DashboardController {

    @Autowired
    private ProductService productService;

    @GetMapping
    public String showDashboard(Model model) {
        // 1. Các chỉ số cơ bản (Summary Cards)
        model.addAttribute("totalProducts", productService.countProducts());
        model.addAttribute("totalValue", productService.getTotalValue());
        model.addAttribute("avgPrice", productService.getAveragePrice());

        // 2. Danh sách cảnh báo (Tables)
        model.addAttribute("lowStockProducts", productService.getLowStockProducts(10)); // Ngưỡng < 10
        model.addAttribute("recentProducts", productService.getRecentProducts());

        // 3. Dữ liệu cho Biểu đồ (Pie Chart)
        List<Object[]> stats = productService.getProductStatsByCategory();

        // Tách dữ liệu thành 2 list riêng để Chart.js dễ đọc
        List<String> categories = new ArrayList<>();
        List<Long> counts = new ArrayList<>();

        for (Object[] row : stats) {
            categories.add((String) row[0]); // Tên Category
            counts.add((Long) row[1]); // Số lượng
        }

        model.addAttribute("chartCategories", categories);
        model.addAttribute("chartCounts", counts);

        return "dashboard";
    }
}