<%--
  Created by IntelliJ IDEA.
  User: azlup
  Date: 10.04.2019
  Time: 18:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
<head>
    <title>DevicePage</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
</head>
<body>
<%@include file="/WEB-INF/view/hader/navigation.jsp"%>

<div class="container" style="margin-top:70px">
    <div class="row">
        <div class="col-sm-6">
            <h2>Show User</h2>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-8">
            <form class="form-horizontal">
                <div class="form-group">
                    <div class="col-sm-10">
                        <p class="form-control-static">UserId: ${user.id}</p>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-10">
                        <p class="form-control-static">user name: ${user.userName}</p>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-10">
                        <p class="form-control-static">user Last name: ${user.lastName}</p>
                    </div>
                </div>

                <div class="panel-heading"><h1> Device list</h1></div>
                <div class="panel-body">

                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th>Device name</th>
                            <th>unique id</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- loop over and print our customers -->
                        <c:if test="${not empty user.devices}" >
                            <c:forEach var="tempDevice" items="${user.devices}">



                                <%--constructing update link--%>
                                <%--<c:url var="updateUserLink" value="/users/showFormForUpdate">--%>
                                <%--<c:param name="userId" value="${tempUser.id}"/>--%>
                                <%--</c:url>--%>




                                <tr>
                                    <td> ${tempDevice.name} </td>
                                    <td> ${tempDevice.uniqueId} </td>

                                </tr>

                            </c:forEach>
                        </c:if>
                        </tbody>
                    </table>
                </div>
                <security:authorize access="hasRole('ADMIN')">
                <%--tu ma być button--%>
                <div class="dropdown">
                    <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">Add User To Device
                        <span class="caret"></span></button>
                    <ul class="dropdown-menu">

                        <c:forEach var="availDevice" items="${availableDevices}">
                            <%--constructing add user to devicelink--%>
                            <c:url var="addDeviceToUser" value="/users/addDeviceToUser">
                                <c:param name="userId" value="${user.id}"/>
                                <c:param name="deviceId" value="${availDevice.id}"/>
                            </c:url>
                            <li><a href="${addDeviceToUser}">${availDevice.name}</a></li>
                            <%--<li><a href="#">CSS</a></li>--%>
                            <%--<li><a href="#">JavaScript</a></li>--%>
                        </c:forEach>
                    </ul>
                </div>
                </security:authorize>
            </form>
        </div>
    </div>

</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</body>
</html>
