package ar.com.urbanusjam.web.utils;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class EmailUtils {

	
	public EmailUtils(){}
	
	//reset password email
	
	//account activation email
	
	//account created
	
	//password changed
	
	public void sendActivationEmail(String username, String token, String email) throws Exception{
		  
		  MimeMessage message =  initSMTP(email);	
	      
	      
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
	      
	      message.setSubject("FIXEALA Activacion de cuenta", "UTF-8");
	      message.setContent(text, "text/html; charset=UTF-8");    
	      Transport.send(message);
	      
	      System.out.println("Message sent successfully....");
	}
	
	public void sendPasswordResetEmail(String username, String token, String email) throws Exception{
		 
	      MimeMessage message =  initSMTP(email);	
	     
	      
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
	      
	      message.setSubject("FIXEALA Reseteo de clave", "UTF-8");
	      message.setContent(text, "text/html; charset=utf-8");    
	      Transport.send(message);
	      
	      System.out.println("Sent message successfully....");
	}
	
	private MimeMessage initSMTP(String email){
		// Recipient's email ID needs to be mentioned.
		   String to = email;

		   // Sender's email ID needs to be mentioned
		   String from = "fixeala@gmail.com";

		   // Assuming you are sending email from localhost
		   String host = "127.0.0.1";

		   // Get system properties
		   Properties properties = System.getProperties();

		   // Setup mail server
		   properties.setProperty("mail.smtp.host", host);

		   // Get the default Session object.
		   Session session = Session.getDefaultInstance(properties);
		   
		   MimeMessage message = new MimeMessage(session);
		   
		   try {
				message.setFrom(new InternetAddress(from));
				message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));	
			} catch (AddressException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		   
		   return message;
	}

}
