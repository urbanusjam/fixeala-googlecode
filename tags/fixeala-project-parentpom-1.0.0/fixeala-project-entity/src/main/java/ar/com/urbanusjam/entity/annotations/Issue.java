package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;
import java.util.GregorianCalendar;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import javax.persistence.Cacheable;
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
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.OrderBy;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;

import org.hibernate.annotations.Cascade;

@Cacheable
@Entity
@Table(name="issue")
public class Issue implements Serializable  {

	private static final long serialVersionUID = 1L;

	@Id
    @GeneratedValue(strategy = GenerationType.AUTO)
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
	private String resolution;
	
	@Column(name = "status")
	private String status;
	
    @OneToMany(mappedBy="issue", fetch = FetchType.LAZY)  
    @Cascade({org.hibernate.annotations.CascadeType.SAVE_UPDATE, org.hibernate.annotations.CascadeType.ALL})	
    @OrderBy("fecha DESC")
	private Set<IssueHistory> revisiones;

	@OneToOne(fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	@PrimaryKeyJoinColumn  
	private IssueRepair reparacion;
	
	@ManyToMany(fetch = FetchType.LAZY) //owner side
    @Cascade({org.hibernate.annotations.CascadeType.SAVE_UPDATE, org.hibernate.annotations.CascadeType.ALL})	
	@JoinTable(name = "issue_tag", 
	         joinColumns = @JoinColumn(name = "id_issue"),
	         inverseJoinColumns = @JoinColumn(name = "id_tag") 
	)
	private Set<Tag> tagsList;	
	
	@OneToMany(mappedBy="issue", fetch = FetchType.LAZY, cascade = CascadeType.ALL)  
	private Set<MediaContent> contenidos;
	
	@OneToMany(mappedBy="issue", fetch = FetchType.LAZY, cascade = CascadeType.ALL)  
	private Set<Comment> comentarios;
	
	@OneToMany(mappedBy="issue", fetch = FetchType.LAZY, cascade = CascadeType.ALL) 
	private Set<IssueVote> votes;
	
	@OneToMany(mappedBy="issue", fetch = FetchType.LAZY) 
	private Set<IssueFollow> followers;
	
//	@OneToMany(mappedBy="issue", fetch = FetchType.LAZY) 
//	private Set<IssuePageView> pageviews;
	
	@OneToMany(mappedBy="issue", fetch = FetchType.LAZY) 
	@Cascade({org.hibernate.annotations.CascadeType.SAVE_UPDATE, org.hibernate.annotations.CascadeType.ALL})	
	private Set<IssueVerification> verificationRequests;

	
	public Issue(){   
		tagsList = new HashSet<Tag>(); 
		revisiones = new HashSet<IssueHistory>();
		contenidos = new HashSet<MediaContent>();
		comentarios = new HashSet<Comment>();
		votes = new HashSet<IssueVote>();
		followers = new HashSet<IssueFollow>();
		verificationRequests = new HashSet<IssueVerification>();
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
		
	public String getPriority() {
		return priority;
	}

	public void setPriority(String priority) {
		this.priority = priority;
	}

	public String getResolution() {
		return resolution;
	}

	public void setResolution(String resolution) {
		this.resolution = resolution;
	}
	
	public Set<Tag> getTagsList() {
		return tagsList;
	}

	public void setTagsList(Set<Tag> tagsList) {
		this.tagsList = tagsList;
	}
		
	public Set<IssueHistory> getRevisiones() {
		return revisiones;
	}

	public void setRevisiones(Set<IssueHistory> revisiones) {
		this.revisiones = revisiones;
	}
	
	public IssueRepair getReparacion() {
		return reparacion;
	}

	public void setReparacion(IssueRepair reparacion) {
		this.reparacion = reparacion;
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
	
	public Set<IssueVote> getVotes() {
		return votes;
	}

	public void setVotes(Set<IssueVote> votes) {
		this.votes = votes;
	}

	public Set<IssueFollow> getFollowers() {
		return followers;
	}

	public void setFollowers(Set<IssueFollow> followers) {
		this.followers = followers;
	}
	
	

	public Set<IssueVerification> getVerificationRequests() {
		return verificationRequests;
	}


	public void setVerificationRequests(Set<IssueVerification> verificationRequests) {
		this.verificationRequests = verificationRequests;
	}


	public void addTag(Tag tag) {	
		if (tag != null) {
	        if (tagsList == null) {
	        	tagsList = new HashSet<Tag>();          
	        }
	        tagsList.add(tag);
	     }
//		if (!getTagsList().contains(tag)) {
//			getTagsList().add(tag);
//		}
//	    if (!tag.getIssueList().contains(this)) {
//	        tag.getIssueList().add(this);
//	    }			
	}	
	
	public void removeTag(Tag tag) {	
		if (getTagsList().contains(tag)) {
			getTagsList().remove(tag);
		}
	    if (tag.getIssueList().contains(this)) {
	        tag.getIssueList().remove(this);
	    }			
	}	
	
	public void addVote(IssueVote vote) {		
		if (vote != null) {
	        if (votes == null) {
	        	votes = new HashSet<IssueVote>();          
	        }
	        votes.add(vote);
	        vote.setIssue(this);
	     }			
	}
	
	public void addRevision(IssueHistory update) {		
		if (update != null) {
	        if (revisiones == null) {
	        	revisiones = new HashSet<IssueHistory>();          
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
	
	public void addFollower(IssueFollow follower) {		
		if (follower != null) {
	        if (followers == null) {
	        	followers = new HashSet<IssueFollow>();          
	        }
	        followers.add(follower);
	        follower.setIssue(this);
	     }			
	}
	
	public void removeFollower(IssueFollow follower) {	
		if (getFollowers().contains(follower)) {
			getFollowers().remove(follower);
		}	   		
	}
	
	public void addVerificationRequest(IssueVerification verification) {	
		if (verification != null) {
	        if (verificationRequests == null) {
	        	verificationRequests = new HashSet<IssueVerification>();          
	        }
	        verificationRequests.add(verification);
	     }		
	}
	
	public Set<IssueVerification> getVerificacionesPositivas(Set<IssueVerification> solicitudes){
		
		Iterator it = solicitudes.iterator();
		Set<IssueVerification> positivas = new HashSet<IssueVerification>();      
		
		while(it.hasNext()){
			IssueVerification element = (IssueVerification) it.next();
			if(element.isVerified())
				positivas.add(element);
		}
		
		return positivas;
		
	}
	
	public Set<IssueVerification> getVerificacionesNegativas(Set<IssueVerification> solicitudes){
		
		Iterator it = solicitudes.iterator();
		Set<IssueVerification> negativas = new HashSet<IssueVerification>();      
		
		while(it.hasNext()){
			IssueVerification element = (IssueVerification) it.next();
			if(!element.isVerified())
				negativas.add(element);
		}
		
		return negativas;
		
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