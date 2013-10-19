package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="AREA")
public class Area implements Serializable {

	private static final long serialVersionUID = -7285598176392005222L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "ID_AREA")
	private Long id;

	@Column(name = "NAME")
	private String nombre;
	
	@Column(name = "ACRONYM")
	private String sigla;
	
	@Column(name = "PROVINCE")
	private String provincia;
	
	@Column(name = "PROVINCE_ACRONYM")
	private String provinciaSigla;
	
	@Column(name = "CITY")
	private String ciudad;
	
	@Column(name = "CITY_ACRONYM")
	private String ciudadSigla;
	
	
	public Area() { }
	

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getSigla() {
		return sigla;
	}

	public void setSigla(String sigla) {
		this.sigla = sigla;
	}

	public String getProvincia() {
		return provincia;
	}

	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}

	public String getProvinciaSigla() {
		return provinciaSigla;
	}

	public void setProvinciaSigla(String provinciaSigla) {
		this.provinciaSigla = provinciaSigla;
	}

	public String getCiudad() {
		return ciudad;
	}

	public void setCiudad(String ciudad) {
		this.ciudad = ciudad;
	}


	public String getCiudadSigla() {
		return ciudadSigla;
	}


	public void setCiudadSigla(String ciudadSigla) {
		this.ciudadSigla = ciudadSigla;
	}

	

}
