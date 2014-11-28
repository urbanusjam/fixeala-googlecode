package ar.com.urbanusjam.web.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.logout.SimpleUrlLogoutSuccessHandler;

public class CustomLogoutSuccessHandler extends SimpleUrlLogoutSuccessHandler {
	
//	@Override
//	public void onLogoutSuccess(HttpServletRequest request,
//	        HttpServletResponse response, Authentication authentication)
//	        throws IOException, ServletException {
//
//
//	    String refererUrl = request.getHeader("Referer");
//	    if (requiredAuthentication(refererUrl, authentication)) {
//	        response.sendRedirect(request.getContextPath());
//	    } else {
//	        response.sendRedirect(refererUrl);
//	    }
//	}
//
//	private boolean requiredAuthentication(String url, Authentication authentication){
//	    return !getPrivilegeEvaluator().isAllowed(url, authentication);
//	}

}
