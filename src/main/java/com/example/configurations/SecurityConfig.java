package com.example.configurations;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;


/**
 * Created by Andros on 24.01.2017.
 */


    @Configuration
    @EnableWebSecurity
    public class SecurityConfig extends WebSecurityConfigurerAdapter {
        @Override
        protected void configure(HttpSecurity http) throws Exception {
            http.csrf().disable()
                    .authorizeRequests()
                    .antMatchers("/index").permitAll()
                    .antMatchers("/resources/**").permitAll() //"/**"
                    .antMatchers("/css/*").permitAll()
                    .antMatchers("/prod_add2basket").authenticated()
                    .antMatchers("/admin", "/admin/**").hasRole("ADMIN")
                    //.anyRequest().authenticated()
                    .and()
                    .formLogin()
                    .loginPage("/index")
                    .permitAll()
                    .and()
                    .logout()
                    .permitAll();

            http.formLogin()
                    .loginPage("/index")
                    .loginProcessingUrl("/j_spring_security_check")
                    .failureUrl("/error")
                    .usernameParameter("j_username")
                    .passwordParameter("j_password")
                    .permitAll();

            http.logout()
                    .permitAll()
                    .logoutUrl("/logout")
                    .logoutSuccessUrl("/")
                    .invalidateHttpSession(true);

        }

       /* @Autowired
        public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
            auth
                    .inMemoryAuthentication()
                    .withUser("user").password("password").roles("USER");
        }*/
    }

