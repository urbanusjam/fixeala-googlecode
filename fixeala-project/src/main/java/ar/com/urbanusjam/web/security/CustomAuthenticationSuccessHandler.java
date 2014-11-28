package ar.com.urbanusjam.web.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

public class CustomAuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
	 
	  @Override
	    public void onAuthenticationSuccess(HttpServletRequest request, 
	    		HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
		  HttpSession httpSession = request.getSession();
		  httpSession.setAttribute("message", "" );
		  request.getRequestDispatcher("home.html").forward(request, response);
	   }
}
