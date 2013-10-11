<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Change Password</title>
				
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery-1.9.0.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.validate.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.json-2.4.min.js"></script>		
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/script.js"></script>
		
		<link type="text/css" href="${pageContext.request.contextPath}/resources/css/jquery-ui.css" rel="stylesheet" />
		<link type="text/css" href="${pageContext.request.contextPath}/resources/css/ejemplos.css" rel="stylesheet" />
		
</head>


<body>

Cambiar clave de: 

	<sec:authorize access="isAuthenticated()">			
		 <b><sec:authentication property="principal.username" /></b>	
	</sec:authorize>
	
		<fieldset style="width:300px">
			<form id="changepasswordform">
				<div class="field">
		  			<label for="currentPassword">Contraseña actual:</label>
		  			<input type="password" id="currentPassword" name="currentPassword" value="" />	
	  			</div>
	  			<div class="field">
		  			<label for="newPassword">Nueva contraseña:</label>
		  			<input type="password" id="newPassword" name="newPassword" value="" />	
	  			</div>
	  			<div class="field">
		  			<label for="newPasswordConfirmation">Confirme nueva contraseña:</label>
		  			<input type="password" id="newPasswordConfirmation" name="newPasswordConfirmation" value="" />	
	  			</div>
	  				<input class="button" id="changepasswordsubmit" name="changepasswordsubmit" type="submit" value="Guardar cambios" />
			</form>
		</fieldset>	
		
			<a href="${pageContext.request.contextPath}">Volver</a>
</body>
</html>