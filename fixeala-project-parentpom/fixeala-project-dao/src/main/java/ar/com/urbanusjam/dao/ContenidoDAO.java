package ar.com.urbanusjam.dao;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import ar.com.urbanusjam.dao.utils.GenericDAO;
import ar.com.urbanusjam.entity.annotations.MediaContent;

public interface ContenidoDAO extends GenericDAO<MediaContent, Serializable> {
	
	public MediaContent findContenidoById(Long idContenido);   
	
	public MediaContent findUserProfilePic(Long idUser); 
	
	public MediaContent findContenidoByContenidoAndIssue(Long idContenido, Long idIssue);   
	
	public List<MediaContent> findContenidosByIssue(Long idIssue);	
	
	public void deleteContenidosByIssue(Collection<MediaContent> contenidos, Long idIssue);
	
	public void deleteContenido(MediaContent contenido);
	
	public boolean existe(Long idContenido);
	
	public void saveContenido(MediaContent contenido);
	
}
