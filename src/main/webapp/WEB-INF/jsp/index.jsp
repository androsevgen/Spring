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
        <li class="active"><a href="#">Главная</a></li>
        <li class="dropdown">
          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Категории <span class="caret"></span></a>
          <ul class="dropdown-menu" role="menu" id="cats">
            <li><a href="./">Все</a></li>
            <li class="divider"></li>
          </ul>
        </li>
        <!-- <li><a href="#">Доставка</a></li>
      <li><a href="#">Downloads</a></li>
        <li><a href="#">О нас</a></li>
        <li><a href="#">Контакты</a></li>-->
      </ul>


      <ul class="nav navbar-nav navbar-right">
        <nav class="main-nav">
<sec:authorize access="isAnonymous()">
          <li><a class="cd-signin" href="#0"><span class="glyphicon glyphicon-user"></span>Вход</a></li>
          <li><a href="./basket"><span class="glyphicon glyphicon-shopping-cart"></span> Корзина</a></li>
</sec:authorize>
  </NAV>
        <sec:authorize access="isAuthenticated()">
          <li><a href="/lk"><span class="glyphicon glyphicon-user"></span>Кабинет</a></li>
          <li><a href="/basket"><span class="glyphicon glyphicon-shopping-cart"></span>Корзина</a></li>
        </sec:authorize>
      </ul>
    </div>
  </div>
</nav>

<div class="container">
  <div id="main_prods">
<!-- class="row"
    <div class="col-sm-3">
      <div class="panel panel-primary">
        <div class="panel-heading">BLACK FRIDAY DEAL</div>
        <div class="panel-body"><img src="https://placehold.it/150x80?text=IMAGE" class="img-responsive" style="width:100%" alt="Image"></div>
        <div>352 grn</div>
        <button type="button" class="btn btn-default btn-lg pull-right">
          <span class="glyphicon glyphicon-shopping-cart" aria-hidden="true"></span></button>
        <div class="panel-footer">

          <div>
            Buy 50 mobiles and get a gift card asdfasdfas dfasd fasd fasd fasdfasdfasdf asd fasdf asdf asdf asdf
          </div>

        </div>
      </div>
    </div>
-->
    img.no-resize {
    min-height: 40px;
    min-width: 50px;
    }
    <script>

      jQuery(function(){


        const mySelect = document.getElementById('cats');

        function getcat(callback) {
          jQuery.ajax({
            url: './allCats',
            method: 'GET',
            success: callback
          });
        }

        function rendercat(response) {
          for (let i = 0; i < response.length; i++) {
            const item = response[i];
            var li = document.createElement('li');
            var divide = document.createElement('li');
            divide.className = "divider";
            var a = document.createElement('a');
            a.setAttribute("onClick","sort("+item.id+")");
            a.innerHTML = item.name;


            li.appendChild(a);
            mySelect.appendChild(li)
            mySelect.appendChild(divide);
          }
        }


        getcat(rendercat);

        function getProds(callback) {
          jQuery.ajax({
            url: './all_prods',
            method: 'GET',
            success: callback
          });
        }

        function renderProds(response) {
          const row = document.getElementById('main_prods');
          while (row.firstChild) {
            row.removeChild(row.firstChild);
          }
          for (let i = 0; i < response.length; i++) {
            const item = response[i];
            const itemid = item.id;
            const divColSm = document.createElement('div');
            divColSm.className = "col-sm-3";

            const panelPrimary = document.createElement('div');
            panelPrimary.className = "panel panel-primary";

            const panelHeading = document.createElement('div');
            panelHeading.className = "panel-heading";
            panelHeading.innerHTML = item.name;

            const panelBody = document.createElement('div');
            panelBody.className = "panel-body";

            const img = document.createElement('img');
            img.src = item.photo;
            img.className = "no-resize";
            img.width="304";
            img.height="236";
           /* img.style = "padding-top: 5px";*/

            const price = document.createElement('div');
            price.innerHTML = "<b>"+item.price+" uah</b>";


           const form = document.createElement('form');
             form.setAttribute("action","/prod_add2basket");
            form.setAttribute("method","post");

            const input = document.createElement('input');
            input.setAttribute("type","hidden");
            input.setAttribute("name","id");
            input.value = item.id;

            const button = document.createElement('button');
            button.typeName="button";
            button.className="btn btn-default btn-lg pull-right";


            const span = document.createElement('span');
            span.className = "glyphicon glyphicon-shopping-cart";
            span.setAttribute("aria-hidden","true");

            const panelFooter = document.createElement('div');
            panelFooter.className="panel-footer";

            const desc = document.createElement('div');
            desc.innerHTML = item.description;



            row.appendChild(divColSm);
            divColSm.appendChild(panelPrimary);
            panelPrimary.appendChild(panelHeading);
            panelPrimary.appendChild(panelBody);
            panelBody.appendChild(img);
            panelPrimary.appendChild(price);
            panelPrimary.appendChild(form);
            form.appendChild(input);
            form.appendChild(button);
            button.appendChild(span);
            panelPrimary.appendChild(panelFooter);
            panelFooter.appendChild(desc);

          }
        }
        sort = function(catid){
          var url = "./all_prods?cat="+catid;
          function sortProds(callback) {
            jQuery.ajax({
              url: url,
              method: 'GET',
              success: callback
            });
          }
          sortProds(renderProds)
        }

        getProds(renderProds);
      });
    </script>
 <!--
 <div class="col-sm-3">
      <div class="panel panel-danger">
        <div class="panel-heading">BLACK FRIDAY DEAL</div>
        <div class="panel-body"><img src="https://placehold.it/150x80?text=IMAGE" class="img-responsive" style="width:100%" alt="Image"></div>
        <div class="panel-footer">Buy 50 mobiles and get a gift card</div>
      </div>
    </div>
    <div class="col-sm-3">
      <div class="panel panel-success">
        <div class="panel-heading">BLACK FRIDAY DEAL</div>
        <div class="panel-body"><img src="https://placehold.it/150x80?text=IMAGE" class="img-responsive" style="width:100%" alt="Image"></div>
        <div class="panel-footer">Buy 50 mobiles and get a gift card</div>
      </div>
    </div>
    <div class="col-sm-3">
    <div class="panel panel-success">
      <div class="panel-heading">BLACK FRIDAY DEAL</div>
      <div class="panel-body"><img src="https://placehold.it/150x80?text=IMAGE" class="img-responsive" style="width:100%" alt="Image"></div>
      <div class="panel-footer">Buy 50 mobiles and get a gift card</div>
    </div>
  </div> -->
  </div>
</div>

<footer class="container-fluid text-center">
  <p>Online Store Copyright</p>
</footer>
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

<script>
  jQuery(function(){
    const mySelect = document.getElementById('main_prods');

    function getCats(callback) {
      jQuery.ajax({
        url: './all_prods',
        method: 'GET',
        success: callback
      });
    }

    function renderCats(response) {
      for (let i = 0; i < response.length; i++) {
        const item = response[i];
        var div = document.createElement("div");
        div.setAttribute("class", "col-sm-3");

        var div1 = document.createElement("div");
        div1.setAttribute("class","panel-heading");
        div1.innerHTML = item.name;
        div.appendChild(div1);

        var div2 = document.createElement("div");
        div2.setAttribute("class","panel-body");
        var img = document.createElement("img");
        img.setAttribute("src", item.valueOf("photo"));
        img.setAttribute("class","img-responsive");
        img.setAttribute("style","width:100%");
        img.setAttribute("alt","img");
        div.appendChild(div2);

        var div3 = document.createElement("div");
        div3.innerHTML = item.valueOf("price");
        div.appendChild(div3)






        /*const option = document.createElement('option');
        const item = response[i];
        option.innerHTML = item.name;
        option.value = item.id;
        mySelect.appendChild(option);*/
      }
    }

    getCats(renderCats);
  });
</script>

</body>
</html>
