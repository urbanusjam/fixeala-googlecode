package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;
import java.util.GregorianCalendar;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MapsId;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="ISSUE_FOLLOW")
public class IssueFollow implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	@EmbeddedId
    private IssueFollowPK id;
	
	@ManyToOne
	@JoinColumn(name="ID_ISSUE", insertable=false, updatable=false)
	private Issue issue;
	
	@ManyToOne
	@JoinColumn(name="ID_FOLLOWER", insertable=false, updatable=false)
	private User follower;
	
	@Column(name = "FOLLOW_DATE")
	private GregorianCalendar date;
	
	
	public IssueFollow(){}


	public IssueFollowPK getId() {
		return id;
	}

	public void setId(IssueFollowPK id) {
		this.id = id;
	}

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

	public GregorianCalendar getDate() {
		return date;
	}

	public void setDate(GregorianCalendar date) {
		this.date = date;
	}	
	
}