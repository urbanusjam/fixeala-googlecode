package ar.com.urbanusjam.dao;

import java.util.List;

import ar.com.urbanusjam.entity.annotations.Issue;


public interface IssueDAO {
	
	public void saveIssue(Issue issue);
	
	public void updateIssue(Issue issue);
	
	public List<Issue> getAllIssues();
	
	public List<Issue> getIssuesByStatus(String[] status);
	
	public Issue findIssueById(String id);

}
