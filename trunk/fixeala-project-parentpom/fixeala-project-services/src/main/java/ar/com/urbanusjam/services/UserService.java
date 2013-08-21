package ar.com.urbanusjam.services;


import java.util.List;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.dto.ActivationDTO;
import ar.com.urbanusjam.services.dto.PasswordResetTokenDTO;
import ar.com.urbanusjam.services.dto.UserDTO;

public interface UserService extends UserDetailsService{
	
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException;
	public List<UserDTO> loadAllActiveUsers();
	public String findUsernameByEmail(String email);
	
	public boolean usernameExists(String username);	
	public boolean emailExists(String email);				
	public String findPassword(String username, String password);	
		
    public void changePassword(String username, String newPassword);    
    
    public String findUsernameByPasswordToken(String token);    
    public void savePasswordResetToken(PasswordResetTokenDTO passwordDTO);    
    public void deletePasswordToken(String token);    
    
    public String findUsernameByActivationToken(String token);    
    public void saveActivationToken(ActivationDTO activationDTO);    
    public void deleteActivationToken(String token);
	
	public void createAccount(UserDTO userDTO);
	public void updateAccount(UserDTO userDTO);
	public void activateAccount(String username);	
	public void closeAccount(String username);
	

}
