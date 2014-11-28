package ar.com.urbanusjam.web.forms;

import java.io.Serializable;
import java.util.List;

public class IssueForm implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String address;
	private String neighborhood;
	private String comuna;
	private String title;
	private String description;
	private String file;
	private List<String> tags;
	
	
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

	public String getComuna() {
		return comuna;
	}
	
	public void setComuna(String comuna) {
		this.comuna = comuna;
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
	
	
	

}
