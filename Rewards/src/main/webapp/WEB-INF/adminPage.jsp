<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
       <%@include file="css/Style.css" %>
       <%@include file="css/skeleton.css" %>
       <%@include file="css/normalize.css" %>
</style>
<title>Admin Page</title>
</head>
<body>

<div id="wrapper">
	<header>
	    <h4>Welcome <c:out value="${currentUser.firstName}"></c:out></h4>
	    <a href="/">Dashboard</a>
	    <form id="logoutForm" method="POST" action="/logout">
	        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	        <input type="submit" value="Logout!" />
	    </form>
    </header>
    
    <table id="table">
    	<thead>
    		<tr>
    			<th>Name </th>
    			<th>Login </th>
    			<th>Current Role</th>
    			<th colspan=3 style="text-align:center;">Action </th>
    		</tr>
    	</thead>
    	<tbody>
    		<c:forEach var="user" items="${ users }">
    			<tr>
    				<td> ${user.firstName}</td>
    				<td> ${user.login} </td>
    				<td> ${user.roles[0].name }
    				<c:choose>
					    <c:when test="${ user.roles[0].name == 'ROLE_ADMIN' }">
					        <td>Admin</td>
					        <td><a href="/user/${user.id}/passUpdate">Reset Password</a></td>
							<td><a href="/user/delete/${user.id}">Delete</a></td>
					    </c:when>    
					    <c:otherwise>
							<td>
								<div class="dropdown">
									<button >Change Role 
								    	<i class="fa fa-caret-down"></i>
								    </button>
								    <div class="dropdown-content">
								    	<c:forEach var="role" items="${ roles }">
									    	<c:if test = "${user.roles[0].name != role.name}">
										    	<a href="/user/${role.name}/${user.id}">Make ${role.name}</a>
									      	</c:if>
								      	</c:forEach>
								    </div>
						  		</div> 
							</td>
							<td><a href="/user/${user.id}/passUpdate">Reset Password</a></td>
							<td><a href="/user/delete/${user.id}">Delete</a></td>
					    </c:otherwise>
					</c:choose>
    			</tr>
    		</c:forEach>
    	</tbody>
    </table>
</div>
</body>
</html>
</html>