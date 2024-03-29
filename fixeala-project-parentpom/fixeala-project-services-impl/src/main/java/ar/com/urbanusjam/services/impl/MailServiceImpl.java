package ar.com.urbanusjam.services.impl;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSendException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import ar.com.urbanusjam.services.MailService;
import ar.com.urbanusjam.services.dto.EmailDTO;

@Service
public class MailServiceImpl implements MailService {
	
	final String from = "fixeala@gmail.com";
	final String to = "coripel@gmail.com";
	
	@Autowired
	private JavaMailSender mailSender;
		
	public MailServiceImpl(){}
	
	@Override
	public void sendActivationRequestEmail(String username, String token, String email) throws MessagingException, MailSendException {
		
		  MimeMessage message = this.mailSender.createMimeMessage();
		  MimeMessageHelper helper = new MimeMessageHelper(message, true);
		  
		  helper.setFrom(from);
	      helper.setTo(email);
		  helper.setSubject("Fixeala - Activacion de cuenta");
		
	      String link = "<a target='_blank' href='http://localhost:8080/fixeala/account/activation/" + token + ".html' > link </a>";
	    
	      String text = "Hola, <b>" + username + "</b>";      
	      text += "<br><br>";
	      text += "Gracias por registrarse en el sitio <a target='_blank' href='http://fixeala.com.ar'>Fixeala.com.ar</a>";
	      text += "<br><br>";	   
	      text += "Para activar su cuenta, por favor cliquee en este ";	 
	      text += link;
	      text += "<br><br>";
	      text += "Si el link no funciona, copie y pegue la direcci&oacute;n completa en el navegador.";	
	      text += "<br><br>";
	      text += "Atentamente,";
	      text += "<br>";
	      text += "<b>El equipo de Fixeala</b>";
	      
	      helper.setText(text, true);
	      mailSender.send(message);
	      
	      System.out.println("Mensaje enviado existosamente...");
	}
	
	@Override
	public void sendActivationSuccessEmail(String username, String email) throws MessagingException, MailException {
		
		  MimeMessage message = this.mailSender.createMimeMessage();
		  MimeMessageHelper helper = new MimeMessageHelper(message, true);
		  
		  helper.setFrom(from);
	      helper.setTo(email);
		  helper.setSubject("Bienvenid@ a Fixeala - Tu plataforma colaborativa de reclamos barriales");
		
	      String text = "Hola, <b>" + username + "</b>";      
	      text += "<br><br>";
	      text += "Bienvenido a <a target='_blank' href='http://fixeala.com.ar'>Fixeala.com.ar</a>. Tu cuenta ha sido activada exitosamente.";	    
	      text += "<br><br>";
	      text += "Atentamente,";
	      text += "<br>";
	      text += "<b>El equipo de Fixeala</b>";
	      
	      helper.setText(text, true);
	      mailSender.send(message);
	      
	      System.out.println("Mensaje enviado existosamente...");
	}
	
	@Override
	public void sendPasswordResetEmail(String username, String token, String email) throws MessagingException, MailException {
		 
		  MimeMessage message = this.mailSender.createMimeMessage();
		  MimeMessageHelper helper = new MimeMessageHelper(message, true);
		  
		  helper.setFrom(from);
	      helper.setTo(email);
		  helper.setSubject("Recuperación de clave");
	      
	      String link = "<a target='_blank' href='http://localhost:8080/fixeala/account/resetPassword/" + token + ".html'> link" + "</a>";
	    
	      String text = "Hola, <b>" + username + "</b>";      
	      text += "<br><br>";
	      text += "Usted (o alguien pretendiendo ser usted) ha enviado una solicitud de cambio de clave para su cuenta en el sitio Fixeala.com.ar";
	      text += "<br><br>";	   
	      text += "Si usted no ha realizado esta petici&oacute;n, ignore este email; no se ha efectuado cambio alguno.";
	      text += "<br><br>";
	      text += "Por el contrario, visite el siguiente enlace para elegir su nueva clave: " + link + ". ";
	      text += "<br><br>";
	      text += "El link estar&aacute; disponible s&oacute;lo por 24 horas.";	
	      text += "<br><br>";
	      text += "Atentamente,";
	      text += "<br>";
	      text += "<b>El equipo de Fixeala</b>";
	      
	      helper.setText(text, true);
	      mailSender.send(message);
	      
	      System.out.println("Mensaje enviado existosamente...");
	}
	
	@Override
	public void sendPasswordResetSuccessEmail(String username, String email) throws MessagingException, MailException {
		
		  MimeMessage message = this.mailSender.createMimeMessage();
		  MimeMessageHelper helper = new MimeMessageHelper(message, true);
		  
		  helper.setFrom(from);
	      helper.setTo(email);
		  helper.setSubject("Modificaste tu clave de Fixeala");
		
	      String text = "Hola, <b>" + username + "</b>";      
	      text += "<br><br>";
	      text += "Este es un mensaje de confirmación de que la clave de tu cuenta de Fixeala ha sido modificada.";
	      text += "<br><br>";
	      text += "Si no pediste cambiar tu clave, iniciá sesión y cambiá la clave si es necesario. Si tenés problemas, contactate con el servicio de ayuda de Fixeala.";  
	      text += "<br><br>";
	      text += "Atentamente,";
	      text += "<br>";
	      text += "<b>El equipo de Fixeala</b>";
	      
	      helper.setText(text, true);
	      mailSender.send(message);
	      
	      System.out.println("Mensaje enviado existosamente...");
	}
	
	@Override
	public void sendClosedAccountEmail(String username, String email) throws MessagingException, MailException {
		
		  MimeMessage message = this.mailSender.createMimeMessage();
		  MimeMessageHelper helper = new MimeMessageHelper(message, true);
		  
		  helper.setFrom(from);
		  helper.setTo(email);
		  helper.setSubject("Cierre de cuenta");
			
	      String text = "Hola, <b>" + username + "</b>";      
	      text += "<br><br>";
	      text += "Tu cuenta de Fixeala ha sido desactivada.";
	      text += "<br><br>";
	      text += "Tus datos personajes se han eliminado pero la información de tus reclamos seguirá vigente en nuestro sitio para el resto de los usuarios.";  
	      text += "<br><br>";
	      text += "Atentamente,";
	      text += "<br>";
	      text += "<b>El equipo de Fixeala</b>";
	      
	      helper.setText(text, true);
	      mailSender.send(message);
	      
	      System.out.println("Mensaje enviado existosamente...");
		
	}
	
	
	//<username> comento en "<issue_title>" [OK]
	
	//<username> resolvio el reclamo #<issue_id> "<issue_title>" [OK]
	
	//<username> reabrio el reclamo #<issue_id> "<issue_title>" [OK]
	
	//<username> actualizo el reclamo #<issue_id> "<issue_title>"
	
	//<username> adjunto X archivos a "<issue_title>"
	
	@Override
	public void sendIssueUpdateEmail(String[] emailList, EmailDTO email)
			throws MessagingException, MailException {
		
		if(emailList != null && emailList.length > 0){
			  MimeMessage message = this.mailSender.createMimeMessage();
			  MimeMessageHelper helper = new MimeMessageHelper(message, true);
			  
			  helper.setFrom(from);
		      helper.setTo(emailList);
			  helper.setSubject(email.getSubject());
				
		      String text = email.getMessage();
		      text += "<br><br>";
		      text += "Atentamente,";
		      text += "<br>";
		      text += "<b>El equipo de Fixeala</b>";
		      
		      helper.setText(text, true);
		      mailSender.send(message);
		}
	}
	
	
	@Override
	public void sendEmailChangeNotification(EmailDTO email)
			throws MessagingException, MailException {
		
		  MimeMessage message = this.mailSender.createMimeMessage();
		  MimeMessageHelper helper = new MimeMessageHelper(message, true);
		  
		  helper.setFrom(from);
		  helper.setTo(email.getTo());
		  helper.setSubject(email.getSubject());
			
	      String text = email.getMessage();
	      text += "<br><br>";
	      text += "Atentamente,";
	      text += "<br>";
	      text += "<b>El equipo de Fixeala</b>";
	      
	      helper.setText(text, true);
	      mailSender.send(message);
	}
	
	@Override
	public void sendFeedbackEmail(String subject, String body, String sender) throws MessagingException, MailException {
		
		  MimeMessage message = this.mailSender.createMimeMessage();
		  MimeMessageHelper helper = new MimeMessageHelper(message, true);

//		  helper.setFrom(new InternetAddress("feedback.fixeala@gmail.com"));
	      helper.setTo("fixeala@gmail.com");
		  helper.setSubject("Feedback - " + subject);
			
	      String text = "<b>Asunto: </b>" + subject;
	      text += "<br><br>";
	      text += "<b>Email: </b>" + sender;
	      text += "<br><br>";
	      text += "<b>Mensaje: </b>" + body;	   
	      
	      helper.setText(text, true);
	      mailSender.send(message);
	      
	      System.out.println("Mensaje enviado existosamente...");
		
	}
}
