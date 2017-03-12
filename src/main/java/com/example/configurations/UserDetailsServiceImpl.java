package com.example.configurations;

import com.example.dao.UserDao;
import com.example.entities.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.Set;

/**
 * Created by Andros on 26.01.2017.
 */

    @Service
    public class UserDetailsServiceImpl implements UserDetailsService {

    @Autowired
    private UserDao userDao;

        @Override
        public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {

            User user = userDao.findByemail(email).get(0);
            Set<GrantedAuthority> roles = new HashSet<>();

            roles.add(new SimpleGrantedAuthority(UserRole.ROLE_USER.name()));

            //Если мыло пользователя a@a - значит даем ему права админа
            if (email.equals("demo@demo")){
                roles.add(new SimpleGrantedAuthority(UserRole.ROLE_ADMIN.name()));
            }
            UserDetails userDetails = new org.springframework.security.core.userdetails.User(user.getEmail(),
                    user.getPassword(),
                    roles);
            return userDetails;
        }


    }

