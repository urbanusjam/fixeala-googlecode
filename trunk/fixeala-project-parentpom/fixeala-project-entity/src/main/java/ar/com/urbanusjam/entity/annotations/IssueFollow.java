package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name="issue_follow")
public class IssueFollow extends IssueMainAction implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
//	@EmbeddedId
//    private IssueFollowPK id;
	
//	@ManyToOne
//	@JoinColumn(name="id_issue", insertable=false, updatable=false)
//	private Issue issue;
//	
//	@ManyToOne
//	@JoinColumn(name="id_follower", insertable=false, updatable=false)
//	private User follower;
	
//	@Column(name = "follow_date")
//	private GregorianCalendar date;
	
	
//	public IssueFollow(){}


//	public IssueFollowPK getId() {
//		return id;
//	}

//	public void setId(IssueFollowPK id) {
//		this.id = id;
//	}

//	public Issue getIssue() {
//		return issue;
//	}
//
//	public void setIssue(Issue issue) {
//		this.issue = issue;
//	}
//
//	public User getFollower() {
//		return follower;
//	}
//
//	public void setFollower(User follower) {
//		this.follower = follower;
//	}

//	public GregorianCalendar getDate() {
//		return date;
//	}
//
//	public void setDate(GregorianCalendar date) {
//		this.date = date;
//	}	
	
}