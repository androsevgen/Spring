package com.example.controllers;

import com.example.dao.CategoryDao;
import com.example.dao.OrderDao;
import com.example.dao.ProductDao;
import com.example.entities.Category;
import com.example.entities.Order;
import com.example.entities.Product;
import com.google.gson.JsonObject;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.IOException;

/**
 * Created by Andros on 04.02.2017.
 */

@Controller
public class AdminPageController implements ServletContextAware {

    @Autowired
    private CategoryDao catDao;

    @Autowired
    private ProductDao productDao;

    @Autowired
    private OrderDao orderDao;


    ServletContext servletContext;

    //редактирует товар
    @RequestMapping(value="/edit" , method = RequestMethod.POST)
    public ModelAndView edit(@RequestParam(value = "id") long id) {
        ModelAndView editMV = new ModelAndView("edit");
        JsonObject j = getJSONProduct(id);
        editMV.addObject("prod", j);
        return editMV;
    }

    //удалить заказ
    @RequestMapping(value = "/delete_order", method = RequestMethod.POST)
    public String delOrder(Long id) {
     orderDao.delete(id);
        return "aorders";
    }

    //подтвердить заказ
    @RequestMapping(value = "/confirm_order", method = RequestMethod.POST)
    public String confOrder(Long id) {
        Order order = orderDao.findOne(id);
        order.setConfirmed(1);
        orderDao.saveAndFlush(order);
        return "aorders";
    }


   /* @RequestMapping("/get_order0")
    public ModelAndView getOrder0() {
        ModelAndView mw = new ModelAndView("aorders");

        return mw;
    }*/

    //возвращает страницу с новыми заказами
    @RequestMapping("/aorders")
    public ModelAndView orders() {
        ModelAndView mw = new ModelAndView("aorders");
        return mw;
    }

    //удалить продукт
    @RequestMapping(value="/delete" , method = RequestMethod.POST)
    public String delete(@RequestParam(value = "id") long id) {
        productDao.delete(id);
        return "admin";
    }

    //добавить новую категорию товаров
    @RequestMapping(value="/addcat" , method = RequestMethod.POST)
    public ModelAndView index(@RequestParam(value = "name") String name) {
        Category cat = new Category();
        cat.setName(name);
        catDao.saveAndFlush(cat);
        ModelAndView mw = new ModelAndView("admin");
        return mw;
    }

    //добавить новый товар
    @RequestMapping(value="/addgoods" , method = RequestMethod.POST)
    public ModelAndView addGoods(@RequestParam(value = "name") String name,
                                 @RequestParam(value = "cat") long cat,
                                 @RequestParam(value = "price") double price,
                                 @RequestParam(value = "comment") String desc,
                                 @RequestParam(value = "photo") MultipartFile photo,
                                 @RequestParam(value = "id", required = false) Long id
    ) {

        ModelAndView mw = new ModelAndView("admin");
        try {
            File file = new File("");
            String path="";
            if (photo.isEmpty()){
                path = productDao.getOne(id).getPhoto();
            } else {
                file = new File(servletContext.getRealPath("/")+"WEB-INF/classes/public/img/goods/"+ System.currentTimeMillis()+photo.getOriginalFilename());
                FileUtils.writeByteArrayToFile(file, photo.getBytes());
                path = file.getAbsolutePath().replace(servletContext.getRealPath("/")+"WEB-INF\\classes\\public", "").replace("\\","/");
            }
            Category category = catDao.getOne(cat);
            Product p = new Product(id, name, category, price, path, desc);
            productDao.saveAndFlush(p);

        } catch (IOException e) {
            e.printStackTrace();
        }
        return mw;
    }

    @Override
    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    //метод отдающий продукт как JSON объект
    public JsonObject getJSONProduct(long id){
        Product product = productDao.getOne(id);
        JsonObject j = new JsonObject();
        j.addProperty("id", product.getId());
        j.addProperty("name",product.getName());
        j.addProperty("desc", product.getDescription());
        j.addProperty("photo",product.getPhoto());
        j.addProperty("price", product.getPrice());
        j.addProperty("cat", product.getCategory().getId());
        j.addProperty("photo", product.getPhoto().replace(servletContext.getRealPath("/")+"WEB-INF\\classes\\public", "").replace("\\","/"));
        return j;
    }
}



