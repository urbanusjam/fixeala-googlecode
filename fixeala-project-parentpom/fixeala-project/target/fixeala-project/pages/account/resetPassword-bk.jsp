<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reset password</title>

		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery-1.9.0.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.validate.min.js"></script>
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/libs/jquery.json-2.4.min.js"></script>		
		<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/script.js"></script>
		
		<link type="text/css" href="${pageContext.request.contextPath}/resources/css/jquery-ui.css" rel="stylesheet" />
		<link type="text/css" href="${pageContext.request.contextPath}/resources/css/ejemplos.css" rel="stylesheet" />
	
</head>
<body>

Resetear clave

</body>

		<fieldset style="width:300px">
			<form id="resetcredentialsform" >				
	  			<div class="field">
		  			<label for="password">Nueva contraseña:</label>
		  			<input type="password" id="password" name="password" value="" />	
	  			</div>
	  			<div class="field">
		  			<label for="passwordConfirmation">Confirme nueva contraseña:</label>
		  			<input type="password" id="passwordConfirmation" name="passwordConfirmation" value="" />	
	  			</div>
	  				<input class="button" id="resetpasswordsubmit" name="resetpasswordsubmit" type="button" 
	  												value="Resetear contraseña" onclick="doResetPasswordAjaxPost();" />
			</form>
		</fieldset>	
</html>