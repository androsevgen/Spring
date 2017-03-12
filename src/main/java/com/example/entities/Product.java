package com.example.entities;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;

/**
 * Created by Andros on 24.01.2017.
 */
@Entity
@Table(name = "Products")
//@JsonAutoDetect
public class Product {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;


    private String name;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="category")
    private Category category;

    private double price;
    private String photo;
    private String description;

   // @ManyToOne(fetch = FetchType.LAZY)
    //@JoinColumn(name = "basket_id")
    //@JsonIgnore
    @ManyToOne//fetch = FetchType.LAZY
    @JoinColumn(name = "basket_id")
    private Basket basket;

    @ManyToOne(cascade = CascadeType.ALL)
    @JsonIgnore
    private OrderLink orderLink;



    public Product(){}

    public Product(String name, Category category, double price, String photo, String description) {

        this.name = name;
        this.category = category;
        this.price = price;
        this.photo = photo;
        this.description = description;
    }

    public Product(Long id, String name, Category category, double price, String photo, String description) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.price = price;
        this.photo = photo;
        this.description = description;
    }


    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

/*    public Order getOrder() {
        return orders;
    }

    public void setOrder(Order order) {
        this.orders = order;
    }*/

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }


    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getPhoto() {
        return photo;
    }

    public void setPhoto(String photo) {
        this.photo = photo;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }


   /* public Basket getBasket() {
        return basket;
    }

    public void setBasket(Basket basket) {
        this.basket = basket;
    }*/
    /*   public Product getProducts() {
        return product;
    }

    public void setOrders(Product p) {
        product = p;

    }*/

}