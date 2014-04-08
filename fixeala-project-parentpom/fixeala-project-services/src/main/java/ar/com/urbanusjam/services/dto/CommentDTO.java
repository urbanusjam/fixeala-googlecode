package ar.com.urbanusjam.services.dto;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

public class CommentDTO implements Serializable {

	private static final long serialVersionUID = 1573529409509170425L;
	
	private String nroReclamo;
	private String usuario;
	private String mensaje;	
	private Date fecha;
	private String fechaFormateada;
	private boolean denunciado;
	
	public String getNroReclamo() {
		return nroReclamo;
	}
	
	public void setNroReclamo(String nroReclamo) {
		this.nroReclamo = nroReclamo;
	}
		
	public String getUsuario() {
		return usuario;
	}

	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

	public String getMensaje() {
		return mensaje;
	}
	
	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}
	
	public Date getFecha() {
		return fecha;
	}
	
	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}
		
	public String getFechaFormateada() {
		return fechaFormateada;
	}

	public void setFechaFormateada(Date fecha) {
		this.fechaFormateada = this.getFormattedDate(fecha);
	}

	public boolean isDenunciado() {
		return denunciado;
	}
	
	public void setDenunciado(boolean denunciado) {
		this.denunciado = denunciado;
	}
	
	public String getFormattedDate(Date date){				
		String formattedDate = "";
		Date d = date;		
        SimpleDateFormat df = new SimpleDateFormat();
        df.applyPattern("dd/MM/yyyy HH:mm");
        formattedDate = df.format(d.getTime());
        return formattedDate;	
	}

	
	
		
}
