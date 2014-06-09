package ar.com.urbanusjam.services.impl;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.services.MailService;

@Service
@Transactional
public class MailServiceImpl implements MailService {
	
	final String from = "fixeala@gmail.com";
	final String to = "coripel@gmail.com";
	
	private JavaMailSender mailSender;
	
	public void setMailSender(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}
	
	public MailServiceImpl(){}
	
	@Override
	public void sendActivationRequestEmail(String username, String token, String email) throws Exception {
		
		  MimeMessage message = this.mailSender.createMimeMessage();
		  MimeMessageHelper helper = new MimeMessageHelper(message, true);
		  
		  helper.setFrom(from);
	      //helper.setTo(email);
		  helper.setTo(to);
		  helper.setSubject("Fixeala - Activaci梟 de cuenta");
		
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
	public void sendActivationSuccessEmail(String username, String email) throws Exception {
		
		  MimeMessage message = this.mailSender.createMimeMessage();
		  MimeMessageHelper helper = new MimeMessageHelper(message, true);
		  
		  helper.setFrom(from);
	      //helper.setTo(email);
		  helper.setTo(to);
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
	public void sendPasswordResetEmail(String username, String token, String email) throws Exception{
		 
		  MimeMessage message = this.mailSender.createMimeMessage();
		  MimeMessageHelper helper = new MimeMessageHelper(message, true);
		  
		  helper.setFrom(from);
	      //helper.setTo(email);
		  helper.setTo(to);
		  helper.setSubject("Recuperaci贸n de clave");
	      
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
	public void sendPasswordResetSuccessEmail(String username, String email) throws Exception {
		
		  MimeMessage message = this.mailSender.createMimeMessage();
		  MimeMessageHelper helper = new MimeMessageHelper(message, true);
		  
		  helper.setFrom(from);
	      //helper.setTo(email);
		  helper.setTo(to);
		  helper.setSubject("Modificaste tu clave de Fixeala");
		
	      String text = "Hola, <b>" + username + "</b>";      
	      text += "<br><br>";
	      text += "Este es un mensaje de confirmaci贸n de que la clave de tu cuenta de Fixeala ha sido modificada.";
	      text += "<br><br>";
	      text += "Si no pediste cambiar tu clave, inici谩 sesi贸n y cambi谩 la clave si es necesario. Si ten茅s problemas, contactate con el servicio de ayuda de Fixeala.";  
	      text += "<br><br>";
	      text += "Atentamente,";
	      text += "<br>";
	      text += "<b>El equipo de Fixeala</b>";
	      
	      helper.setText(text, true);
	      mailSender.send(message);
	      
	      System.out.println("Mensaje enviado existosamente...");
	}
	
	@Override
	public void sendClosedAccountEmail(String username, String email)
			throws Exception {
		
		  MimeMessage message = this.mailSender.createMimeMessage();
		  MimeMessageHelper helper = new MimeMessageHelper(message, true);
		  
		  helper.setFrom(from);
	      //helper.setTo(email);
		  helper.setTo(to);
		  helper.setSubject("Cierre de cuenta");
			
	      String text = "Hola, <b>" + username + "</b>";      
	      text += "<br><br>";
	      text += "Tu cuenta de Fixeala ha sido desactivada.";
	      text += "<br><br>";
	      text += "Tus datos personajes se han eliminado pero la informaci贸n de tus reclamos seguir谩 vigente en nuestro sitio para el resto de los usuarios.";  
	      text += "<br><br>";
	      text += "Atentamente,";
	      text += "<br>";
	      text += "<b>El equipo de Fixeala</b>";
	      
	      helper.setText(text, true);
	      mailSender.send(message);
	      
	      System.out.println("Mensaje enviado existosamente...");
		
	}
	
	
	
	
	
	
	
	private MimeMessage initSession(String email){
		
		 	String to = "coripel@gmail.com";
		   
//			Properties props = new Properties();
//			props.put("mail.smtp.host", "smtp.gmail.com");
//			props.put("mail.smtp.auth", "true");
//			props.put("mail.smtp.starttls.enable", "true");
//			props.put("mail.smtp.socketFactory.port", "465");
//			props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");		
//			
//			Session session = Session.getInstance(props,
//					  new javax.mail.Authenticator() {
//						protected PasswordAuthentication getPasswordAuthentication() {
//							return new PasswordAuthentication(mailuser, mailpassword);
//						}
//					  });
			

		
		   String from = "fixeala@gmail.com";
		   String host = "127.0.0.1";
		   Properties properties = System.getProperties();
		   properties.setProperty("mail.smtp.host", host);

		   // Get the default Session object.
		   Session session = Session.getDefaultInstance(properties);
		 
		   MimeMessage message = new MimeMessage(session);
		   
		   try {
//				message.setFrom(new InternetAddress(mailuser));
				message.setFrom(new InternetAddress(from));
				message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));	
				message.setRecipients(Message.RecipientType.TO,
						InternetAddress.parse(to));
		   } catch (MessagingException e) {
				throw new RuntimeException(e);
			}
		   
		   return message;
	}

	
}
