package ar.com.urbanusjam.jpa.dao.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Repository;

import ar.com.urbanusjam.dao.IssuePageViewDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.entity.annotations.IssuePageView;

@Repository
public class IssuePageViewDAOImpl extends GenericDAOImpl<IssuePageView, Serializable> 
	implements IssuePageViewDAO {

	public IssuePageViewDAOImpl() {
		super(IssuePageView.class);
	}

	@Override
	public void saveIssuePageView(IssuePageView pageview) {
		this.save(pageview);
	}

	@Override
	public int getIssuePageViews(Long issueID) {
		List<IssuePageView> pageviews = this.findWhere(" issue.id = ? ", new Object[]{issueID});
		return pageviews.size();
	}

	@Override
	public boolean existsIssuePageView(Long issueID, String username) {
		List<IssuePageView> pageviews = this.findWhere(" issue.id = ? AND user.username = ? ", 
				new Object[]{issueID, username});
		return pageviews.size() > 0 ? true : false; 	
	}


}
