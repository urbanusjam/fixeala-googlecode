package ar.com.urbanusjam.web.context;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class IndexSessionFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		/** Casteo a HttpServletRequest **/
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		HttpServletResponse httpServletResponse = (HttpServletResponse) response;
		
		String authError = (String) httpServletRequest.getSession().getAttribute("AuthError");
		
		/** Si no tiene authError y no es index.jsp lo mando a volar **/
		if ( authError == null && ! "/fixeala/index.jsp".equals(httpServletRequest.getRequestURI()) ){
			httpServletResponse.sendRedirect("/fixeala/index.jsp");
			return;
		}

		/** Llamo a todos los que vengan debajo **/
		chain.doFilter(request, response);
		
		if ( "/fixeala/index.jsp".equals(httpServletRequest.getRequestURI()) ){
			/** Remuevo el atributo de la sesion, despues de que fue parseado el JSF **/
			httpServletRequest.getSession().removeAttribute("AuthError");
		}
	}

	@Override
	public void destroy() {
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

}
