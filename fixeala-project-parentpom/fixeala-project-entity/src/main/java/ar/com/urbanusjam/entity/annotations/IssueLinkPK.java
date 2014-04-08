package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;

import javax.persistence.Column;

public class IssueLinkPK implements Serializable {

	private static final long serialVersionUID = 7480411529540823812L;
	
	@Column(name="id_issue")
	private Long issueID;
	
	@Column(name="id_follower")
	private Long relatedIssueID;

	
	public IssueLinkPK(){}
	

	public Long getIssueID() {
		return issueID;
	}

	public void setIssueID(Long issueID) {
		this.issueID = issueID;
	}

	public Long getRelatedIssueID() {
		return relatedIssueID;
	}

	public void setRelatedIssueID(Long relatedIssueID) {
		this.relatedIssueID = relatedIssueID;
	}


	@Override
    public int hashCode() {
		final int prime = 31;		
		int result = 1;		
		result = prime * result + ((issueID == null) ? 0 : issueID.hashCode());		
		result = prime * result + ((relatedIssueID == null) ? 0 : relatedIssueID.hashCode());
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
	 
	 IssueLinkPK other = (IssueLinkPK) obj;
	 
	 if (issueID == null) {
		 if (other.issueID != null)
	         return false;
	 } else if (!issueID.equals(other.issueID))
	         return false;
	 if (relatedIssueID == null) {
		 if (other.relatedIssueID != null)
	         return false;
	 } else if (!relatedIssueID.equals(other.relatedIssueID))
	         return false;

	 return true;
	        
    }

}
