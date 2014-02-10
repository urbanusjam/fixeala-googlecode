package ar.com.urbanusjam.dao;

import java.util.List;
import java.util.Set;

import ar.com.urbanusjam.dao.utils.IssueCriteriaSearchRaw;
import ar.com.urbanusjam.entity.annotations.Issue;
import ar.com.urbanusjam.entity.annotations.Tag;


public interface IssueDAO {
	
	public void saveIssue(Issue issue);
	
	public void updateIssue(Issue issue);
	
	public List<Issue> getAllIssues();
	
	public List<Issue> getIssuesByStatus(String[] status);
	
	public List<Issue> getIssuesByUser(String username);
	
	public List<Issue> getIssuesByArea(String areaName);
	
	public List<Issue> getIssuesByCriteria(IssueCriteriaSearchRaw fields);
	
	public List<Issue> getAssignedIssuesByVerifiedOfficial(String username);
	
	public Issue findIssueById(String id);
	
	public Set<Tag> findIssueTagsById(String id);

}
