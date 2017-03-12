<%--
  Created by IntelliJ IDEA.
  User: Andros
  Date: 22.02.2017
  Time: 11:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>edit goods</title>
    <link rel="stylesheet" href="./css/bootstrap.css" media="screen">
    <link rel="stylesheet" href="./css/custom.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
    <div class="row">
<div class="col-sm-4">
    <div class="panel panel-default">
        <div class="panel-heading">Добавить товар</div>
        <div class="panel-body">
            <form enctype="multipart/form-data" action="./addgoods" method="post">
                <img src="https://placehold.it/150x80?text=IMAGE" class="img-responsive" style="width:100%" alt="Image" id = "image">

                <div class="panel panel-default">Photo: <input type="file" name="photo"></div>
                <div class="panel panel-default">
                    <input type="text" class="form-control" name="name" size="5" placeholder="Наименование" id="prodname">
                </div>
                <div class="panel panel-default">


                    Категория:   <select class="dropdown-toggle" name="cat" data-toggle="dropdown" id="mySelect"></select>


                </div>

                <div class="panel panel-default">
                    <input type="text" class="form-control" name="price" size="5" placeholder="Цена" id="price">
                </div>

                <div class="panel panel-default">
                    <label for="comment">Описание:</label>
                    <textarea class="form-control" rows="5" name="comment" id="comment"></textarea>
                </div>

                <div class="panel panel-default">
                    <input type="hidden" class="form-control" name="id" id="id">
                    <button type="submit" class="btn btn-success" value="add">Сохранить</button>
                </div>
            </form>


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

    var prod = ${prod};
    const name = document.getElementById('prodname');
    const price = document.getElementById('price');
    const comment = document.getElementById('comment');
    const cat = document.getElementById('mySelect');
    const photo = document.getElementById('image');
    const id = document.getElementById('id');
    id.value = prod.id;
    name.value = prod.name;
    price.value = prod.price;
    comment.value = prod.desc;
    cat.value = prod.cat;
    photo.src = prod.photo;





</script>


</body>
</html>
