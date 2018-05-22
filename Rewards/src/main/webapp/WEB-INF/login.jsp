<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome</title>
</head>
<body>
	<h1>Login</h1>
	<c:if test="${logoutMessage != null}">
        <span><c:out value="${logoutMessage}"></c:out></span>
    </c:if>
    <c:if test="${errorMessage != null}">
        <span><c:out value="${errorMessage}"></c:out></span>
    </c:if>
	<form action="/login" method="post">
		Email: <input type="text" name="username">
		Password: <input type="password" name="password">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		
		<input type="Submit" value="Login">
	</form>
	
	
	<h1>Registration</h1>
	<form:form action="/registration" method="post" modelAttribute="new_user">
		Name:<form:input type="text" path="name"/>
		 <form:errors path="name"/>
		<br>
		Email:<form:input type="text" path="email"/>
		 <form:errors path="email"/>
		<br>
		Password:<form:password path="password"/>
		 <form:errors path="password"/>.
		<br>
		Confirm Password:<form:password path="passwordConfirmation"/>
		 <form:errors path="passwordConfirmation"/>
		<br>
		<input type="Submit" value="Register">
	</form:form>
</body>
</html>