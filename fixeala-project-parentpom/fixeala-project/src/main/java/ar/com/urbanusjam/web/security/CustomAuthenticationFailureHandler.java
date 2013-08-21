package ar.com.urbanusjam.web.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.ExceptionMappingAuthenticationFailureHandler;

public class CustomAuthenticationFailureHandler extends ExceptionMappingAuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request,
			HttpServletResponse response, AuthenticationException exception)
			throws IOException, ServletException {
		HttpSession httpSession = request.getSession();
		String authError = "El usuario y/o la contraseña son incorrectos.";		
//		if ( exception instanceof DisabledException )
//			authError = "Cuenta deshabilitada";		
		
		httpSession.setAttribute("message", authError.trim() );
		request.getRequestDispatcher("index.jsp").forward(request, response);
	}
}
