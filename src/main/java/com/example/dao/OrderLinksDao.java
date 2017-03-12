package com.example.dao;

import com.example.entities.OrderLink;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Andros on 28.02.2017.
 */
@Repository
public interface OrderLinksDao extends JpaRepository<OrderLink,Long> {
    List<OrderLink> findByOrder_id(long id);
}
