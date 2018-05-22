<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <style> <%@include file="skeleton.css"%></style>
    <style> <%@include file="styles.css"%></style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Welcome Page</title>
</head>
<body>
	<header>
	    <h4>Welcome <c:out value="${currentUser.name}"></c:out></h4>
	    <c:if test="${ currentUser.roles[0].name == 'ROLE_ADMIN' }">
	        <td> <a href="/admin">Admin Dashboard</a> </td>
	    </c:if>   	  
	    <form id="logoutForm" method="POST" action="/logout">
	        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	        <input type="submit" value="Logout!" />
	    </form>
    </header>
    <div>
		<table>
			<thead>
				<tr>
					<th>Ideas</th>
					<th>Created By</th>
					<th>Likes</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="idea" items="${ideas}">
					<tr>
						<td> <a href="/ideas/${idea.id }"> ${ idea.content } </a></td>
						<td> ${ idea.createdBy.name }</td>
						<td>${ idea.likedBy.size() } </td>
						<c:choose>
							<c:when test="${ idea.likedBy.contains(currentUser) }">
								<td> <a href="/ideas/${idea.id}/unlike"> Unlike </a></td>
							</c:when>
							<c:otherwise>
								<td> <a href="/ideas/${idea.id}/like"> Like </a></td>
							</c:otherwise>
						</c:choose>
					</tr>
				</c:forEach>
			</tbody>
		</table>
    </div>
    
    <a href="/ideas/new"><button>Create an Idea</button></a>
    
</body>
</html>