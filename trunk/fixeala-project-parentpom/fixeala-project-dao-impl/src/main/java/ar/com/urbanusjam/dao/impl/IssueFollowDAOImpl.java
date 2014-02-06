package ar.com.urbanusjam.dao.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.IssueFollowDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.entity.annotations.IssueFollow;

@Transactional(propagation= Propagation.REQUIRED, readOnly=false)
public class IssueFollowDAOImpl extends GenericDAOImpl<IssueFollow, Serializable> implements IssueFollowDAO {	
	
	public IssueFollowDAOImpl() {
		super(IssueFollow.class);
	}

	@Override
	public void saveFollowing(IssueFollow newFollowing) {
		this.save(newFollowing);
	}

	@Override
	public void deleteFollowing(IssueFollow following) {
		List<IssueFollow> followings = this.findWhere(" id.issueID = ? AND id.followerID = ? ", 
				new Object[]{
				following.getId().getIssueID(), 
				following.getId().getFollowerID()
					});
		this.delete(followings.get(0));		
	}

	@Override
	public IssueFollow findFollowing(IssueFollow following) {
		List<IssueFollow> followings = this.findWhere(" id.issueID = ? AND id.followerID = ? ", 
				new Object[]{
					following.getId().getIssueID(), 
					following.getId().getFollowerID()
					});
		
		return followings.size() > 0 ? followings.get(0) : null; 		
	}

	@Override
	public List<IssueFollow> findFollowingsByIssue(Long issueID) {
		List<IssueFollow> followers = this.findWhere(" id.issueID = ? ", new Object[]{ issueID });
		return followers;
	}

	@Override
	public List<IssueFollow> findFollowingsByUser(Long userID) {
		List<IssueFollow> followings = this.findWhere(" id.followerID = ? ", new Object[]{ userID });
		return followings;
	}

}
