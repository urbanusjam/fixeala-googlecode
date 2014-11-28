package ar.com.urbanusjam.dao;

import ar.com.urbanusjam.entity.annotations.IssueVerification;

public interface IssueVerificationDAO {
	
	public IssueVerification findVerificationByUser(Long issueID, Long userID);

}
