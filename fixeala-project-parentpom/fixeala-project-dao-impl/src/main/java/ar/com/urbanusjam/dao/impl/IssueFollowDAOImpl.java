package ar.com.urbanusjam.dao.impl;

import java.io.Serializable;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
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
		List<IssueFollow> followings = this.findWhere(" id.issue.id = ? AND id.follower.username = ? ", 
				new Object[]{
					following.getId().getIssue().getId(), 
					following.getId().getFollower().getUsername()
					});
		this.delete(followings.get(0));		
	}

	@Override
	public IssueFollow findFollowing(IssueFollow following) {
//		List<IssueFollow> followings = this.findWhere(" id.issue.id = ? AND id.follower.username = ? ", 
//				new Object[]{
//					following.getId().getIssue().getId(), 
//					following.getId().getFollower().getUsername()
//					});
		
			List<IssueFollow> followings = getSessionFactory().getCurrentSession().createCriteria(IssueFollow.class)
				 .createAlias("id", "pk")
				 .createAlias("pk.issue", "i")
				 	.add( Restrictions.eq("i.issue.id", following.getId().getIssue().getId()) ) 
				 .createAlias("pk.follower", "f")			
				 	.add( Restrictions.eq("f.follower.username", following.getId().getFollower().getUsername()) )
				 .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
				 .list();
		return followings.size() > 0 ? followings.get(0) : null; 		
	}

}
