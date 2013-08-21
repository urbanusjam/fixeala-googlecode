package ar.com.urbanusjam.dao;

import java.util.List;

import ar.com.urbanusjam.entity.annotations.Issue;


public interface IssueDAO {
	
	public void saveIssue(Issue issue);
	
	public List<Issue> getAllIssues();
	
	public List<Issue> getIssuesByStatus(String[] status);

}
