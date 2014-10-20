package ar.com.urbanusjam.web.controllers;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ar.com.urbanusjam.services.ContenidoService;
import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.UserService;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.web.domain.LoginStatus;
import ar.com.urbanusjam.web.utils.URISchemeUtils;
 
/**
 * LoginController manages LOGIN and LOGOUT requests
 * 
 * */

@Controller
public class LoginController {
	
	@Autowired
	@Qualifier("fixealaAuthenticationManager")
	AuthenticationManager fixealaAuthenticationManager;
	
	@Autowired
	@Qualifier("userService")
	UserService userService;
	
	@Autowired
	@Qualifier("issueService")
	IssueService issueService;
	
	@Autowired
	@Qualifier("contenidoService")
	ContenidoService contenidoService;
	
	@ModelAttribute("issuesJson")
	public @ResponseBody String getIssuesJson() throws JSONException{  
  
		List<IssueDTO> issues = issueService.loadAllIssues();

		JSONArray array = new JSONArray();
	
		for(IssueDTO issue : issues){
			JSONObject obj = new JSONObject();
			obj.put("id", issue.getId());
			obj.put("title", issue.getTitle());
			obj.put("description", issue.getDescription());		
			obj.put("address", issue.getFullAddress());	
			obj.put("barrio", issue.getNeighborhood());	
			obj.put("city", issue.getCity());	
			obj.put("province", issue.getProvince());	
			obj.put("date", issue.getFechaFormateada());
			obj.put("status", issue.getStatus());
			obj.put("css", issue.getStatusCss());		
			obj.put("colorCss", issue.getTitleCss());	
			obj.put("url", URISchemeUtils.CONN_RELATIVE_URL_ISSUES + "/" + issue.getId());
			array.put(obj);
		}		

		return array.toString();

	}  
	
	 
	

	
	@RequestMapping(value="/home2", method = RequestMethod.GET, produces = "application/json")
	public String home2(HttpServletRequest request, HttpServletResponse response){				
//		response.addHeader("Access-Control-Allow-Origin", "*");
//		response.addHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE");
//        response.addHeader("Access-Control-Allow-Headers", "Content-Type");
//        response.addHeader("Access-Control-Max-Age", "1800");
		return "home2";
	}
	
	@RequestMapping(value="/index", method = RequestMethod.GET)
	public String index(){
		return "index";
	}
	
	@RequestMapping(value="/template2", method= RequestMethod.GET)
	public String template(){
		return "template2";
	}

	
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public String login(Model model){
		return "index";
	}

	@RequestMapping(value="/login", method = RequestMethod.POST)	  
	public @ResponseBody LoginStatus login(@RequestParam("j_username") String username,
                      					 @RequestParam("j_password") String password, Model model){
	
		LoginStatus loggedUser = new LoginStatus();
	    UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(username, password);	   

	    try {
		      Authentication auth = fixealaAuthenticationManager.authenticate(token);
		      SecurityContextHolder.getContext().setAuthentication(auth);	
		      loggedUser.setLoggedIn(auth.isAuthenticated());
		      loggedUser.setUsername(auth.getName());
		     
		      return loggedUser;

	    } catch (BadCredentialsException e) {
	    	  loggedUser.setLoggedIn(false);
	    	  loggedUser.setUsername(null);
		      return loggedUser;	    
	    }  
	}
	  
	  
	@RequestMapping(value ="/logout", method = RequestMethod.GET)
    public String logout(HttpServletRequest request){    
		String s = request.getRequestURL().toString();
    	return "index";
    }
	 
}