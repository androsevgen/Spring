package com.example.controllers;

import com.example.dao.UserDao;
import com.example.entities.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.security.Principal;

/**
 * Created by Andros on 24.01.2017.
 */


@Controller
public class MainController {

    @Autowired
    private UserDao userDao;

    @RequestMapping("/")
    public ModelAndView index() {
        ModelAndView mw = new ModelAndView("index");


        return mw;
    }

    @RequestMapping("/admin")
    public ModelAndView login() {
        ModelAndView mw = new ModelAndView("admin");

        return mw;
    }


    @RequestMapping("/lk")
    public ModelAndView lk() {
        ModelAndView mw = new ModelAndView("lk");

        return mw;
    }

    //Регестрируем нового юзера и редиректим его на страницу для логина с новыми данными
    @RequestMapping(value="/new_user" , method = RequestMethod.POST)
    public ModelAndView register(@RequestParam(value = "name") String name,
                                 @RequestParam(value = "adress", required = false) String adress,
                                 @RequestParam(value = "phone", required = false) String phone,
                                 @RequestParam(value = "email") String email,
                                 @RequestParam(value = "password") String password,
                                 HttpServletRequest request) {
        ModelAndView mw = new ModelAndView("login_redirect");
        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        userDao.saveAndFlush(user);
        mw.addObject("email", email);
        mw.addObject("password", password);
        return mw;
    }


    //редактирует юзера
    @RequestMapping(value ="/update_user", method = RequestMethod.POST)
    public ModelAndView update_user(Principal principal,
                                    @RequestParam(value = "name") String name,
                                    @RequestParam(value = "adress", required = false) String adress,
                                    @RequestParam(value = "phone", required = false) String phone,
                                    @RequestParam(value = "email") String email,
                                    @RequestParam(value = "password") String password) {
        User user = userDao.findByemail(email).get(0);
        user.setName(name);
        user.setAdress(adress);
        user.setPhone(phone);
        user.setEmail(email);
        user.setPassword(password);
        userDao.saveAndFlush(user);
        ModelAndView mw = new ModelAndView("lk");

        return mw;
    }
}
