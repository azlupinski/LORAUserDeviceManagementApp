<div>
    <nav class="navbar navbar-inverse navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="/">LoRa</a>
            </div>
            <ul class="nav navbar-nav">
                <li class=><a href="/myAccount">Home</a></li>
                <security:authorize access="hasRole('ADMIN')">
                    <li><a href="${pageContext.request.contextPath}/users">Users</a></li>
                </security:authorize>
                <li><a href="${pageContext.request.contextPath}/devices">Devices</a></li>
                <li><a href="#">Settings</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <c:if test="${empty user}">
                <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
                </c:if>
                <c:if test="${not empty user}">
                    <li><a href="/logout"><span class="glyphicon glyphicon-log-in"></span> Logout</a></li>
                </c:if>
            </ul>
        </div>
    </nav>
</div>


