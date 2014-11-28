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
import javax.persistence.criteria.Join;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.jfree.util.Log;
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
			return (List<Issue>) entityManager.createQuery("SELECT i FROM Issue i WHERE i.status != 'ARCHIVADO' ORDER BY i.creationDate DESC").getResultList();
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
		
		try{
			
			CriteriaBuilder criteriaBuilder = entityManager.getCriteriaBuilder();
			CriteriaQuery<Issue> criteriaQuery = criteriaBuilder.createQuery(Issue.class);
			
			Root issueRoot = criteriaQuery.from(Issue.class);			
			List<Predicate> predicates = new ArrayList<Predicate>();
		
			//PROVINCE
			if(!issueSearch.getProvincia().equalsIgnoreCase("todas"))	
				predicates.add(criteriaBuilder.equal( criteriaBuilder.lower(issueRoot.get( "province" )), issueSearch.getProvincia().toLowerCase()));
			
			//CITY
			if(!issueSearch.getCiudad().equalsIgnoreCase("todas"))		
				predicates.add(criteriaBuilder.equal( criteriaBuilder.lower(issueRoot.get( "city" )), issueSearch.getCiudad().toLowerCase()));		
			
			//NEIGHBORHOOD
			if(!issueSearch.getBarrio().isEmpty() && issueSearch.getBarrio() != null)	
				predicates.add(criteriaBuilder.equal( criteriaBuilder.lower(issueRoot.get( "neighborhood" )), issueSearch.getBarrio().toLowerCase()));
						
			//TAGS    
			if(issueSearch.getTagsArray() != null){					
				Join<Issue, Tag> tagJoin = issueRoot.join("tagsList");
				Expression<String> exp = tagJoin.get("tagname");
				Predicate predicateTag = exp.in(issueSearch.getTagsArray());
			    predicates.add(predicateTag);			     
			}
		
			//STATUS
			if(issueSearch.getEstadosArray() != null){
				Expression<String> exp = issueRoot.get("status");
				Predicate predicateStatus = exp.in(issueSearch.getEstadosArray());
				predicates.add(predicateStatus);
			}
			
			//DATE
			predicates.add(criteriaBuilder.between(issueRoot.get( "creationDate" ), issueSearch.getMinFechaFormateada(), issueSearch.getMaxFechaFormateada()));
			
			//add predicates
			criteriaQuery.where(criteriaBuilder.and((Predicate[]) predicates.toArray(new Predicate[]{})));
									
			//sort asc
			if(issueSearch.getSortDirection().equalsIgnoreCase("asc"))
				criteriaQuery.orderBy( criteriaBuilder.asc( issueRoot.get( issueSearch.getSortField() ) ) );
			
			//sort desc
			else 	
			    criteriaQuery.orderBy( criteriaBuilder.desc( issueRoot.get( issueSearch.getSortField() ) ) );
			
			criteriaQuery.select(issueRoot).distinct(true);		
			
			TypedQuery<Issue> query = entityManager.createQuery(criteriaQuery);		
			
			int LIMIT = issueSearch.getMaxResults();
			
			if(LIMIT == 0)
				return query.getResultList();
			else
				return query.setMaxResults(LIMIT).getResultList();
			
		}catch(Exception e){
			Log.error(e.getMessage());
		}
	
		return null;
	
      
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
