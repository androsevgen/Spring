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
                <li ><a href="./">Главная</a></li>
                <!--  <li><a href="#">Доставка</a></li>
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
                    <li class="active"><a href="./logout"><span class="glyphicon glyphicon-user"></span>Выход</a></li>
                    <li><a href="/basket"><span class="glyphicon glyphicon-shopping-cart"></span>Корзина</a></li>
                </sec:authorize>
            </ul>
        </div>
    </div>
</nav>


<div class="container">
    <div class="row">

        <div class="col-sm-8">
            <div class="panel panel-success">
                <div class="panel-heading">История заказов</div>

                <div class="panel-body">
                    <!-- <div class="container"> -->
                    <table class="table table-bordered">
                        <thead>
                        <tr>
                            <th>Номер заказа</th>
                            <th>Дата</th>
                            <th>Товар</th>
                            <th>Цена</th>
                            <th>Статус</th>

                        </tr>
                        </thead>

                        <tbody id="prods">

                        </tbody>
                    </table>

                </div>
                <div class="panel-footer"></div>
            </div>
        </div>


        <div class="row">
            <div class="col-sm-4">
                <div class="panel panel-warning">
                    <div class="panel-heading">Личная информация</div>
                    <div class="panel-body">
                      <form enctype="multipart/form-data" action="./update_user" method="post">
                            <div  class="panel panel-info">
                                <input type="text" class="form-control" id="name" name="name" size="5" placeholder="Name">
                            </div>

                            <div  class="panel panel-info">
                                <input type="text" class="form-control" id="phone" name="phone" size="5" placeholder="Phone">
                            </div>

                            <div  class="panel panel-info">
                                <input type="text" class="form-control" id="adress" name="adress" size="5" placeholder="Adress">
                            </div>

                            <div  class="panel panel-info">
                                <input type="text" class="form-control" id="email" name="email" size="5" placeholder="Email">
                            </div>

                            <div  class="panel panel-info">
                                <input type="password" class="form-control" id="password" name="password" size="5" placeholder="Password">
                            </div>

                            <div>
                                <button type="submit" class="btn btn-success"  value="add">Обновить</button>
                            </div>
                      </form>
                    </div>
                    </div>
                </div>
            </div>
        </div>


    </div>
</div>

<script>
    jQuery(function(){
        const name = document.getElementById('name');
        const phone = document.getElementById('phone');
        const adress = document.getElementById('adress');
        const email = document.getElementById('email');
        const password = document.getElementById('password');

        function getCats(callback) {
            jQuery.ajax({
                url: './get_user',
                method: 'GET',
                success: callback
            });
        }

        function renderProds(response) {
            name.value = response.name;
            phone.value = response.phone;
            adress.value = response.adress;
            email.value = response.email;
            password.value = response.password;

        }


        getCats(renderProds);
    });
</script>

<script>
    jQuery(function(){
        const getProds = document.getElementById('prods');

        function getCats(callback) {
            jQuery.ajax({
                url: './get_userords',
                method: 'GET',
                success: callback
            });
        }

        function renderProds(response) {
            const ords = response;

            for (let i = 0; i < ords.length; i++) {
                const item = ords[i];
                const tr = document.createElement('tr');
                const id = document.createElement('td');
                const date = document.createElement('td');
                const goods = document.createElement('td');
                const price = document.createElement('td');
                const status = document.createElement('td');

                id.innerHTML = item.id;
                date.innerHTML = item.date;
                var g = ""
                var pr = 0;
                for(let i = 0; i<item.orderLinks.length; i++){
                    const ord = item.orderLinks[i];
                    g = g+"<div>"+ord.product.name+"</div>";
                    pr += ord.product.price;
                }
                goods.innerHTML = g;
                price.innerHTML = pr;
                if(item.confirmed == 0) {
                    status.innerHTML = "В обработке";
                }
                if(item.confirmed == 1) {
                    status.innerHTML = "Выполнен";
                }
                tr.appendChild(id);
                tr.appendChild(date);
                tr.appendChild(goods);
                tr.appendChild(price);
                tr.appendChild(status);
                getProds.appendChild(tr);
            }

        }


        getCats(renderProds);
    });
</script>

</body>
</html>
