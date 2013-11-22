package ar.com.urbanusjam.services;

import java.util.List;

import ar.com.urbanusjam.services.dto.AreaDTO;
import ar.com.urbanusjam.services.dto.CommentDTO;
import ar.com.urbanusjam.services.dto.IssueDTO;

public interface IssueService {
	
	public void reportIssue(IssueDTO issue);	
	
	public void updateIssue(IssueDTO issue);	
	
	public void updateIssueStatus(String issueID, String newStatus);
	
	public void assignUserToIssue(String issueID, String user);
	
	public List<IssueDTO> getIssuesAsignados(String username);
	
	public List<IssueDTO> loadAllIssues();
	
	public List<IssueDTO> loadIssuesByStatus(String[] status);
	
	public List<IssueDTO> loadIssuesByUser(String username);
	
	public List<IssueDTO> loadIssuesByArea(String areaName);
	
	public List<String> getTagList();
	
	public IssueDTO getIssueById(String issueID);
	
	public AreaDTO getAreaByName(String areaName);
	
	public void postComment(CommentDTO comment);
	
	public List<CommentDTO> getCommentsByIssue(String issueID);
	
}
