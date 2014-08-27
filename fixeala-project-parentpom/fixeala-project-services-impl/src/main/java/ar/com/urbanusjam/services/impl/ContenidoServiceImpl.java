package ar.com.urbanusjam.services.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Set;

import javax.mail.MessagingException;

import org.jfree.util.Log;
import org.springframework.mail.MailException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.ContenidoDAO;
import ar.com.urbanusjam.dao.IssueDAO;
import ar.com.urbanusjam.dao.UserDAO;
import ar.com.urbanusjam.entity.annotations.Issue;
import ar.com.urbanusjam.entity.annotations.IssueFollow;
import ar.com.urbanusjam.entity.annotations.IssueUpdateHistory;
import ar.com.urbanusjam.entity.annotations.MediaContent;
import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.ContenidoService;
import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.MailService;
import ar.com.urbanusjam.services.dto.EmailDTO;
import ar.com.urbanusjam.services.dto.IssueUpdateHistoryDTO;
import ar.com.urbanusjam.services.utils.Messages;
import ar.com.urbanusjam.services.utils.Operation;

@Service
@Transactional
public class ContenidoServiceImpl implements ContenidoService {

	private IssueService issueService;
	private MailService mailService;
 	private ContenidoDAO contenidoDAO;
 	private IssueDAO issueDAO;
 	private UserDAO userDAO; 
	
	public void setContenidoDAO(ContenidoDAO contenidoDAO) {
		this.contenidoDAO = contenidoDAO;
	}
	
	public void setIssueDAO(IssueDAO issueDAO) {
		this.issueDAO = issueDAO;
	}

	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}
	
	public void setMailService(MailService mailService) {
		this.mailService = mailService;
	}
	
	public void setIssueService(IssueService issueService) {
		this.issueService = issueService;
	}

	@Override
	public List<MediaContent> getIssueFiles(String issueID) {
		return contenidoDAO.findContenidosByIssue(Long.valueOf(issueID));
	}

	@Override
	public MediaContent getUserPic(String username) {
		return contenidoDAO.findProfilePic(username);
	}
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void uploadUserPic(MediaContent file) {
		
		String username = file.getUsername();
		//find current profile pic
		MediaContent currentPic = contenidoDAO.findProfilePic(username);
			//if exists, delete 
			if(currentPic != null)
				contenidoDAO.deleteProfilePic(currentPic.getFileID(), username);
		//persist
		List<MediaContent> contenidos = new ArrayList<MediaContent>();
		contenidos.add(file);
		
		
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED, noRollbackFor={MessagingException.class, MailException.class})
	public void uploadFiles(List<MediaContent> files, String issueID, String username) {
		
		Issue issue = issueDAO.findIssueById(issueID);
		User user = userDAO.loadUserByUsername(username);
		
		List<MediaContent> completeFiles = new ArrayList<MediaContent>();
		
		for(MediaContent file : files){
			file.setIssue(issue);
			file.setFileOrder(1); //find last order
			completeFiles.add(file);
		}
		
		IssueUpdateHistory revision = new IssueUpdateHistory();
		revision.setFecha(this.getCurrentCalendar(new Date()));
		revision.setUsuario(user);	
		revision.setOperacion(Operation.CREATE);			
		revision.setMotivo(Messages.ISSUE_UPDATE_ATTACH_FILES + " " + completeFiles.size() + " archivo(s).");				
		revision.setEstado(issue.getStatus());	

		issue.setLastUpdateDate(revision.getFecha());
		issue.addRevision(revision);		
		
		contenidoDAO.saveContenidos(completeFiles);
		issueDAO.updateIssue(issue);
		
		try{			
			//email notification
			String link = "<a target='_blank' href='http://localhost:8080/fixeala/issues/" + issue.getId().toString() + ".html' >LINK</a>.";
			String text = "El usuario <i>" + username + "</i> agrego fotos al reclamo <i>#" +issue.getId()+ " \"" + issue.getTitle() + "\"</i>.";
			text += "<br><br>";
			text += "Para acceder al mismo, hac&eacute; clic en el siguiente " + link;
			
			EmailDTO email = new EmailDTO();
			email.setSubject("Nueva actualizaci&oacute;n en el reclamo #" + issue.getId().toString() + " \"" + issue.getTitle() + "\"" );
			email.setTo(issue.getReporter().getEmail());
			email.setUrl(link);
			email.setMessage(text);
			
			Set<IssueFollow> followers = issue.getFollowers();
			String reporterEmail = null;
			
			mailService.sendIssueUpdateEmail(issueService.getFollowersEmails(followers, reporterEmail), email);
			
		}catch(Exception e){			
			Log.debug("Error en el envio del email a los seguidores del reclamo.");			
		}
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void deleteFiles(List<String> filesID, String issueID) {
		for(String fileID : filesID){
			contenidoDAO.deleteContenido(Long.valueOf(issueID), fileID);
		}
		//save update
		//send notification
	} 

	private GregorianCalendar getCurrentCalendar(Date date){		
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(date);
		return (GregorianCalendar) calendar;	
	} 
}