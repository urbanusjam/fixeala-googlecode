package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;
import java.util.GregorianCalendar;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name="ISSUE_VOTE")
public class IssueVote implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	@EmbeddedId
    private IssueVotePK id;
	
	@Column(name = "VOTE")
	private int vote;
	
	@Column(name = "VOTE_DATE")
	private GregorianCalendar date;
	
	
	public IssueVote(){}
	
	
	public IssueVotePK getId() {
		return id;
	}

	public void setId(IssueVotePK id) {
		this.id = id;
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
