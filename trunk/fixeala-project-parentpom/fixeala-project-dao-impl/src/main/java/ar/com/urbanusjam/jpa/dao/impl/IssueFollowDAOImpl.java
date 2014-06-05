package ar.com.urbanusjam.jpa.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
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
		IssueFollow activeFollowing = entityManager.createNamedQuery("IssueFollow.findByIssueFollower", IssueFollow.class)
			     .setParameter("id.issueID", following.getId().getIssueID())
			     .setParameter("id.followerID", following.getId().getFollowerID())
			     .getSingleResult();
		entityManager.remove(activeFollowing);		
	}

	@Override
	public IssueFollow findFollowing(IssueFollow following) {
		IssueFollow activeFollowing = entityManager.createNamedQuery("IssueFollow.findByIssueFollower", IssueFollow.class)
				     .setParameter("id.issueID", following.getId().getIssueID())
				     .setParameter("id.followerID", following.getId().getFollowerID())
				     .getSingleResult();
		return activeFollowing; 		
	}

	@Override
	public List<IssueFollow> findFollowingsByIssue(Long issueID) {
		List<IssueFollow> followers = entityManager.createNamedQuery("IssueFollow.findByIssue", IssueFollow.class)
			     .setParameter("id.issueID", issueID)
			     .getResultList();
		return followers;
	}

	@Override
	public List<IssueFollow> findFollowingsByUser(Long userID) {
		List<IssueFollow> followings = entityManager.createNamedQuery("IssueFollow.findByUser", IssueFollow.class)
			     .setParameter("id.followerID", userID)
			     .getResultList();
		return followings;
	}

}
