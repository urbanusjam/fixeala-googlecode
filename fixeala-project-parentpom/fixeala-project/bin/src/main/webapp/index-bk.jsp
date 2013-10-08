<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Login Page</title>


</head>
<body style="margin:0;padding:0">
	
	<h3 style="width:200px;margin:0 auto;padding:0;text-align:center">Fixeala Login</h3>
	
	<div style="margin:50px auto;padding:10px;width:500px;min-height:250px;height:auto;border:1px solid #000;">	
		<sec:authorize access="isAuthenticated()">					
			 	Bienvenido, <b><sec:authentication property="principal.username" /></b>			
							<a href="<c:url value="/doLogout" />" >(Salir)</a>	
				Clave: <b><sec:authentication property="principal.password" /></b>					
				<a href="map2.jsp">MAPA!</a>
				<a href="account/changePassword.jsp" >Cambiar contraseña</a>											
		</sec:authorize>
		
		<h4 style="color:red">${message}</h4>		
	
		<sec:authorize ifNotGranted="ROLE_USER">	
			<form action="doLogin" method="POST" >
				<table>
					<tr>
						<td>Nombre de usuario:</td>
						<td><input type="text" name="j_username" >
						</td>
					</tr>
					<tr>
						<td>Contraseña:</td>
						<td><input type="password" name="j_password" />
						</td>
					</tr>
					<tr>
						<td colspan="2" align="right">
							<input id="_spring_security_remember_me" name="_spring_security_remember_me" 
								type="checkbox" checked="checked"/>
							<label for="_spring_security_remember_me">Recordarme</label>	
						</td>
					</tr>				
					<tr>
						<td colspan="2" style="text-align:right;"><input name="submit" type="submit" value="Iniciar sesión" />			
					</tr>
				</table>
			</form>			
			<a href="account/forgotPassword.jsp" >¿Olvidaste tu contraseña?</a>								
			<a href="account/signup.jsp">REGISTRATE!</a>			
		</sec:authorize>	
	</div>
</body>
</html>