package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;

import javax.persistence.Column;

public class IssueVerificationPK implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name="id_issue")
	private Long issueID;
	
	@Column(name="id_user")
	private Long userID;

	
	public IssueVerificationPK(){}
	
	public IssueVerificationPK(Long issueID, Long userID){
		this.issueID = issueID;
		this.userID = userID;
	}
	

	public Long getIssueID() {
		return issueID;
	}

	public void setIssueID(Long issueID) {
		this.issueID = issueID;
	}
	
	public Long getUserID() {
		return userID;
	}

	public void setUserID(Long userID) {
		this.userID = userID;
	}


	@Override
    public int hashCode() {
		final int prime = 31;		
		int result = 1;		
		result = prime * result + ((issueID == null) ? 0 : issueID.hashCode());		
		result = prime * result + ((userID == null) ? 0 : userID.hashCode());
        return result;
    }
	
	@Override
    public boolean equals(Object obj) {
		
	 if (this == obj)
	      return true;
	 if (obj == null)
	      return false;
	 if (getClass() != obj.getClass())
	      return false;
	 
	 IssueVerificationPK other = (IssueVerificationPK) obj;
	 
	 if (issueID == null) {
		 if (other.issueID != null)
	         return false;
	 } else if (!issueID.equals(other.issueID))
	         return false;
	 if (userID == null) {
		 if (other.userID != null)
	         return false;
	 } else if (!userID.equals(other.userID))
	         return false;

	 return true;
	        
    }

}