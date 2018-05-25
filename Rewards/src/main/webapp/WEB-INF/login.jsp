<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<script>
	$(document).ready(function(){
		
		$("#forgotPassword").on("click", function(){
			$(this).fadeOut();
			$("#passwordForm").append("<p style='color:blue'>Enter your login to recover your password: </p><input id='log' class='form-control' placeholder='Login' type='text'><button id='recover' class='btn'>Recover</button>");
			return false;
		});
		
		$('#passwordForm').on('click','#recover', function() {
			console.log("/forgotPassword/"+$("#log").val());
			$('#passwordForm').hide();
			$('#message').append("<img src='/css/d9933c4e2c272f33b74ef18cdf11a7d5.gif' style='width:70px;' id='loading'>");
			$.ajax({
				  type: 'GET',
				  url: "/forgotPassword/"+$("#log").val(),
				  success: function(data){
					  $('#loading').fadeOut('fast');
					  $('#message').append(data); 
				  }
			});
        });
	})

</script>
<title>Welcome</title>
</head>
<body>
	<div style="margin:10% auto;">
	<div style="vertical-align:top;margin:0% 4%;width:40%;text-align:center;display:inline-block">
		<h1>Login</h1>
		<c:if test="${logoutMessage != null}">
	        <span  style="color:red"><c:out value="${logoutMessage}"></c:out></span>
	    </c:if>
	    
		<form action="/login" method="post" class="form-group">
		
			<div class="input-group mb-3">
			  <input type="text" name="username" class="form-control" placeholder="Login">
			  <div class="input-group-append">
			    <span class="input-group-text" id="basic-addon2">@amazon.com</span>
			  </div>
			</div>
			<input type="password" name="password" class="form-control" placeholder="Password">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			
			<input type="Submit" value="Login" class="btn btn-dark">
		</form>
	    <c:if test="${errorMessage != null}">
	        <span style="color:red"><c:out value="${errorMessage}"></c:out></span>
	    </c:if>
		<a	href="" id='forgotPassword'>Forgot password?</a>
		<div id="passwordForm"></div>
		<p id="message" style="color:green"></p>
		</div>
		
		<div style="vertical-align:top;width:40%;text-align:center;display:inline-block">
		<h1>Registration</h1>
		<form:form action="/registration" method="post" modelAttribute="new_user" class="form-group">
			
			<form:input type="text" path="firstName" class="form-control" placeholder="First Name"/>
			 <form:errors path="firstName" style="color:red"/>
			 <br>
			 <form:input type="text" path="lastName" class="form-control" placeholder="Last Name"/>
			 <form:errors path="lastName" style="color:red"/>
			<br>
			<form:input type="text" path="login" class="form-control" placeholder="Login"/>
			 <form:errors path="login" style="color:red"/>
			<br>
			<form:password path="password" class="form-control" placeholder="Password"/>
			 <form:errors path="password" style="color:red"/>
			<br>
			<form:password path="passwordConfirmation" class="form-control" placeholder="Confirm Password"/>
			 <form:errors path="passwordConfirmation" style="color:red"/>
			<br>
			<input type="Submit" value="Register" class="btn btn-dark">
		</form:form>
	</div>
	</div>
</body>
</html>