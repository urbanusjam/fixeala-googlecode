package ar.com.urbanusjam.dao;

import ar.com.urbanusjam.entity.annotations.PasswordResetToken;

public interface PasswordResetDAO{
	
	public void saveToken(PasswordResetToken token);
	
	public String findUsernameByPasswordToken(String token);
	
	public void deleteToken(String token);

	
	
}
