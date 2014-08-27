package ar.com.urbanusjam.web.domain.api;

import java.util.Collection;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElementWrapper;
import javax.xml.bind.annotation.XmlRootElement;


@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name="fixeala")
public class ReclamoListaResponse {
	
	@XmlElementWrapper(name="reclamos",nillable=false, required=true)
	@XmlElement(name="reclamo") 
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
