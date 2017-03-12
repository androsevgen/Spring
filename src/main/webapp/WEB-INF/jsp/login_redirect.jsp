<%--
  Created by IntelliJ IDEA.
  User: Andros
  Date: 27.01.2017
  Time: 20:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form name="myForm" id="submit" action="/j_spring_security_check" method="POST">
    <p>
        <input name="j_username" value="${email}" hidden="true" />
        <input name="j_password" value="${password}" hidden="true" />
    </p>
    <p>
        <input type="submit" value="Submit" hidden="true"/>
    </p>
</form>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript">
    $(function(){
        $("#submit").submit();
    });
</script>
</body>
</html>
