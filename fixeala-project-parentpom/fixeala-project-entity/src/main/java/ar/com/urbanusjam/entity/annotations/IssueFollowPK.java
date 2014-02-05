package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class IssueFollowPK implements Serializable {

	private static final long serialVersionUID = 1L;

	//@ManyToOne
	@Column(name = "ID_ISSUE")
	private Issue issue;
	
	//@OneToOne
	@Column(name = "ID_FOLLOWER")
	private User follower;

	
	public Issue getIssue() {
		return issue;
	}

	public void setIssue(Issue issue) {
		this.issue = issue;
	}

	public User getFollower() {
		return follower;
	}

	public void setFollower(User follower) {
		this.follower = follower;
	}
	
	@Override
    public int hashCode() {
		final int prime = 31;		
		int result = 1;		
		result = prime * result + ((issue == null) ? 0 : issue.hashCode());		
		result = prime * result + ((follower == null) ? 0 : follower.hashCode());
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
	 
	 if (issue == null) {
		 if (other.issue != null)
	         return false;
	 } else if (!issue.getId().equals(other.issue.getId()))
	         return false;
	 if (follower == null) {
		 if (other.follower != null)
	         return false;
	 } else if (!follower.getId().equals(other.follower.getId()))
	         return false;

	 return true;
	        
    }

}
