package com.example.product_management.service;

import com.example.product_management.entity.Product;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

public interface ProductService {

    List<Product> getAllProducts();

    Optional<Product> getProductById(Long id);

    Product saveProduct(Product product);

    void deleteProduct(Long id);

    List<Product> searchProducts(String keyword);

    List<Product> getProductsByCategory(String category);

    Page<Product> searchProducts(String name, String category, BigDecimal minPrice, BigDecimal maxPrice,
            Pageable pageable);

    List<String> getAllCategories();

    Page<Product> searchProducts(String keyword, Pageable pageable);

    List<Product> getAllProducts(Sort sort);

    List<Product> getProductsByCategory(String category, Sort sort);

    long countProducts();

    BigDecimal getTotalValue();

    BigDecimal getAveragePrice();

    List<Product> getLowStockProducts(int threshold);

    List<Product> getRecentProducts();

    List<Object[]> getProductStatsByCategory();
}
