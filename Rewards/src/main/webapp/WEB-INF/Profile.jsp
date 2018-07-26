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
<title>Profile</title>
</head>
<body>
<!-- NAV -->
<nav class="navbar navbar-expand-md navbar-dark bg-dark">
  	<!-- Brand -->
  	<a class="navbar-brand" href="/">Rewards and Recognitions</a>
  	<ul class="navbar-nav mr-auto">
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
  	<ul class="nav navbar-nav navbar-right">
		<!-- PROFILE -->
    	<li class="nav-item dropdown">
      		<a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
        		<c:out value = '${ currentUser.firstName }'/>
      		</a>
      		<div class="dropdown-menu dropdown-menu-right">
        		<a class="dropdown-item" href="/editPassword">Edit Password</a>
        		<a class="dropdown-item" href="/users/${ currentUser.id }/profile">Profile</a>
        		<form id="logoutForm" method="POST" action="/logout">
	        		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	        		<input class="dropdown-item" type="submit" value="Logout!" />
	    		</form>
			</div>
		</li>
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
			    		<c:otherwise>
			    			<p class="card-text" style="text-align:center;">Points Available: ${currentUser.points}</p>
			    		</c:otherwise>
		    		</c:choose>
			  	</div>
			</div>
			<ul class="nav flex-column">
			</ul>
		</div>
	</div>
<!-- END OF SIDEBAR -->
<!-- BODY -->
  	<div class="col-sm-9">
  		<div class="container table-tasks">
			<nav aria-label="Page navigation example" style="float:right;">
			  <ul class="pagination">
				<c:forEach var="i" begin="1" end="${totalPages }">
	           		<li class="page-item"><a class="page-link" href="/dashboard/pages/${ i }"> ${ i } </a></li>
	        		</c:forEach>
			  </ul>
			</nav>
		<c:choose>
			<c:when test="${currentUser.level == 3}">
			<h2>Tasks</h2>
			<br>
			<div class="table-responsive">
			    <table class="table">
			      <thead>
			        <tr>
			          <th>Name</th>
			          <th>Status</th>
			          <th>Show</th>
			        </tr>
			      </thead>
			      <tbody>
					<c:forEach items="${ userTasks }" var="task">
						<tr>
						<td>${ task.name }</td>
						<td>${ task.status }</td>
						<td><a href="/tasks/${task.id}/show"><button>View Task</button></a></td>
						</tr>
					</c:forEach>
			      </tbody>
				</table>
			</div>
			<h2>Purchases</h2>
			<br>
			<div class="table-responsive">
			    <table class="table">
			      <thead>
			        <tr>
			          <th>Product Name</th>
			          <th>Status</th>
			        </tr>
			      </thead>
			      <tbody>
					<c:forEach items="${ userProducts }" var="product">
						<tr>
						<td>${ product.getProduct().name }</td>
						<td>${ product.status }</td>
						</tr>
					</c:forEach>
			      </tbody>
				</table>
			</div>
			</c:when>
			<c:otherwise>
			<h2>Tasks Created</h2>
			<br>
			<div class="table-responsive">
			    <table class="table">
			      <thead>
			        <tr>
			          <th>Name</th>
			          <th>Status</th>
			          <th>Resolver</th>
			        </tr>
			      </thead>
			      <tbody>
					<c:forEach items="${ createdTasks }" var="createdTask">
						<tr>
						<td><a href="/tasks/${createdTask.id}/show">${ createdTask.name }</a></td>
						<td>${ createdTask.status }</td>
						<td>
							<c:choose>
								<c:when test="${createdTask.getTaskResolver() == NULL}">
									<p>Unassigned</p>
								</c:when>
								<c:otherwise>
									<p>${createdTask.getTaskResolver().login}</p>
								</c:otherwise>
							</c:choose>
						</td>
						</tr>
					</c:forEach>
			      </tbody>
				</table>
			</div>
			<h2>Assigned Rewards</h2>
			<br>
			<div class="table-responsive">
			    <table class="table">
			      <thead>
			        <tr>
			          <th>Reward</th>
			          <th>Assigned To</th>
			          <th>Value</th>
			        </tr>
			      </thead>
			      <tbody>
					<c:forEach items="${ assignedRecognitions }" var="recognition">
						<tr>
						<td>${ recognition.getReward().description }</td>
						<td>${ recognition.getRecognitionReceiver().login }</td>
						<td>${ recognition.getReward().points }</td>
						</tr>
					</c:forEach>
			      </tbody>
				</table>
			</div>
			</c:otherwise>
		</c:choose>
	  </div>	
	</div>
</div>
</body>
</html>