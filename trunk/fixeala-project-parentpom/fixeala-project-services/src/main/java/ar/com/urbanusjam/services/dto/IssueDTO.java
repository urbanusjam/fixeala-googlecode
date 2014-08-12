package ar.com.urbanusjam.services.dto;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

import ar.com.urbanusjam.services.utils.DateUtils;


@XmlRootElement(name = "reclamo")
public class IssueDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	public  UserDTO user;
	public  String username;
	public  String id;
	public  String address;
	public  String neighborhood;
	public  String city;
	public  String province;
	public  String latitude;
	public  String longitude;
	public  String title;
	public  String titleCss;
	public  String parsedTitle;
	public  String description;
	public  Date creationDate;	
	public  Date lastUpdateDate;	
	public  String area;
	
	@XmlTransient
	private AreaDTO assignedArea;
	
	@XmlTransient
	private UserDTO assignedOfficial;
	
	@XmlTransient
	private IssueRepairDTO licitacion = new IssueRepairDTO();
	
	@XmlTransient
	private List<String> tags = new ArrayList<String>();
	
	@XmlTransient
	private Map<String, Object> tagsMap = new HashMap<String, Object>();
	
	@XmlTransient
	private List<IssueUpdateHistoryDTO> historial = new ArrayList<IssueUpdateHistoryDTO>();
	
	@XmlTransient
	private List<MediaContentDTO> contenidos = new ArrayList<MediaContentDTO>();
	
	@XmlTransient
	private List<CommentDTO> comentarios = new ArrayList<CommentDTO>();	
	
	@XmlTransient
	private List<IssueFollowDTO> followers = new ArrayList<IssueFollowDTO>();
	
	@XmlTransient
	private List<IssueVoteDTO> votes = new ArrayList<IssueVoteDTO>();
	public  Long totalVotes;
	public  int totalFollowers;
	public  int totalViews;
	public  String status;
	public  String statusCss;	
	public  String resolution;
	
	@XmlTransient
	private String fechaFormateada;
	
	@XmlTransient
	private String fechaFormateadaCompleta;
	
	@XmlTransient
	private String fullAddress;
	
	@XmlTransient
	private MediaContentDTO uploadedFile;	
	

	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public UserDTO getUser() {
		return user;
	}
	
	public void setUser(UserDTO user) {
		this.user = user;
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

	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
		
	public String getTitleCss() {
		return titleCss;
	}

	public void setTitleCss(String titleCss) {
		this.titleCss = titleCss;
	}

	public String getDescription() {
		return description;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public AreaDTO getAssignedArea() {
		return assignedArea;
	}

	public void setAssignedArea(AreaDTO assignedArea) {
		this.assignedArea = assignedArea;
	}
	
	public UserDTO getAssignedOfficial() {
		return assignedOfficial;
	}

	public void setAssignedOfficial(UserDTO assignedOfficial) {
		this.assignedOfficial = assignedOfficial;
	}

	public IssueRepairDTO getLicitacion() {
		return licitacion;
	}

	public void setLicitacion(IssueRepairDTO licitacion) {
		this.licitacion = licitacion;
	}
	
	public List<String> getTags() {
		return tags;
	}
	
	public void setTags(List<String> tags) {
		this.tags = tags;
	}
	
	public Map<String, Object> getTagsMap() {
		return tagsMap;
	}

	public void setTagsMap(Map<String, Object> tagsMap) {
		this.tagsMap = tagsMap;
	}

	public List<IssueUpdateHistoryDTO> getHistorial() {
		return historial;
	}

	public void setHistorial(List<IssueUpdateHistoryDTO> historial) {
		this.historial = historial;
	}
		
	public List<IssueVoteDTO> getVotes() {
		return votes;
	}

	public void setVotes(List<IssueVoteDTO> votes) {
		this.votes = votes;
	}
	
	public int getTotalFollowers() {
		return totalFollowers;
	}

	public void setTotalFollowers(int totalFollowers) {
		this.totalFollowers = totalFollowers;
	}

	public Long getTotalVotes() {
		return totalVotes;
	}

	public void setTotalVotes(Long totalVotes) {
		this.totalVotes = totalVotes;
	}
	
	public int getTotalViews() {
		return totalViews;
	}

	public void setTotalViews(int totalViews) {
		this.totalViews = totalViews;
	}

	public List<MediaContentDTO> getContenidos() {
		return contenidos;
	}

	public void setContenidos(List<MediaContentDTO> contenidos) {
		this.contenidos = contenidos;
	}

	public List<CommentDTO> getComentarios() {
		return comentarios;
	}

	public void setComentarios(List<CommentDTO> comentarios) {
		this.comentarios = comentarios;
	}

	public Date getCreationDate() {
		return creationDate;
	}

	public void setCreationDate(Date creationDate) {
		this.creationDate = creationDate;
	}

	public Date getLastUpdateDate() {
		return lastUpdateDate;
	}

	public void setLastUpdateDate(Date lastUpdateDate) {
		this.lastUpdateDate = lastUpdateDate;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getStatusCss() {
		return statusCss;
	}

	public void setStatusCss(String statusCss) {
		this.statusCss = statusCss;
	}
	
	public String getResolution() {
		return resolution;
	}

	public void setResolution(String resolution) {
		this.resolution = resolution;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getFechaFormateada() {
		return fechaFormateada;
	}

	public void setFechaFormateada(Date date) {
		this.fechaFormateada = this.getFormattedDate(date, DateUtils.DATE_TIME_PATTERN_SHORT);
	}
	
	public String getFechaFormateadaCompleta() {
		return fechaFormateadaCompleta;
	}
	
	public void setFechaFormateadaCompleta(Date date) {
		this.fechaFormateadaCompleta = this.getFormattedDate(date, DateUtils.DATE_TIME_PATTERN_LONG);
	}
	
	public String getFullAddress(){		
		return address + ", " + city + ", " + province;	
	}

	public void setFullAddress(String fullAddress) {
		this.fullAddress = fullAddress;
	}

	public List<IssueFollowDTO> getFollowers() {
		return followers;
	}

	public void setFollowers(List<IssueFollowDTO> followers) {
		this.followers = followers;
	}

	public String getFormattedDate(Date date, String pattern){				
		String formattedDate = "";	
		Locale.setDefault(new Locale("es", "AR"));
        SimpleDateFormat formatter = new SimpleDateFormat(pattern, Locale.getDefault());
        formattedDate = formatter.format(date).toUpperCase();    
        return formattedDate;	
	}
		
	public String getParsedTitle() {	
		return 	title.replaceAll("\\s", "-").toLowerCase();	
	}

	public void setParsedTitle(String parsedTitle) {
		this.parsedTitle = parsedTitle;
	}

	public MediaContentDTO getUploadedFile() {
		return uploadedFile;
	}

	public void setUploadedFile(MediaContentDTO uploadedFile) {
		this.uploadedFile = uploadedFile;
	}
	
	public String getCategorias(){
		
	  StringBuilder result = new StringBuilder();
	    for(String categoria : this.tags) {
	        result.append(categoria);
	        result.append(",");
	    }
	    return result.length() > 0 ? result.substring(0, result.length() - 1): "";
	}
	
}
