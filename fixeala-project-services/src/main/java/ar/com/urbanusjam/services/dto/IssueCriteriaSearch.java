package ar.com.urbanusjam.services.dto;

import java.io.Serializable;

import antlr.StringUtils;



public class IssueCriteriaSearch implements Serializable {

	private static final long serialVersionUID = 1L;
	private String provincia;
	private String ciudad;
	private String barrio;
	private String tags;
	private String estados;	
	private String minFecha;
	private String maxFecha;	
	private String orden;
	private String formatoArchivo;
	private int cantResultados;
	
	public IssueCriteriaSearch(){
		this.tags = "";
		this.estados = "";
	}
	
	
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
	
	public String getTags() {
		return tags;
	}
	
	public void setTags(String tags) {
		this.tags = tags;
	}
	
	public String getEstados() {
		return estados;
	}
	
	public void setEstados(String estados) {
		this.estados = estados;
	}

	public String getMinFecha() {
		return minFecha;
	}
	public void setMinFecha(String minFecha) {
		this.minFecha = minFecha;
	}
	
	public String getMaxFecha() {
		return maxFecha;
	}
	
	public void setMaxFecha(String maxFecha) {
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


	public int getCantResultados() {
		return cantResultados;
	}


	public void setCantResultados(int cantResultados) {
		this.cantResultados = cantResultados;
	}
	
	
	
}