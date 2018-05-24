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
<title>Display of the Products</title>
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
<!-- BODY -->
<div class="row">
	<div class="col-sm-3">
		<div class="container text-center">
		<br>
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
  	<div class="col-sm-9">
		<div class="container float-left text-center">
		<br>
		<h2>Products Available</h2>
		<br>
			<div class="table-responsive">
				<table class="table">
			    	<thead>
			        	<tr>
			          		<th>Name</th>
			          		<th>Points</th>
			          		<th>In Stock</th>
			        	</tr>
			      	</thead>
			      	<tbody>
			      		<c:forEach items = "${ all_Products }" var = "product">
						<tr onclick="window.location.assign('/products/<c:out value = '${ product.id }'/>');">
			          		<td>${ product.name }</td>
			          		<td>${ product.price }</td>
			          		<td>${ product.stock }</td>
			        	</tr>
			        	</c:forEach>
			      	</tbody>
				</table>
			</div>
		  </div>	
	</div>
</div>
</body>
</html>