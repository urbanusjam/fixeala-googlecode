package ar.com.urbanusjam.services.dto;

import java.io.Serializable;
import java.util.Date;

import ar.com.urbanusjam.services.utils.DateUtils;

public class IssueHistoryDTO extends IssueMainActionDTO implements Serializable {
	
	private static final long serialVersionUID = 3825783987489912575L;
	
	private String fechaFormateada;		
	private String observaciones;
	private String operacion;
	private String motivo;
	private String estado;
	private String resolucion;
	private String detalle;
		
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
	
	public String getResolucion() {
		return resolucion;
	}

	public void setResolucion(String resolucion) {
		this.resolucion = resolucion;
	}	

	public String getDetalle() {
		return detalle;
	}

	public void setDetalle(String detalle) {
		this.detalle = detalle;
	}
	
	public void setFechaFormateada(Date date) {
		this.fechaFormateada = DateUtils.getFechaFormateada(date, DateUtils.DATE_TIME_PATTERN_SHORT);
	}
	
	public String getFechaFormateada() {
		return fechaFormateada;
	}
	
}
