package ar.com.urbanusjam.web.security;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UserDetails;

import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.UserService;

public class CustomAuthenticationProvider implements AuthenticationProvider {
	
	@Autowired
	private UserService userService;	
	
	@Autowired
	private ShaPasswordEncoder passwordEncoder;
		

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		
		  User user = userService.loadUserByUsername((String) authentication.getPrincipal());
		  String plainPass = (String) authentication.getCredentials();
		  String encodedPass = passwordEncoder.encodePassword(plainPass, user.getUsername());
		 		
		  if(user.isEnabled()){
			  if (user.getPassword().equals(encodedPass)){				  
				  userService.updateUserLastLogin(user.getUsername());
				  return new UsernamePasswordAuthenticationToken(user, authentication.getCredentials(), user.getRoles());
			  }
			  else
				  return null;
		  }
		  else
			  return null;		 
	}
	

	public Authentication autoLogin(Authentication authentication) throws AuthenticationException {
		
		  UserDetails user = userService.loadUserByUsername((String) authentication.getPrincipal());
		  String plainPass = (String) authentication.getCredentials();
		
		  if(user.isEnabled()){
			  if (user.getPassword().equals(plainPass))
				  return new UsernamePasswordAuthenticationToken(user, authentication.getCredentials(), user.getAuthorities());
			   else
				  return null;
		  }
		  else
			  return null;		 
	}
 

	@Override
	public boolean supports(Class<? extends Object> authentication) {
		   return (UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication));
		 // return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}


}
