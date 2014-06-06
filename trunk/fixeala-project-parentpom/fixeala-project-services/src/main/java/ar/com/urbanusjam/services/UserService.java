package ar.com.urbanusjam.services;


import java.util.List;

import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.dto.ActivationDTO;
import ar.com.urbanusjam.services.dto.PasswordChangeDTO;
import ar.com.urbanusjam.services.dto.PasswordResetTokenDTO;
import ar.com.urbanusjam.services.dto.UserDTO;

public interface UserService extends UserDetailsService {
	
	public UserDTO getUserByUsername(String username) throws UsernameNotFoundException;	
	public User loadUserByUsername(String username) throws UsernameNotFoundException;
	public Long getUserId(String username) throws UsernameNotFoundException;
//	public List<UserDTO> loadVerifiedUsersByArea(String idArea);
	public List<UserDTO> loadAllActiveUsers();
	  
    public String findUsernameByPasswordToken(String token);    
    public String findUsernameByActivationToken(String token);    
    public String findUsernameByEmail(String email);
//    public String findPassword(String username, String password);
    
    public boolean usernameExists(String username);	
	public boolean emailExists(String email);
    
    public void savePasswordResetToken(PasswordResetTokenDTO passwordDTO); 
    public void saveActivationToken(ActivationDTO activationDTO);    
    
    public void changePassword(PasswordChangeDTO passwordChange) throws Exception;    
    
    public void deleteActivationToken(String token);
    public void deleteAccountAndToken(String username);
//  public void deletePasswordToken(String token);    
	
	public void createAccount(UserDTO userDTO) throws Exception;	
	public void activateAccount(String username) throws UsernameNotFoundException, Exception;
	public void updateAccount(UserDTO userDTO);	
	public void closeAccount(String username) throws Exception;	

}
