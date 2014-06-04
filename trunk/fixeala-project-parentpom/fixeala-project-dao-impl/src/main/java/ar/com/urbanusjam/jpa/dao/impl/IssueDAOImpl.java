package ar.com.urbanusjam.jpa.dao.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.IssueDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.dao.utils.IssueCriteriaSearchRaw;
import ar.com.urbanusjam.entity.annotations.Issue;
import ar.com.urbanusjam.entity.annotations.Tag;

@Repository
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
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Issue> getIssues(int numberOfResults) {
		List<Issue> issues = new ArrayList<Issue>();
//		Criteria criteria = getSessionFactory().getCurrentSession().createCriteria(Issue.class);
//		criteria.setMaxResults(numberOfResults);
//		criteria.addOrder(Order.asc("creationDate"));
//		issues = criteria.list();	
		
		Query query  = getSessionFactory().getCurrentSession().createQuery("FROM Issue i ORDER BY i.creationDate DESC ");  
		issues = query.setMaxResults(numberOfResults).list(); 
		
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
		issues = this.findWhere(" id = ? ", new Object[]{  Long.valueOf(issueID) });
		return issues.get(0);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Issue> getIssuesByCriteria(IssueCriteriaSearchRaw issueSearch) {
		
		List<Issue> issues = new ArrayList<Issue>();		
		Criteria criteria = getSessionFactory().getCurrentSession().createCriteria(Issue.class);
				
		if(!issueSearch.getProvincia().equals("Todas"))		
			criteria.add(Restrictions.eq("province", issueSearch.getProvincia()));
		
		if(!issueSearch.getCiudad().equals("Todas"))		
			criteria.add(Restrictions.eq("city", issueSearch.getCiudad()));
		
		if(!issueSearch.getBarrio().equals("") && issueSearch.getBarrio() != null)	
			criteria.add(Restrictions.eq("neighborhood", issueSearch.getBarrio()));
		
		if(issueSearch.getTagsArray() != null)
			criteria.createAlias("tagsList", "t")
					.add(Restrictions.in("t.tagname", issueSearch.getTagsArray()));
		
		if(issueSearch.getEstadosArray() != null)
			criteria.add( Restrictions.in("status", issueSearch.getEstadosArray()));	
		
		if(issueSearch.getSortDirection().equals("asc"))
			criteria.addOrder(Order.asc(issueSearch.getSortField()));
		
		else if(issueSearch.getSortDirection().equals("desc"))
			criteria.addOrder(Order.desc(issueSearch.getSortField()) );
				
		criteria.add(Restrictions.between("date", issueSearch.getMinFechaFormateada(), issueSearch.getMaxFechaFormateada()))
		        .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);
			        		
		issues = criteria.list();	
		
		return issues;        
        
	}

	@Override
	public Set<Tag> findIssueTagsById(String issueID) {
		List<Issue> issues = new ArrayList<Issue>();
		issues = this.findWhere(" id = ? ", new Object[]{  Long.parseLong(issueID) });
		return issues.get(0).getTagsList();
	}

}
