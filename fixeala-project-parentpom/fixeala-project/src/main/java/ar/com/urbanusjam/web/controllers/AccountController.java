package ar.com.urbanusjam.web.controllers;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.UserService;
import ar.com.urbanusjam.services.dto.ActivationDTO;
import ar.com.urbanusjam.services.dto.PasswordResetTokenDTO;
import ar.com.urbanusjam.services.dto.UserDTO;
import ar.com.urbanusjam.web.domain.AlertStatus;
import ar.com.urbanusjam.web.security.CustomAuthenticationProvider;
import ar.com.urbanusjam.web.utils.EmailUtils;

@Controller
@RequestMapping(value="/account")
public class AccountController {
	
	@Autowired
	@Qualifier(value = "userService")
	private UserService userService;
	
	@Autowired
	@Qualifier(value = "passwordEncoder")
	private ShaPasswordEncoder passwordEncoder;
	
	@Autowired
	@Qualifier(value = "fixealaAuthenticationManager")
	protected AuthenticationManager fixealaAuthenticationManager;
	
	@Autowired
	@Qualifier(value = "customAuthenticationProvider")
	protected CustomAuthenticationProvider customAuthenticationProvider;
	
	
	

	@RequestMapping(value = "/signup", method = RequestMethod.GET)	
	public String showSignUpPage(){
		return "signup";
	}
	
	
	@RequestMapping(value = "/signup/checkEmailAvailability", method = RequestMethod.POST)	
	public @ResponseBody boolean checkEmailAvailability(@RequestParam String email) {		
		if(userService.emailExists(email))
			return false;		
		else
			return true;		
	}
	

    @RequestMapping(value = "/signup/checkUsernameAvailability", method = RequestMethod.POST)	
    public @ResponseBody boolean checkUsernameAvailability(@RequestParam String username) {
    	if(userService.usernameExists(username))
			return false;		
		else
			return true;	    
    }
    
    @RequestMapping(value = "/signup/verifyCaptcha", method = RequestMethod.POST)
   	public @ResponseBody boolean doVerifyCaptcha(@RequestParam String challengeField, @RequestParam String responseField){   			
    	if(responseField.equals(challengeField)) 
    		return true;
    	else 
    		return false;
    }
    
    
    @RequestMapping(value = "/signup/createAccount", method = RequestMethod.POST)
	public @ResponseBody AlertStatus doCreateAccount(@ModelAttribute(value="user") UserDTO user, 
			HttpServletRequest request){
 					
		try {

			String encodedPass = passwordEncoder.encodePassword(user.getPassword(), user.getUsername());
	    	user.setPassword(encodedPass);
	    	user.setEnabled(false);
	    	 
	    	List<String> authorities = new ArrayList<String>();
			authorities.add("ROLE_USER");		
			user.setAuthorities(authorities);	
			user.setRegistrationDate(new Date());
			
			//create account
	        userService.createAccount(user);
			               
	        DateTime creation = new DateTime();
			DateTime expiration = creation.plusDays(3); 
						
			//random token generation
			String token = UUID.randomUUID().toString();
			EmailUtils emailUtils = new EmailUtils();
			
			ActivationDTO tokenDTO = new ActivationDTO();
			tokenDTO.setToken(token);
			tokenDTO.setUsername(user.getUsername());
			tokenDTO.setCreation(creation.toDate());
			tokenDTO.setExpiration(expiration.toDate());
			
			//save token in DB
			userService.saveActivationToken(tokenDTO);		
		
			//send activation email
			emailUtils.sendActivationEmail(user.getUsername(), token, user.getEmail());			
			
			return new AlertStatus(true, "¡Felicitaciones! Se ha enviado un link de activación de cuenta a su casilla de correo. ");
					
			
		} catch (Exception e) {
			
			return new AlertStatus(false, "Ha ocurrido un error al crear su cuenta. Intente de nuevo. ");		
		}
       		
		
	}
    
    @RequestMapping(value="/activation/{token}")
	public String showAccountActivationPage(Model model, @PathVariable("token") String tokenID, 
			HttpServletRequest request){
    	
    	String username = userService.findUsernameByActivationToken(tokenID);	
    	
		if(username != null){		
			    		
    		try{
    			
    			UserDetails user = userService.loadUserByUsername(username);  	    							
    	    	
    	    	//activate account	    
    			userService.activateAccount(user.getUsername());
    			
    			//delete token
    			userService.deleteActivationToken(tokenID);
    			
    			//auto-login
        		UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(
        				username, user.getPassword());
        	    request.getSession();
        		token.setDetails(new WebAuthenticationDetails(request));
        		
    			Authentication authenticatedUser = customAuthenticationProvider.autoLogin(token);
    			SecurityContextHolder.getContext().setAuthentication(authenticatedUser);
    		
    		} catch(Exception e){
    	        e.printStackTrace();
    		}

    		model.addAttribute("message", "Su cuenta ha sido activada.");
    		model.addAttribute("messageTitle", "¡Felicitaciones!");
    		model.addAttribute("alertType", "success");
    		return "result";
		}
		else{
			model.addAttribute("message", "El link de activación ya ha sido usado o ha expirado.");
			model.addAttribute("messageTitle", "¡Atención!");
			model.addAttribute("alertType", "error");
			return "result";
		}
    	
		    	
    }
    
    
    @RequestMapping(value="/changePassword", method = RequestMethod.GET)
	public String showChangePasswordPage(ModelAndView model) { 		
		User loggedUser = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();	
		if(loggedUser != null){	
			model.addObject("principal", loggedUser);
			return "account/changePassword";	 
		}				
		return "index";	
	}
	
	@RequestMapping(value = "/changePassword/doChange", method = RequestMethod.POST)
	public @ResponseBody boolean doChangePassword(@ModelAttribute(value="user") UserDTO user, 
			HttpServletRequest request){
				
		User loggedUser = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		final String plainPass = user.getNewPassword();
		
		String currentEncodedPass = passwordEncoder.encodePassword(user.getPassword(), loggedUser.getUsername());	
		user.setPassword(currentEncodedPass);
		
		String currentDBPass = userService.findPassword(loggedUser.getUsername(), currentEncodedPass);		
		
		String newEncodedPass = passwordEncoder.encodePassword(user.getNewPassword(), loggedUser.getUsername());
		user.setNewPassword(newEncodedPass);
		
		if(currentDBPass != null){
			//valido clave actual
			if(currentEncodedPass.equals(currentDBPass)){		
					userService.changePassword(loggedUser.getUsername(), user.getNewPassword());		
						
					//auto-login con nueva clave
					try{
						loggedUser.setPassword(newEncodedPass);
						UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(
								user.getUsername(), plainPass);
					    request.getSession();
						token.setDetails(new WebAuthenticationDetails(request));
						Authentication authenticatedUser = fixealaAuthenticationManager.authenticate(token);
						SecurityContextHolder.getContext().setAuthentication(authenticatedUser);
					} catch(Exception e){
		    	        e.printStackTrace();
					}
					return true;
			}
			else{
				return false;		
			}
		}
		else{
			return false;
		}				
	}
	
	
	
	@RequestMapping(value="/forgotPassword", method = RequestMethod.GET)
	public String showForgotPassword() { 						
		return "forgotPassword";	 
	}
	
	@RequestMapping(value="/forgotPassword/sendEmailToken", method = RequestMethod.POST)
	public @ResponseBody boolean doSendForgotPasswordToken(@RequestParam ("email")String email) { 		
		
		String username = userService.findUsernameByEmail(email);
		
		if(username != null){			
			
			DateTime creation = new DateTime();
			DateTime expiration = creation.plusDays(1); 
		
			//random token generation
			String token = UUID.randomUUID().toString();
			EmailUtils emailUtils = new EmailUtils();
			
			try {
				
				PasswordResetTokenDTO tokenDTO = new PasswordResetTokenDTO();
				tokenDTO.setToken(token);
				tokenDTO.setUsername(username);
				tokenDTO.setCreation(creation.toDate());
				tokenDTO.setExpiration(expiration.toDate());
				
				userService.savePasswordResetToken(tokenDTO);				
				emailUtils.sendPasswordResetEmail(username, token, email);
				
			} catch (Exception e) {
				return false;
			}
		
			return true;
 			
 		 }else{
			return false;
		}
//		return "La direcciÃ³n de email ingresada no existe en el sistema.";
		
	}
	
	
	@RequestMapping(value="/resetPassword/{token}")
	public String showResetPasswordPage(Model model, @PathVariable("token") String tokenID){

		String username = userService.findUsernameByPasswordToken(tokenID);		
		
		if(username != null){			
			return "resetPassword";
		}
		else{
			model.addAttribute("errorMessage", "La pÃ¡gina solicitada no existe.");
			return "account/error";
		}
		
	}
	
	
	@RequestMapping(value="/resetPassword/{token}", method = RequestMethod.POST)
	public @ResponseBody String doResetPassword(@PathVariable("token") String tokenID, 
			@RequestParam String newPassword, HttpServletRequest request) { 	
		
		//validate token against database
		String tokenNoExtension = StringUtils.EMPTY;
		try{
			tokenNoExtension = tokenID.substring(0,tokenID.lastIndexOf("."));
		}
		catch(StringIndexOutOfBoundsException e){
			tokenNoExtension = tokenID;
		}
		
		//find username by token (expiration date validated in query)
		String username = userService.findUsernameByPasswordToken(tokenNoExtension);			
		final String plainPass = newPassword;	
		String encodedNewPass = passwordEncoder.encodePassword(plainPass, username);	
	
		if(username != null){
			
			try{
				//change password		
				userService.changePassword(username, encodedNewPass);							
						
				//delete token
				userService.deletePasswordToken(tokenNoExtension);
							
				//auto-login with new password				
				UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(
						username, plainPass);
			    request.getSession();
			    authToken.setDetails(new WebAuthenticationDetails(request));
				Authentication authenticatedUser = fixealaAuthenticationManager.authenticate(authToken);
				SecurityContextHolder.getContext().setAuthentication(authenticatedUser);
				
			} catch(Exception e){
				//show page not found error page	
				return "No se ha podido modificar la clave.";
			}
			
			//send notification email
			
			//show success message
			return "La contraseÃ±a ha sido modificada.";
		}
			
		else{
			//show page not found error page	
			return "Token no valido.";
		}
		
	}
	
	@RequestMapping(value = "/profile", method = RequestMethod.GET)	
	public String showProfilePage(){
		return "profile";
	}
	
	@RequestMapping(value="/closeAccount", method = RequestMethod.POST)
	public @ResponseBody String doCloseAccount(@ModelAttribute(value="user") UserDTO user, HttpServletRequest request) { 	
					
		User loggedUser = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();		
		UserDetails userDB = userService.loadUserByUsername(loggedUser.getUsername());
		
		//Password stored in database
		String encodedDBPass = userDB.getPassword();
		
		//Password provided by user through form input
		String encodedInputPass = passwordEncoder.encodePassword(user.getPassword(), loggedUser.getUsername());	
		
		if(encodedDBPass != null){
		
			if(encodedInputPass.equals(encodedDBPass)){		
				userService.closeAccount(loggedUser.getUsername());
				
				return "La cuenta ha sido desactivada.";
			}
			
			else{
				return "La contraseÃ±a ingresada es incorrecta.";
			}
		}
		
		return "";
		
	}
	
	

	public UserDTO convertTo(User user){
		UserDTO userDTO = new UserDTO();
		userDTO.setUsername(user.getUsername());
		userDTO.setPassword(user.getPassword());
		userDTO.setEmail(user.getEmail());
		
		Collection<GrantedAuthority> auth = new ArrayList<GrantedAuthority>();		
		auth.addAll(user.getAuthorities());
		List<String> authToString = new ArrayList<String>();
		
		for(GrantedAuthority g : auth ){
			authToString.add(g.getAuthority());
		}
			
		userDTO.setAuthorities(authToString);	
		return userDTO;
	}
	
}
