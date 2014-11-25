package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="issue_vote")
public class IssueVote extends IssueMainAction implements Serializable {
	
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
	
	
	
//	@EmbeddedId
//    private IssueVotePK id;
//	
//	@ManyToOne
//	@JoinColumn(name="id_issue", insertable=false, updatable=false)
//	private Issue issue;
//	
//	@ManyToOne
//	@JoinColumn(name="id_voter", insertable=false, updatable=false)
//	private User voter;
//	
//	@Column(name = "vote")
//	private int vote;
//	
//	@Column(name = "vote_date")
//	private GregorianCalendar date;
//	
//	
//	public IssueVote(){}
//	
//	
//	public IssueVotePK getId() {
//		return id;
//	}
//
//	public void setId(IssueVotePK id) {
//		this.id = id;
//	}
//		
//	public Issue getIssue() {
//		return issue;
//	}
//
//	public void setIssue(Issue issue) {
//		this.issue = issue;
//	}
//
//	public User getVoter() {
//		return voter;
//	}
//
//	public void setVoter(User voter) {
//		this.voter = voter;
//	}
//
//	public int getVote() {
//		return vote;
//	}
//
//	public void setVote(int vote) {
//		this.vote = vote;
//	}
//
//	public GregorianCalendar getDate() {
//		return date;
//	}
//
//	public void setDate(GregorianCalendar date) {
//		this.date = date;
//	}
	
}
