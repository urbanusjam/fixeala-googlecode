package ar.com.urbanusjam.web.controllers;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.naming.AuthenticationException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.core.Authentication;
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
import org.springframework.web.servlet.mvc.AbstractController;

import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.ContenidoService;
import ar.com.urbanusjam.services.UserService;
import ar.com.urbanusjam.services.dto.ActivationDTO;
import ar.com.urbanusjam.services.dto.PasswordResetTokenDTO;
import ar.com.urbanusjam.services.dto.UserDTO;
import ar.com.urbanusjam.web.domain.AlertStatus;
import ar.com.urbanusjam.web.domain.ContenidoResponse;
import ar.com.urbanusjam.web.security.CustomAuthenticationProvider;
import ar.com.urbanusjam.web.utils.EmailUtils;
import ar.com.urbanusjam.web.validators.SimpleCaptchaValidator;

@Controller
@RequestMapping(value="/account")
public class AccountController extends AbstractController {
	
	@Autowired
	@Qualifier(value = "userService")
	private UserService userService;
	
	@Autowired
	@Qualifier(value = "contenidoService")
	private ContenidoService contenidoService;
	
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
	public String showSignUpPage(HttpServletResponse response){
//		response.setContentType("text/javascript");
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
  
    @RequestMapping(value = "/signup/captchaImg",  method = RequestMethod.GET)
    private boolean isCaptchaValido (HttpServletRequest request) {
		SimpleCaptchaValidator validator = new SimpleCaptchaValidator();
		if(validator.isCaptchaValido(request)) {
			return true;
		} else {	
			return false;
		}
	}
        
    @RequestMapping(value = "/signup/createAccount", method = RequestMethod.POST)
	public @ResponseBody AlertStatus doCreateAccount(@ModelAttribute("user") UserDTO user, 
			HttpServletRequest request){
    
    	if(!isCaptchaValido(request)) {
    		return new AlertStatus(true, "Captcha invalido");
    	}
    	    	
		try {
			
			String encodedPass = passwordEncoder.encodePassword(user.getPassword(), user.getUsername());
	    	user.setPassword(encodedPass);	       	
	    	user.setRegistrationDate(new Date());
	    	user.setEnabled(false);
	    	user.setVerifiedOfficial(false);	   
		    user.setAreaId("1");
		    
		    List<String> roles = new ArrayList<String>();
		    roles.add("ROLE_USER");
		    user.setAuthorities(roles);
	    	
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
 			
 			/**
 			 * TODO englobar la creacion de CUENTA, el TOKEN y el envio de EMAIL en una unica transaccion
 			 */
 			
 			//create user
 			userService.createAccount(user);
 			  
 			//save token
 			userService.saveActivationToken(tokenDTO);		
 		
 			//send activation email
 			emailUtils.sendActivationEmail(user.getUsername(), token, user.getEmail());		
 			
 			String message = "Se ha enviado un link de activacion de cuenta a su casilla de correo. ";

			return new AlertStatus(true, message);
					
			
		} catch (Exception e) {
			if(e instanceof MessagingException){
				userService.deleteAccountAndToken(user.getUsername());
				return new AlertStatus(false, "Ha ocurrido un error y no se ha podido mandar el link de activaci&oacute;n. Intente de nuevo. ");		
			}	
			else{
				return new AlertStatus(false, "Ha ocurrido un error al crear su cuenta. Intente de nuevo. ");		
			}	

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
    		model.addAttribute("messageTitle", "&iexcl;Felicitaciones!");
    		model.addAttribute("alertType", "success");
    		return "result";
		}
		else{
			model.addAttribute("message", "El link de activaci&oacute;n ya ha sido usado o ha expirado.");
			model.addAttribute("messageTitle", "&iexcl;Atenci&oacute;n!");
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
	public @ResponseBody AlertStatus doChangePassword(@ModelAttribute(value="user") UserDTO user, 
			HttpServletRequest request){
				
		User loggedUser = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		final String newPlainPass = user.getNewPassword();
		
		String currentEncodedPass = passwordEncoder.encodePassword(user.getPassword(), loggedUser.getUsername());	
		user.setPassword(currentEncodedPass);
		
		String currentDBPass = userService.findPassword(loggedUser.getUsername(), currentEncodedPass);		
		
		String newEncodedPass = passwordEncoder.encodePassword(user.getNewPassword(), loggedUser.getUsername());
		user.setNewPassword(newEncodedPass);
		
		//valido clave actual
		if(currentEncodedPass.equals(currentDBPass)){
				//auto-login con nueva clave
				try{
					userService.changePassword(loggedUser.getUsername(), newEncodedPass);		
					UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(
							loggedUser.getUsername(), newPlainPass);
				    request.getSession();
					token.setDetails(new WebAuthenticationDetails(request));
					Authentication authenticatedUser = fixealaAuthenticationManager.authenticate(token);
					SecurityContextHolder.getContext().setAuthentication(authenticatedUser);
				} catch(Exception e){
					if(e instanceof AuthenticationException)
						return new AlertStatus(false, "Ha ocurrido un error al intentar iniciar sesión con la nueva clave.");
					else
						return new AlertStatus(false, "Ha ocurrido un error al intentar modificar la clave.");
				}
				return new AlertStatus(true, "La clave ha sido modificada.");
		}
		else{
			return new AlertStatus(false, "La clave actual ingresada es incorrecta.");		
		}
	}
							
	
	
	
	
	@RequestMapping(value="/forgotPassword", method = RequestMethod.GET)
	public String showForgotPassword() { 						
		return "forgotPassword";	 
	}
	
	@RequestMapping(value="/forgotPassword/sendEmailToken", method = RequestMethod.POST)
	public @ResponseBody boolean doSendForgotPasswordToken(@RequestParam ("email") String email) { 		
		
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
//		return "La dirección de email ingresada no existe en el sistema.";
		
	}
	
	
	@RequestMapping(value="/resetPassword/{token}")
	public String showResetPasswordPage(Model model, @PathVariable("token") String tokenID){

		String username = userService.findUsernameByPasswordToken(tokenID);		
		
		if(username != null){			
			return "resetPassword";
		}
		else{
			model.addAttribute("errorMessage", "La página solicitada no existe.");
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
			return "La contraseña ha sido modificada.";
		}
			
		else{
			//show page not found error page	
			return "Token no valido.";
		}
		
	}
	
	@RequestMapping(value="/updateAccount", method = RequestMethod.POST)
	public @ResponseBody ContenidoResponse doUpdateAccount(@RequestParam ("newEmail") String newEmail, @RequestParam ("newBarrio") String newBarrio, HttpServletRequest request) {
		
		User loggedUser = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();	
		
		try {		
		
			if( !newEmail.equals(loggedUser.getEmail()) 
					&& userService.emailExists(newEmail))
				return new ContenidoResponse(false, "La direcci&oacute;n de email ya ha sido registrada por otro usuario.");
			
			UserDTO userDTO = userService.getUserByUsername(loggedUser.getUsername());		
			userDTO.setEmail(newEmail);
			userDTO.setNeighborhood(newBarrio);
			userService.updateAccount(userDTO);
			
		    return new ContenidoResponse(true, "Los datos de la cuenta han sido actualizados.");
			
		}catch(Exception e){
			return new ContenidoResponse(false, "Hubo un error al intentar actualizar los datos de la cuenta.");
		}
				
	}
	
	
	@RequestMapping(value="/closeAccount", method = RequestMethod.POST)
	public @ResponseBody AlertStatus doCloseAccount(@RequestParam ("password") String password, HttpServletRequest request) { 	
					
		User loggedUser = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();		
		UserDetails userDB = userService.loadUserByUsername(loggedUser.getUsername());
		
		//Password stored in database
		String encodedDBPass = userDB.getPassword();
		
		//Password provided by user through form input
		String encodedInputPass = passwordEncoder.encodePassword(password, loggedUser.getUsername());	
		
		if(encodedInputPass.equals(encodedDBPass)){				
			try{
				userService.closeAccount(loggedUser.getUsername());
				SecurityContextHolder.getContext().setAuthentication(null);
				
				return new AlertStatus(true, "La cuenta ha sido desactivada.", "closedAccount.html");
			}
			catch(Exception e){
				return new AlertStatus(false, "Ha ocurrido un error al intentar desactivar su cuenta.");
			}								
		}
		
		else{
			return new AlertStatus(false, "La clave ingresada es incorrecta.");	
		}		
	}
	
	

	public static UserDTO convertTo(User user){
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


	@Override
	protected ModelAndView handleRequestInternal(HttpServletRequest arg0,
			HttpServletResponse arg1) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
}
