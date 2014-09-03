package ar.com.urbanusjam.services;

import javax.mail.MessagingException;

import org.springframework.mail.MailException;

import ar.com.urbanusjam.services.dto.EmailDTO;

public interface MailService {
	
	/** 
	 * TODO
	 * 		- agrupar parametros en EmailDTO
	 * 		- unir servicios comunes
	 */
	public void sendActivationRequestEmail(String username, String token, String email) throws MessagingException, MailException;
	
	public void sendActivationSuccessEmail(String username, String email) throws MessagingException, MailException;
	
	public void sendPasswordResetEmail(String username, String token, String email) throws MessagingException, MailException;
	
	public void sendPasswordResetSuccessEmail(String username, String email) throws MessagingException, MailException;
	
	public void sendClosedAccountEmail(String username, String email) throws MessagingException, MailException;
	
	public void sendIssueUpdateEmail(String[] emailList, EmailDTO email) throws MessagingException, MailException;
	
	public void sendEmailChangeNotification(EmailDTO email) throws MessagingException, MailException;
	
	public void sendFeedbackEmail(String subject, String body, String sender) throws MessagingException, MailException;
	
}
