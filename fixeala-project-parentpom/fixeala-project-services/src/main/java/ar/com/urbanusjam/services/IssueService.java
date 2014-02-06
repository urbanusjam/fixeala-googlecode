package ar.com.urbanusjam.services;

import java.util.List;

import ar.com.urbanusjam.services.dto.AreaDTO;
import ar.com.urbanusjam.services.dto.CommentDTO;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.IssueFollowDTO;
import ar.com.urbanusjam.services.dto.UserDTO;

public interface IssueService {
	
	public void reportIssue(IssueDTO issue);	
	public void postComment(CommentDTO comment);
	
	public void updateIssue(IssueDTO issue);		
	public void updateIssueStatus(String issueID, String newStatus);
		
	public void assignUserToIssue(String issueID, String user);
		
	public List<IssueDTO> loadAllIssues();	
	public List<IssueDTO> loadIssuesByStatus(String[] status);	
	public List<IssueDTO> loadIssuesByUser(String username);	
	public List<IssueDTO> loadIssuesByArea(String areaName);
	public List<IssueDTO> getIssuesAsignados(String username);	
	public List<CommentDTO> getCommentsByIssue(String issueID);
	public List<String> getTagList();
	public IssueDTO getIssueById(String issueID);	
	public AreaDTO getAreaByName(String areaName);
	
//	public void voteIssue();
//	public void unVoteIssue();
	
	public void followIssue(IssueFollowDTO followDTO);
	public void unFollowIssue(IssueFollowDTO followDTO);
	public boolean isUserFollowingIssue(IssueFollowDTO followDTO);
	public List<String> getIssueFollowers(String issueID);
	public List<String> getUserFollowings(String username);
		
}
