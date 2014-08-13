package ar.com.urbanusjam.web.services.export.dto;


import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.JsonRootName;

@JsonAutoDetect
@JsonRootName(value = "reclamos")  
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name="fixeala")
public class ReclamoResponse {
	
	@XmlElement(name="id")
	private String nroReclamo;
	
	@XmlElement(name="fecha")
	private String fecha;	
	
	@XmlElement(name="categoria")
	private String categoria;
	
	@XmlElement(name="titulo")
	private String titulo;		
	
	@XmlElement(name="direccion")
	private String direccion;
	
	@XmlElement(name="barrio")
	private String barrio;	
	
	@XmlElement(name="ciudad")	
	private String ciudad;	
	
	@XmlElement(name="provincia")	
	private String provincia;	
	
	@XmlElement(name="latitud")	
	private String latitud;	
	
	@XmlElement(name="longitud")	
	private String longitud;
	
	@XmlElement(name="estado")	
	private String estado;		
	
	
	public String getNroReclamo() {
		return nroReclamo;
	}
	
	public void setNroReclamo(String nroReclamo) {
		this.nroReclamo = nroReclamo;
	}	
	
	public String getFecha() {
		return fecha;
	}
	
	public void setFecha(String fecha) {
		this.fecha = fecha;
	}
		
	public String getCategoria() {
		return categoria;
	}

	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}
		
	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}
	
	
	public String getDireccion() {
		return direccion;
	}
	
	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}
	
	
	public String getBarrio() {
		return barrio;
	}
	
	public void setBarrio(String barrio) {
		this.barrio = barrio;
	}
	
	
	public String getCiudad() {
		return ciudad;
	}
	
	public void setCiudad(String ciudad) {
		this.ciudad = ciudad;
	}		
	
	public String getProvincia() {
		return provincia;
	}
	
	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}
	
	public String getLatitud() {
		return latitud;
	}
	
	public void setLatitud(String latitud) {
		this.latitud = latitud;
	}

	public String getLongitud() {
		return longitud;
	}
	
	public void setLongitud(String longitud) {
		this.longitud = longitud;
	}
	
	public String getEstado() {
		return estado;
	}
	
	public void setEstado(String estado) {
		this.estado = estado;
	}
		
}
