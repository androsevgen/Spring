<%--
  Created by IntelliJ IDEA.
  User: Andros
  Date: 27.01.2017
  Time: 21:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="ru">
<head>
    <meta charset="utf-8">
    <title>admin</title>
    <link rel="stylesheet" href="./css/bootstrap.css" media="screen">
    <link rel="stylesheet" href="./css/custom.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <!-- Latest compiled and minified CSS-->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.1/css/bootstrap-select.min.css">

    <!-- Latest compiled and minified JavaScript
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-select/1.12.1/js/bootstrap-select.min.js"></script> -->

</head>
<body>
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">Brand</a>
        </div>

        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
            <ul class="nav navbar-nav">
                <li class="active"><a href="./admin">Goods</a></li>
                <li><a href="./aorders">Orders <span class="sr-only">(current)</span></a></li>
                <%--<li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Dropdown <span class="caret"></span></a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a href="#">Action</a></li>
                        <li><a href="#">Another action</a></li>
                        <li><a href="#">Something else here</a></li>
                        <li class="divider"></li>
                        <li><a href="#">Separated link</a></li>
                        <li class="divider"></li>
                        <li><a href="#">One more separated link</a></li>
                    </ul>
                </li>
            </ul>
            <form class="navbar-form navbar-left" role="search">
                <div class="form-group">
                    <input type="text" class="form-control" placeholder="Search">
                </div>
                <button type="submit" class="btn btn-default">Submit</button>
            </form>--%>
            <ul class="nav navbar-nav navbar-right">
                <li><a href="./">Home</a></li>
            </ul>
        </div>
    </div>
</nav>


<div class="col-sm-8">
    <div class="panel panel-success">
        <div class="panel-heading">Заказы</div>

        <div class="panel-body">
            <!-- <div class="container"> -->
            <table class="table table-bordered">
                <thead>
                <tr>
                    <th>Номер заказа</th>
                    <th>Пользователь</th>
                    <th>Дата</th>
                    <th>Товар</th>
                    <th>Цена</th>
                    <th>Подтвердить</th>
                    <th>Удалить</th>
                </tr>
                </thead>

                <tbody id="prods">

                </tbody>
            </table>

        </div>
        <div class="panel-footer"></div>
    </div>
</div>


<script>

    jQuery(function(){
    const getProds = document.getElementById('prods');
    function getCats(callback) {
        jQuery.ajax({
            url: './get_orders0',
            method: 'GET',
            success: callback
        });
    }
    var allorders ;
    function renderProds(response) {
        allorders = response;
        for (let i = 0; i < response.length; i++) {
            const item = response[i];

            const tr = document.createElement('tr');
            const id = document.createElement('td');
            const user = document.createElement('td');
            const date = document.createElement('td');
            const goods = document.createElement('td');
            const price = document.createElement('td');
            const confirm = document.createElement('td');
            const del = document.createElement('td');


            id.innerHTML = item.id;
            user.innerHTML = item.user.email;
            date.innerHTML = item.date;

            var listProds = ""
            var allprice = 0;
            for (let i = 0; i < item.orderLinks.length; i++) {
                const prod = item.orderLinks[i].product;
                listProds += "<div>" + prod.name + "</div>";
                allprice += prod.price;
            }
            goods.innerHTML = listProds;
            price.innerHTML = allprice;
           // "+item.id+"  del.innerHTML = "<form action=\"/delete_order\" enctype=\"application/json\" method=\"post\"><button type=\"submit\" class=\"btn btn-default btn-lg pull-right\" value=\""+JSON.stringify(item)+"\"> <span class=\"glyphicon glyphicon-remove\" aria-hidden=\"true\"></span></button></form>"
            confirm.innerHTML = "<button onClick=\"confirmB("+item.id+")\" type=\"submit\" class=\"btn btn-default btn-lg pull-right\" > <span class=\"glyphicon glyphicon-ok\" aria-hidden=\"true\"></span></button>"
            del.innerHTML = "<button onClick=\"deleteB("+item.id+")\" type=\"submit\" class=\"btn btn-default btn-lg pull-right\" > <span class=\"glyphicon glyphicon-remove\" aria-hidden=\"true\"></span></button>"


            tr.appendChild(id);
            tr.appendChild(user);
            tr.appendChild(date);
            tr.appendChild(goods);
            tr.appendChild(price);
            tr.appendChild(confirm);
            tr.appendChild(del);
            getProds.appendChild(tr);
        }
    }
        deleteB = function(orderitem){
            var ord = orderitem;
            alert(ord);

            $.ajax({
                url: "/delete_order",
                type: "POST",
                data: "id="+ord,
                dataType: "json",
                statusCode: {
                    200: function() {
                        location.href = "aorders"
                    }
                }

            });
        }

        confirmB = function(orderitem){
            var ord = orderitem;

                      $.ajax({
                url: "/confirm_order",
                type: "POST",
                data: "id="+ord,
                dataType: "json",
                statusCode: {
                    200: function() {
                        location.href = "aorders"
                    }
                }

            });
        }

        getCats(renderProds);
    });


</script>

</body>
</html>

