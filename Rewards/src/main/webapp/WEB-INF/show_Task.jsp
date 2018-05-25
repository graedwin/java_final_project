<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<title>Show task</title>
</head>
<body>
<!-- NAV -->
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  	<!-- Brand -->
  	<a class="navbar-brand" href="/">Trading Hub</a>
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
<div class="container-fluid">
	<div class="row justify-content-md-center">
  		<div class="col-3">
			<table class=""> 
				<tbody>
			    <tr class="">
			      <td><h1 style="padding-top: 30px;">${ task.name }</h1></td>
			      <c:choose>
			        <c:when test="${currentUser.level < 3 or task.taskCreator == currentUser}">
			          <td>
			            <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
			              Admin Options
			            </a>
			            <div class="dropdown-menu">
			              <a class="dropdown-item" href="/tasks/${task.id}/edit">Edit</a>
			              <a class="dropdown-item" href="/tasks/${task.id}/cancel">Cancel</a>
			            </div>
			          </td>
			        </c:when>
			        <c:otherwise>
			        	<c:choose>
					        <c:when test="${task.status == 'Claimed - Work in Progress'}">
					          <td><a href="/tasks/${task.id}/complete">Mark as Completed</a></td>
					        </c:when>
					        <c:when test="${task.status == 'Completed'}">
					          <td></td>
					        </c:when>
					        <c:otherwise>
					          <td><a href="/tasks/${task.id}/request">Claim task</a></td>
					        </c:otherwise>
				        </c:choose>
			        </c:otherwise>
			      </c:choose>
					</tr>
					<tr>
						<td colspan="2">
							<c:if test="${fn:contains(task.image,'jpg') or fn:contains(task.image,'jpeg') or fn:contains(task.image,'png') or fn:contains(task.image,'gif')}">
								<p> <a href="/tasks/${task.id}/showImage"> <img alt="${task.image}" src="/taskImages/${task.image}" width="300"></a></p>
							</c:if>
						</td>
					</tr>
			    <tr>
			      <td colspan="2"><h3>Description</h3></td>
			    </tr>
			    <tr>
			      <td colspan="2">${ task.description }</td>
			    </tr>
			    <tr>
			      <td><h5>Status</h5></td>
			      <td>${task.status}</td>
			    </tr>
			    <tr>
			      <td><h5>Type of Task</h5></td>
			      <td>${task.taskReward.description}</td>
			    </tr>
			    <tr>
			      <td><h5>Value</h5></td>
			      <td>${task.taskReward.points}</td>
			    </tr>
			    <tr>
			      <td><h5>Due Date</h5></td>
			      <td>${task.dueDate}</td>
			    </tr>
			    <tr>
			    	<c:if test="${!fn:contains(task.image,'.jpg') and !fn:contains(task.image,'.png') and !fn:contains(task.image,'.jpeg') and !fn:contains(task.image,'.gif')}">
						<td><a href="/file/download/${task.image }">Download ${task.image }</a></td>
					</c:if>
				</tr>
			</tbody>
			</table>
		</div>
	</div>
</div>
</body>
</html>