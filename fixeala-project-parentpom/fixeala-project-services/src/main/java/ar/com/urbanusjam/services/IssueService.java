package ar.com.urbanusjam.services;

import java.util.List;

import ar.com.urbanusjam.services.dto.AreaDTO;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.IssueHistorialRevisionDTO;
import ar.com.urbanusjam.services.dto.IssueLicitacionDTO;

public interface IssueService {
	
	public void reportIssue(IssueDTO issue);	
	
	public void updateIssue(IssueDTO issue);	
	
	public List<IssueDTO> loadAllIssues();
	
	public List<IssueDTO> loadIssuesByStatus(String[] status);
	
	public List<String> getTagList();
	
	public IssueDTO getIssueById(String issueID);
	
	public AreaDTO getAreaByName(String areaName);

}
