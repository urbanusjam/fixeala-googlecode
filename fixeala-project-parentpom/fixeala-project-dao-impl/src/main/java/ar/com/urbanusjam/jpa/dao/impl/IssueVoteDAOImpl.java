package ar.com.urbanusjam.jpa.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.IssueVoteDAO;
import ar.com.urbanusjam.entity.annotations.IssueVote;

@Repository
@Transactional(propagation= Propagation.REQUIRED, readOnly=false)
public class IssueVoteDAOImpl implements IssueVoteDAO {	
	
	@PersistenceContext(unitName = "fixealaPU")
	private EntityManager entityManager; 
	
	public IssueVoteDAOImpl() {}

	@Override
	public void saveIssueVote(IssueVote vote) {
		entityManager.persist(vote);
	}

	@Override
	public IssueVote getVoteByUser(Long issueID, Long userID) {
		IssueVote vote = entityManager.createQuery("SELECT i FROM IssueVote i WHERE id.issueID = :issueID AND i.id.voterID = :voterID", IssueVote.class)
				   .setParameter("issueID", issueID)
				   .setParameter("voterID", userID)
			       .getSingleResult();		
		return vote;		
	}

	@Override
	public List<IssueVote> getVotesByIssue(Long issueID) {
		List<IssueVote> votes = entityManager.createQuery("SELECT i FROM IssueVote i WHERE id.issueID = :issueID", IssueVote.class)
				   						     .setParameter("id.issueID", issueID)
				   						     .getResultList();	
		return votes;
	}

	@Override
	public Long getTotalVotesCount(Long issueID) {
		Long votesCount = (Long) entityManager.createQuery(
				"SELECT SUM(v.vote) FROM IssueVote v WHERE v.issue.id = :issueID")
				.setParameter("issueID", issueID)	
				.getSingleResult();	
		return votesCount != null ?  votesCount : new Long(0);
	}

}
