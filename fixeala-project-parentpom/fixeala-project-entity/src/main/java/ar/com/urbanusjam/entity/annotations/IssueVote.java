package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;
import java.util.GregorianCalendar;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="issue_vote")
public class IssueVote implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	@EmbeddedId
    private IssueVotePK id;
	
	@ManyToOne
	@JoinColumn(name="id_issue", insertable=false, updatable=false)
	private Issue issue;
	
	@ManyToOne
	@JoinColumn(name="id_voter", insertable=false, updatable=false)
	private User voter;
	
	@Column(name = "vote")
	private int vote;
	
	@Column(name = "vote_date")
	private GregorianCalendar date;
	
	
	public IssueVote(){}
	
	
	public IssueVotePK getId() {
		return id;
	}

	public void setId(IssueVotePK id) {
		this.id = id;
	}
		
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

	public int getVote() {
		return vote;
	}

	public void setVote(int vote) {
		this.vote = vote;
	}

	public GregorianCalendar getDate() {
		return date;
	}

	public void setDate(GregorianCalendar date) {
		this.date = date;
	}
	
}
