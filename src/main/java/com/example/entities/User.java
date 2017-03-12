package com.example.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import javax.persistence.*;
import java.util.List;

/**
 * Created by Andros on 24.01.2017.
 */
@Entity
@Table(name="Users")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;
    private String name;
    private String adress;
    private String phone;
    @Column(unique = true, nullable = false)
    private String email;
    private String password;



    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL) //cascade = CascadeType.ALL,
    private List<Basket> basket;

    @OneToMany(mappedBy = "user", cascade = CascadeType.ALL) //cascade = CascadeType.ALL,
    @JsonIgnore
    private List<Order> orders;

    /*@OneToMany(mappedBy="user", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Product> basket = new ArrayList<Product>();*/

    /*public void addOrder(Order order) {
        orders.add(order);
    }
    public void setOrders(List<Order> orders){
        this.orders = orders;
    }
    public List<Order> getOrders(){
        return orders;
    }*/

    public User(){}
    public User(String name, String adress, String phone, String email, String password) {
        this.name = name;
        this.adress = adress;
        this.phone = phone;
        this.email = email;
        this.password = password;
    }

    public List<Basket> getBasket() {
        return basket;
    }

    public void setBasket(List<Basket> basket) {
        this.basket = basket;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAdress() {
        return adress;
    }

    public void setAdress(String adress) {
        this.adress = adress;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }
    public List<Order> getOrders() {
        return orders;
    }

    public void setOrders(List<Order> orders) {
        this.orders = orders;
    }
}
