package com.example.controllers;

import com.example.dao.BasketDao;
import com.example.dao.ProductDao;
import com.example.dao.UserDao;
import com.example.entities.Basket;
import com.example.entities.Product;
import com.example.entities.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.security.Principal;

/**
 * Created by Andros on 23.02.2017.
 */
@Controller
public class BasketController {

    @Autowired
    UserDao userDao;
    @Autowired
    BasketDao basketDao;
    @Autowired
    ProductDao productDao;

    Basket basket;
    User user;

    @RequestMapping(value = "/basket",method = RequestMethod.GET)
    public ModelAndView basket() {
       return new ModelAndView("basket");

    }

    //добавляет продукт в корзину по ИД
    @RequestMapping(value = "/prod_add2basket",method = RequestMethod.POST)
    public String add2bascet(@RequestParam(value = "id") long id, Principal principal, HttpServletRequest request, HttpServletResponse response) {
        Product product = productDao.findOne(id);
        User user = userDao.findByemail(principal.getName()).get(0);
        Basket basket = new Basket();
        basket.setProduct(product);
        basket.setUser(user);
        basketDao.saveAndFlush(basket);
        return "index";
    }

    //удаляет продукт из корзины по ИД
    @RequestMapping(value = "/delete_basket",method = RequestMethod.POST)
    public String del(@RequestParam(value = "id") long id) {
                basketDao.delete(id);
                return "basket";
    }

}
