package ar.com.urbanusjam.services;

import java.util.List;
import java.util.Set;

import javax.mail.MessagingException;

import org.springframework.mail.MailException;

import ar.com.urbanusjam.entity.annotations.IssueFollow;
import ar.com.urbanusjam.entity.annotations.IssueRepair;
import ar.com.urbanusjam.services.dto.CommentDTO;
import ar.com.urbanusjam.services.dto.IssueCriteriaSearch;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.IssueFollowDTO;
import ar.com.urbanusjam.services.dto.IssuePageViewDTO;
import ar.com.urbanusjam.services.dto.IssueVoteDTO;

public interface IssueService {
	
	//issues
	public void reportIssue(IssueDTO issue);	
	public void updateIssue(IssueDTO issue) throws MessagingException, MailException;		
	public void updateIssueStatus(String username, String issueID, String newStatus, String resolution, String obs) throws MessagingException, MailException;	
	public IssueDTO getIssueById(String issueID);	
	public List<IssueDTO> loadAllIssues();	
	public List<IssueDTO> loadIssues(int numberOfResults);	
	public List<IssueDTO> loadIssuesByLocation(float latitude, float longitude, int numberOfResults);
	public List<IssueDTO> loadIssuesByStatus(String[] status);	
	public List<IssueDTO> loadIssuesByUser(String username);	
	public List<IssueDTO> findIssuesByCriteria(IssueCriteriaSearch search);
	public List<IssueDTO> searchByTagOrStatus(String searchType, String value);
		
	//comments
	public void postComment(CommentDTO comment) throws MessagingException, MailException;		
	
	//repair
	public void addReparacion(IssueRepair repair, String username);
	public void deleteReparacion(String issueID, String username);
	
	//tags	
	public List<String> getTagList();
		
	//followers
	public void followIssue(IssueFollowDTO followDTO);
	public void unFollowIssue(IssueFollowDTO followDTO);
	public boolean isUserFollowingIssue(IssueFollowDTO followDTO);
	public List<String> getIssueFollowers(String issueID);
	public List<String> getUserFollowings(String username);
	public String[] getFollowersEmails(Set<IssueFollow> followers, String reporterEmail);
	
	//votes
	public void voteIssue(IssueVoteDTO voteDTO);
	public IssueVoteDTO getCurrentVote(String issueID, String username);
	public Long countIssueVotes(String issueID);	
	
	//pageviews
	public boolean trackIssuePageView(IssuePageViewDTO pageviewDTO);
	public int getIssuePageViews(String issueID);
	
	//provinces
	public List<String> loadProvinces();
	public List<String> loadLocalityByProvince(String province);
	
	public boolean isIssueVerifiedByUser(String issueID, String username);
		
}
