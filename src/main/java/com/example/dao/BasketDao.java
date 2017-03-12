package com.example.dao;

import com.example.entities.Basket;
import com.example.entities.Product;
import com.example.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Andros on 23.02.2017.
 */
@Repository
public interface BasketDao  extends JpaRepository<Basket,Long> {
    List<Basket> findByUser(User user);
}
