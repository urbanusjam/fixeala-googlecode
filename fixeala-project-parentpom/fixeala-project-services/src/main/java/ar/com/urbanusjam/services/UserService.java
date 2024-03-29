package ar.com.urbanusjam.services;


import java.util.List;

import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import ar.com.urbanusjam.entity.annotations.PasswordToken;
import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.dto.PasswordChangeDTO;
import ar.com.urbanusjam.services.dto.UserDTO;

public interface UserService extends UserDetailsService {
	
	public UserDTO getUserByUsername(String username) throws UsernameNotFoundException;	
	public User loadUserByUsername(String username) throws UsernameNotFoundException;
	public Long getUserId(String username) throws UsernameNotFoundException;
	public List<UserDTO> loadAllActiveUsers();
	  
    public String findUsernameByPasswordToken(String token);    
    public String findUsernameByActivationToken(String token);    
    public String findUsernameByEmail(String email);
    
    public boolean usernameExists(String username);	
	public boolean emailExists(String email);
    
	public void createAccount(UserDTO userDTO) throws Exception;	
	public void activateAccount(String username) throws UsernameNotFoundException, Exception;
	public void updateAccount(UserDTO userDTO);	
	public void closeAccount(String username) throws Exception;	
	
    public void savePasswordResetToken(PasswordToken pwdToken) throws Exception; 
    public void changePassword(PasswordChangeDTO passwordChange) throws Exception;   
	
	public void updateUserLastLogin(String username);	

}
