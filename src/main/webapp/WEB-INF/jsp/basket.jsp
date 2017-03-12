<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="css/reset.css"> <!-- CSS reset -->
  <link rel="stylesheet" href="css/style.css"> <!-- Gem style -->
  <script src="js/modernizr.js"></script> <!-- Modernizr -->
  <style>
    /* Remove the navbar's default rounded borders and increase the bottom margin */
    .navbar {
      margin-bottom: 50px;
      border-radius: 0;
    }

    /* Remove the jumbotron's default bottom margin */
    .jumbotron {
      margin-bottom: 0;
    }

    /* Add a gray background color and some padding to the footer */
    footer {
      background-color: #f2f2f2;
      padding: 25px;
    }
  </style>
</head>
<body>

<div class="jumbotron">
  <div class="container text-center">
    <h1>Online Store</h1>
    <p>goods & foods</p>
  </div>
</div>

<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>
      <a class="navbar-brand" href="#">Logo</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li><a href="./">Главная</a></li>
        <!--  <li><a href="#">Каталог</a></li>
          <li><a href="#">Доставка</a></li>
           <li><a href="#">Downloads</a></li>
        <li><a href="#">О нас</a></li>
        <li><a href="#">Контакты</a></li>-->
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <nav class="main-nav">
          <sec:authorize access="isAnonymous()">
            <li><a class="cd-signin" href="#0"><span class="glyphicon glyphicon-user"></span>Вход</a></li>
            <li  class="active"><a href="#"><span class="glyphicon glyphicon-shopping-cart"></span> Корзина</a></li>
          </sec:authorize>
        </NAV>
        <sec:authorize access="isAuthenticated()">
          <li><a href="./lk"><span class="glyphicon glyphicon-user"></span>Кабинет</a></li>
          <li><a href="./basket"><span class="glyphicon glyphicon-shopping-cart"></span>Корзина</a></li>
        </sec:authorize>
      </ul>
    </div>
  </div>
</nav>


<div class="col-sm-4">
 <!-- <form enctype="application/json" action="/submit_order" method="post"> -->
  <div class="panel panel-success">
    <div class="panel-heading">ВСЕ ТОВАРЫ</div>

    <div class="panel-body">
      <!-- <div class="container"> -->

      <table class="table table-bordered">
        <thead>
        <tr>
          <th>id</th>
          <th>Наименование</th>
          <th>Цена</th>
          <th>delete</th>
        </tr>
        </thead>

        <tbody id="prods">


        </tbody>

      </table>
      <!--  </div> -->
      <!-- <p id="prods"></p> -->

    </div>
    <div class="panel-footer">

      <button type="submit" class="btn btn-default" onclick="acceptB()" id="acceptbtn">Подтвердить</button>

    </div>
  </div>
   <!-- </form> -->
</div>

</div>
</div>
</div>

<script>
  jQuery(function(){
    const getProds = document.getElementById('prods');



    function getCats(callback) {
      jQuery.ajax({
        url: './get_basket',
        method: 'GET',
        success: callback
      });
    }

    var resp;

    function renderProds(response) {
        resp = response;
      for (let i = 0; i < response.length; i++) {
        const tr = document.createElement('tr');
        const id = document.createElement('td');
        const name = document.createElement('td');
        const price = document.createElement('td');

        const del = document.createElement('td');


        const item = response[i];
        id.innerHTML = item.id+"<input name=\"id\" type=\"hidden\" value=\""+item.id+"\">";
        name.innerHTML = item.product.name;
        price.innerHTML = item.product.price;

        del.innerHTML = "<form action=\"/delete_basket\" method=\"post\"><button type=\"submit\" class=\"btn btn-default btn-lg pull-right\"  name=\"id\" value=\""+item.id+"\"> <span class=\"glyphicon glyphicon-remove\" aria-hidden=\"true\"></span></button></form>"


        tr.appendChild(id);
        tr.appendChild(name);
        tr.appendChild(price);
        tr.appendChild(del);
        getProds.appendChild(tr);
      }


    }

    acceptB = function(){
      const objs = JSON.stringify(resp);

      $.ajax({
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json'
        },
        url: "/submit_order",
        type: "POST",
        data: objs,
        dataType: "json",
        statusCode: {
          200: function() {
            location.href = "lk"
          }
        }

      });

    }

    getCats(renderProds);


  });
</script>


<br><br>


<div class="cd-user-modal"> <!-- все формы на фоне затемнения-->
  <div class="cd-user-modal-container"> <!-- основной контейнер -->
    <ul class="cd-switcher">
      <li><a href="#0">Вход</a></li>
      <li><a href="#0">Регистрация</a></li>
    </ul>

    <div id="cd-login"> <!-- форма входа -->
      <form class="cd-form" action="./j_spring_security_check" method="post">
        <p class="fieldset">
          <label class="image-replace cd-email" for="signin-email">E-mail</label>
          <input class="full-width has-padding has-border" id="signin-email" type="email" name="j_username" placeholder="E-mail">
          <span class="cd-error-message">Здесь сообщение об ошибке!</span>
        </p>

        <p class="fieldset">
          <label class="image-replace cd-password" for="signin-password">Пароль</label>
          <input class="full-width has-padding has-border" id="signin-password" type="text"  name="j_password"  placeholder="Пароль">
          <a href="#0" class="hide-password">Скрыть</a>
          <span class="cd-error-message">Здесь сообщение об ошибке!</span>
        </p>

        <p class="fieldset">
          <input type="checkbox" id="remember-me" checked>
          <label for="remember-me">Запомнить меня</label>
        </p>

        <p class="fieldset">
          <button class="btn btn-lg btn-primary btn-block" type="submit">Войти</button>
        </p>
      </form>

      <p class="cd-form-bottom-message"><a href="#0">Забыли свой пароль?</a></p>
      <!-- <a href="#0" class="cd-close-form">Close</a> -->
    </div> <!-- cd-login -->

    <div id="cd-signup"> <!-- форма регистрации -->
      <form class="cd-form" action="./new_user" method="post">
        <p class="fieldset">
          <label class="image-replace cd-username" for="signup-username">Имя пользователя</label>
          <input class="full-width has-padding has-border" id="signup-username"  name="name" type="text" placeholder="Имя пользователя">
          <span class="cd-error-message">Здесь сообщение об ошибке!</span>
        </p>

        <p class="fieldset">
          <label class="image-replace cd-email" for="signup-email">E-mail</label>
          <input class="full-width has-padding has-border" id="signup-email"  name="email" type="email" placeholder="E-mail">
          <span class="cd-error-message">Здесь сообщение об ошибке!</span>
        </p>

        <p class="fieldset">
          <label class="image-replace cd-password" for="signup-password">Пароль</label>
          <input class="full-width has-padding has-border" id="signup-password"  name="password" type="text"  placeholder="Пароль">
          <a href="#0" class="hide-password">Скрыть</a>
          <span class="cd-error-message">Здесь сообщение об ошибке!</span>
        </p>

        <p class="fieldset">
          <input type="checkbox" id="accept-terms">
          <label for="accept-terms">Я согласен с <a href="#0">Условиями</a></label>
        </p>

        <p class="fieldset">
          <button class="btn btn-lg btn-primary btn-block" type="submit">Создать аккаунт"</button>
        </p>
      </form>

      <!-- <a href="#0" class="cd-close-form">Close</a> -->
    </div> <!-- cd-signup -->

    <div id="cd-reset-password"> <!-- форма восстановления пароля -->
      <p class="cd-form-message">Забыли пароль? Пожалуйста, введите адрес своей электронной почты. Вы получите ссылку, чтобы создать новый пароль.</p>

      <form class="cd-form">
        <p class="fieldset">
          <label class="image-replace cd-email" for="reset-email">E-mail</label>
          <input class="full-width has-padding has-border" id="reset-email" type="email" placeholder="E-mail">
          <span class="cd-error-message">Здесь сообщение об ошибке!</span>
        </p>

        <p class="fieldset">
          <input class="full-width has-padding" type="submit" value="Восстановить пароль">
        </p>
      </form>

      <p class="cd-form-bottom-message"><a href="#0">Вернуться к входу</a></p>
    </div> <!-- cd-reset-password -->
    <a href="#0" class="cd-close-form">Закрыть</a>
  </div> <!-- cd-user-modal-container -->
</div> <!-- cd-user-modal -->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="js/main.js"></script> <!-- Gem jQuery -->


</body>
</html>
