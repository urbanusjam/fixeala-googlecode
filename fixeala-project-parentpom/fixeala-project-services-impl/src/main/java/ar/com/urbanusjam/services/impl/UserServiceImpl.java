package ar.com.urbanusjam.services.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;

import org.jfree.util.Log;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.ActivationDAO;
import ar.com.urbanusjam.dao.AuthorityDAO;
import ar.com.urbanusjam.dao.PasswordResetDAO;
import ar.com.urbanusjam.dao.UserDAO;
import ar.com.urbanusjam.entity.annotations.ActivationToken;
import ar.com.urbanusjam.entity.annotations.Authority;
import ar.com.urbanusjam.entity.annotations.MediaContent;
import ar.com.urbanusjam.entity.annotations.PasswordToken;
import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.ContenidoService;
import ar.com.urbanusjam.services.MailService;
import ar.com.urbanusjam.services.UserService;
import ar.com.urbanusjam.services.dto.EmailDTO;
import ar.com.urbanusjam.services.dto.PasswordChangeDTO;
import ar.com.urbanusjam.services.dto.UserDTO;


@Service
public class UserServiceImpl implements UserService {
	
	private static final String PASSWORD_FORGOT = "forgot";
	private static final String PASSWORD_CHANGE = "change";
	
	@Autowired
	private UserDAO userDAO;
	
	@Autowired
	private AuthorityDAO authorityDAO;
	
	@Autowired
	private PasswordResetDAO passwordResetDAO;
	
	@Autowired
	private ActivationDAO activationDAO;
	
	@Autowired
	private ContenidoService contenidoService; 
	
	@Autowired
	private MailService mailService;
	

	@Override
	public User loadUserByUsername(String username) throws UsernameNotFoundException, DisabledException{	
		
			try {
				User user = (User) userDAO.loadUserByUsername(username);
				
			 	 if(user == null)
			 		 throw new BadCredentialsException("Authentication failed.");
			 	 
			 	 if(!user.hasSingleRole("ROLE_USER", user.getRoles()))
			 		 throw new BadCredentialsException("Authentication failed.");
			 	 
			 	 else			 	
			 		 return user;				   			   
	        } 
			catch (UsernameNotFoundException e) {
	            throw new UsernameNotFoundException("User not found.");
	        }	
	}
	
	@Override
	public UserDTO getUserByUsername(String username) throws UsernameNotFoundException, DisabledException{	
		
			try {
				User user = (User) userDAO.loadUserByUsername(username);
				
			 	 if(user == null)
			 		 throw new BadCredentialsException("Authentication failed.");
			 	
			 	 else
			    	 return convertToDTO(user);				     	   
	        } 
			catch (UsernameNotFoundException e) {
	            throw new UsernameNotFoundException("User not found.");
	        }	
	}	
	
	@Override
	public List<UserDTO> loadAllActiveUsers() {
		List<User> users = userDAO.findAllActiveUsers();
		List<UserDTO> usersDTO = new ArrayList<UserDTO>();
		
		for(User u : users){	
			UserDTO uDTO = convertToDTO(u);
			usersDTO.add(uDTO);	
		}
		
		return usersDTO;
	}
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED, noRollbackFor = MessagingException.class)
	public void changePassword(PasswordChangeDTO passwordChange) throws Exception {
		
		String operation = passwordChange.getOperation();
		String username = passwordChange.getUsername();
		
		if(operation.equals(PASSWORD_FORGOT)){		
			userDAO.changePassword(passwordChange.getUsername(), passwordChange.getNewPassword());		
			passwordResetDAO.deleteToken(passwordChange.getToken());			
			mailService.sendPasswordResetSuccessEmail(username, userDAO.findEmailbyUsername(username));
		}
		else if(operation.equals(PASSWORD_CHANGE)){
			if(userDAO.findPassword(username, passwordChange.getCurrentPassword())){
				userDAO.changePassword(username, passwordChange.getNewPassword());	
				
				try{
					mailService.sendPasswordResetSuccessEmail(username, userDAO.findEmailbyUsername(username));
				}catch(Exception e){			
					Log.debug("Error en el envio del email por cambio de clave.");			
				}
				
			}				
			else
				throw new Exception("La clave actual ingresada es incorrecta.");
		}	
	}
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = MessagingException.class)
	public void createAccount(UserDTO userDTO) throws Exception {
		
		User user = new User();
		ActivationToken token = new ActivationToken();		
		DateTime currentDate = new DateTime();
		
		//user data
	    List<String> roles = new ArrayList<String>();
	    roles.add("ROLE_USER");	
    	user.setEnabled(false);
	    userDTO.setAuthorities(roles);
	    userDTO.setRegistrationDate(currentDate.toDate());
	    userDTO.setCity(null);
	    userDTO.setProvince(null);
		user = this.convertTo(userDTO);
		
		//token data			
		DateTime expiration = currentDate.plusDays(3); 	
		String tokenUUID = UUID.randomUUID().toString(); //random token	
		token.setToken(tokenUUID);
		token.setUsername(user.getUsername());
		token.setCreation(currentDate.toDate());
		token.setExpiration(expiration.toDate());			

		try {
			//create user
			userDAO.createUser(user);		
			  
			//save token 			
			activationDAO.saveToken(token);
			
			//send activation email			
			mailService.sendActivationRequestEmail(user.getUsername(), tokenUUID, user.getEmail());
			
		} catch (Exception e) {
			throw new MessagingException();
		}	
				
	}
		
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = MessagingException.class)
	public void activateAccount(String username) throws UsernameNotFoundException, Exception {
		userDAO.activateAccount(username);
		activationDAO.deleteTokenByUsername(username);			
		mailService.sendActivationSuccessEmail(username, userDAO.loadUserByUsername(username).getEmail());
	}
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void updateAccount(UserDTO userDTO) {
		User user = new User();
		user = this.convertToUpdate(userDTO);
		
		String currentEmail = userDAO.findEmailbyUsername(userDTO.getUsername());
		
		if(!currentEmail.equals(userDTO.getEmail())){
			EmailDTO email = new EmailDTO();
			String message = "La direcci&oacute;n de email para tu cuenta de Fixeala ha sido correctamente actualizada.";
			email.setSubject("Aviso de cambio de Email");
			email.setMessage(message);
			email.setTo(userDTO.getEmail());
		}
		
		userDAO.updateAccount(user);			
	}
	
	@Override
	public boolean usernameExists(String username) {
		return userDAO.userExists(username);
	}

	@Override
	public boolean emailExists(String email) {
		return userDAO.emailExists(email);
	}

	@Override
	public String findUsernameByEmail(String email) {
		return userDAO.findUsernameByEmail(email);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = MessagingException.class)
	public void savePasswordResetToken(PasswordToken pwdToken) throws Exception {
		passwordResetDAO.saveToken(pwdToken);		
		String email = userDAO.findEmailbyUsername(pwdToken.getUsername());
		mailService.sendPasswordResetEmail(pwdToken.getUsername(), pwdToken.getToken(), email);
	}

	@Override
	public String findUsernameByPasswordToken(String token) {
		return passwordResetDAO.findUsernameByPasswordToken(token);
	}	

	@Override
	public String findUsernameByActivationToken(String token) {
		return activationDAO.findUsernameByActivationToken(token);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, noRollbackFor = MessagingException.class)
	public void closeAccount(String username) throws Exception {		
		userDAO.closeAccount(username);
		try{
			mailService.sendClosedAccountEmail(username, userDAO.findEmailbyUsername(username));
		}catch(Exception e){			
			Log.debug("Error en el envio del email por cambio de clave.");			
		}
	}
	
	@Override
	public Long getUserId(String username) throws UsernameNotFoundException {
		return userDAO.findUserIDbyUsername(username);
	}

	@Override
	public void updateUserLastLogin(String username) {
		userDAO.saveUserLastLogin(username);
	}
		
	///////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public User convertTo(UserDTO userDTO){
		User user = new User();
		user.setUsername(userDTO.getUsername());
		user.setPassword(userDTO.getPassword());
		user.setEmail(userDTO.getEmail());		
		user.setRoles(convertToAuthority(userDTO.getAuthorities()));
		user.setEnabled(userDTO.isEnabled());
		user.setCity(userDTO.getCity());
		user.setProvince(userDTO.getProvince());
		user.setRegistrationDate(userDTO.getRegistrationDate());		
		
		return user;
	}
	
	public UserDTO convertToDTO(User user){
		UserDTO userDTO = new UserDTO();
		userDTO.setUsername(user.getUsername());		
		userDTO.setEmail(user.getEmail());			
		userDTO.setId(String.valueOf(user.getId()));
		
		List<String> roles = new ArrayList<String>();
		for(GrantedAuthority auth : user.getRoles()){
			roles.add(auth.getAuthority());
		}
		userDTO.setAuthorities(roles);
		userDTO.setEnabled(user.isEnabled());				
		userDTO.setRegistrationDate(user.getRegistrationDate());		
		userDTO.setLastLoginDate(user.getLastLoginDate());			
		userDTO.setCity(user.getCity());
		userDTO.setProvince(user.getProvince());
		
		MediaContent userPic = contenidoService.getUserPic(user.getUsername());
		
		userDTO.setProfilePic(userPic != null ? userPic.getLink() : null);

		if(user.isEnabled())
			userDTO.setAccountStatus("ACTIVO");
		else
			userDTO.setAccountStatus("DESHABILITADO");
		
		return userDTO;
	}
	
	public User convertToUpdate(UserDTO userDTO){
		User user = new User();		
		user.setUsername(userDTO.getUsername());
		user.setEmail(userDTO.getEmail());	
		user.setCity(userDTO.getCity());
		user.setProvince(userDTO.getProvince());
		return user;
	}	
	
	private List<Authority> convertToAuthority(List<String> roles){
		List<Authority> authorities = new ArrayList<Authority>();
		for(String role : roles){
			Authority authority = new Authority();
			authority = authorityDAO.getRoleByName(role);
			authorities.add(authority);
		}
		return authorities;
	}

}