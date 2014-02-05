package ar.com.urbanusjam.dao;

import ar.com.urbanusjam.entity.annotations.IssueFollow;

public interface IssueFollowDAO {
	
	public void saveFollowing(IssueFollow following);
	
	public void deleteFollowing (IssueFollow following);
	
	public IssueFollow findFollowing(IssueFollow following);

}
