package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;

import javax.persistence.Column;

public class IssueFollowPK implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name="id_issue")
	private Long issueID;
	
	@Column(name="id_follower")
	private Long followerID;

	
	public IssueFollowPK(){}
	

	public Long getIssueID() {
		return issueID;
	}

	public void setIssueID(Long issueID) {
		this.issueID = issueID;
	}

	public Long getFollowerID() {
		return followerID;
	}

	public void setFollowerID(Long followerID) {
		this.followerID = followerID;
	}


	@Override
    public int hashCode() {
		final int prime = 31;		
		int result = 1;		
		result = prime * result + ((issueID == null) ? 0 : issueID.hashCode());		
		result = prime * result + ((followerID == null) ? 0 : followerID.hashCode());
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
	 
	 IssueFollowPK other = (IssueFollowPK) obj;
	 
	 if (issueID == null) {
		 if (other.issueID != null)
	         return false;
	 } else if (!issueID.equals(other.issueID))
	         return false;
	 if (followerID == null) {
		 if (other.followerID != null)
	         return false;
	 } else if (!followerID.equals(other.followerID))
	         return false;

	 return true;
	        
    }

}