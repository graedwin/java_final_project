<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<link rel="stylesheet" href="css/Modify.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<title>Recognitions</title>
</head>
<body>
<!-- NAV -->
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  	<!-- Brand -->
<<<<<<< HEAD
  	<a class="navbar-brand" href="/"> Rewards and Recognition</a>
=======
  	<a class="navbar-brand" href="/">Rewards and Recognitions</a>
>>>>>>> 48752341c2b074858cd4eb679f57f2faec78d4b6
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
<!-- SIDEBAR -->
<br>
<div class="row">
	<div class="col-sm-3">
		<div class="container">
			<div class="card border-dark mb-3" style="max-width: 18rem;">
		  		<div class="card-header" style="text-align:center;"><h2> ${currentUser.firstName } ${currentUser.lastName } </h2></div>
			  	<br>
				<img alt="Badge photo" src="https://internal-cdn.amazon.com/badgephotos.amazon.com/?uid=${ currentUser.login}" style="margin:auto auto;">
			  	<div class="card-body">
		    		<h5 class="card-title" style="text-align:center;"> ${currentUser.login}</h5>
		    		<c:choose>
			    		<c:when test="${currentUser.level == 1}">
				    		<p class="card-text" style="text-align:center;"><a href="/admin">Admin Users</a></p>
				    		<p class="card-text" style="text-align:center;"><a href="/recognitions/history">Show Reward History</a></p>		    		
			    		</c:when>
			    		<c:when test="${currentUser.level == 2}">
			    			<p class="card-text" style="text-align:center;"><a href="/recognitions/history">Show Reward History</a></p>
			    		</c:when>
		    		</c:choose>
			  	</div>
			</div>
			<ul class="nav flex-column">
			</ul>
		</div>
	</div>
<!-- END OF SIDEBAR -->
<!-- BODY -->
	<div style="width: 50%; margin: 5% auto;">
		<div class="table-responsive">
			<table class="table">
				<thead>
					<tr>
						<th colspan="2">Add Recognition Points</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><h6>Associate</h6></td>
						<td><h6>Recognition</h6></td>
					</tr>
					<tr>
						<td colspan="2">
							<form class="form-inline" action="/rewards/assign" method="post">
								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
								<select class="custom-select my-1 mr-sm-2" id="inlineFormCustomSelectPref" name="associate">
									<option selected>Choose...</option>
									<c:forEach items="${ users }" var="user">
										<c:if test="${(user.level == 3) or (user.level == 4)}">
											<option value="${user.id}">${ user.login } - ${user.firstName} ${user.lastName}</option>
										</c:if>
									</c:forEach>
								</select>
								<select class="custom-select my-1 mr-sm-2" id="inlineFormCustomSelectPref" name="reward">
									<option selected>Choose...</option>
									<c:forEach items="${ rewards }" var="reward">
										<option value="${reward.id}">${ reward.points } - ${reward.description}</option>
									</c:forEach>
								</select>
								<input type="submit" value="Award" class="btn btn-primary mb-2" style="float:right">
							</form>
							<p>${success}</p>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>