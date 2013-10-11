package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

@Entity
@Table(name="TAG")
public class Tag implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "ID_TAG")
	private Long id;
	
	@Column(name = "TAG_NAME")
	private String tagname;
	
	@ManyToMany(cascade = CascadeType.ALL, mappedBy="tagsList")
//	@JoinTable(name = "ISSUES_TAGS",
//	         joinColumns = @JoinColumn(name = "ID_TAG"),
//	         inverseJoinColumns = @JoinColumn(name = "ID_ISSUE")
//	)
	private Collection<Issue> issueList;
	
	public Tag() { issueList = new ArrayList<Issue>(); }

	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTagname() {
		return tagname;
	}

	public void setTagname(String tagname) {
		this.tagname = tagname;
	}

	public Collection<Issue> getIssueList() {
		return issueList;
	}

	public void setIssueList(Collection<Issue> issueList) {
		this.issueList = issueList;
	}
			
	public void addIssue(Issue issue) {	
		if (!getIssueList().contains(issue)) {
			getIssueList().add(issue);
		}
	    if (!issue.getTagsList().contains(this)) {
	    	issue.getTagsList().add(this);
	    }	
	}
	    
	    
	@Override
    public int hashCode() {
        int result;
        result = getId().hashCode();
        result = (int) (29 * result + getId());
        return result;
    }


    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if ( !(obj instanceof Tag) ) return false;

        final Tag t = (Tag) obj;

        return t.getId().equals( this.getId() ) ;
        
    }


}
