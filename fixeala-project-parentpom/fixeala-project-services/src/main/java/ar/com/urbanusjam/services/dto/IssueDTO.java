package ar.com.urbanusjam.services.dto;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.xml.bind.annotation.XmlRootElement;


@XmlRootElement(name = "issue")
public class IssueDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private UserDTO user;
	private String username;
	private String id;
	private String address;
	private String neighborhood;
	private String city;
	private String province;
	private String latitude;
	private String longitude;
	private String title;
	private String description;
	private Date date;	
	private String area;
	private AreaDTO assignedArea;
	private UserDTO assignedOfficial;
	private IssueLicitacionDTO licitacion = new IssueLicitacionDTO();
	private List<String> tags = new ArrayList<String>();
	private List<IssueHistorialRevisionDTO> historial = new ArrayList<IssueHistorialRevisionDTO>();
	private List<ContenidoDTO> contenidos = new ArrayList<ContenidoDTO>();
	private List<CommentDTO> comentarios = new ArrayList<CommentDTO>();	
	private String status;
	private String statusCss;
	



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

	public IssueLicitacionDTO getLicitacion() {
		return licitacion;
	}

	public void setLicitacion(IssueLicitacionDTO licitacion) {
		this.licitacion = licitacion;
	}
	
	public List<String> getTags() {
		return tags;
	}
	
	public void setTags(List<String> tags) {
		this.tags = tags;
	}

	public List<IssueHistorialRevisionDTO> getHistorial() {
		return historial;
	}

	public void setHistorial(List<IssueHistorialRevisionDTO> historial) {
		this.historial = historial;
	}
		
	public List<ContenidoDTO> getContenidos() {
		return contenidos;
	}

	public void setContenidos(List<ContenidoDTO> contenidos) {
		this.contenidos = contenidos;
	}

	public List<CommentDTO> getComentarios() {
		return comentarios;
	}

	public void setComentarios(List<CommentDTO> comentarios) {
		this.comentarios = comentarios;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
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

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}


	public String getFormattedDate(){		
		
		String formattedDate = "";
		
//		Date d = this.getDate().getTime();		
		Date d = this.getDate();		
        SimpleDateFormat df = new SimpleDateFormat();
        df.applyPattern("dd/MM/yyyy");
        formattedDate = df.format(d.getTime());
        return formattedDate;	
	}
	
		
	public String getFormattedAddress(){
		
		String formattedAddress = "";
		
		if( !neighborhood.isEmpty() && !city.isEmpty() ) {		
			formattedAddress = address + ", " + neighborhood + ", " + city + ", " + province;		
		}
		
		else if( neighborhood.isEmpty() && city.isEmpty() ) {
			formattedAddress = address + ", " + province;		
		}	
		
		else if ( neighborhood.isEmpty() && !city.isEmpty() ) {		
			formattedAddress = address + ", " + city + ", " + province;	
		}	
		
		return formattedAddress;
	}
	
}
