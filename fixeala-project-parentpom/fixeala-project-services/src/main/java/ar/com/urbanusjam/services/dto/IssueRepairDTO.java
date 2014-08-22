package ar.com.urbanusjam.services.dto;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.format.annotation.NumberFormat;
import org.springframework.format.annotation.NumberFormat.Style;

//import org.springframework.format.annotation.DateTimeFormat;

public class IssueRepairDTO implements Serializable {

	private static final long serialVersionUID = -7810118330923948669L;
	
	private String obra;
	private String nroLicitacion;
	private String nroExpediente;
	private String nroReclamo;	
	private String unidadEjecutora;
	private String unidadFinanciamiento;
	private String empresaNombre;
	private String empresaCuit;
	private String representanteNombre;
	private String representanteMatricula;
	private Integer plazo;
	@NumberFormat(style = Style.CURRENCY)
	private double presupuestoAdjudicacion;
	@NumberFormat(style = Style.CURRENCY)
	private double presupuestoFinal;
	@DateTimeFormat(pattern = "dd-MM-yyyy")
	private Date fechaEstimadaInicio;	
	@DateTimeFormat(pattern = "dd-MM-yyyy")
	private Date fechaEstimadaFin;
	@DateTimeFormat(pattern = "dd-MM-yyyy")
	private Date fechaRealInicio;
	@DateTimeFormat(pattern = "dd-MM-yyyy")
	private Date fechaRealFin;
	private String estadoObra;
	private String observaciones;
	
	public IssueRepairDTO(){}
	
	
	public String getObra() {
		return obra;
	}

	public void setObra(String obra) {
		this.obra = obra;
	}

	public String getNroLicitacion() {
		return nroLicitacion;
	}
	
	public void setNroLicitacion(String nroLicitacion) {
		this.nroLicitacion = nroLicitacion;
	}
	
	public String getNroExpediente() {
		return nroExpediente;
	}
	
	public void setNroExpediente(String nroExpediente) {
		this.nroExpediente = nroExpediente;
	}
	
	public String getNroReclamo() {
		return nroReclamo;
	}
	
	public void setNroReclamo(String nroReclamo) {
		this.nroReclamo = nroReclamo;
	}
	
	public String getEmpresaNombre() {
		return empresaNombre;
	}
	
	public void setEmpresaNombre(String empresaNombre) {
		this.empresaNombre = empresaNombre;
	}
	
	public String getEmpresaCuit() {
		return empresaCuit;
	}
	
	public void setEmpresaCuit(String empresaCuit) {
		this.empresaCuit = empresaCuit;
	}
	
	public String getUnidadEjecutora() {
		return unidadEjecutora;
	}
	
	public void setUnidadEjecutora(String unidadEjecutora) {
		this.unidadEjecutora = unidadEjecutora;
	}
	
	public String getUnidadFinanciamiento() {
		return unidadFinanciamiento;
	}
	
	public void setUnidadFinanciamiento(String unidadFinanciamiento) {
		this.unidadFinanciamiento = unidadFinanciamiento;
	}
	
	public String getRepresentanteNombre() {
		return representanteNombre;
	}

	public void setRepresentanteNombre(String representanteNombre) {
		this.representanteNombre = representanteNombre;
	}

	public String getRepresentanteMatricula() {
		return representanteMatricula;
	}

	public void setRepresentanteMatricula(String representanteMatricula) {
		this.representanteMatricula = representanteMatricula;
	}
	
	public Integer getPlazo() {
		return plazo;
	}

	public void setPlazo(Integer plazo) {
		this.plazo = plazo;
	}

	public double getPresupuestoAdjudicacion() {
		return presupuestoAdjudicacion;
	}

	public void setPresupuestoAdjudicacion(double presupuestoAdjudicacion) {
		this.presupuestoAdjudicacion = presupuestoAdjudicacion;
	}

	public double getPresupuestoFinal() {
		return presupuestoFinal;
	}
	
	public void setPresupuestoFinal(double presupuestoFinal) {
		this.presupuestoFinal = presupuestoFinal;
	}
	
	public Date getFechaEstimadaInicio() {
		return fechaEstimadaInicio;
	}
	
	public void setFechaEstimadaInicio(Date fechaEstimadaInicio) {
		this.fechaEstimadaInicio = fechaEstimadaInicio;
	}
	
	public Date getFechaEstimadaFin() {
		return fechaEstimadaFin;
	}
	
	public void setFechaEstimadaFin(Date fechaEstimadaFin) {
		this.fechaEstimadaFin = fechaEstimadaFin;
	}
	
	public Date getFechaRealInicio() {
		return fechaRealInicio;
	}
	
	public void setFechaRealInicio(Date fechaRealInicio) {
		this.fechaRealInicio = fechaRealInicio;
	}
	
	public Date getFechaRealFin() {
		return fechaRealFin;
	}
	
	public void setFechaRealFin(Date fechaRealFin) {
		this.fechaRealFin = fechaRealFin;
	}
	
	public String getEstadoObra() {
		return estadoObra;
	}
	
	public void setEstadoObra(String estadoObra) {
		this.estadoObra = estadoObra;
	}

	public String getObservaciones() {
		return observaciones;
	}

	public void setObservaciones(String observaciones) {
		this.observaciones = observaciones;
	}
	
	
}
