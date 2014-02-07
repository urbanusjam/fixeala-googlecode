package ar.com.urbanusjam.dao;

import ar.com.urbanusjam.entity.annotations.IssuePageView;

public interface IssuePageViewDAO {
	
	public void saveIssuePageView (IssuePageView pageview);
	
	public int getIssuePageViews (Long issueID);
	
	public boolean existsIssuePageView (Long issueID, String username);

}
