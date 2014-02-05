package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;

import javax.persistence.Embeddable;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

@Embeddable
public class IssueVotePK implements Serializable {

	private static final long serialVersionUID = 1L;

	@ManyToOne
	@JoinColumn(name = "ID_ISSUE")
	private Issue issue;
	
	@OneToOne
	@JoinColumn(name = "ID_VOTER")
	private User voter;
	

	public Issue getIssue() {
		return issue;
	}

	public void setIssue(Issue issue) {
		this.issue = issue;
	}

	public User getVoter() {
		return voter;
	}

	public void setVoter(User voter) {
		this.voter = voter;
	}
	
	@Override
    public int hashCode() {
		final int prime = 31;		
		int result = 1;		
		result = prime * result + ((issue == null) ? 0 : issue.hashCode());		
		result = prime * result + ((voter == null) ? 0 : voter.hashCode());
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
	 
	 IssueVotePK other = (IssueVotePK) obj;
	 
	 if (issue == null) {
		 if (other.issue != null)
	         return false;
	 } else if (!issue.equals(other.issue))
	         return false;
	 if (voter == null) {
		 if (other.voter != null)
	         return false;
	 } else if (!voter.equals(other.voter))
	         return false;

	 return true;
	        
    }

}
