package ar.com.urbanusjam.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

public class Issue implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Long id;
	private UserOriginal reporter;
	private Integer issueID;
	private Date date;
	private String title;
	private String description;
	private String address;
	private String neighborhood;
	private String city;
	private String province;
	private float latitude;
	private float longitude;
	private String status;
	private List<String> tags;
	private List<Content> content;
	private List<Revision> revisions;
	private List<Comment> comments;
	private List<PointRecord> pointRecord;
	
		
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public UserOriginal getReporter() {
		return reporter;
	}
	
	public void setReporter(UserOriginal reporter) {
		this.reporter = reporter;
	}
	
	public Integer getIssueID() {
		return issueID;
	}
	
	public void setIssueID(Integer issueID) {
		this.issueID = issueID;
	}
	
	public Date getDate() {
		return date;
	}
	
	public void setDate(Date date) {
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
	
	public List<String> getTags() {
		return tags;
	}
	
	public void setTags(List<String> tags) {
		this.tags = tags;
	}
	
	public List<Content> getContent() {
		return content;
	}
	
	public void setContent(List<Content> content) {
		this.content = content;
	}
	
	public List<Revision> getRevisions() {
		return revisions;
	}
	
	public void setRevisions(List<Revision> revisions) {
		this.revisions = revisions;
	}
	
	public List<Comment> getComments() {
		return comments;
	}
	
	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public List<PointRecord> getPointRecord() {
		return pointRecord;
	}

	public void setPointRecord(List<PointRecord> pointRecord) {
		this.pointRecord = pointRecord;
	}
	
	
	

}
