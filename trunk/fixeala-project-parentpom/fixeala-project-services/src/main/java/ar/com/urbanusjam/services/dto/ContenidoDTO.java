package ar.com.urbanusjam.services.dto;

import java.io.Serializable;


public class ContenidoDTO implements Serializable {

	private static final long serialVersionUID = 1500359499775427609L;

	private Long id;
	private String tipo;    
    private Integer alto;
    private Integer ancho;
    private String pathRelativo;
    private String url;
    private String nombre;  
    private String nombreFileSystem;    
    private String nombreFileSystemExtension;
    
	

	public Long getId() {
		return id;
	}



	public void setId(Long id) {
		this.id = id;
	}



	public String getTipo() {
		return tipo;
	}



	public void setTipo(String tipo) {
		this.tipo = tipo;
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



	public String getUrl() {
		return url;
	}



	public void setUrl(String url) {
		this.url = url;
	}



	public String getNombre() {
		return nombre;
	}



	public void setNombre(String nombre) {
		this.nombre = nombre;
	}



	public String getNombreFileSystem() {
		return nombreFileSystem;
	}



	public void setNombreFileSystem(String nombreFileSystem) {
		this.nombreFileSystem = nombreFileSystem;
	}



	public String getNombreFileSystemExtension() {
		return nombreFileSystemExtension;
	}



	public void setNombreFileSystemExtension(String nombreFileSystemExtension) {
		this.nombreFileSystemExtension = nombreFileSystemExtension;
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
