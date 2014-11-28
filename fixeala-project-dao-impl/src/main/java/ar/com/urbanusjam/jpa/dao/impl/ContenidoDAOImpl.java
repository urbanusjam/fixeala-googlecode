package ar.com.urbanusjam.jpa.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import ar.com.urbanusjam.dao.ContenidoDAO;
import ar.com.urbanusjam.entity.annotations.MediaContent;

@Repository
public class ContenidoDAOImpl implements ContenidoDAO  {
	
	@PersistenceContext(unitName = "fixealaPU")
	private EntityManager entityManager; 

	public ContenidoDAOImpl() {}


	@Override
	public void saveContenidos(List<MediaContent> contenidos) {
		for(MediaContent c : contenidos)
			entityManager.persist(c);
	}
	
	@Override
	public List<MediaContent> findContenidosByIssue(Long idIssue) {
		try{
			List<MediaContent> contenidos = entityManager.createQuery("SELECT c FROM MediaContent c WHERE c.issue.id = :idIssue", MediaContent.class)
					 .setParameter("idIssue", idIssue)
					 .getResultList();
			return contenidos; 
		} catch(NoResultException e){
			return null;
		}	
	}

	@Override
	public MediaContent findProfilePic(String username) {
		try{
			MediaContent contenido = entityManager.createQuery("SELECT c FROM MediaContent c WHERE c.isProfilePic = 1 AND c.username= :username", MediaContent.class)
					 .setParameter("username", username)
					 .getSingleResult();
			return contenido; 
		} catch(NoResultException e){
			return null;
		}	
	}

	@Override
	public boolean deleteContenido(Long issueID, String fileID) {
		try{
			MediaContent contenido = entityManager.createQuery("SELECT c FROM MediaContent c WHERE c.issue.id = :issueID AND c.fileID = :fileID", MediaContent.class)
					 .setParameter("issueID", issueID)
					 .setParameter("fileID", fileID)
					 .getSingleResult();
			entityManager.remove(contenido);
			return true;
		} catch(NoResultException e){
			return false;
		}		
	}	
	
	@Override
	public boolean deleteProfilePic(String fileID, String username) {
		try{
			MediaContent contenido = (MediaContent) entityManager.createQuery("SELECT c FROM MediaContent c WHERE c.isProfilePic = 1 AND c.fileID = :fileID AND c.username = :userID", MediaContent.class)
					 .setParameter("fileID", fileID)
					 .setParameter("userID", username) 
					 .getSingleResult();
			entityManager.remove(contenido);
			return true;
		} catch(NoResultException e){
			return false;
		}		
	}	
	
	
}
