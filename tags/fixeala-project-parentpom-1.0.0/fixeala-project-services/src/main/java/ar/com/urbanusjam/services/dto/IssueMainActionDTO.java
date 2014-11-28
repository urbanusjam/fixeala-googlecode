package ar.com.urbanusjam.services.dto;

import java.io.Serializable;
import java.util.Date;

public abstract class IssueMainActionDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Long nroReclamo;
	private String username;
	private Date fecha;
	
	public IssueMainActionDTO(){}

	public Long getNroReclamo() {
		return nroReclamo;
	}

	public void setNroReclamo(Long nroReclamo) {
		this.nroReclamo = nroReclamo;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Date getFecha() {
		return fecha;
	}

	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}
	
}