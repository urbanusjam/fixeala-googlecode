package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import org.hibernate.annotations.LazyToOne;
import org.hibernate.annotations.LazyToOneOption;
import org.hibernate.bytecode.javassist.FieldHandled;
import org.hibernate.bytecode.javassist.FieldHandler;

@Entity
@Table(name="ISSUE_LICITACION")
public class IssueLicitacion implements Serializable {

	private static final long serialVersionUID = -3526522777509354350L;
	
	@Id
	//@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "ID_ISSUE")	
	private Long id;
	
	@Column(name = "NRO_LICITACION")
	private String nroLicitacion;
	
	@Column(name = "NRO_EXPEDIENTE")
	private String nroExpediente;
	
//	@OneToOne
//	@JoinColumn(name = "ID_ISSUE")
//	private Issue issue;
	
	@Column(name = "TIPO")
	private String tipo;
	
	@Column(name = "OBJETO")
	private String objeto;
	
	@Column(name = "VALOR_PLIEGO")
	private Float valorPliego;
	
	@Column(name = "DOCUMENTACION_PLIEGO")
	private String documentacionPliego;
	
	@Column(name = "UNIDAD_EJECUTORA")
	private String unidadEjecutora;
	
	@Column(name = "UNIDAD_FINANCIAMIENTO")
	private String unidadFinanciamiento;
	
	@Column(name = "EMPRESA_CONSTRUCTORA_NOMBRE")
	private String empresaConstructoraNombre;
	
	@Column(name = "EMPRESA_CONSTRUCTORA_CUIT")
	private Integer empresaConstructoraCuit;
	
	@Column(name = "EMPRESA_CONSTRUCTORA_EMAIL")
	private String empresaConstructoraEmail;
	
	@Column(name = "REPRESENTANTE_TECNICO_NOMBRE")
	private String representanteTecnicoNombre;
	
	@Column(name = "REPRESENTANTE_TECNICO_DNI")
	private Integer representanteTecnicoDni;
	
	@Column(name = "REPRESENTANTE_TECNICO_EMAIL")
	private String representanteTecnicoEmail;
	
	@Column(name = "PLAZO_EJECUCION")
	private int plazoEjecucionEnDias;
	
	@Column(name = "PRESUPUESTO_ADJUDICADO")
	private Float presupuestoAdjudicado;
	
	@Column(name = "PRESUPUESTO_FINAL")
	private Float presupuestoFinal;
		
	@Column(name = "FECHA_ESTIMADA_INICIO")
	private Date fechaEstimadaInicio;	
	
	@Column(name = "FECHA_ESTIMADA_FIN")
	private Date fechaEstimadaFin;
	
	@Column(name = "FECHA_REAL_INICIO")
	private Date fechaRealInicio;
	
	@Column(name = "FECHA_REAL_FIN")
	private Date fechaRealFin;
	
	@Column(name = "STATUS_OBRA")
	private String estadoObra;
	
  	   	
	public IssueLicitacion(){}
	
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
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

//	public Issue getIssue() {
//		return issue;
//	}
//	
//	public void setIssue(Issue issue) {
//		this.issue = issue;
//	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public String getObjeto() {
		return objeto;
	}

	public void setObjeto(String objeto) {
		this.objeto = objeto;
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

	public String getEmpresaConstructoraNombre() {
		return empresaConstructoraNombre;
	}

	public void setEmpresaConstructoraNombre(String empresaConstructoraNombre) {
		this.empresaConstructoraNombre = empresaConstructoraNombre;
	}

	public Integer getEmpresaConstructoraCuit() {
		return empresaConstructoraCuit;
	}

	public void setEmpresaConstructoraCuit(Integer empresaConstructoraCuit) {
		this.empresaConstructoraCuit = empresaConstructoraCuit;
	}

	public String getEmpresaConstructoraEmail() {
		return empresaConstructoraEmail;
	}

	public void setEmpresaConstructoraEmail(String empresaConstructoraEmail) {
		this.empresaConstructoraEmail = empresaConstructoraEmail;
	}

	public String getRepresentanteTecnicoNombre() {
		return representanteTecnicoNombre;
	}

	public void setRepresentanteTecnicoNombre(String representanteTecnicoNombre) {
		this.representanteTecnicoNombre = representanteTecnicoNombre;
	}

	public Integer getRepresentanteTecnicoDni() {
		return representanteTecnicoDni;
	}

	public void setRepresentanteTecnicoDni(Integer representanteTecnicoDni) {
		this.representanteTecnicoDni = representanteTecnicoDni;
	}

	public String getRepresentanteTecnicoEmail() {
		return representanteTecnicoEmail;
	}

	public void setRepresentanteTecnicoEmail(String representanteTecnicoEmail) {
		this.representanteTecnicoEmail = representanteTecnicoEmail;
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

	public String getEstadoObra() {
		return estadoObra;
	}

	public void setEstadoObra(String estadoObra) {
		this.estadoObra = estadoObra;
	}



}
