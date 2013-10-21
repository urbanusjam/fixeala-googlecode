package ar.com.urbanusjam.dao.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import ar.com.urbanusjam.dao.IssueDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.entity.annotations.Issue;

public class IssueDAOImpl extends GenericDAOImpl<Issue, Serializable> implements IssueDAO {	

	public IssueDAOImpl() {
		super(Issue.class);
	}

	@Override
	public void saveIssue(Issue issue) {
		this.save(issue);		
	}
	
	@Override
	public void updateIssue(Issue issue) {
		this.update(issue);		
	}

	@Override
	public List<Issue> getAllIssues() {
		List<Issue> issues = new ArrayList<Issue>();
		issues = this.findAll();
		return issues;
	}

	@Override
	public List<Issue> getIssuesByStatus(String[] status) {
		List<Issue> issues = new ArrayList<Issue>();
		issues = this.getHibernateTemplate().
						findByNamedParam(" SELECT * FROM Issue i WEHRE i.status IN (:statusOptions) ", 
								"statusOptions", status);
		return issues;
	}
	
	@Override
	public List<Issue> getIssuesByUser(String username) {
		List<Issue> issues = new ArrayList<Issue>();
		issues = this.findWhere(" reporter.username = ? ", new Object[]{ username});
		return issues;
	}

	@Override
	public Issue findIssueById(String issueID) {
		List<Issue> issues = new ArrayList<Issue>();
		issues = this.findWhere(" id = ? ", new Object[]{  Long.parseLong(issueID) });
		return issues.get(0);
	}

	
	

}
