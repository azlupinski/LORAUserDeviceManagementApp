<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">

<head>
    <title>Device table</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/viewResources/styles.css"/>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">


</head>
<body>

<%@include file="/WEB-INF/view/hader/navigation.jsp"%>

<div class="container" style="margin-top:70px">
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

                        <%--constructing show device link--%>
                        <c:url var="showDeviceLink" value="/devices/showDevice">
                            <c:param name="deviceId" value="${tempDevice.id}"/>
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
                                <a href="${showDeviceLink}">Show Device</a>

                            </td>


                        </tr>

                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
</body>
</html>
