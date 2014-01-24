package ar.com.urbanusjam.dao.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.IssueDAO;
import ar.com.urbanusjam.dao.impl.utils.CriteriaType;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.dao.utils.IssueCriteriaSearch;
import ar.com.urbanusjam.entity.annotations.Issue;
import ar.com.urbanusjam.entity.annotations.Tag;

@Transactional(propagation= Propagation.REQUIRED, readOnly=false)
public class IssueDAOImpl extends GenericDAOImpl<Issue, Serializable> implements IssueDAO {	
	
	@Autowired
	private SessionFactory sessionFactory;	
	 
	public IssueDAOImpl() {
		super(Issue.class);
	}

	@Override
	public void saveIssue(Issue issue) {
		this.save(issue);		
	}
	
	@Override
	public void updateIssue(Issue issue) {
		issue = (Issue) getSessionFactory().getCurrentSession().merge(issue);	
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

	@SuppressWarnings("unchecked")
	@Override
	public List<Issue> getIssuesByCriteria(IssueCriteriaSearch issueSearch) {
		
		List<Issue> issues = new ArrayList<Issue>();
		
		if(issueSearch.getSearchType().equals(CriteriaType.DEFAULT_SEARCH)){					
			issues = getSessionFactory().getCurrentSession().createCriteria(Issue.class)  				
				.add( Restrictions.between("date", issueSearch.getMinFecha(), issueSearch.getMaxFecha()))				
		        .addOrder(Order.asc("date") )
		        .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
		        .list();			
		}
		
		else if(issueSearch.getSearchType().equals(CriteriaType.CUSTOM_SEARCH)){
			issues = getSessionFactory().getCurrentSession().createCriteria(Issue.class)  	
					.add( Restrictions.eq("province", issueSearch.getProvincia()))	
					.add( Restrictions.eq("city", issueSearch.getCiudad()))	
					.add( Restrictions.between("date", issueSearch.getMinFecha(), issueSearch.getMaxFecha()))		
					.add( Restrictions.in("status", issueSearch.getEstado()))						
					.createAlias("tagsList", "t")
					.add(Restrictions.in("t.tagname", issueSearch.getTags()))
			        .addOrder(Order.asc("date") )
			        .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
			        .list();			
		}
		
		
		return issues;        
        
	}

	@Override
	public Set<Tag> findIssueTagsById(String issueID) {
		List<Issue> issues = new ArrayList<Issue>();
		issues = this.findWhere(" id = ? ", new Object[]{  Long.parseLong(issueID) });
		return issues.get(0).getTagsList();
	}
	
	

}
