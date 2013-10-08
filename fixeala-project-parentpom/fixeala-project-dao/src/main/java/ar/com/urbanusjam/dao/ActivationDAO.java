package ar.com.urbanusjam.dao;

import ar.com.urbanusjam.entity.annotations.ActivationToken;


public interface ActivationDAO{
	
	public void saveToken(ActivationToken token);
	
	public String findUsernameByActivationToken(String token);
	
	public void deleteToken(String token);
	
	public void deleteTokenByUsername(String username);	
	
}
