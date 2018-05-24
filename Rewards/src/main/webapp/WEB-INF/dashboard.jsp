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
<title>Display of the Products</title>
</head>
<body>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <!-- Brand -->
  <a class="navbar-brand" href="/">Trading Hub</a>
  <ul class="navbar-nav">
    <!-- Dropdown -->
    <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
        ${currentUser.firstName }
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
        <a class="dropdown-item" href="/product/add">Add</a>
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
<br>
<div class="row">
	<div class="col-sm-3">
		<div class="container">
		<div class="card border-dark mb-3" style="max-width: 18rem;">
		  <div class="card-header"><h2> ${currentUser.firstName } ${currentUser.lastName } </h2></div>
		  <br>
			<img alt="Badge photo" src="https://internal-cdn.amazon.com/badgephotos.amazon.com/?uid=${ currentUser.login}" style="margin:auto auto;">
		  <div class="card-body">
		    <h5 class="card-title "> ${currentUser.login }</h5>
		    <p class="card-text"></p>
		  </div>
		</div>
		  <ul class="nav flex-column">
		  </ul>
		</div>
	</div>
  	<div class="col-sm-9">
  		<div class="container table-tasks">
		<h2>News</h2>
		<br>
			<div class="table-responsive">
			    <table class="table">
			      <thead>
			        <tr>
			          <th>Name</th>
			          <th>Description</th>
			          <th>Worth</th>
			          <th>Status</th>
			          <th>Show</th>
			        </tr>
			      </thead>
			      <tbody>
					<c:forEach items="${ tasks }" var="task">
						<tr>
						<td>${ task.name }</td>
						<td>${ task.description }</td>
						<td>${ task.taskReward.points }</td>
						<td>${ task.status }</td>
						<td><a href="/tasks/${task.id}/show"><button>View Task</button></a></td>
						</tr>
					</c:forEach>
			      </tbody>
				</table>
			</div>
		  </div>	
	</div>
</div>
<div class="col-sm-3">
		<div class="container">
		
		
		<div class="card mb-3" style="max-width: 18rem;">
		  <div class="card-header"><h2> Completed tasks </h2></div>
		  <div class="card-body text-dark">
		    <h5 class="card-title"></h5>
		    <p class="card-text">
    		  <ul class="nav flex-column">
			  	<c:forEach var="task" items="${currentUser.resolvedTasks }">
				    <li class="nav-item">
				      <a class="nav-link" href="#"> ${task.name} </a>
				    </li>
			    </c:forEach>
			  </ul>
		    </p>
		  </div>
		</div>
		
		
		
		
		
		
		  

		</div>
	</div>
</body>
</html>