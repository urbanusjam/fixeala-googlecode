package ar.com.urbanusjam.dao.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import ar.com.urbanusjam.dao.IssueDAO;
import ar.com.urbanusjam.dao.TagDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.dao.utils.CriteriaSearch;
import ar.com.urbanusjam.entity.annotations.Issue;
import ar.com.urbanusjam.entity.annotations.Tag;

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
	public List<Issue> getIssuesByArea(String areaName) {
		List<Issue> issues = new ArrayList<Issue>();
		issues = this.findWhere(" assignedArea.nombre = ? ", new Object[]{areaName});
		return issues;
	}
	
	@Override
	public List<Issue> getAssignedIssuesByVerifiedOfficial(String username) {
		List<Issue> issues = new ArrayList<Issue>();
		issues = this.findWhere(" assignedOfficial.username = ? ", new Object[]{ username});
		return issues;
	}

	@Override
	public Issue findIssueById(String issueID) {
		List<Issue> issues = new ArrayList<Issue>();
		issues = this.findWhere(" id = ? ", new Object[]{  Long.parseLong(issueID) });
		return issues.get(0);
	}

	@Override
	public List<Issue> getIssuesByCriteria(CriteriaSearch issueSearch) {
		
		@SuppressWarnings("unchecked")
		List<Issue> issues = this.getSessionFactory().getCurrentSession().createCriteria(Issue.class)        
	        .add( Restrictions.eq("provincia", issueSearch.getProvincia()) )
	        .add( Restrictions.eq("ciudad", issueSearch.getCiudad()) )
	        .add( Restrictions.eq("barrio", issueSearch.getBarrio()) )	     
	        .add( Restrictions.gt("fecha", issueSearch.getEstado()) )
	        .add( Restrictions.lt("fecha", issueSearch.getEstado()) )
	        .add( Restrictions.in("tags", issueSearch.getTags()) )
	        .add( Restrictions.in("estado", issueSearch.getEstado()) )
	        .addOrder(Order.asc("fecha") )
	        .list();
		
		return issues;        
        
	}

}
