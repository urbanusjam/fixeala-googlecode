package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;
import java.util.GregorianCalendar;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name="ISSUE_FOLLOW")
public class IssueFollow implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	@EmbeddedId
    private IssueFollowPK id;
	
	@Column(name = "FOLLOW_DATE")
	private GregorianCalendar date;
	
	
	public IssueFollow(){}


	public IssueFollowPK getId() {
		return id;
	}

	public void setId(IssueFollowPK id) {
		this.id = id;
	}

	public GregorianCalendar getDate() {
		return date;
	}

	public void setDate(GregorianCalendar date) {
		this.date = date;
	}	
	
}
