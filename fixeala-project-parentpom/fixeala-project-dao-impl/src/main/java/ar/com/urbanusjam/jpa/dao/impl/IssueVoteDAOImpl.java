package ar.com.urbanusjam.jpa.dao.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityTransaction;
import javax.persistence.Persistence;
import javax.persistence.Query;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.IssueVoteDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.entity.annotations.IssueVote;

@Repository
@Transactional(propagation= Propagation.REQUIRED, readOnly=false)
public class IssueVoteDAOImpl extends GenericDAOImpl<IssueVote, Serializable> implements IssueVoteDAO {	
	
	public IssueVoteDAOImpl() {
		super(IssueVote.class);
	}

	@Override
	public void saveIssueVote(IssueVote vote) {
		this.save(vote);
	}

	@Override
	public IssueVote getVoteByUser(Long issueID, Long userID) {
		List<IssueVote> votes = this.findWhere(" id.issueID = ? AND id.voterID = ? ", 
				new Object[]{issueID, userID});
		
		return votes.size() > 0 ? votes.get(0) : null; 		
	}

	@Override
	public List<IssueVote> getVotesByIssue(Long issueID) {
		List<IssueVote> votes = this.findWhere(" id.issueID = ? ", 
				new Object[]{issueID});
		
		return votes;
	}

	@Override
	public Long getTotalVotesCount(Long issueID) {
	
		String query = " SELECT SUM(v.vote) FROM IssueVote v WHERE v.issue.id = ? ";			
		Object[] queryParam = {issueID};
		List<Long> votesCount = new ArrayList<Long>();
		votesCount = getHibernateTemplate().find(query, queryParam);
		
		return votesCount.get(0) != null ?  votesCount.get(0) : new Long(0);
	
	}

}
