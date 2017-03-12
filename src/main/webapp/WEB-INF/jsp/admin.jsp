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
                <li class="active"><a href="./admin">Goods <span class="sr-only">(current)</span></a></li>
                <li><a href="./aorders">Orders</a></li>
             <%--   <li class="dropdown">
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

<div class="container">
    <div class="row">
        <div class="col-sm-4">
            <div class="panel panel-default">
                <div class="panel-heading">Добавить товар</div>
                <div class="panel-body">
                    <form enctype="multipart/form-data" action="./addgoods" method="post">
                    <img src="https://placehold.it/150x80?text=IMAGE" class="img-responsive" style="width:100%" alt="Image">

                    <div class="panel panel-default">Photo: <input type="file" name="photo"></div>
                        <div class="panel panel-default">
                            <input type="text" class="form-control" name="name" size="5" placeholder="Наименование">
                        </div>
                    <div class="panel panel-default">


                            Категория:   <select class="dropdown-toggle" name="cat" data-toggle="dropdown" id="mySelect"></select>


                    </div>

                    <div class="panel panel-default">
                        <input type="text" class="form-control" name="price" size="5" placeholder="Цена">
                    </div>

                    <div class="panel panel-default">
                        <label for="comment">Описание:</label>
                        <textarea class="form-control" rows="5" name="comment" id="comment"></textarea>
                    </div>

                    <div class="panel panel-default">
                        <button type="submit" class="btn btn-success" value="add">Добавить</button>
                    </div>
                    </form>


                </div>
                <div class="panel-footer">
                    <form action="./addcat" method="post">
                        <input type="text" class="form-control" name="name" size="5" placeholder="Новая категория">
                        <button type="submit" class="btn btn-default">Создать</button>
                        </form>
            </div>
        </div>
      </div>

        <div class="col-sm-8">
            <div class="panel panel-success">
                <div class="panel-heading">ВСЕ ТОВАРЫ</div>

                <div class="panel-body">
                   <!-- <div class="container"> -->
                        <table class="table table-bordered">
                            <thead>
                            <tr>
                                <th>id</th>
                                <th>Наименование</th>
                                <th>Категория</th>
                                <th>Цена</th>
                                <th>edit</th>
                                <th>delete</th>

                            </tr>
                            </thead>

                            <tbody id="prods">

                            </tbody>
                        </table>
                  <!--  </div> -->
                   <!-- <p id="prods"></p> -->

                </div>
                <div class="panel-footer">Buy 50 mobiles and get a gift card</div>
            </div>
        </div>

    </div>
</div>
</div>

<script>
    jQuery(function(){
        const mySelect = document.getElementById('mySelect');

        function getCats(callback) {
            jQuery.ajax({
                url: './allCats',
                method: 'GET',
                success: callback
            });
        }

        function renderCats(response) {
            for (let i = 0; i < response.length; i++) {
                const option = document.createElement('option');
                const item = response[i];
                option.innerHTML = item.name;
                option.value = item.id;
                mySelect.appendChild(option);
            }
        }

        getCats(renderCats);
    });
</script>




<script>
    jQuery(function(){
        const getProds = document.getElementById('prods');

        function getCats(callback) {
            jQuery.ajax({
                url: './all_prods',
                method: 'GET',
                success: callback
            });
        }

        function renderProds(response) {




            for (let i = 0; i < response.length; i++) {
                const tr = document.createElement('tr');
                const id = document.createElement('td');
                const name = document.createElement('td');
                const cat = document.createElement('td');
                const price = document.createElement('td');
                const edit = document.createElement('td');
                const del = document.createElement('td');


                const item = response[i];
                id.innerHTML = item.id;
                name.innerHTML = item.name;
                cat.innerHTML = item.category.name;
                price.innerHTML = item.price;

                edit.innerHTML = "<form action=\"/edit\" method=\"post\"><button type=\"submit\" class=\"btn btn-default btn-lg pull-right\" name=\"id\" value=\""+item.id+"\"> <span class=\"glyphicon glyphicon-pencil\" aria-hidden=\"true\"></span></button></form>"
                del.innerHTML = "<form action=\"/delete\" method=\"post\"><button type=\"submit\" class=\"btn btn-default btn-lg pull-right\"  name=\"id\" value=\""+item.id+"\"> <span class=\"glyphicon glyphicon-remove\" aria-hidden=\"true\"></span></button></form>"


                tr.appendChild(id);
                tr.appendChild(name);
                tr.appendChild(cat);
                tr.appendChild(price);
                tr.appendChild(edit);
                tr.appendChild(del);
                getProds.appendChild(tr);
            }
        }

        getCats(renderProds);
    });
</script>

</body>
</html>


</body>
</html>