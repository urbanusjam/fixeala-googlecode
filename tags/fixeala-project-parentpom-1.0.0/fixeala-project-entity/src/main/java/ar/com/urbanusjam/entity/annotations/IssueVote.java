package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="issue_vote")
public class IssueVote extends IssueMainAbstract implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	@Column(name="vote")
	private int vote;
	
	@Transient
	private boolean isCurrentlyVoteByUser;

	public int getVote() {
		return vote;
	}

	public void setVote(int vote) {
		this.vote = vote;
	}

	public boolean isCurrentlyVoteByUser() {
		return isCurrentlyVoteByUser;
	}

	public void setCurrentlyVoteByUser(boolean isCurrentlyVoteByUser) {
		this.isCurrentlyVoteByUser = isCurrentlyVoteByUser;
	}

}
