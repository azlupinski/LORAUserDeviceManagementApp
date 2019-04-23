<%--
  Created by IntelliJ IDEA.
  User: azlup
  Date: 19.03.2019
  Time: 13:44
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <title>Welcome Page of LoRa</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/viewResources/styles.css"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
</head>
<body>
<%@include file="hader/navigation.jsp"%>


<div class="container" style="margin-top:50px">
    <div class="panel-group" >
        <div class="panel panel-default">
            <div class="panel panel-heading"> User info</div>
            <div class="panel-body">
                <a href="${pageContext.request.contextPath}/myAccount">My Account</a>
                <br><br>
            </div>
        </div>
    </div>




</div>
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</body>
</html>
