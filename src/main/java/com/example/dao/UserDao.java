package com.example.dao;

import com.example.entities.Order;
import com.example.entities.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Andros on 24.01.2017.
 */
@Repository
public interface UserDao extends JpaRepository<User,Long> {
    List<User> findByemail(String email);
}
