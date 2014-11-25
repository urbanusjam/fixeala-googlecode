package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;
import java.util.GregorianCalendar;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.MappedSuperclass;

@MappedSuperclass
public abstract class IssueMainAction implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@EmbeddedId
    private IssueMainActionPK id;
	
	@ManyToOne
	@JoinColumn(name="id_issue", insertable=false, updatable=false)
	private Issue issue;
	
	@ManyToOne
	@JoinColumn(name="id_user", insertable=false, updatable=false)
	private User user;
	
	@Column(name = "date")
	private GregorianCalendar date;
	
	public IssueMainAction(){}

	public IssueMainActionPK getId() {
		return id;
	}

	public void setId(IssueMainActionPK id) {
		this.id = id;
	}

	public Issue getIssue() {
		return issue;
	}

	public void setIssue(Issue issue) {
		this.issue = issue;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public GregorianCalendar getDate() {
		return date;
	}

	public void setDate(GregorianCalendar date) {
		this.date = date;
	}
		
}
