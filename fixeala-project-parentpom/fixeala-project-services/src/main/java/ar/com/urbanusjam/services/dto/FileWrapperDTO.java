package ar.com.urbanusjam.services.dto;

import java.io.File;
import java.io.Serializable;


public class FileWrapperDTO implements Serializable {
  
	private static final long serialVersionUID = -2503702339105478315L;

	public FileWrapperDTO() {
		super();
	}

    private File file;
    private String tipoContenido;
    private Integer alto;
    private Integer ancho;

	public File getFile() {
		return file;
	}

	public void setFile(File file) {
		this.file = file;
	}

	public String getTipoContenido() {
		return tipoContenido;
	}

	public void setTipoContenido(String tipoContenido) {
		this.tipoContenido = tipoContenido;
	}

	public Integer getAlto() {
		return alto;
	}

	public void setAlto(Integer alto) {
		this.alto = alto;
	}

	public Integer getAncho() {
		return ancho;
	}

	public void setAncho(Integer ancho) {
		this.ancho = ancho;
	}
    
}
