package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Cascade;

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
	
//	@ManyToMany(fetch = FetchType.LAZY, cascade = CascadeType.ALL, mappedBy="tagsList")
	@ManyToMany(fetch = FetchType.EAGER)
    @Cascade(org.hibernate.annotations.CascadeType.SAVE_UPDATE)
	@JoinTable(name = "ISSUE_TAG",
	         joinColumns = @JoinColumn(name = "ID_TAG"),
	         inverseJoinColumns = @JoinColumn(name = "ID_ISSUE")
	)
	private Set<Issue> issueList;
	
	public Tag() { issueList = new HashSet<Issue>(); }

	
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

	public Set<Issue> getIssueList() {
		return issueList;
	}

	public void setIssueList(Set<Issue> issueList) {
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
	    
	    
//	@Override
//    public int hashCode() {
//        int result;
//        result = getTagname().hashCode();
//        result = (int) (29 * result + getId());
//        return result;
//    }


    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if ( !(obj instanceof Tag) ) return false;

        final Tag t = (Tag) obj;

        return t.getTagname().equals( this.getTagname() ) ;
        
    }


}
