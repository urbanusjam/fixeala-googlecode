package ar.com.urbanusjam.web.controllers;

import java.util.ArrayList;
import java.util.Collection;
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
import ar.com.urbanusjam.services.MailService;
import ar.com.urbanusjam.services.UserService;
import ar.com.urbanusjam.services.dto.PasswordChangeDTO;
import ar.com.urbanusjam.services.dto.PasswordResetTokenDTO;
import ar.com.urbanusjam.services.dto.UserDTO;
import ar.com.urbanusjam.web.domain.AlertStatus;
import ar.com.urbanusjam.web.domain.ContenidoResponse;
import ar.com.urbanusjam.web.security.CustomAuthenticationProvider;
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
	@Qualifier(value = "mailService")
	private MailService mailService;
	
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
			HttpServletRequest request) throws MessagingException {
    
    	if(!isCaptchaValido(request)) {
    		return new AlertStatus(false, "Captcha inv&aacute;lido. Intente de nuevo.");
    	}
    	    	
		try {			
			String encodedPass = passwordEncoder.encodePassword(user.getPassword(), user.getUsername());
	    	user.setPassword(encodedPass);  
 			userService.createAccount(user);
 			
			return new AlertStatus(true, "Se ha enviado un link de activacion de cuenta a su casilla de correo.");					
			
		} catch (Exception e) {			
				return new AlertStatus(false, "Ha ocurrido un error al crear su cuenta.");
		}       		
		
	}
    
    
    @RequestMapping(value="/activation/{token}")
	public String showAccountActivationPage(Model model, @PathVariable("token") String tokenID, 
			HttpServletRequest request){
    	
    	String username = userService.findUsernameByActivationToken(tokenID);	
    	
		if(username != null){		
			    		
    		try{
    			
//    			UserDetails user = userService.loadUserByUsername(username);  	    							
    	    
    			userService.activateAccount(username);
    			    			
    			//auto-login
//        		UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(
//        				username, user.getPassword());
//        	    request.getSession();
//        		token.setDetails(new WebAuthenticationDetails(request));
//        		
//    			Authentication authenticatedUser = customAuthenticationProvider.autoLogin(token);
//    			SecurityContextHolder.getContext().setAuthentication(authenticatedUser);
    			
    			model.addAttribute("message", "Su cuenta ha sido activada.");
        		model.addAttribute("messageTitle", "&iexcl;Felicitaciones!");
        		model.addAttribute("alertType", "success");
        		return "error";
    		
    		} catch(Exception e){
    			model.addAttribute("messageTitle", "&iexcl;Atenci&oacute;n!");
    			model.addAttribute("message", "El link de activaci&oacute;n ya ha sido usado o ha expirado.");
    			model.addAttribute("alertType", "error");
    			return "error";
    		}

    	
		}
		else{
			model.addAttribute("messageTitle", "&iexcl;Atenci&oacute;n!");
			model.addAttribute("message", "El link de activaci&oacute;n ya ha sido usado o ha expirado.");
			model.addAttribute("alertType", "error");
			return "error";			
		}    	
		    	
    }
    
			
	@RequestMapping(value="/forgotPassword", method = RequestMethod.GET)
	public String showForgotPassword() { 						
		return "forgotPassword";	 
	}
	
	@RequestMapping(value="/forgotPassword/sendPasswordResetMail", method = RequestMethod.POST)
	public @ResponseBody AlertStatus doSendForgotPasswordToken(@RequestParam ("email") String email) { 		
	
		String username = userService.findUsernameByEmail(email);
		
		if(username != null){			

			DateTime creation = new DateTime();
			DateTime expiration = creation.plusDays(1); 
		
			//random token generation
			String token = UUID.randomUUID().toString();
			
			try {
				
				PasswordResetTokenDTO pwdTokenDTO = new PasswordResetTokenDTO();
				pwdTokenDTO.setToken(token);
				pwdTokenDTO.setUsername(username);
				pwdTokenDTO.setCreation(creation.toDate());
				pwdTokenDTO.setExpiration(expiration.toDate());
				
				userService.savePasswordResetToken(pwdTokenDTO);
				//mailService.sendPasswordResetEmail(username, token, email);
				
			} catch (Exception e) {
				
				return new AlertStatus(false, "Ha ocurrido un error. Intente m&aacute;s tarde.");
			}
		
			return new AlertStatus(true, "Se ha enviado un email de recuperaci&oacute;n de clave<br>a su casilla de correo.");
		
 			
 		 }else{ 			
 			return new AlertStatus(false, "La direcci&oacute;n de correo no est&aacute; registrada en el sitio.");
		}
	
	}	
	
	@RequestMapping(value="/resetPassword/{token}", method = RequestMethod.GET)
	public String showResetPasswordPage(Model model, @PathVariable("token") String tokenID){

		String username = userService.findUsernameByPasswordToken(tokenID);		
		
		if(username != null){			
			return "resetPassword";
		}
		else{
			model.addAttribute("messageTitle", "&iexcl;Atenci&oacute;n!");
			model.addAttribute("message", "La página solicitada no existe.");
			return "error";		
		}
		
	}	
	
	@RequestMapping(value="/resetPassword/{token}", method = RequestMethod.POST)
	public @ResponseBody AlertStatus doResetPassword(@PathVariable("token") String tokenID, 
			@RequestParam("newPassword") String newPassword, HttpServletRequest request) { 	
	
		String token = StringUtils.EMPTY;
		try{
			token = tokenID.substring(0,tokenID.lastIndexOf("."));
		}
		catch(StringIndexOutOfBoundsException e){
			token = tokenID;
		}
	
		String username = userService.findUsernameByPasswordToken(token);			
		final String plainPass = newPassword;	
		String newEncodedPass = passwordEncoder.encodePassword(plainPass, username);	
	
		if(username != null){			
			try{		
				
				userService.changePassword(new PasswordChangeDTO("forgot", token, username, null, newEncodedPass));					
				
			} catch(Exception e){				
				return new AlertStatus(false, "Ha ocurrido un error al procesar el cambio. Intente m&aacute;s tarde.");
			}
			
			return new AlertStatus(true, "La clave ha sido modificada.");
		}
			
		else{		
			return new AlertStatus(false, "Ha ocurrido un error al procesar el cambio. Intente m&aacute;s tarde.");
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
    	
	@RequestMapping(value = "/changePassword", method = RequestMethod.POST)
	public @ResponseBody AlertStatus doChangePassword(@RequestParam("currentPassword") String currentPassword, 
			@RequestParam("newPassword") String newPassword, HttpServletRequest request){
				
		User loggedUser = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		final String newPlainPass = newPassword;		
		String currentEncodedPass = passwordEncoder.encodePassword(currentPassword, loggedUser.getUsername());	
		String newEncodedPass = passwordEncoder.encodePassword(newPassword, loggedUser.getUsername());
				
		try{
			userService.changePassword(new PasswordChangeDTO("change", null, loggedUser.getUsername(), currentEncodedPass, newEncodedPass));	
			
			//auto-login con nueva clave
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
				return new AlertStatus(false, e.getMessage());
		}
		
		return new AlertStatus(true, "La clave ha sido modificada.");
		
	}

	
	@RequestMapping(value="/updateAccount", method = RequestMethod.POST)
	public @ResponseBody ContenidoResponse doUpdateAccount(@RequestParam ("newEmail") String newEmail, 
			@RequestParam ("newCity") String newCity, @RequestParam ("newProvince") String newProvince, HttpServletRequest request) {
		
		User loggedUser = (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();	
		
		if(newProvince.equals("none")){
			newProvince = null;
			newCity = null;
		}
			
		
		try {		
		
			if( userService.emailExists(newEmail) && 
				!loggedUser.getUsername().equals(userService.findUsernameByEmail(newEmail)) ){
				return new ContenidoResponse(false, "La direcci&oacute;n de email ya ha sido registrada por otro usuario.");
			}
				
			UserDTO userDTO = userService.getUserByUsername(loggedUser.getUsername());		
			userDTO.setEmail(newEmail);
			userDTO.setCity(newCity);
			userDTO.setProvince(newProvince);
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
