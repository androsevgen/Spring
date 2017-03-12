package com.example.dao;

import com.example.entities.Order;
import com.example.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Andros on 28.02.2017.
 */
@Repository
public interface OrderDao extends JpaRepository<Order,Long> {
    List<Order> findByUser(User user);
    List<Order> findByConfirmed(int id);
}
