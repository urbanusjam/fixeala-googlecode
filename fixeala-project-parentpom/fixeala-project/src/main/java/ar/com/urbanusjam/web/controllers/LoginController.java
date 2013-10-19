package ar.com.urbanusjam.web.controllers;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.UserService;
import ar.com.urbanusjam.web.domain.LoginStatus;
 
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
	
	@RequestMapping(value="/home", method = RequestMethod.GET)
	public String home(){
		return "home";
	}
	
	@RequestMapping(value="/index", method = RequestMethod.GET)
	public String index(){
		return "index";
	}
	
	@RequestMapping(value="/template2", method= RequestMethod.GET)
	public String template(){
		return "template2";
	}
	
	

//	@RequestMapping(value="/doLogin", method = RequestMethod.GET)
//	public String login(ModelAndView model) { 		
//		
//		User loggedUser = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();	
//		
//		if(loggedUser != null){	
//			model.addObject("principal", loggedUser);		
//		}				
//		
//		return "index";	 
//	}
	
	
//	  @RequestMapping(method = RequestMethod.GET)
//	  @ResponseBody	 
//	  public LoginStatus getStatus() {
//	    Authentication auth = SecurityContextHolder.getContext().getAuthentication();	    
//	    if (auth != null && !auth.getName().equals("anonymousUser") && auth.isAuthenticated()) {
//	      return new LoginStatus(true, auth.getName());
//	    } else {
//	      return new LoginStatus(false, null);
//	    }
//	  }
	
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public String login(){
		return "index";
	}

	  @RequestMapping(value="/login", method = RequestMethod.POST)	  
	  public @ResponseBody LoginStatus login(@RequestParam("j_username") String username,
	                      					 @RequestParam("j_password") String password){
		
		LoginStatus loggedUser = new LoginStatus();
	    UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(username, password);	   

	    try {
	    	  User details = (User) userService.loadUserByUsername(username);
	 	      token.setDetails(details);
		      Authentication auth = fixealaAuthenticationManager.authenticate(token);
		      SecurityContextHolder.getContext().setAuthentication(auth);	
		      loggedUser.setLoggedIn(auth.isAuthenticated());
		      loggedUser.setUsername(auth.getName());
		      return loggedUser;
		      
	      // return new LoginStatus(auth.isAuthenticated(), auth.getName());
	    } catch (BadCredentialsException e) {
	   //   return new LoginStatus(false, null);
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