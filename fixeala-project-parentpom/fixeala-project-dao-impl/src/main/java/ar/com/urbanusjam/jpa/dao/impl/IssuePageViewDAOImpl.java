package ar.com.urbanusjam.jpa.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import ar.com.urbanusjam.dao.IssuePageViewDAO;
import ar.com.urbanusjam.entity.annotations.IssuePageView;

@Repository
public class IssuePageViewDAOImpl implements IssuePageViewDAO {
	
	@PersistenceContext(unitName = "fixealaPU")
	private EntityManager entityManager; 

	public IssuePageViewDAOImpl() {}

	@Override
	public void saveIssuePageView(IssuePageView pageview) {
		entityManager.persist(pageview);
	}

	@Override
	public int getIssuePageViews(Long issueID) {
		List<IssuePageView> pageviews = entityManager.createQuery("SELECT i FROM IssuePageView i WHERE i.issue.id = :issueID", IssuePageView.class)
				   .setParameter("issueID", issueID)
			       .getResultList();
		return pageviews.size();
	}

	@Override
	public boolean existsIssuePageView(Long issueID, String username) {
		List<IssuePageView> pageviews = entityManager.createNamedQuery("SELECT i FROM IssuePageView i WHERE i.issue.id = :issueID AND i.user.username = :username", IssuePageView.class)
				   .setParameter("issueID", issueID)
				   .setParameter("username", username)
			       .getResultList();
		return pageviews.size() > 0 ? true : false; 	
	}


}
