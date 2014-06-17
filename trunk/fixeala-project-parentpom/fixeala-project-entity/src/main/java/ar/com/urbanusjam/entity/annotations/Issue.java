package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.OrderBy;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.annotations.Cascade;



@Entity
@Table(name="issue")
public class Issue implements Serializable  {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "id_issue")
	private Long id;
	
	@OneToOne
	@JoinColumn(name = "id_reporter")
	private User reporter;
	
	@Column(name = "creation_date")
	private GregorianCalendar creationDate;
	
	@Column(name = "last_update_date")
	private GregorianCalendar lastUpdateDate;
	
	@Column(name = "address")
	private String address;
	
	@Column(name = "latitude")
	private float latitude;
	
	@Column(name = "longitude")
	private float longitude;
	
	@Column(name = "neighborhood")
	private String neighborhood;
	
	@Column(name = "city")
	private String city;
	
	@Column(name = "province")
	private String province;
	
	@Column(name = "title")
	private String title;
	
	@Column(name = "description")
	private String description;
	
	@Column(name = "priority")
	private String priority;
	
	@Column(name = "resolution_type")
	private String resolutionType;
	
	@Column(name = "status")
	private String status;
	
	@OneToOne
	@JoinColumn(name = "id_assigned_official")
	private User assignedOfficial;
	
	@ManyToOne
	@JoinColumn(name = "id_area")
	private Area assignedArea;
		
    @OneToMany(mappedBy="issue", fetch = FetchType.EAGER)  
    @Cascade({org.hibernate.annotations.CascadeType.SAVE_UPDATE, org.hibernate.annotations.CascadeType.ALL})	
    @OrderBy("fecha DESC")
	private Set<IssueUpdateHistory> revisiones;

	@OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@PrimaryKeyJoinColumn  
	private IssueRepair licitacion;

//	@ManyToMany(fetch = FetchType.EAGER, mappedBy="issueList") //inverse side
//	private Set<Tag> tagsList;	
	
	@ManyToMany(fetch = FetchType.EAGER) //owner side
    @Cascade({org.hibernate.annotations.CascadeType.SAVE_UPDATE, org.hibernate.annotations.CascadeType.ALL})	
	@JoinTable(name = "issue_tag", 
	         joinColumns = @JoinColumn(name = "id_issue"),
	         inverseJoinColumns = @JoinColumn(name = "id_tag") 
	)
	private Set<Tag> tagsList;	
	
	@OneToMany(mappedBy="issue", fetch = FetchType.EAGER, cascade = CascadeType.ALL)  
	private Set<MediaContent> contenidos;
	
	@OneToMany(mappedBy="issue", fetch = FetchType.EAGER, cascade = CascadeType.ALL)  
	@OrderBy("fecha DESC")
	private Set<Comment> comentarios;
	
//	@OneToMany(mappedBy="issue", fetch = FetchType.LAZY, cascade = CascadeType.ALL) 
//	private Set<IssueVote> votes;
	
	@OneToMany(mappedBy="issue", fetch = FetchType.LAZY) 
	private Set<IssueFollow> followers;
	
	@OneToMany(mappedBy="issue", fetch = FetchType.LAZY) 
	private Set<IssuePageView> pageviews;

	
	public Issue(){   
		tagsList = new HashSet<Tag>(); 
		revisiones = new HashSet<IssueUpdateHistory>();
		contenidos = new HashSet<MediaContent>();
		comentarios = new HashSet<Comment>();
//		votes = new HashSet<IssueVote>();
		followers = new HashSet<IssueFollow>();
	}	
		
	
	public Issue(User reporter, GregorianCalendar creationDate, String address, float latitude,
			float longitude, String neighborhood, String city, String province, String title,
			String description, Set<Tag> tagsList) {
		super();
		this.reporter = reporter;
		this.creationDate = creationDate;
		this.address = address;
		this.latitude = latitude;
		this.longitude = longitude;
		this.neighborhood = neighborhood;
		this.city = city;
		this.province = province;
		this.title = title;
		this.description = description;
		this.tagsList = tagsList;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public User getReporter() {
		return reporter;
	}
	
	public void setReporter(User reporter) {
		this.reporter = reporter;
	}
	
	public GregorianCalendar getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(GregorianCalendar creationDate) {
		this.creationDate = creationDate;
	}

	public GregorianCalendar getLastUpdateDate() {
		return lastUpdateDate;
	}

	public void setLastUpdateDate(GregorianCalendar lastUpdateDate) {
		this.lastUpdateDate = lastUpdateDate;
	}

	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getDescription() {
		return description;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getAddress() {
		return address;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getNeighborhood() {
		return neighborhood;
	}
	
	public void setNeighborhood(String neighborhood) {
		this.neighborhood = neighborhood;
	}
		
	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public float getLatitude() {
		return latitude;
	}
	
	public void setLatitude(float latitude) {
		this.latitude = latitude;
	}
	
	public float getLongitude() {
		return longitude;
	}
	
	public void setLongitude(float longitude) {
		this.longitude = longitude;
	}
	
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
	
	public User getAssignedOfficial() {
		return assignedOfficial;
	}

	public void setAssignedOfficial(User assignedOfficial) {
		this.assignedOfficial = assignedOfficial;
	}
	
	public Area getAssignedArea() {
		return assignedArea;
	}

	public void setAssignedArea(Area assignedArea) {
		this.assignedArea = assignedArea;
	}

	public Set<Tag> getTagsList() {
		return tagsList;
	}

	public void setTagsList(Set<Tag> tagsList) {
		this.tagsList = tagsList;
	}
		
	public Set<IssueUpdateHistory> getRevisiones() {
		return revisiones;
	}

	public void setRevisiones(Set<IssueUpdateHistory> revisiones) {
		this.revisiones = revisiones;
	}

	public IssueRepair getLicitacion() {
		return licitacion;
	}

	public void setLicitacion(IssueRepair licitacion) {
		this.licitacion = licitacion;
	}
	
	public Set<MediaContent> getContenidos() {
		return contenidos;
	}


	public void setContenidos(Set<MediaContent> contenidos) {
		this.contenidos = contenidos;
	}
	
	public Set<Comment> getComentarios() {
		return comentarios;
	}


	public void setComentarios(Set<Comment> comentarios) {
		this.comentarios = comentarios;
	}
	
	public Set<IssueFollow> getFollowers() {
		return followers;
	}


	public void setFollowers(Set<IssueFollow> followers) {
		this.followers = followers;
	}


	public void addTag(Tag tag) {	
		if (!getTagsList().contains(tag)) {
			getTagsList().add(tag);
		}
	    if (!tag.getIssueList().contains(this)) {
	        tag.getIssueList().add(this);
	    }				   
	}	
	
	public void removeTag(Tag tag) {	
		if (getTagsList().contains(tag)) {
			getTagsList().remove(tag);
		}
	    if (tag.getIssueList().contains(this)) {
	        tag.getIssueList().remove(this);
	    }			
	}	
	
	public void addRevision(IssueUpdateHistory update) {		
		if (update != null) {
	        if (revisiones == null) {
	        	revisiones = new HashSet<IssueUpdateHistory>();          
	        }
	        revisiones.add(update);
	        update.setIssue(this);
	     }			
	}
	
	public void addComment(Comment comment) {	
		if (comment != null) {
	        if (comentarios == null) {
	        	comentarios = new HashSet<Comment>();          
	        }
	        comentarios.add(comment);
	        comment.setIssue(this);
	     }		
	}
	
	public void addMediaContent(MediaContent contenido) {	
		if (contenido != null) {
	        if (contenidos == null) {
	        	contenidos = new HashSet<MediaContent>();          
	        }
	        contenidos.add(contenido);
	        contenido.setIssue(this);
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
    	if (obj == this) return true;
    	if (obj == null) return false;            
    	if ( !(obj instanceof Tag) ) return false;
        Tag t = (Tag) obj;
        return t.getId().equals(this.getId());        
    }
	
}