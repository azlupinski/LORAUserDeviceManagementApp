<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">

<head>
	<title>Registration Confirmation</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
</head>

<body>
<%@include file="/WEB-INF/view/hader/navigation.jsp"%>
<div class="container" style="margin-top:70px">

	<h2>User registered successfully!</h2>

	<hr>
	
	<a href="${pageContext.request.contextPath}/users/showMyLoginPage">Login with new user</a>
	<hr>
	<a href="${pageContext.request.contextPath}/">Back to homepage</a>"
</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</body>

</html>