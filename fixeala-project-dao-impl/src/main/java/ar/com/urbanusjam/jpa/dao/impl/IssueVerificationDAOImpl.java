package ar.com.urbanusjam.jpa.dao.impl;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

import ar.com.urbanusjam.dao.IssueVerificationDAO;
import ar.com.urbanusjam.entity.annotations.IssueVerification;

public class IssueVerificationDAOImpl implements IssueVerificationDAO{

	@PersistenceContext(unitName = "fixealaPU")
	private EntityManager entityManager; 

	public IssueVerificationDAOImpl() {}
	
	@Override
	public IssueVerification findVerificationByUser(Long issueID,
			Long userID) {
		try{
			IssueVerification verification = (IssueVerification) entityManager.createQuery(		
			    						"SELECT v FROM IssueVerification v WHERE v.id.issueID = :issueID AND v.id.userID = :userID")
			    						.setParameter("issueID", issueID)	
			    						.setParameter("userID", userID)	
			    						.getSingleResult();
			return verification;
		}catch(NoResultException e){
			return null;
		}
	}

}
