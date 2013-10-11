package ar.com.urbanusjam.services;

import java.util.List;

import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.IssueHistorialRevisionDTO;

public interface IssueService {
	
	public void reportIssue(IssueDTO issue, IssueHistorialRevisionDTO historialDTO);	
	
	public void updateIssue(IssueDTO issue, IssueHistorialRevisionDTO historialDTO);	
	
	public List<IssueDTO> loadAllIssues();
	
	public List<IssueDTO> loadIssuesByStatus(String[] status);
	
	public List<String> getTagList();
	
	public IssueDTO getIssueById(String issueID);

}
