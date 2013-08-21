package ar.com.urbanusjam.web.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

public class CustomAccessDeniedHandler implements AccessDeniedHandler {

	private String accessDeniedUrl;
	
	
	public void setAccessDeniedUrl(String accessDeniedUrl) {
		this.accessDeniedUrl = accessDeniedUrl;
	}

	
	@Override
	public void handle(HttpServletRequest request, HttpServletResponse response,
			AccessDeniedException exception) throws IOException, ServletException {
		
			String redirectUrl = response.encodeRedirectURL( request.getContextPath() + this.accessDeniedUrl);
	
			request.getSession().setAttribute("message",
			     		"¡ACCESO DENEGADO! No tiene permisos para acceder a esta página.");
	        response.sendRedirect(redirectUrl);		 	     
	}

	
}
