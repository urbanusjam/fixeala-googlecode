package ar.com.urbanusjam.dao;

import java.util.List;

import ar.com.urbanusjam.entity.annotations.MediaContent;

public interface ContenidoDAO {
	
	public void saveContenidos(List<MediaContent> contenidos);
	
	public List<MediaContent> findContenidosByIssue(Long idIssue);	
	
	public MediaContent findProfilePic(String username);
	
	public boolean deleteContenido(String issueID, String fileID);
	
	public boolean deleteProfilePic(String fileID, String username);
	
}
