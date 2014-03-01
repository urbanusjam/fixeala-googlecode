package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class IssueVotePK implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name="id_issue")
	private Long issueID;
	
	@Column(name="id_voter")
	private Long voterID;
	
	
	public IssueVotePK(){}

	
	public Long getIssueID() {
		return issueID;
	}

	public void setIssueID(Long issueID) {
		this.issueID = issueID;
	}

	public Long getVoterID() {
		return voterID;
	}

	public void setVoterID(Long voterID) {
		this.voterID = voterID;
	}

	@Override
    public int hashCode() {
		final int prime = 31;		
		int result = 1;		
		result = prime * result + ((issueID == null) ? 0 : issueID.hashCode());		
		result = prime * result + ((voterID == null) ? 0 : voterID.hashCode());
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
	 
	 if (voterID == null) {
		 if (other.voterID != null)
	         return false;
	 } else if (!issueID.equals(other.voterID))
	         return false;
	 if (voterID == null) {
		 if (other.voterID != null)
	         return false;
	 } else if (!voterID.equals(other.voterID))
	         return false;

	 return true;
	        
    }

}
