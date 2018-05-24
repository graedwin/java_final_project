<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<<<<<<< HEAD
<title>Show task</title>
=======
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<title>Insert title here</title>
>>>>>>> 89b7c6807107b44844b64ed6942f88dcd9b066c8
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
	<p>${ task.name }</p>
  <p> <a href="/file/download/${task.image }"> ${task.image } </a>  </p>
  
<!-- BODY -->
<img src="http://via.placeholder.com/350x150">
<table>
    <tbody>
    <tr>
      <c:choose>
        <c:when test="${(user.roles[0].id < 3) or (task.taskCreator == currentUser)}">
          <td><h3>${ task.name }</h3></td>
          <td>
              <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
                  Admin Tools
                </a>
                <div class="dropdown-menu">
                  <a class="dropdown-item" href="/tasks/${task.id}/edit">Edit</a>
                  <a class="dropdown-item" href="/tasks/${task.id}/cancel">Cancel</a>
                </div>
          </td>
        </c:when>
        <c:otherwise>
          <td colspan="2"><h1>${task.name}</h1></td>
        </c:otherwise>
      </c:choose>
    </tr>
    <tr>
      <td colspan="2"><h3>Description</h3></td>
    </tr>
    <tr>
      <td colspan="2">${ task.description }</td>
    </tr>
    <tr>
      <td>Status</td>
<<<<<<< HEAD
      <td>
        
      </td>
=======
      <td>${ task.status }</td>
    </tr>
    <tr>
      <td>Worth</td>
      <td>${ task.worth }</td>
>>>>>>> 89b7c6807107b44844b64ed6942f88dcd9b066c8
    </tr>
  </tbody>
</table>
</body>
</html>