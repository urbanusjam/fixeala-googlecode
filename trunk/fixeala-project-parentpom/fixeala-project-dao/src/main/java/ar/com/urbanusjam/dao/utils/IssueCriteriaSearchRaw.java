package ar.com.urbanusjam.dao.utils;

import java.io.Serializable;
import java.util.Calendar;



public class IssueCriteriaSearchRaw implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String provincia;
	private String ciudad;
	private String barrio;
	private String[] tagsArray;
	private String[] estadosArray;	
	private Calendar minFechaFormateada;	
	private Calendar maxFechaFormateada;	
	private String sortField;
	private String sortDirection;
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
	public String[] getTagsArray() {
		return tagsArray;
	}
	public void setTagsArray(String[] tagsArray) {
		this.tagsArray = tagsArray;
	}
	
	public String[] getEstadosArray() {
		return estadosArray;
	}
	public void setEstadosArray(String[] estadosArray) {
		this.estadosArray = estadosArray;
	}
	
	public Calendar getMinFechaFormateada() {
		return minFechaFormateada;
	}
	public void setMinFechaFormateada(Calendar minFechaFormateada) {
		this.minFechaFormateada = minFechaFormateada;
	}
	
	public Calendar getMaxFechaFormateada() {
		return maxFechaFormateada;
	}
	public void setMaxFechaFormateada(Calendar maxFechaFormateada) {
		this.maxFechaFormateada = maxFechaFormateada;
	}
	
	public String getSortField() {
		return sortField;
	}
	public void setSortField(String sortField) {
		this.sortField = sortField;
	}
	public String getSortDirection() {
		return sortDirection;
	}
	public void setSortDirection(String sortDirection) {
		this.sortDirection = sortDirection;
	}
	public String getFormatoArchivo() {
		return formatoArchivo;
	}
	public void setFormatoArchivo(String formatoArchivo) {
		this.formatoArchivo = formatoArchivo;
	}
	
	


}
