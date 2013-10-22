package ar.com.urbanusjam.dao;



import java.util.List;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.provisioning.UserDetailsManager;

import ar.com.urbanusjam.entity.annotations.User;



public interface UserDAO extends UserDetailsManager {
	
	public UserDetails loadUserByName(String name);
	
	public User loadUserByUsername(String username) throws UsernameNotFoundException;

	public List<User> findAllActiveUsers();
	
	public List<User> findUsersByArea(String areaID);
	
	public void createUser(User user);
	
	public boolean usernameExists(String username);
	
	public boolean emailExists(String email);
	
	public String findUsernameByEmail(String email);
		
	public String findPassword(String username, String password);	

	public void changePassword(String username, String newPassword);	
	
	public void updateAccount(User user);
	
	public void activateAccount(String username);
	
	public void closeAccount(String username);
	
	public void deleteUnabledUserAndToken(String username);
	
}
