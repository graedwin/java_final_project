<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Admin Page</title>
</head>
<body>
	<header>
	    <h4>Welcome <c:out value="${currentUser.name}"></c:out></h4>
	    <a href="/">Dashboard</a>
	    <form id="logoutForm" method="POST" action="/logout">
	        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	        <input type="submit" value="Logout!" />
	    </form>
    </header>
    
    <table>
    	<thead>
    		<tr>
    			<th>Name </th>
    			<th>Email </th>
    			<th>Action </th>
    		</tr>
    	</thead>
    	<tbody>
    		<c:forEach var="user" items="${ users }">
    			<tr>
    				<td> ${user.name}</td>
    				<td> ${user.email} </td>
    				<c:choose>
					    <c:when test="${ user.roles[0].name == 'ROLE_ADMIN' }">
					        <td>  Admin</td>
					    </c:when>    
					    <c:otherwise>
							<td> <a href="user/delete/${user.id}"> Delete  </a> | <a href="user/makeadmin/${user.id}">  Make Admin </a></td>
					    </c:otherwise>
					</c:choose>
    			</tr>
    		</c:forEach>
    	</tbody>
    </table>
    
</body>
</html>
</html>