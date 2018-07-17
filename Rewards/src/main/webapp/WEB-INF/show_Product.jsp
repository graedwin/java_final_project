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
<script>
	$(document).ready(function(){
		$(".page-link").on("click", function(){
			
			
			$.ajax({
				  type: 'GET',
				  url: $(this).attr("href"),
				  success: function(data){
					  
					  $("table").load("table");
				  }
			});
			return false;
		})
	
	})
</script>            
<title>Show your Product</title>
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
	  		<div class="col-3 text-center">
	  			<h1 style="padding-top: 30px;"><c:out value = '${ product.name }'/></h1>
	  			<c:choose>
		   			<c:when test = "${currentUser.level<3}">
		   				<div class="dropdown">
						  <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						    Admin Options
						  </button>
						  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
						    <a class="dropdown-item" href="/products/<c:out value = '${ product.id }'/>/edit">Edit</a>
						    <a class="dropdown-item" href="/products/<c:out value = '${ product.id }'/>/remove">Remove from Inventory</a>
						  </div>
						</div>
						<br>
					</c:when>
		   		</c:choose>
		   		<img alt="product image" src="/productImages/${product.image}" width="350px">
				<h5>Description:</h5>
				<p><c:out value = '${ product.description }'/></p>
				<h5>Price:</h5>
				<p><c:out value = '${ product.price }'/></p>
				<h5>Stock:</h5>
				<p><c:out value = '${ product.stock }'/></p>
				<a href="/products/<c:out value = '${ product.id }'/>/purchase"><button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#myModal">Purchase</button></a>
			    
			    <!-- The Modal -->
				<div class="modal" id="myModal">
					<div class="modal-dialog">
				    	<div class="modal-content">
				      
					        <!-- Modal Header -->
					        <div class="modal-header">
					        	<h4 class="modal-title">Your Purchase</h4>
					          	<button type="button" class="close" data-dismiss="modal">&times;</button>
					        </div>
					        
					        <!-- Modal body -->
					        <div class="modal-body">
					        	<c:choose>
						          	<c:when test="${errorMessage != null}">
							        	<c:out value="${errorMessage}"></c:out>
								    </c:when>
								    <c:otherwise>
								    	Your purchase has been successful
								    </c:otherwise>
							    </c:choose>
					        </div>
				        
				        	<!-- Modal footer -->
				        	<div class="modal-footer">
				          		<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				        	</div>
				    	</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>