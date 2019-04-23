<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="input" uri="http://www.springframework.org/tags/form" %>
<!doctype html>
<html lang="en">

<head>
    <title>LoRa DooR LocK Homepage Company</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/viewResources/styles.css"/>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">



</head>

<body>

<%@include file="hader/navigation.jsp"%>
<div class="container" style="margin-top:50px">


    <h2>LoRa DooR LocK Homepage Company</h2>
    <hr>

    <p>
        Welcome to LoRa company home page!
    </p>


    <hr>

    <!-- display user name and role -->
    <div class="panel-group" >
        <div class="panel panel-default">
            <div class="panel panel-heading"> User info</div>
            <div class="panel-body">
                User: <security:authentication property="principal.username"/>
                <br><br>
                Role(s): <security:authentication property="principal.authorities"/>
                <br><br>
                First name: ${user.firstName}, Last name: ${user.lastName}, Email: ${user.email}, Account
                id: ${user.account.id}
            </div>
        </div>
    </div>



        <hr>

        <a href="${pageContext.request.contextPath}/users/regularUserRegistration"> create new user</a>

        <a href="${pageContext.request.contextPath}/devices/addDeviceForm"> add device</a>



    <hr>



    <div class="row content">
        <div class="panel panel-default">
            <div class="panel-heading"><h1>Devices</h1></div>
            <div class="panel-body">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>Name</th>
                        <th>Unique id</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- loop over and print our customers -->
                    <c:forEach var="tempDevice" items="${devices}">

                        <%--constructing update link--%>
                        <c:url var="updateDeviceLink" value="">
                            <c:param name="customerId" value="${tempDevice.id}"/>
                        </c:url>


                        <%--constructing delete link--%>
                        <c:url var="deleteDeviceLink" value="/devices/deleteDevice">
                            <c:param name="deviceId" value="${tempDevice.id}"/>
                        </c:url>

                        <%--constructing consrtucting send message link--%>

                        <c:url var="sendMessageLink" value="/devices/sendMsgToDevice">
                            <c:param name="deviceId" value="${tempDevice.id}"/>
                            <c:param name="textMessage" value="ziomek poziomek" />
                        </c:url>


                        <tr>
                            <td> ${tempDevice.name} </td>
                            <td> ${tempDevice.uniqueId} </td>

                            <td>
                                    <%--display lkink--%>
                                <a href="${updateDeviceLink}">Update</a>
                                |
                                <a href="${deleteDeviceLink}"
                                   onclick="if (!(confirm('Are you sure you want to delete this customer'))) return false">Delete</a>
                                |
                                        <form action="/devices/sendMsgToDevice" method="get">
                                            <input type="hidden" name="deviceId" value="${tempDevice.id}">
                                            Write message: <input type="text" name="textMessage">
                                            <button type="submit" >Send</button>
                                        </form>
                                <a href="${sendMessageLink}">sendMessage</a>
                            </td>


                        </tr>

                    </c:forEach>
                    </tbody>
                </table>
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









