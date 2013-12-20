package ar.com.urbanusjam.dao.utils;

import java.util.Date;

public class CriteriaSearch {

	private String provincia;
	private String ciudad;
	private String barrio;
	private String[] tags;
	private String[] estado;
	private Date minFecha;
	private Date maxFecha;
	private String orden;
	private String formatoArchivo;
	
	public String getProvincia() {
		return provincia;
	}
	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}
	public String getCiudad() {
		return ciudad;
	}
	public void setCiudad(String ciudad) {
		this.ciudad = ciudad;
	}
	public String getBarrio() {
		return barrio;
	}
	public void setBarrio(String barrio) {
		this.barrio = barrio;
	}
	public String[] getTags() {
		return tags;
	}
	public void setTags(String[] tags) {
		this.tags = tags;
	}
	public String[] getEstado() {
		return estado;
	}
	public void setEstado(String[] estado) {
		this.estado = estado;
	}
	public Date getMinFecha() {
		return minFecha;
	}
	public void setMinFecha(Date minFecha) {
		this.minFecha = minFecha;
	}
	public Date getMaxFecha() {
		return maxFecha;
	}
	public void setMaxFecha(Date maxFecha) {
		this.maxFecha = maxFecha;
	}
	public String getOrden() {
		return orden;
	}
	public void setOrden(String orden) {
		this.orden = orden;
	}
	public String getFormatoArchivo() {
		return formatoArchivo;
	}
	public void setFormatoArchivo(String formatoArchivo) {
		this.formatoArchivo = formatoArchivo;
	}	
	
	

}
