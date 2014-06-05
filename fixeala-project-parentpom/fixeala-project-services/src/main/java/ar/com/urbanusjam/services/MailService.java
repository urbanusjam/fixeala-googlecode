package ar.com.urbanusjam.services;

public interface MailService {
	
	public void sendActivationRequestEmail(String username, String token, String email) throws Exception;
	
	public void sendActivationSuccessEmail(String username, String email) throws Exception;
	
	public void sendPasswordResetEmail(String username, String token, String email) throws Exception;	

}
