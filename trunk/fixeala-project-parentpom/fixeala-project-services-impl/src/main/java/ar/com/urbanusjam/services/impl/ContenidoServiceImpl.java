package ar.com.urbanusjam.services.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.ContenidoDAO;
import ar.com.urbanusjam.dao.IssueDAO;
import ar.com.urbanusjam.entity.annotations.Issue;
import ar.com.urbanusjam.entity.annotations.MediaContent;
import ar.com.urbanusjam.services.ContenidoService;

@Service
@Transactional
public class ContenidoServiceImpl implements ContenidoService {
	 
 	private ContenidoDAO contenidoDAO;
 	private IssueDAO issueDAO;
	
	public void setContenidoDAO(ContenidoDAO contenidoDAO) {
		this.contenidoDAO = contenidoDAO;
	}
	
	public void setIssueDAO(IssueDAO issueDAO) {
		this.issueDAO = issueDAO;
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
		
		//find current profile pic
		MediaContent currentPic = contenidoDAO.findProfilePic(file.getUsername());
			//if exists, delete 
			if(currentPic != null)
				contenidoDAO.deleteProfilePic(currentPic.getFileID(), currentPic.getUsername());
		//persist
		List<MediaContent> contenido = new ArrayList<MediaContent>();
		contenido.add(file);
		contenidoDAO.saveContenidos(contenido);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void uploadFiles(List<MediaContent> files, String issueID) {
		
		Issue issue = issueDAO.findIssueById(issueID);
		
		List<MediaContent> completeFiles = new ArrayList<MediaContent>();
		
		for(MediaContent file : files){
			file.setIssue(issue);
			file.setFileOrder(1); //find last order
			completeFiles.add(file);
		}
		
		contenidoDAO.saveContenidos(completeFiles);
		//save update
		//send notification
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

	
}