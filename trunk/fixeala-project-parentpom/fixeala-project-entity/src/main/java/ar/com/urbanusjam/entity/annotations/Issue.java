package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.GregorianCalendar;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;



@Entity
@Table(name="ISSUES")
public class Issue implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "ID_ISSUE")
	private Long id;
	
	@OneToOne
	@JoinColumn(name = "USERNAME")
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
	
	
	@ManyToMany(cascade = CascadeType.ALL)
	@JoinTable(name = "ISSUES_TAGS",
	         joinColumns = @JoinColumn(name = "ID_ISSUE"),
	         inverseJoinColumns = @JoinColumn(name = "ID_TAG")
	)
	private Collection<Tag> tagsList;
	
	@Column(name = "STATUS")
	private String status;
	
//	private Integer views;
//	private Integer votes;	
//	private List<Content> content;
//	private List<Revision> revisions;
//	private List<Comment> comments;
//	private List<PointRecord> pointRecord;
	
	public Issue(){   tagsList = new ArrayList<Tag>(); }	
		
	
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

	public Collection<Tag> getTagsList() {
		return tagsList;
	}

	public void setTagsList(Collection<Tag> tagsList) {
		this.tagsList = tagsList;
	}
	
	public void addTag(Tag tag) {	
			if (!getTagsList().contains(tag)) {
				getTagsList().add(tag);
			}
		    if (!tag.getIssueList().contains(this)) {
		        tag.getIssueList().add(this);
		    }		
		
	}
		
	
}
