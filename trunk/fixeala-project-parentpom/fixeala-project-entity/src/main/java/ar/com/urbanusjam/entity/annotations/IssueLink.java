package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="issue_link")
public class IssueLink implements Serializable {

	private static final long serialVersionUID = -8113319250298068069L;
	
	@EmbeddedId
    private IssueLinkPK id;
	
	@ManyToOne
	@JoinColumn(name="id_issue", insertable=false, updatable=false)
	private Issue issue;
	
	@ManyToOne
	@JoinColumn(name="id_related_issue", insertable=false, updatable=false)
	private Issue relatedIssue;
	
	@Column(name="link_type")
	private String linkType;
	
	public IssueLink(){}

	public IssueLinkPK getId() {
		return id;
	}

	public void setId(IssueLinkPK id) {
		this.id = id;
	}

	public Issue getIssue() {
		return issue;
	}

	public void setIssue(Issue issue) {
		this.issue = issue;
	}

	public Issue getRelatedIssue() {
		return relatedIssue;
	}

	public void setRelatedIssue(Issue relatedIssue) {
		this.relatedIssue = relatedIssue;
	}

	public String getLinkType() {
		return linkType;
	}

	public void setLinkType(String linkType) {
		this.linkType = linkType;
	}
	
}
