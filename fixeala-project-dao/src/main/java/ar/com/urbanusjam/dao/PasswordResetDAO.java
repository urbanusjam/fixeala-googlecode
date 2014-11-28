package ar.com.urbanusjam.dao;

import ar.com.urbanusjam.entity.annotations.PasswordToken;

public interface PasswordResetDAO {
	
	public void saveToken(PasswordToken token);
	
	public String findUsernameByPasswordToken(String token);
	
	public void deleteToken(String token);		
	
}
