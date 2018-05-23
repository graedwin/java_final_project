<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/bootstrap-grid.css">
<link rel="stylesheet" href="css/bootstrap-grid.min.css">
<link rel="stylesheet" href="css/bootstrap-reboot.css">
<link rel="stylesheet" href="css/bootstrap-reboot.min.css">
<link rel="stylesheet" href="css/Modify.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<title>Add a Product</title>
</head>
<body>
<!-- NAVIGATION BAR -->
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <!-- Brand -->
  <a class="navbar-brand" href="/">Trading Hub</a>
  <ul class="navbar-nav">
    <!-- Dropdown -->
    <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
        Name
      </a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="#">Settings</a>
        <a class="dropdown-item" href="#">Profile</a>
        <form id="logoutForm" method="POST" action="/logout">
	        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	        <input class="dropdown-item" type="submit" value="Logout!" />
	    </form>
     
      </div>
    </li>
    
    <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
        Tasks
      </a>
      <div class="dropdown-menu">
        <a class="dropdown-item" href="#">Add</a>
        <a class="dropdown-item" href="#">Available Tasks</a>
      </div>
    </li>
  
  <!-- Links -->
    <li class="nav-item">
      <a class="nav-link" href="#">Shop</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">Cart</a>
    </li>
  </ul>
</nav>
<!-- END OF NAVIGATION BAR -->
<!-- BODY -->
<div class="row">
	<div class="col-sm-3">
		<div class="container">
		  <h2>Filters</h2>
		  <ul class="nav flex-column">
		    <li class="nav-item">
		      <a class="nav-link" href="#">Order A to Z</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link" href="#">Order Z to A</a>
		    </li>
		    <li class="nav-item">
		      <a class="nav-link" href="#">Points Ascending Order</a>
		    </li>
   		    <li class="nav-item">
		      <a class="nav-link" href="#">Points Descending Order</a>
		    </li>
		  </ul>
		</div>
	</div>
  	<div class="container-fluid">
		<form:form action="#" method="post" modelAttribute="new_Product">
			<div class="form-group">
			  	<form:label for="name">name</form:label>
			  	<form:input type="email" path="name" class="form-control" id="email"/>
			  	<form:errors path="name"/>
			</div>
			<div class="form-group">
			  	<form:label for="price">price</form:label>
			  	<form:input type="number" path="price" class="form-control" id="price"/>
			  	<form:errors path="price"/>
			  	<br>
			</div>
			<div class="form-group">
			  	<form:label for="stock">stock</form:label>
			  	<form:input type="number" path="stock" class="form-control" id="stock"/>
			  	<form:errors path="stock"/>
			  	<br>
			</div>
			<div class="form-group">
			  	<form:label for="description">description</form:label>
			  	<form:input type="text" path="description" class="form-control" id="description"/>
			  	<form:errors path="description"/>
			  	<br>
			</div>
			<div class="form-group">
			  	<form:label for="image">image</form:label>
			  	<form:input type="text" path="image" class="form-control" id="image"/>
			  	<br>
			</div>
			<div class="form-group">
			 	<label for="pwd">Password:</label>
				<input type="password" class="form-control" id="pwd">
			</div>
			<button type="submit" class="btn btn-primary">Submit</button>
		</form:form>
	</div>
</div>
</body>
</html>