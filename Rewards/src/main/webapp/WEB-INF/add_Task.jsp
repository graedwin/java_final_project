<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<title>Add a Task</title>
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
        <a class="dropdown-item" href="/tasks/add">Add</a>
        <a class="dropdown-item" href="/tasks">Available Tasks</a>
      </div>
    </li>
  
  <!-- Links -->
    <li class="nav-item">
      <a class="nav-link" href="#">Shop</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">Cart</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">Add Product</a>
    </li>
  </ul>
</nav>
<!-- END OF NAVIGATION BAR -->
<!-- BODY -->
<div class="row">
  	<div class="container-fluid">
		<form:form action="/tasks/add" method="post" modelAttribute="new_Task" enctype="multipart/form-data"	>
			<div class="form-group">
			  	<form:label path="name">Name</form:label>
			  	<form:input type="text" path="name" class="form-control" id="email"/>
			  	<form:errors path="name"/>
			</div>
			<div class="form-group">
			  	<form:label path="description">Description</form:label>
				<form:textarea rows="7" cols="70" type="text" path="description" class="form-control" id="description"/>
			  	<form:errors path="description"/>
			  	<br>
			</div>
			<input type="file" class="form-control" name="file"/>
			<div class="form-group">
			  	<form:label path="image">Image</form:label>
			  	<form:input type="text" path="image" class="form-control" id="image"/>
			  	<br>
			</div>
			<div class="form-group">
			 	<form:label path="taskReward">Reward:</form:label>
				<form:select path="taskReward" class="form-control" id="taskReward">
          <form:option value="1" label="10 - Easy Task"/>
          <form:option value="2" label="20 - Medium Task"/>
          <form:option value="3" label="30 - Hard Task"/>
        </form:select>
			  <form:errors path="taskReward"/>				
			</div>
			<div class="form-group">
			 	<form:label path="dueDate">Due Date:</form:label>
				<form:input path="dueDate" type="date" class="form-control" id="dueDate"/>
			  	<form:errors path="dueDate"/>				
			</div>
			<button type="submit" class="btn btn-primary">Create task</button>
		</form:form>
	</div>
</div>
</body>
</html>