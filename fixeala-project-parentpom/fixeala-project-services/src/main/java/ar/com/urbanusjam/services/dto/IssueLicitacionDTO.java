package ar.com.urbanusjam.services.dto;

import java.io.Serializable;
import java.util.Date;

//import org.springframework.format.annotation.DateTimeFormat;

public class IssueLicitacionDTO implements Serializable {

	private static final long serialVersionUID = -7810118330923948669L;
	
	private String obra;
	private String nroLicitacion;
	private String nroExpediente;
	private String nroReclamo;
	private Float valorPliego;
	private String documentacionPliego;
	private String unidadEjecutora;
	private String unidadFinanciamiento;
	private String empresaConstructora;
	private String empresaNombre;
	private Integer empresaCuit;
	private String empresaEmail;
	private String representanteTecnico;
	private String representanteNombre;
	private Integer representanteDni;
	private String representanteEmail;
	private int plazoEjecucionEnDias;
	private Float presupuestoAdjudicado;
	private Float presupuestoFinal;
//	@DateTimeFormat(pattern = "dd-MM-yyyy")
	private Date fechaEstimadaInicio;	
//	@DateTimeFormat(pattern = "dd-MM-yyyy")
	private Date fechaEstimadaFin;
//	@DateTimeFormat(pattern = "dd-MM-yyyy")
	private Date fechaRealInicio;
//	@DateTimeFormat(pattern = "dd-MM-yyyy")
	private Date fechaRealFin;
	private String tipoObra;
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
	
	public Float getValorPliego() {
		return valorPliego;
	}
	
	public void setValorPliego(Float valorPliego) {
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
	
	public Integer getEmpresaCuit() {
		return empresaCuit;
	}
	
	public void setEmpresaCuit(Integer empresaCuit) {
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
				+ ","+ getRepresentanteDni() 
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

	public Integer getRepresentanteDni() {
		return representanteDni;
	}

	public void setRepresentanteDni(Integer representanteDni) {
		this.representanteDni = representanteDni;
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
	
	public Float getPresupuestoAdjudicado() {
		return presupuestoAdjudicado;
	}
	
	public void setPresupuestoAdjudicado(Float presupuestoAdjudicado) {
		this.presupuestoAdjudicado = presupuestoAdjudicado;
	}
	
	public Float getPresupuestoFinal() {
		return presupuestoFinal;
	}
	
	public void setPresupuestoFinal(Float presupuestoFinal) {
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
	
	public String getTipoObra() {
		return tipoObra;
	}

	public void setTipoObra(String tipoObra) {
		this.tipoObra = tipoObra;
	}

	public String getEstadoObra() {
		return estadoObra;
	}
	
	public void setEstadoObra(String estadoObra) {
		this.estadoObra = estadoObra;
	}
	
	

}