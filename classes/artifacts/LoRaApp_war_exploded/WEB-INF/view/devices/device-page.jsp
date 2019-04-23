<%--
  Created by IntelliJ IDEA.
  User: azlup
  Date: 09.04.2019
  Time: 16:07
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
            <h2>Show Device</h2>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-8">
            <form class="form-horizontal">
                <div class="form-group">
                    <div class="col-sm-10">
                        <p class="form-control-static">Device Id: ${device.id}</p>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-10">
                        <p class="form-control-static">Device name: ${device.name}</p>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-10">
                        <p class="form-control-static">Device uniqueId: ${device.uniqueId}</p>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-10">
                        <p class="form-control-static">Device account id: ${device.account.id}</p>
                    </div>
                </div>

                <div class="panel-heading"><h1> Users list</h1></div>
                <div class="panel-body">

                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th>Username</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Email</th>
                        </tr>
                        </thead>
                        <tbody>
                        <!-- loop over and print our customers -->
                        <c:if test="${not empty device.users}" >
                        <c:forEach var="tempUser" items="${device.users}">



                            <%--constructing update link--%>
                            <%--<c:url var="updateUserLink" value="/users/showFormForUpdate">--%>
                                <%--<c:param name="userId" value="${tempUser.id}"/>--%>
                            <%--</c:url>--%>




                            <tr>
                                <td> ${tempUser.userName} </td>
                                <td> ${tempUser.firstName} </td>
                                <td> ${tempUser.lastName} </td>
                                <td> ${tempUser.email} </td>




                            </tr>

                        </c:forEach>
                        </c:if>
                        </tbody>
                    </table>
                </div>

                <%--tu ma być button--%>
                <security:authorize access="hasRole('ADMIN')">

                    <!-- Add a link to point to /systems ... this is for the admins -->

                    <%--<p>--%>
                        <%--<a href="${pageContext.request.contextPath}/systems">IT Systems Meeting</a>--%>
                        <%--(Only for Admin peeps)--%>
                    <%--</p>--%>


                <div class="dropdown">
                    <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">Add User To Device
                        <span class="caret"></span></button>
                    <ul class="dropdown-menu">

                        <c:forEach var="availUser" items="${availableUsers}">

                            <%--constructing add user to devicelink--%>
                            <c:url var="addUserToDevice" value="/devices/addUserToDevice">
                                <c:param name="userId" value="${availUser.id}"/>
                                <c:param name="deviceId" value="${device.id}"/>
                            </c:url>
                        <li><a href="${addUserToDevice}">${availUser.userName}</a></li>


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
