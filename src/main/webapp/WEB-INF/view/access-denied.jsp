<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
	<title>Nie masz uprawnień</title>
</head>

<body>
<%@include file="/WEB-INF/view/hader/navigation.jsp"%>
<div class="container" style="margin-top:50px">
	<h2>Access Denied - You are not authorized to access this resource.</h2>

	<hr>
	
	<a href="${pageContext.request.contextPath}/">Back to Home Page</a>
</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</body>

</html>