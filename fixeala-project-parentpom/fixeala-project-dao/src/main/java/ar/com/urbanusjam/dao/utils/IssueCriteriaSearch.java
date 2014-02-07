package ar.com.urbanusjam.dao.utils;

import java.util.Calendar;

public class IssueCriteriaSearch {

	private String provincia;
	private String ciudad;
	private String[] tags;
	private String[] estado;
	private Calendar minFecha;
	private Calendar maxFecha;	
	private String ordenField;
	private String orden;
	private String formatoArchivo;
	
	private String searchType;
	
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
	
	public Calendar getMinFecha() {
		return minFecha;
	}
	
	public void setMinFecha(Calendar minFecha) {
		this.minFecha = minFecha;
	}
	
	public Calendar getMaxFecha() {
		return maxFecha;
	}
	
	public void setMaxFecha(Calendar maxFecha) {
		this.maxFecha = maxFecha;
	}
			
	public String getOrdenField() {
		return ordenField;
	}
	
	public void setOrdenField(String ordenField) {
		this.ordenField = ordenField;
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
	
	public String getSearchType() {
		return searchType;
	}
	
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}	
	
	

}
