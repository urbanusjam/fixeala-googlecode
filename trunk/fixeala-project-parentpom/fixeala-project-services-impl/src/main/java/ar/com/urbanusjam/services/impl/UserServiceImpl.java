package ar.com.urbanusjam.services.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.mail.MessagingException;

import org.joda.time.DateTime;
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
import ar.com.urbanusjam.entity.annotations.PasswordResetToken;
import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.MailService;
import ar.com.urbanusjam.services.UserService;
import ar.com.urbanusjam.services.dto.ActivationDTO;
import ar.com.urbanusjam.services.dto.PasswordResetTokenDTO;
import ar.com.urbanusjam.services.dto.UserDTO;


@Service
public class UserServiceImpl implements UserService {
	
	private UserDAO userDAO;
	private AuthorityDAO authorityDAO;
	private PasswordResetDAO passwordResetDAO;
	private ActivationDAO activationDAO;
	private MailService mailService;
	
	
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}
	
	public void setAuthorityDAO(AuthorityDAO authorityDAO) {
		this.authorityDAO = authorityDAO;
	}		

	public void setPasswordResetDAO(PasswordResetDAO passwordResetDAO) {
		this.passwordResetDAO = passwordResetDAO;
	}
	
	public void setActivationDAO(ActivationDAO activationDAO) {
		this.activationDAO = activationDAO;
	}
		
	public void setMailService(MailService mailService) {
		this.mailService = mailService;
	}

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
	/**
	@Override
	public List<UserDTO> loadVerifiedUsersByArea(String areaID) {
		List<User> users = userDAO.findUsersByArea(areaID);
		List<UserDTO> usersDTO = new ArrayList<UserDTO>();
		
		for(User u : users){	
			UserDTO uDTO = convertToDTO(u);
			usersDTO.add(uDTO);	
		}
		return usersDTO;
	}
	 **/

	@Override
	public void changePassword(String username, String newPassword) {		
		userDAO.changePassword(username, newPassword);			
	}
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED, rollbackFor = MessagingException.class)
	public void createAccount(UserDTO userDTO) throws Exception {
		
		User user = new User();
		ActivationDTO tokenDTO = new ActivationDTO();		
		DateTime currentDate = new DateTime();
		
		//user data
	    List<String> roles = new ArrayList<String>();
	    roles.add("ROLE_USER");	
    	user.setEnabled(false);
	    userDTO.setAuthorities(roles);
	    userDTO.setRegistrationDate(currentDate.toDate());
		user = this.convertTo(userDTO);
		
		//token data			
		DateTime expiration = currentDate.plusDays(3); 	
		String tokenUUID = UUID.randomUUID().toString(); //random token	
		tokenDTO.setToken(tokenUUID);
		tokenDTO.setUsername(user.getUsername());
		tokenDTO.setCreation(currentDate.toDate());
		tokenDTO.setExpiration(expiration.toDate());			
		ActivationToken token = convertTo(tokenDTO); 			
		
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
	@Transactional(propagation = Propagation.REQUIRED)
	public void activateAccount(String username) throws UsernameNotFoundException, Exception {
		userDAO.activateAccount(username);
		activationDAO.deleteTokenByUsername(username);			
		mailService.sendActivationSuccessEmail(username, userDAO.loadUserByUsername(username).getEmail());
	}
	
	@Override
	public void updateAccount(UserDTO userDTO) {
		User user = new User();
		user = this.convertToUpdate(userDTO);
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
	public String findPassword(String username, String password) {
		return userDAO.findPassword(username, password);
	}

	@Override
	public String findUsernameByEmail(String email) {
		return userDAO.findUsernameByEmail(email);
	}

	@Override
	public void savePasswordResetToken(PasswordResetTokenDTO passwordDTO) {
		PasswordResetToken token = new PasswordResetToken();
		token = convertTo(passwordDTO);
		passwordResetDAO.saveToken(token);		
	}

	@Override
	public String findUsernameByPasswordToken(String token) {
		return passwordResetDAO.findUsernameByPasswordToken(token);
	}

	@Override
	public void deletePasswordToken(String token) {
		passwordResetDAO.deleteToken(token);		
	}
	
	@Override
	public void saveActivationToken(ActivationDTO activationDTO) {
		ActivationToken token = new ActivationToken();
		token = convertTo(activationDTO);
		activationDAO.saveToken(token);		
	}

	@Override
	public void deleteActivationToken(String token) {
		activationDAO.deleteToken(token);		
	}
	
	@Override
	public void deleteAccountAndToken(String username) {
		userDAO.deleteUnabledUserAndToken(username);		
	}
	
	@Override
	public String findUsernameByActivationToken(String token) {
		return activationDAO.findUsernameByActivationToken(token);
	}

	@Override
	public void closeAccount(String username) {
		userDAO.closeAccount(username);
	}
	
	
	
	public User convertTo(UserDTO userDTO){
		User user = new User();
		user.setUsername(userDTO.getUsername());
		user.setPassword(userDTO.getPassword());
		user.setEmail(userDTO.getEmail());		
		user.setRoles(convertToAuthority(userDTO.getAuthorities()));
		user.setEnabled(userDTO.isEnabled());
		user.setNeighborhood(userDTO.getNeighborhood());
		user.setRegistrationDate(userDTO.getRegistrationDate());		
		
//		if(userDTO.isVerifiedOfficial()){
//			user.setVerifiedOfficial(true);
//			user.setNombre(userDTO.getNombre());
//			user.setApellido(userDTO.getApellido());
//			user.setCargo(userDTO.getCargo());
//			user.setSubArea(userDTO.getSubarea());
//			user.setArea(areaDAO.getAreaById(userDTO.getAreaId()));
//		}
//		
//		else{
			
//		}
		
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
		
		if(user.isVerifiedOfficial()){
			userDTO.setVerifiedOfficial(user.isVerifiedOfficial());
			userDTO.setNombre(user.getNombre());
			userDTO.setApellido(user.getApellido());
			userDTO.setCargo(user.getCargo());
			userDTO.setAreaId(String.valueOf(user.getArea().getId()));
			userDTO.setAreaNombre(user.getArea().getNombre());
			userDTO.setAreaCiudad(user.getArea().getCiudad());
			userDTO.setAreaProvinciaSigla(user.getArea().getProvinciaSigla());
		}
		
		else{
			userDTO.setNeighborhood(user.getNeighborhood());
		}
		
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
		user.setNeighborhood(userDTO.getNeighborhood());
		return user;
	}
	
	
	public PasswordResetToken convertTo(PasswordResetTokenDTO passwordDTO){
		PasswordResetToken pwd = new PasswordResetToken();
		pwd.setToken(passwordDTO.getToken());
		pwd.setUsername(passwordDTO.getUsername());
		pwd.setCreation(passwordDTO.getCreation());
		pwd.setExpiration(passwordDTO.getExpiration());		
		return pwd;
	}
	
	
	public ActivationToken convertTo(ActivationDTO activationDTO){
		ActivationToken actv = new ActivationToken();
		actv.setToken(activationDTO.getToken());
		actv.setUsername(activationDTO.getUsername());
		actv.setCreation(activationDTO.getCreation());
		actv.setExpiration(activationDTO.getExpiration());		
		return actv;
	}

	
	private List<String> convertTo(List<Authority> roles){
		List<String> authorities = new ArrayList<String>();
		for(Authority role : roles){
			authorities.add(role.getAuthority());
		}
		return authorities;
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

	@Override
	public Long getUserId(String username) throws UsernameNotFoundException {
		return userDAO.findUserIDbyUsername(username);
	}

	
}
