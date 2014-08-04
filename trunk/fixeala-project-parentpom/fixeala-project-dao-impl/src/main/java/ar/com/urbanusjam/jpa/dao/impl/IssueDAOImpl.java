package ar.com.urbanusjam.jpa.dao.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Set;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Expression;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.hibernate.Criteria;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.IssueDAO;
import ar.com.urbanusjam.dao.utils.IssueCriteriaSearchRaw;
import ar.com.urbanusjam.entity.annotations.Issue;
import ar.com.urbanusjam.entity.annotations.Tag;

@Repository
public class IssueDAOImpl implements IssueDAO {	
	
	@PersistenceContext(unitName = "fixealaPU")
	private EntityManager entityManager; 
	
	public IssueDAOImpl() {}

	@Override
	public void saveIssue(Issue issue) {
		entityManager.persist(issue);		
	}
	
	@Override
	@Transactional(propagation= Propagation.REQUIRED, readOnly=false)
	public void updateIssue(Issue issue) {
		entityManager.merge(issue);		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Issue> getAllIssues() throws NoResultException, PersistenceException {
		try{
			return (List<Issue>) entityManager.createQuery("SELECT i FROM Issue i ORDER BY i.creationDate DESC").getResultList();
		}catch(NoResultException e){
			return null;
		}catch(PersistenceException e){
			return null;
		}
	
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Issue> getIssues(int numberOfResults) {
		List<Issue> issues = entityManager.createQuery("SELECT i FROM Issue i ORDER BY i.creationDate DESC ")
				.setMaxResults(numberOfResults)  
				.getResultList(); 
		return issues;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Issue> getIssuesByLocation(float latitude, float longitude, int numberOfResults) {
		List<Issue> issues = entityManager.createQuery("SELECT i FROM Issue i WHERE i.latitude = :lat AND i.longitude = :lon ")
				.setParameter("lat", latitude)
				.setParameter("lon", longitude)
				.setMaxResults(numberOfResults)  
				.getResultList(); 
		return issues;
	}
	

	@Override
	public List<Issue> getIssuesByStatus(String[] status) {
		try{
			List<Issue> issues = entityManager.createQuery("SELECT i FROM Issue i WHERE i.status IN (:statusOptions)", Issue.class)
					  .setParameter("statusOptions", Arrays.asList(status))
					  .getResultList();
			return issues;
			
		}catch(NoResultException e){
			return null;
		}		
	}
	
	@Override
	public List<Issue> getIssuesByUser(String username) {
		List<Issue> issues = entityManager.createQuery("SELECT i FROM Issue i WHERE i.reporter.username = :username", Issue.class)
			     .setParameter("username", username)
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
		try{
			Issue issue = entityManager.createQuery("SELECT i FROM Issue i WHERE i.id = :issueID ", Issue.class)
				     .setParameter("issueID", Long.valueOf(issueID))
				     .getSingleResult();
			return issue;
		}catch(NoResultException e){
			return null;
		}	
	}

	@Override
	public List<Issue> getIssuesByCriteria(IssueCriteriaSearchRaw issueSearch) {
		
		List<Issue> issues = new ArrayList<Issue>();	
		
		final CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
		final CriteriaQuery<Issue> criteriaQuery = criteriaBuilder.createQuery(Issue.class);
		
		final Root issueRoot = criteriaQuery.from(Issue.class);
		final Root tagRoot = criteriaQuery.from(Tag.class);

		List criteriaList = new ArrayList();
	
//		if(!issueSearch.getProvincia().equals("Todas"))	
//			criteriaQuery.where(criteriaBuilder.equal( issueRoot.get( "province" ), issueSearch.getProvincia()));
//		
//		if(!issueSearch.getCiudad().equals("Todas"))		
//			criteriaQuery.where(criteriaBuilder.equal( issueRoot.get( "city" ), issueSearch.getCiudad()));		
//		
//		if(!issueSearch.getBarrio().equals("") && issueSearch.getBarrio() != null)	
//			criteriaQuery.where(criteriaBuilder.equal( issueRoot.get( "neighborhood" ), issueSearch.getBarrio()));
//			
//		if(issueSearch.getTagsArray() != null){
//			 Predicate predicateTags = criteriaBuilder.equal(
//					 issueRoot. get("tagsList"). get("tagname"),
//					 issueSearch.getTagsArray());
//		      criteriaList.add(predicateTags);
//		}
//			
//		
//		if(issueSearch.getEstadosArray() != null){
//			Expression<String> exp = issueRoot.get("status");
//			Predicate predicateStatus = exp.in(issueSearch.getEstadosArray());
//			criteriaList.add(predicateStatus);
//		}
		
		 criteriaQuery.select(issueRoot).distinct(true);

		
//		criteriaQuery.where(criteriaBuilder.and((Predicate[]) criteriaList.toArray(new Predicate[0])));

		if(issueSearch.getSortDirection().equals("asc"))
			criteriaQuery.orderBy( criteriaBuilder.asc( issueRoot.get( issueSearch.getSortField() ) ) );
		
		else if(issueSearch.getSortDirection().equals("desc"))			
		    criteriaQuery.orderBy( criteriaBuilder.desc( issueRoot.get( issueSearch.getSortField() ) ) );

				
		criteriaQuery.where(criteriaBuilder.between(issueRoot.get( "creationDate" ), issueSearch.getMinFechaFormateada(), issueSearch.getMaxFechaFormateada()));
			        	
		final TypedQuery query = entityManager.createQuery(criteriaQuery);

		return query.getResultList();
      
	}

	@Override
	public Set<Tag> findIssueTagsById(String issueID) {
		Issue issue = entityManager.createQuery("SELECT i FROM Issue i WHERE id = :issueID", Issue.class)
				     .setParameter("issueID", Long.valueOf(issueID))
				     .getSingleResult();
		return issue.getTagsList();
	}

	@Override
	public List<Issue> getIssuesByTag(String tag) {
		try{
			List<Issue> issues = entityManager.createQuery("SELECT i FROM Issue i LEFT JOIN FETCH i.tagsList t WHERE t.tagname = :tag)", Issue.class)
				     .setParameter("tag", tag)
				     .getResultList();
			return issues;
		}catch(NoResultException e){
			return null;
		}		
	}

}
