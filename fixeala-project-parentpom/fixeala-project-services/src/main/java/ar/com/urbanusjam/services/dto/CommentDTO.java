package ar.com.urbanusjam.services.dto;

import java.io.Serializable;
import java.util.Date;

import ar.com.urbanusjam.services.utils.DateUtils;

public class CommentDTO extends IssueMainActionDTO implements Serializable {

	private static final long serialVersionUID = 1573529409509170425L;

	private String mensaje;	
	private String fechaFormateada;
	private boolean denunciado;
	
	public String getMensaje() {
		return mensaje;
	}
	
	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}
			
	public String getFechaFormateada() {
		return fechaFormateada;
	}

	public void setFechaFormateada(Date fecha) {
		this.fechaFormateada = DateUtils.getFechaFormateada(fecha, DateUtils.DATE_TIME_PATTERN_SHORT);
	}

	public boolean isDenunciado() {
		return denunciado;
	}
	
	public void setDenunciado(boolean denunciado) {
		this.denunciado = denunciado;
	}
	
}
