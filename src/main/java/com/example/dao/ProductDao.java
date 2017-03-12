package com.example.dao;

import com.example.entities.Category;
import com.example.entities.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Andros on 04.02.2017.
 */
@Repository
public interface ProductDao extends JpaRepository<Product,Long> {
    List<Product> findByCategory(Category category);
}