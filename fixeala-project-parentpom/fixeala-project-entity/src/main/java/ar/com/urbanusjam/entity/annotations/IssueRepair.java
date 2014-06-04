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
//import org.hibernate.bytecode.javassist.FieldHandled;
//import org.hibernate.bytecode.javassist.FieldHandler;

@Entity
@Table(name="issue_repair")
public class IssueRepair implements Serializable {

	private static final long serialVersionUID = -3526522777509354350L;
	
	@Id
	//@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id_issue")	
	private Long id;
	
	@Column(name = "nro_licitacion")
	private String nroLicitacion;
	
	@Column(name = "nro_expediente")
	private String nroExpediente;
	
//	@OneToOne
//	@JoinColumn(name = "ID_ISSUE")
//	private Issue issue;
	
	@Column(name = "tipo")
	private String tipo;
	
	@Column(name = "descripcion")
	private String objeto;
	
	@Column(name = "valor_pliego")
	private Float valorPliego;
	
	@Column(name = "unidad_ejecutora")
	private String unidadEjecutora;
	
	@Column(name = "unidad_financiamiento")
	private String unidadFinanciamiento;
	
	@Column(name = "empresa_contratada_nombre")
	private String empresaConstructoraNombre;
	
	@Column(name = "empresa_contratada_cuit")
	private Integer empresaConstructoraCuit;
	
	@Column(name = "representante_tecnico_nombre")
	private String representanteTecnicoNombre;
	
	@Column(name = "representante_tecnico_dni")
	private Integer representanteTecnicoDni;
	
	@Column(name = "plazo_ejecucion_en_dias")
	private int plazoEjecucionEnDias;
	
	@Column(name = "presupuesto_adjudicado")
	private Float presupuestoAdjudicado;
	
	@Column(name = "presupuesto_final")
	private Float presupuestoFinal;
		
	@Column(name = "fecha_estimada_inicio")
	private Date fechaEstimadaInicio;	
	
	@Column(name = "fecha_estimada_fin")
	private Date fechaEstimadaFin;
	
	@Column(name = "fecha_real_inicio")
	private Date fechaRealInicio;
	
	@Column(name = "fecha_real_fin")
	private Date fechaRealFin;
	
	@Column(name = "estado_obra")
	private String estadoObra;
	
  	   	
	public IssueRepair(){}
	
	
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