package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Cascade;

@Entity
@Table(name="tag")
public class Tag implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id_tag")
	private Long id;
	
	@Column(name = "tagname")
	private String tagname;
	
//	@ManyToMany(fetch = FetchType.EAGER) //owner side
//    @Cascade({org.hibernate.annotations.CascadeType.SAVE_UPDATE, org.hibernate.annotations.CascadeType.ALL})	
//	@JoinTable(name = "ISSUE_TAG", 
//	         joinColumns = @JoinColumn(name = "ID_TAG"),
//	         inverseJoinColumns = @JoinColumn(name = "ID_ISSUE") 
//	)
//	private Set<Issue> issueList;
	
	
	@ManyToMany(fetch = FetchType.EAGER, mappedBy="tagsList") //inverse side
	@Cascade(org.hibernate.annotations.CascadeType.SAVE_UPDATE)
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
	
	public void removeIssue(Issue issue) {	
		if (getIssueList().contains(issue)) {
			getIssueList().remove(issue);
		}
	    if (issue.getTagsList().contains(this)) {
	    	issue.getTagsList().remove(this);
	    }	
	}
	    
	    
//	@Override
//    public int hashCode() {
//        int result;     
//        result = (int) (29 * (this.getTagname().hashCode()) + this.getId());
//        return result;
//    }


    @Override
    public boolean equals(Object obj) {
    	if (obj == this) return true;
    	if (obj == null) return false;            
    	if ( !(obj instanceof Tag) ) return false;
        Tag t = (Tag) obj;
        return t.getTagname().equals(this.getTagname());        
    }


}
