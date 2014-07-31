package ar.com.urbanusjam.services;

import ar.com.urbanusjam.services.dto.EmailDTO;

public interface MailService {
	
	public void sendActivationRequestEmail(String username, String token, String email) throws Exception;
	
	public void sendActivationSuccessEmail(String username, String email) throws Exception;
	
	public void sendPasswordResetEmail(String username, String token, String email) throws Exception;	
	
	public void sendPasswordResetSuccessEmail(String username, String email) throws Exception;	
	
	public void sendClosedAccountEmail(String username, String email) throws Exception;	
	
	public void sendIssueUpdateEmail(String[] emailList, EmailDTO email) throws Exception;	
	
	public void sendEmailChangeNotification(EmailDTO email) throws Exception;	
	
//	public void sendMultipleNotifications(String[] emailList, EmailDTO email) throws Exception;

	
}
