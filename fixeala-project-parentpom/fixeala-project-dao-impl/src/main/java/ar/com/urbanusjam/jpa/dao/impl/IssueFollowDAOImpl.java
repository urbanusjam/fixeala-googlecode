package ar.com.urbanusjam.jpa.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.IssueFollowDAO;
import ar.com.urbanusjam.entity.annotations.IssueFollow;

@Repository
@Transactional(propagation= Propagation.REQUIRED, readOnly=false)
public class IssueFollowDAOImpl implements IssueFollowDAO {	
	
	@PersistenceContext(unitName = "fixealaPU")
	private EntityManager entityManager; 
	
	public IssueFollowDAOImpl() {}

	@Override
	public void saveFollowing(IssueFollow newFollowing) {
		entityManager.persist(newFollowing);
	}

	@Override
	public void deleteFollowing(IssueFollow following) {
		IssueFollow activeFollowing = entityManager.createQuery("SELECT f FROM IssueFollow f WHERE f.id.issueID = :issueID and f.id.followerID = :followerID", IssueFollow.class)
			     .setParameter("issueID", following.getId().getIssueID())
			     .setParameter("followerID", following.getId().getFollowerID())
			     .getSingleResult();
		entityManager.remove(activeFollowing);		
	}

	@Override
	public IssueFollow findFollowing(IssueFollow following) {
		IssueFollow activeFollowing = entityManager.createQuery("SELECT f FROM IssueFollow f WHERE f.id.issueID = :issueID and f.id.followerID = :followerID", IssueFollow.class)
				     .setParameter("issueID", following.getId().getIssueID())
				     .setParameter("followerID", following.getId().getFollowerID())
				     .getSingleResult();
		return activeFollowing; 		
	}

	@Override
	public List<IssueFollow> findFollowingsByIssue(Long issueID) {
		List<IssueFollow> followers = entityManager.createQuery("SELECT f FROM IssueFollow f WHERE f.id.issueID = :issueID", IssueFollow.class)
			     .setParameter("issueID", issueID)
			     .getResultList();
		return followers;
	}

	@Override
	public List<IssueFollow> findFollowingsByUser(Long userID) throws NoResultException {
		List<IssueFollow> followings = entityManager.createQuery("SELECT i FROM IssueFollow i WHERE i.id.followerID = :userID", IssueFollow.class)
			     .setParameter("userID", userID)
			     .getResultList();
		return followings;
	}

}
