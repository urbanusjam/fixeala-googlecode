package ar.com.urbanusjam.services;

import java.util.List;

import ar.com.urbanusjam.services.dto.AreaDTO;
import ar.com.urbanusjam.services.dto.CommentDTO;
import ar.com.urbanusjam.services.dto.IssueCriteriaSearch;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.IssueFollowDTO;
import ar.com.urbanusjam.services.dto.IssuePageViewDTO;
import ar.com.urbanusjam.services.dto.IssueRepairDTO;
import ar.com.urbanusjam.services.dto.IssueUpdateHistoryDTO;
import ar.com.urbanusjam.services.dto.IssueVoteDTO;

public interface IssueService {
	
	public void reportIssue(IssueDTO issue);	
	public void postComment(CommentDTO comment);
	
	public void addHistoryUpdate(IssueUpdateHistoryDTO update);
	public void addRepairInfo(IssueRepairDTO licitacion);
	public void updateRepairInfo(IssueRepairDTO licitacion);
	public void deleteRepairInfo(String issueID);
	public IssueRepairDTO getRepairInfoByIssue(String issueID);
	
	public void updateIssue(IssueDTO issue);		
	public void updateIssueStatus(String issueID, String newStatus);
		
	public void assignUserToIssue(String issueID, String username);
		
	public List<IssueDTO> loadAllIssues();	
	public List<IssueDTO> loadIssues(int numberOfResults);	
	public List<IssueDTO> loadIssuesByStatus(String[] status);	
	public List<IssueDTO> loadIssuesByUser(String username);	
//	public List<IssueDTO> loadIssuesByArea(String areaName);
	public List<IssueDTO> findIssuesByCriteria(IssueCriteriaSearch search);
	
//	public List<IssueDTO> getIssuesAsignados(String username);	
	public List<CommentDTO> getCommentsByIssue(String issueID);
	public List<String> getTagList();
	public IssueDTO getIssueById(String issueID);	
//	public AreaDTO getAreaByName(String areaName);
		
	public void followIssue(IssueFollowDTO followDTO);
	public void unFollowIssue(IssueFollowDTO followDTO);
	public boolean isUserFollowingIssue(IssueFollowDTO followDTO);
	public List<String> getIssueFollowers(String issueID);
	public List<String> getUserFollowings(String username);
	
	public boolean trackIssuePageView(IssuePageViewDTO pageviewDTO);
	public int getIssuePageViews(String issueID);
	
	public void voteIssue(IssueVoteDTO voteDTO);
	public IssueVoteDTO getCurrentVote(String issueID, String username);
	public Long countIssueVotes(String issueID);	
	
	public List<IssueDTO> searchByTagOrStatus(String searchType, String value);
		
}
