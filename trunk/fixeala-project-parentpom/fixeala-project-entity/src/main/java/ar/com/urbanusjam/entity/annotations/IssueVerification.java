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
@Table(name="issue_verification_request")
public class IssueVerification implements Serializable {

	private static final long serialVersionUID = 1L;

	@EmbeddedId
    private IssueVerificationPK id;
	
	@ManyToOne
	@JoinColumn(name="id_issue", insertable=false, updatable=false)
	private Issue issue;
	
	@ManyToOne
	@JoinColumn(name = "id_user", insertable=false, updatable=false)
	private User user;
		
	@Column(name = "is_verified")
	private boolean isVerified;
	
	@Column(name = "verification_date")
	private GregorianCalendar date;
	
	public IssueVerification(){}

	public IssueVerificationPK getId() {
		return id;
	}

	public void setId(IssueVerificationPK id) {
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

	public boolean isVerified() {
		return isVerified;
	}

	public void setVerified(boolean isVerified) {
		this.isVerified = isVerified;
	}

	public GregorianCalendar getDate() {
		return date;
	}

	public void setDate(GregorianCalendar date) {
		this.date = date;
	}
	
}
