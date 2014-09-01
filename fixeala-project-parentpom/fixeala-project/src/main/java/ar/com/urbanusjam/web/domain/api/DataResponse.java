package ar.com.urbanusjam.web.domain.api;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;


//@JsonAutoDetect
//@JsonRootName(value = "data") 
@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement
public class DataResponse {
	
	@XmlElement(name="id")
	private String id;
	
	@XmlElement(name="fecha")
	private String fecha;	
	
	@XmlElement(name="informante")
	private String informante;
	
	@XmlElement(name="titulo")
	private String titulo;		
	
	@XmlElement(name="descripcion")
	private String descripcion;
	
	@XmlElement(name="direccion")
	private String direccion;
	
	@XmlElement(name="barrio")
	private String barrio;	
	
	@XmlElement(name="ciudad")	
	private String ciudad;	
	
	@XmlElement(name="provincia")	
	private String provincia;	
	
	@XmlElement(name="latitud")	
	private float latitud;	
	
	@XmlElement(name="longitud")	
	private float longitud;
	
	@XmlElement(name="estado")	
	private String estado;	
	
	@XmlElement(name="comentarios")	
	private int comentarios;	
		
	@XmlElement(name="votos")	
	private Long votos;	
	
	@XmlElement(name="seguidores")	
	private int seguidores;	
	
	@XmlElement(name="link")	
	private String link;
	

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}

	public String getInformante() {
		return informante;
	}

	public void setInformante(String informante) {
		this.informante = informante;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
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

	public float getLatitud() {
		return latitud;
	}

	public void setLatitud(float latitud) {
		this.latitud = latitud;
	}

	public float getLongitud() {
		return longitud;
	}

	public void setLongitud(float longitud) {
		this.longitud = longitud;
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public int getComentarios() {
		return comentarios;
	}

	public void setComentarios(int comentarios) {
		this.comentarios = comentarios;
	}

	public Long getVotos() {
		return votos;
	}

	public void setVotos(Long votos) {
		this.votos = votos;
	}

	public int getSeguidores() {
		return seguidores;
	}

	public void setSeguidores(int seguidores) {
		this.seguidores = seguidores;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}	

	
}
