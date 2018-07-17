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
<title>Edit your product</title>
</head>
<body>
<!-- NAV -->
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  	<!-- Brand -->
  	<a class="navbar-brand" href="/">Rewards and Recognitions</a>
  	<ul class="navbar-nav">
    	<!-- PROFILE -->
    	<li class="nav-item dropdown">
      		<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
        		<c:out value = '${ currentUser.firstName }'/>
      		</a>
      		<div class="dropdown-menu">
        		<a class="dropdown-item" href="/editPassword">Edit Password</a>
        		<a class="dropdown-item" href="/users/${ currentUser.id }/profile">Profile</a>
        		<form id="logoutForm" method="POST" action="/logout">
	        		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	        		<input class="dropdown-item" type="submit" value="Logout!" />
	    		</form>
			</div>
		</li>
		<!-- TASKS -->
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
   		<!-- PRODUCTS -->
  		<c:choose>
  			<c:when test = "${currentUser.level<3}">
   				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="/tasks" id="navbardrop" data-toggle="dropdown">
	        		Products
	      			</a>
	      			<div class="dropdown-menu">
	    				<a class="dropdown-item" href="/products">View Products</a>	      			
	        			<a class="dropdown-item" href="/products/add">Add Product</a>
	    				<a class="dropdown-item" href="/products/reinstate">Reinstate Product</a>
	      			</div>	
      			</li>
			</c:when>
			<c:otherwise>
				<li class="nav-item">
		      		<a class="nav-link" href="/products">Products</a>
		    	</li>
			</c:otherwise>
  		</c:choose>
  		<!-- REWARDS -->
  		<c:choose>
  			<c:when test = "${currentUser.level<3}">
   				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="/tasks" id="navbardrop" data-toggle="dropdown">
	        		Rewards
	      			</a>
	      			<div class="dropdown-menu">
	        			<a class="dropdown-item" href="/rewards/add">Add Reward</a>
	    				<a class="dropdown-item" href="/rewards">Show Rewards</a>
	      			</div>	
      			</li>
			</c:when>
			<c:when test = "${currentUser.level>3}">
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" href="/tasks" id="navbardrop" data-toggle="dropdown">
	        		Rewards
	      			</a>
	      			<div class="dropdown-menu">
	        			<a class="dropdown-item" href="/rewards/assign">Assign Reward</a>
	        			<a class="dropdown-item" href="/rewards">Show Rewards</a>
	      			</div>	
      			</li>
			</c:when>
			<c:otherwise>
				<li class="nav-item">
		      		<a class="nav-link" href="/rewards">Rewards</a>
		    	</li>
			</c:otherwise>
  		</c:choose>
  	</ul>
</nav>
<!-- END OF NAV -->
<!-- BODY -->
<div class="container-fluid">
	<div class="row justify-content-md-center">
  		<div class="col-3">
  			<h3 style="padding-top: 30px;">Edit your product</h3>
			<form:form action="#" method="post" modelAttribute="new_Product"  enctype="multipart/form-data">
				<div class="form-group">
				  	<form:label path="name" >Name</form:label>
				  	<form:input type="text" path="name" value="${ product.name }" class="form-control" id="name"/>
				  	<form:errors path="name"/>
				</div>
				<div class="form-group">
				  	<form:label path="price">Price</form:label>
				  	<form:input type="number" path="price" value="${ product.price }" class="form-control" id="price"/>
				  	<form:errors path="price"/>
				  	<br>
				</div>
				<div class="form-group">
				  	<form:label path="stock">Stock</form:label>
				  	<form:input type="number" path="stock" value="${ product.stock }" class="form-control" id="stock"/>
				  	<form:errors path="stock"/>
				  	<br>
				</div>
				<div class="form-group">
				  	<label >Description</label>
				  	<textarea rows="7" cols="70" type="text" class="form-control" name="description" > ${ product.description } </textarea>
				  	<br>
				</div>
				<div class="form-group">
				  	<label>Image</label>
				  	<input type="file" name="file" class="form-control"/>
				  	<br>
				</div>
				<button type="submit" class="btn btn-primary">Submit</button>
				<a href="/products/${product.id}">Go back</a>
			</form:form>
		</div>
	</div>
</div>
</body>
</html>