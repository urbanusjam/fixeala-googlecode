package ar.com.urbanusjam.services.dto;

import java.io.Serializable;
import java.util.Date;

public class IssueLicitacionDTO implements Serializable {

	private static final long serialVersionUID = -7810118330923948669L;
	
	private String obra;
	private String nroLicitacion;
	private String nroExpediente;
	private String nroReclamo;
	private int valorPliego;
	private String documentacionPliego;
	private String unidadEjecutora;
	private String unidadFinanciamiento;
	private String empresaConstructora;
	private String empresaNombre;
	private String empresaCuit;
	private String empresaEmail;
	private String representanteTecnico;
	private String representanteNombre;
	private String representanteTel;
	private String representanteEmail;
	private int plazoEjecucionEnDias;
	private float presupuestoAdjudicado;
	private float presupuestoFinal;
	private Date fechaEstimadaInicio;	
	private Date fechaEstimadaFin;
	private Date fechaRealInicio;
	private Date fechaRealFin;
	private String estadoObra;
	
	
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
	
	public int getValorPliego() {
		return valorPliego;
	}
	
	public void setValorPliego(int valorPliego) {
		this.valorPliego = valorPliego;
	}
	
	public String getDocumentacionPliego() {
		return documentacionPliego;
	}
	
	public void setDocumentacionPliego(String documentacionPliego) {
		this.documentacionPliego = documentacionPliego;
	}
	
	public String getEmpresaConstructora() {
		return empresaConstructora;
	}
	
	public void setEmpresaConstructora(String empresaConstructora) {
		this.empresaConstructora = empresaConstructora;
	}
	
	public void setEmpresaConstructora() {
		this.empresaConstructora = getEmpresaNombre() 
				+ "," + getEmpresaCuit() 
				+ "," + getEmpresaEmail();
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
	
	public String getEmpresaEmail() {
		return empresaEmail;
	}
	
	public void setEmpresaEmail(String empresaEmail) {
		this.empresaEmail = empresaEmail;
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
	
	public String getRepresentanteTecnico() {
		return representanteTecnico;
	}
	
	public void setRepresentanteTecnico() {
		this.representanteTecnico = getRepresentanteNombre() 
				+ ","+ getRepresentanteTel() 
				+ "," + getRepresentanteEmail();
	}
	
	public void setRepresentanteTecnico(String representanteTecnico) {
		this.representanteTecnico = representanteTecnico;
	}
	
	public String getRepresentanteNombre() {
		return representanteNombre;
	}

	public void setRepresentanteNombre(String representanteNombre) {
		this.representanteNombre = representanteNombre;
	}

	public String getRepresentanteTel() {
		return representanteTel;
	}

	public void setRepresentanteTel(String representanteTel) {
		this.representanteTel = representanteTel;
	}

	public String getRepresentanteEmail() {
		return representanteEmail;
	}

	public void setRepresentanteEmail(String representanteEmail) {
		this.representanteEmail = representanteEmail;
	}

	public int getPlazoEjecucionEnDias() {
		return plazoEjecucionEnDias;
	}
	
	public void setPlazoEjecucionEnDias(int plazoEjecucionEnDias) {
		this.plazoEjecucionEnDias = plazoEjecucionEnDias;
	}
	
	public float getPresupuestoAdjudicado() {
		return presupuestoAdjudicado;
	}
	
	public void setPresupuestoAdjudicado(float presupuestoAdjudicado) {
		this.presupuestoAdjudicado = presupuestoAdjudicado;
	}
	
	public float getPresupuestoFinal() {
		return presupuestoFinal;
	}
	
	public void setPresupuestoFinal(float presupuestoFinal) {
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
	
	

}
