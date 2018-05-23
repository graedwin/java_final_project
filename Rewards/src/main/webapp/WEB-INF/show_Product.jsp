<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %> 
        
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/Modify.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>            
<title>Insert title here</title>
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
   		<c:choose>
   			<c:when test = "${currentUser.level<3}">
   				<li class="nav-item">
	      			<a class="nav-link" href="/products/add">Add Product</a>
		    	</li>
			</c:when>
   		</c:choose>
  	</ul>
</nav>
<!-- END OF NAV -->
<!-- BODY -->
	<div class="container-fluid">
		<div class="row justify-content-md-center">
	  		<div class="col-3 text-center">
	  			<h1 style="padding-top: 30px;"><c:out value = '${ product.name }'/></h1>
				<h5>Description:</h5>
				<p>			<c:out value = '${ product.description }'/></p>
				<h5>Price:</h5>
				<p>			<c:out value = '${ product.price }'/></p>
				<h5>Stock:</h5>
				<p>			<c:out value = '${ product.stock }'/></p>
				<h5>Image:</h5>
				<p>			<c:out value = '${ product.image }'/></p>
				<a><button>Purchase</button></a>
			</div>
		</div>
	</div>
</body>
</html>