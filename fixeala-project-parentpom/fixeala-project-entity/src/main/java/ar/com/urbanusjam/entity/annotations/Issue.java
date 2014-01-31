package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;
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
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.annotations.Cascade;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;



@Entity
@Table(name="ISSUE")
public class Issue implements Serializable  {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "ID_ISSUE")
	private Long id;
	
	@OneToOne
	@JoinColumn(name = "ID_REPORTER")
	private User reporter;
	
	@Column(name = "REPORTED_DATE")
	private GregorianCalendar date;
	
	@Column(name = "ADDRESS")
	private String address;
	
	@Column(name = "LATITUDE")
	private float latitude;
	
	@Column(name = "LONGITUDE")
	private float longitude;
	
	@Column(name = "NEIGHBORHOOD")
	private String neighborhood;
	
	@Column(name = "CITY")
	private String city;
	
	@Column(name = "PROVINCE")
	private String province;
	
	@Column(name = "TITLE")
	private String title;
	
	@Column(name = "DESCRIPTION")
	private String description;
	
	@Column(name = "STATUS")
	private String status;
	
	@OneToOne
	@JoinColumn(name = "ID_ASSIGNED_OFFICIAL")
	private User assignedOfficial;
	
	@ManyToOne
	@JoinColumn(name = "ID_AREA")
	private Area assignedArea;
		
    @OneToMany(mappedBy="issue", fetch = FetchType.EAGER, cascade = CascadeType.ALL)  
	private Set<IssueHistorialRevision> revisiones;

	@OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@PrimaryKeyJoinColumn  
	private IssueLicitacion licitacion;

//	@ManyToMany(fetch = FetchType.EAGER, mappedBy="issueList") //inverse side
//	private Set<Tag> tagsList;	
	
	@ManyToMany(fetch = FetchType.EAGER) //owner side
    @Cascade({org.hibernate.annotations.CascadeType.SAVE_UPDATE, org.hibernate.annotations.CascadeType.ALL})	
	@JoinTable(name = "ISSUE_TAG", 
	         joinColumns = @JoinColumn(name = "ID_ISSUE"),
	         inverseJoinColumns = @JoinColumn(name = "ID_TAG") 
	)
	private Set<Tag> tagsList;	
	
	@OneToMany(mappedBy="issue", fetch = FetchType.EAGER, cascade = CascadeType.ALL)  
	private Set<Contenido> contenidos;
	
	@OneToMany(mappedBy="issue", fetch = FetchType.EAGER, cascade = CascadeType.ALL)  
	private Set<Comment> comentarios;

	
	public Issue(){   
		tagsList = new HashSet<Tag>(); 
		revisiones = new HashSet<IssueHistorialRevision>();
		contenidos = new HashSet<Contenido>();
		comentarios = new HashSet<Comment>();
	}	
		
	
	public Issue(User reporter, GregorianCalendar date, String address, float latitude,
			float longitude, String neighborhood, String city, String province, String title,
			String description, Set<Tag> tagsList) {
		super();
		this.reporter = reporter;
		this.date = date;
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
	

	public GregorianCalendar getDate() {
		return date;
	}

	public void setDate(GregorianCalendar date) {
		this.date = date;
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
		
	public Set<IssueHistorialRevision> getRevisiones() {
		return revisiones;
	}

	public void setRevisiones(Set<IssueHistorialRevision> revisiones) {
		this.revisiones = revisiones;
	}

	public IssueLicitacion getLicitacion() {
		return licitacion;
	}

	public void setLicitacion(IssueLicitacion licitacion) {
		this.licitacion = licitacion;
	}
	
	public Set<Contenido> getContenidos() {
		return contenidos;
	}


	public void setContenidos(Set<Contenido> contenidos) {
		this.contenidos = contenidos;
	}
	
	public Set<Comment> getComentarios() {
		return comentarios;
	}


	public void setComentarios(Set<Comment> comentarios) {
		this.comentarios = comentarios;
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
	
	public void addRevision(IssueHistorialRevision revision) {	
		if (!getRevisiones().contains(revision)) {
			getRevisiones().add(revision);
		}
	}
	
	public void addComment(Comment comment) {	
		if (!getComentarios().contains(comment)) {
			getComentarios().add(comment);
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