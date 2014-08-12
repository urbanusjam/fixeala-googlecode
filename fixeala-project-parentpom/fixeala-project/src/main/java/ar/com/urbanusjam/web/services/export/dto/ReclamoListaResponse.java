package ar.com.urbanusjam.web.services.export.dto;

import java.util.Collection;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonRootName;


@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name="fixeala")
@JsonAutoDetect
@JsonRootName(value = "fixeala")  
public class ReclamoListaResponse {
	
	@XmlElementWrapper(name="reclamos",nillable=false, required=true)
	@XmlElement(name="reclamo") 
	@JsonProperty("reclamos")
	private Collection<ReclamoResponse> reclamo;
	
	public ReclamoListaResponse(){}
	
	public ReclamoListaResponse(Collection<ReclamoResponse> reclamo){
		this.reclamo = reclamo;
	}

	
	public Collection<ReclamoResponse> getReclamo() {
		return reclamo;
	}

	public void setReclamo(Collection<ReclamoResponse> reclamo) {
		this.reclamo = reclamo;
	}


	
	

}
