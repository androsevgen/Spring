package com.example.controllers;
import com.example.dao.*;
import com.example.entities.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

/**
 * Created by Andros on 25.01.2017.
 */
@RestController
public class RestControllers {

    @Autowired
    UserDao userDao;

    @Autowired
    CategoryDao catdao;

    @Autowired
    ProductDao productDao;

    @Autowired
    BasketDao basketDao;

    @Autowired
    OrderDao orderDao;

    @Autowired
    OrderLinksDao orderLinksDao;

    //submit order from basket
    //delete goods from basket and add it to order
    @RequestMapping(value ="/submit_order",  method = RequestMethod.POST)
    public void submitordr(@RequestBody List<Basket> baskets, Principal principal) {
        User user =  userDao.findByemail(principal.getName()).get(0);
        orderDao.saveAndFlush(new Order(user, baskets));
        basketDao.deleteInBatch(user.getBasket());
    }

    @RequestMapping("/t")
    public List<Category> greeting() {
        return catdao.findAll();
    }


    //отдает все продукты для главной, если в запросе присудствует параметр cat - отдает(фильтрует) товары с катигорией
    @RequestMapping("/all_prods")
    public List<Product> getProds(@RequestParam(value = "cat", required = false)Long id) {

        List<Product> prods = productDao.findAll();
        if (id != null){
            prods = productDao.findByCategory(catdao.findOne(id));
        }
         return prods;
    }


    //отдает все категории товаров
    @RequestMapping("/allCats")
    public List<Category> allcats() {
        List<Category> cats = catdao.findAll();
        return cats;
    }

    //отдает залогиненого юзера
    @RequestMapping("/get_user")
    public User getUser(Principal principal) {
        return userDao.findByemail(principal.getName()).get(0);
    }


    //отдает список товаров в корзине залогиненого юзера
    @RequestMapping("/get_basket")
    public List<Basket> getBasket(Principal principal) {
        return userDao.findByemail(principal.getName()).get(0).getBasket();
    }

    //отдает список новых (не подтвержденных) заказов
    @RequestMapping("/get_orders0")
    public List<Order> getOrders0() {
        List<Order> orders = orderDao.findByConfirmed(0);
        return orders;
    }

    //отдает все заказы залогиненого юзера
    @RequestMapping("/get_userords")
    public List<Order> getUserOrders0(Principal principal) {
        List<Order> orders = orderDao.findByUser(userDao.findByemail(principal.getName()).get(0));
        return orders;
    }

}
