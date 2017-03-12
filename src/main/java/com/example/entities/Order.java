package com.example.entities;

import javax.persistence.*;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Andros on 24.01.2017.
 */
@Entity
@Table(name="Orders")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "client_id")
    //@JsonIgnore
    private User user;

    private int confirmed;
    private Date date;

    @OneToMany(mappedBy= "order", cascade = CascadeType.ALL, fetch = FetchType.EAGER, orphanRemoval=true)
    private List<OrderLink> orderLinks= new ArrayList<>();
    public Order(){}

    public Order(User user, List<Basket> baskets ) {
        this.user = user;
        date = new Date(System.currentTimeMillis());
        for (Basket b : baskets){
            OrderLink ol = new OrderLink();
            ol.setOrder(this);
            ol.setP(b.getProduct());
            this.getOrderLinks().add(ol);
        }
        confirmed = 0;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }



    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getConfirmed() {
        return confirmed;
    }

    public void setConfirmed(int confirmed) {
        this.confirmed = confirmed;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public List<OrderLink> getOrderLinks() {
        return orderLinks;
    }

    public void setOrderLinks(List<OrderLink> orderLinks) {
        this.orderLinks = orderLinks;
    }
}