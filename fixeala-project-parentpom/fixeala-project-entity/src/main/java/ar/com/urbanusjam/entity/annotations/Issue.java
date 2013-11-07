package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.GregorianCalendar;
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
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.annotations.LazyToOne;
import org.hibernate.annotations.LazyToOneOption;
import org.hibernate.bytecode.javassist.FieldHandled;
import org.hibernate.bytecode.javassist.FieldHandler;



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
	
	@ManyToMany(cascade = CascadeType.ALL)
	@JoinTable(name = "ISSUE_TAG",
	         joinColumns = @JoinColumn(name = "ID_ISSUE"),
	         inverseJoinColumns = @JoinColumn(name = "ID_TAG")
	)
	private Collection<Tag> tagsList;
	
	
	@OneToMany(mappedBy="issue", fetch = FetchType.EAGER, cascade = CascadeType.ALL)  
	private Set<Contenido> contenidos;
	
//	@OneToMany(mappedBy = "issue")  
//	private Collection<Comment> comments;

	
	public Issue(){   
		tagsList = new ArrayList<Tag>(); 
		revisiones = new HashSet<IssueHistorialRevision>();
	}	
		
	
	public Issue(User reporter, GregorianCalendar date, String address, float latitude,
			float longitude, String neighborhood, String city, String province, String title,
			String description, Collection<Tag> tagsList) {
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

	public Collection<Tag> getTagsList() {
		return tagsList;
	}

	public void setTagsList(Collection<Tag> tagsList) {
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
	
	
//
//	public Collection<Comment> getComments() {
//		return comments;
//	}
//
//	public void setComments(Collection<Comment> comments) {
//		this.comments = comments;
//	}
//
//	public void setComments(List<Comment> comments) {
//		this.comments = comments;
//	}

	public void addTag(Tag tag) {	
			if (!getTagsList().contains(tag)) {
				getTagsList().add(tag);
			}
		    if (!tag.getIssueList().contains(this)) {
		        tag.getIssueList().add(this);
		    }			
	}
	
	
	public void addRevision(IssueHistorialRevision revision) {	
		if (!getRevisiones().contains(revision)) {
			getRevisiones().add(revision);
		}
	}

	
}
