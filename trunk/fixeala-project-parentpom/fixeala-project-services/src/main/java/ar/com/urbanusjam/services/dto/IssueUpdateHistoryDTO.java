package ar.com.urbanusjam.services.dto;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

public class IssueUpdateHistoryDTO implements Serializable {
	
	private static final long serialVersionUID = 3825783987489912575L;
	
	private Long nroReclamo;
	private String username;
	private Date fecha;	
	private String fechaFormateada;		
	private String observaciones;
	private String operacion;
	private String motivo;
	private String estado;
	private String resolucion;
	private String detalle;
	
	
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
	
	public Long getNroReclamo() {
		return nroReclamo;
	}

	public void setNroReclamo(Long nroReclamo) {
		this.nroReclamo = nroReclamo;
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

	public String getFechaFormateada(){	
		
		String formattedDate = "";	
		Date d = this.getFecha();		
        SimpleDateFormat df = new SimpleDateFormat();
//      df.applyPattern("dd/MM/yyyy hh:mm a");
        df.applyPattern("dd/MM/yyyy HH:mm");        
        formattedDate = df.format(d.getTime());
        return formattedDate;	
	}
	

}
