package ar.com.urbanusjam.services.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import ar.com.urbanusjam.dao.ActivationDAO;
import ar.com.urbanusjam.dao.AreaDAO;
import ar.com.urbanusjam.dao.AuthorityDAO;
import ar.com.urbanusjam.dao.PasswordResetDAO;
import ar.com.urbanusjam.dao.UserDAO;
import ar.com.urbanusjam.entity.annotations.ActivationToken;
import ar.com.urbanusjam.entity.annotations.Authority;
import ar.com.urbanusjam.entity.annotations.PasswordResetToken;
import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.UserService;
import ar.com.urbanusjam.services.dto.ActivationDTO;
import ar.com.urbanusjam.services.dto.PasswordResetTokenDTO;
import ar.com.urbanusjam.services.dto.UserDTO;


public class UserServiceImpl implements UserService {
	
	private UserDAO userDAO;
	private AuthorityDAO authorityDAO;
	private PasswordResetDAO passwordResetDAO;
	private ActivationDAO activationDAO;
	private AreaDAO areaDAO;
	
	
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
		
	public void setAreaDAO(AreaDAO areaDAO) {
		this.areaDAO = areaDAO;
	}
	
	@Override
	public User loadUserByUsername(String username) throws UsernameNotFoundException, DisabledException{	
		
			try {
				User user = (User) userDAO.loadUserByUsername(username);
				
			 	 if(user == null)
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
	public List<UserDTO> loadVerifiedUsersByArea(String areaID) {
		List<User> users = userDAO.findUsersByArea(areaID);
		List<UserDTO> usersDTO = new ArrayList<UserDTO>();
		
		for(User u : users){	
			UserDTO uDTO = convertToDTO(u);
			usersDTO.add(uDTO);	
		}
		return usersDTO;
	}


	@Override
	public void changePassword(String username, String newPassword) {		
			userDAO.changePassword(username, newPassword);			
	}

	
	@Override
	public void createAccount(UserDTO userDTO) {
		User user = new User();
		user = this.convertTo(userDTO);
		userDAO.createUser(user);		
	}
	
	@Override
	public void updateAccount(UserDTO userDTO) {
		User user = new User();
		user = this.convertToUpdate(userDTO);
		userDAO.updateAccount(user);			
	}
	
	@Override
	public boolean usernameExists(String username) {
		return userDAO.usernameExists(username);
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
	public void activateAccount(String username) {
		userDAO.activateAccount(username);
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
		
		if(userDTO.isVerifiedOfficial()){
			user.setVerifiedOfficial(true);
			user.setNombre(userDTO.getNombre());
			user.setApellido(userDTO.getApellido());
			user.setCargo(userDTO.getCargo());
			user.setSubArea(userDTO.getSubarea());
			user.setArea(areaDAO.getAreaById(userDTO.getAreaId()));
		}
		
		else{
			userDTO.setNeighborhood(userDTO.getNeighborhood());
		}
		
		return user;
	}
	
	public UserDTO convertToDTO(User user){
		UserDTO userDTO = new UserDTO();
		userDTO.setUsername(user.getUsername());		
		userDTO.setEmail(user.getEmail());		
		
		userDTO.setId(user.getUsername());
		
		List<String> roles = new ArrayList<String>();
		for(GrantedAuthority auth : user.getRoles()){
			roles.add(auth.getAuthority());
		}
		userDTO.setAuthorities(roles);
		
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

	
}
