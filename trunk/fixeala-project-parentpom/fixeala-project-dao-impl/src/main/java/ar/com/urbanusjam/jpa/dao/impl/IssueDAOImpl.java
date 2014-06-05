package ar.com.urbanusjam.jpa.dao.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.IssueDAO;
import ar.com.urbanusjam.dao.utils.IssueCriteriaSearchRaw;
import ar.com.urbanusjam.entity.annotations.Issue;
import ar.com.urbanusjam.entity.annotations.Tag;

@Repository
@Transactional(propagation= Propagation.REQUIRED, readOnly=false)
public class IssueDAOImpl implements IssueDAO {	
	
	@PersistenceContext(unitName = "fixealaPU")
	private EntityManager entityManager; 
	
	public IssueDAOImpl() {}

	@Override
	public void saveIssue(Issue issue) {
		entityManager.persist(issue);		
	}
	
	@Override
	public void updateIssue(Issue issue) {
		entityManager.merge(issue);		
	}

	@Override
	public List<Issue> getAllIssues() {
		return (List<Issue>) entityManager.createQuery("SELECT i FROM Issue i").getResultList();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Issue> getIssues(int numberOfResults) {
		List<Issue> issues = entityManager.createQuery("SELECT i FROM Issue i ORDER BY i.creationDate DESC ")
				.setMaxResults(numberOfResults)  
				.getResultList(); 
		return issues;
	}
	

	@Override
	public List<Issue> getIssuesByStatus(String[] status) {
		List<Issue> issues = (List<Issue>)entityManager.createQuery("SELECT * FROM Issue i WEHRE i.status IN (:statusOptions)")
										  .setParameter("statusOptions", status)
										  .getResultList();
		return issues;
	}
	
	@Override
	public List<Issue> getIssuesByUser(String username) {
		List<Issue> issues = entityManager.createNamedQuery("Issue.findByUsername", Issue.class)
			     .setParameter("reporter.username", username)
			     .getResultList();
		return issues;
	}
	
//	@Override
//	public List<Issue> getIssuesByArea(String areaName) {
//		List<Issue> issues = new ArrayList<Issue>();
//		issues = this.findWhere(" assignedArea.nombre = ? ", new Object[]{areaName});
//		return issues;
//	}
	
//	@Override
//	public List<Issue> getAssignedIssuesByVerifiedOfficial(String username) {
//		List<Issue> issues = new ArrayList<Issue>();
//		issues = this.findWhere(" assignedOfficial.username = ? ", new Object[]{ username});
//		return issues;
//	}

	@Override
	public Issue findIssueById(String issueID) {
		Issue issue = entityManager.createNamedQuery("Issue.findByID", Issue.class)
			     .setParameter("id", Long.valueOf(issueID))
			     .getSingleResult();
		return issue;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Issue> getIssuesByCriteria(IssueCriteriaSearchRaw issueSearch) {
		
		List<Issue> issues = new ArrayList<Issue>();		
		/*Criteria criteria = getSessionFactory().getCurrentSession().createCriteria(Issue.class);
				
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
		*/
		return issues;        
        
	}

	@Override
	public Set<Tag> findIssueTagsById(String issueID) {
		Issue issue = entityManager.createNamedQuery("Issue.findByID", Issue.class)
				     .setParameter("id", Long.valueOf(issueID))
				     .getSingleResult();
		return issue.getTagsList();
	}

}
