<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<title>Rewards</title>
</head>
<body>
<!-- NAV -->
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
    <!-- Brand -->
    <a class="navbar-brand" href="/">Trading Hub</a>
    <ul class="navbar-nav">
        <!-- Dropdown -->
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
                <c:out value = '${ currentUser.firstName }'/>
            </a>
            <div class="dropdown-menu">
                <a class="dropdown-item" href="#">Settings</a>
                <a class="dropdown-item" href="/users/${ currentUser.id }/profile">Profile</a>
                <form id="logoutForm" method="POST" action="/logout">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <input class="dropdown-item" type="submit" value="Logout!" />
                </form>
            </div>
        </li>
        <c:choose>
                <c:when test = "${currentUser.level == 3}">
                <li class="nav-item">
                <a class="nav-link" href="/tasks">Tasks</a>
                </li>
            </c:when>
            <c:otherwise>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="/tasks" id="navbardrop" data-toggle="dropdown">
                    Tasks
                    </a>
                    <div class="dropdown-menu">
                        <a class="dropdown-item" href="/tasks/add">Create a new Task</a>
                        <a class="dropdown-item" href="/tasks">Available Tasks</a>
                    </div>	
                </li>
            </c:otherwise>
            </c:choose>
            <li class="nav-item">
            <a class="nav-link" href="/products">Products</a>
        </li>
        <li class="nav-item dropdown">
        <c:choose>
                <c:when test = "${currentUser.level<3}">
                    <li class="nav-item">
                    <a class="nav-link" href="/products/add">Add Product</a>
                </li>
            </c:when>
            </c:choose>
            </li>
    </ul>
</nav>
<!-- END OF NAV -->
<div class="container-fluid">
    <div class="row justify-content-md-center">
            <div class="col-3">
                <h3 style="padding-top: 30px;">Add a new recognition</h3>
            <form:form action="/rewards/add" method="post" modelAttribute="newReward" enctype="multipart/form-data">
                <div class="form-group">
                        <form:label path="points" >Points</form:label>
                        <form:input type="number" path="points" class="form-control" id="points"/>
                        <form:errors path="points"/>
                </div>
                <div class="form-group">
                        <form:label path="description">Description</form:label>
                        <form:input type="text" path="description" class="form-control" id="description"/>
                        <form:errors path="description"/>
                        <br>
                </div>
                <button type="submit" class="btn btn-primary">Submit</button>
            </form:form>
        </div>
    </div>
</div> 
</body>
</html>