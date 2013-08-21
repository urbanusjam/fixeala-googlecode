package ar.com.urbanusjam.services.dto;

import java.io.Serializable;

public class TagDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String tagname;

	public String getTagname() {
		return tagname;
	}

	public void setTagname(String tagname) {
		this.tagname = tagname;
	}
	
	

}
