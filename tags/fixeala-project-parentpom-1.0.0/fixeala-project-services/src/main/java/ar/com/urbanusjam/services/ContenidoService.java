package ar.com.urbanusjam.services;

import java.util.List;

import ar.com.urbanusjam.entity.annotations.MediaContent;


public interface ContenidoService {
	 
	public List<MediaContent> getIssueFiles(String issueID);
	
	public MediaContent getUserPic(String username);
	 
    public void uploadFiles(List<MediaContent> files, String issueID, String username);
    
    public void uploadUserPic(MediaContent file);
    
    public void deleteFiles(List<String> files, String issueID);
        
}
