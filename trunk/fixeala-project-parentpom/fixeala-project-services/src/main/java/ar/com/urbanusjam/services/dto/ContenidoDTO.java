package ar.com.urbanusjam.services.dto;

import java.io.InputStream;
import java.io.Serializable;


public class ContenidoDTO implements Serializable {

	private static final long serialVersionUID = 1500359499775427609L;

	private Long id;	
    private Integer alto;
    private Integer ancho;
    private String extension;    
    private String nombre;  
    private String nombreConExtension;    
    private String nroReclamo;   
    private String pathRelativo;
    private InputStream inputStream;
	

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getExtension() {
		return extension;
	}

	public void setExtension(String extension) {
		this.extension = extension;
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

	public String getPathRelativo() {
		return pathRelativo;
	}

	public void setPathRelativo(String pathRelativo) {
		this.pathRelativo = pathRelativo;
	}
	

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getNombreConExtension() {
		return nombreConExtension;
	}

	public void setNombreConExtension(String nombreConExtension) {
		this.nombreConExtension = nombreConExtension;
	}

	public String getNroReclamo() {
		return nroReclamo;
	}

	public void setNroReclamo(String nroReclamo) {
		this.nroReclamo = nroReclamo;
	}	

	public InputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	@Override
	public boolean equals(Object other) {
		
	    if (other == null) return false;
	    if (other == this) return true;
	    if (!(other instanceof ContenidoDTO))return false;
	    ContenidoDTO otherMyClass = (ContenidoDTO)other;
		
	    return otherMyClass.getId().equals(this.getId()); 
	}

}
