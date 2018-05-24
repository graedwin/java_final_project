<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css" integrity="sha384-9gVQ4dYFwwWSjIDZnLEWnxCjeSWFphJiwGPXr1jddIhOegiu1FwO5qRGvFXOdJZ4" crossorigin="anonymous">
<link rel="stylesheet" href="css/Modify.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<title>Recognitions</title>
</head>
<body>
    <div class="table-responsive">
        <table class="table">
            <thead>
                <tr>
                    <th colspan="2">Add Recognition Points</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><h6>Associate</h6></td>
                    <td><h6>Recognition</h6></td>
                </tr>
                <tr>
                    <form class="form-inline" action="/rewards/assign" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <td>
                            <select class="custom-select my-1 mr-sm-2" id="inlineFormCustomSelectPref" name="associate">
                                <option selected>Choose...</option>
                                <c:forEach items="${ users }" var="user">
                                    <c:if test="${(user.level == 3) or (user.level == 4)}">
                                        <option value="${user.id}">${ user.login } - ${user.firstName} ${user.lastName}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </td>
                        <td>
                            <select class="custom-select my-1 mr-sm-2" id="inlineFormCustomSelectPref" name="reward">
                                <option selected>Choose...</option>
                                <c:forEach items="${ rewards }" var="reward">
                                    <option value="${reward.id}">${ reward.points } - ${reward.description}</option>
                                </c:forEach>
                            </select>
                        </td>
                    </form>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <input type="submit" value="Award" class="btn btn-primary mb-2" style="float:right">
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>