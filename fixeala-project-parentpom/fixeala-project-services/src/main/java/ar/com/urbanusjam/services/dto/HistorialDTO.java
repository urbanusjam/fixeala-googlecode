package ar.com.urbanusjam.services.dto;

import java.io.Serializable;
import java.util.Date;

public class HistorialDTO implements Serializable {
	
	private static final long serialVersionUID = 3825783987489912575L;
	
	private String reclamoID;
	private Date fecha;
	private String username;
	private String estado;
	private String motivo;
	private String observaciones;
	private String operacion;
	private String[] camposModificados;
	
		
	public String getReclamoID() {
		return reclamoID;
	}

	public void setReclamoID(String reclamoID) {
		this.reclamoID = reclamoID;
	}

	public Date getFecha() {
		return fecha;
	}
	
	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}
	
	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getEstado() {
		return estado;
	}
	
	public void setEstado(String estado) {
		this.estado = estado;
	}
	
	public String getMotivo() {
		return motivo;
	}
	
	public void setMotivo(String motivo) {
		this.motivo = motivo;
	}
	
	public String getObservaciones() {
		return observaciones;
	}
	
	public void setObservaciones(String observaciones) {
		this.observaciones = observaciones;
	}
		
	public String getOperacion() {
		return operacion;
	}

	public void setOperacion(String operacion) {
		this.operacion = operacion;
	}

	public String[] getCamposModificados() {
		return camposModificados;
	}

	public void setCamposModificados(String[] camposModificados) {
		this.camposModificados = camposModificados;
	}
	
	
	

}
