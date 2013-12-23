package ar.com.urbanusjam.dao.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.annotation.Propagation;

import ar.com.urbanusjam.dao.IssueDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.dao.utils.CriteriaSearch;
import ar.com.urbanusjam.entity.annotations.Issue;

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
		List<Issue> issues = getSessionFactory().getCurrentSession().createCriteria(Issue.class)        
//	        .add( Restrictions.eq("province", issueSearch.getProvincia()) )
//	        .add( Restrictions.eq("city", issueSearch.getCiudad()) )
//	        .add( Restrictions.eq("neighborhood", issueSearch.getBarrio()) )	        
//	        .add( Restrictions.gt("date", issueSearch.getMinFecha()) )
//	        .add( Restrictions.lt("date", issueSearch.getMaxFecha()) )
//	        .add( Restrictions.in("tags", issueSearch.getTags()) )
			.add( Restrictions.between("date", this.toCalendar(issueSearch.getMinFecha()), this.toCalendar(issueSearch.getMaxFecha())) )				
//	        .add( Restrictions.in("status", issueSearch.getEstado()) )
//	        .addOrder(Order.asc("date") )
	        .list();
		
		return issues;        
        
	}
	
	private GregorianCalendar toCalendar(Date date){
		Calendar cal = new GregorianCalendar();
        cal.setTime(date);
        return (GregorianCalendar) cal;
	}

}
