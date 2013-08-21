package ar.com.urbanusjam.services.dto;

import java.io.Serializable;
import java.util.GregorianCalendar;
import java.util.List;

public class IssueDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private UserDTO user;
	private Long id;
	private String address;
	private String neighborhood;
	private String city;
	private String province;
	private float latitude;
	private float longitude;
	private String title;
	private String description;
	private String file;	
	private GregorianCalendar date;
	private List<String> tags;
	private String status;
	
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
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
	
	public void setNeighbourhood(String neighborhood) {
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
	
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	
	public List<String> getTags() {
		return tags;
	}
	
	public void setTags(List<String> tags) {
		this.tags = tags;
	}

	public GregorianCalendar getDate() {
		return date;
	}

	public void setDate(GregorianCalendar date) {
		this.date = date;
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

	public void setNeighborhood(String neighborhood) {
		this.neighborhood = neighborhood;
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
