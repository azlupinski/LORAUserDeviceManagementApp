<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">

<head>
    <title>LUser Table</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/viewResources/styles.css"/>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">


</head>
<body>
<%@include file="/WEB-INF/view/hader/navigation.jsp"%>
<div class="container" style="margin-top:70px">
    <div class="row content">
        <div class="panel panel-default">
            <div class="panel-heading"><h1> Users</h1></div>
            <div class="panel-body">

                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>Username</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Email</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <!-- loop over and print our customers -->
                    <c:forEach var="tempUser" items="${users}">



                            <%--constructing update link--%>
                            <c:url var="updateUserLink" value="/users/showFormForUpdate">
                                <c:param name="userId" value="${tempUser.id}"/>
                            </c:url>


                            <%--constructing delete link--%>
                            <c:url var="deleteUserLink" value="/users/deleteUser">
                                <c:param name="userId" value="${tempUser.id}"/>
                            </c:url>

                        <%--constructing show user link--%>
                        <c:url var="showUserLink" value="/users/showUser">
                            <c:param name="userId" value="${tempUser.id}"/>
                        </c:url>


                            <tr>
                                <td> ${tempUser.userName} </td>
                                <td> ${tempUser.firstName} </td>
                                <td> ${tempUser.lastName} </td>
                                <td> ${tempUser.email} </td>

                                <td>
                                        <%--display lkink--%>
                                    <a href="${updateUserLink}">Update</a>
                                    |
                                    <a href="${deleteUserLink}"
                                       onclick="if (!(confirm('Are you sure you want to delete this customer'))) return false">Delete</a>
                                    |
                                    <a href="${showUserLink}">Show User</a>

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
