package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;
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
	
	@Column(name = "obra")
	private String obra;

	@Column(name = "plazo")
	private int plazo;
	
	@Column(name = "unidad_ejecutora")
	private String unidadEjecutora;
	
	@Column(name = "unidad_financiamiento")
	private String unidadFinanciamiento;
	
	@Column(name = "contratista_nombre")
	private String contratistaNombre;
	
	@Column(name = "contratista_cuit")
	private String contratistaCuit;
	
	@Column(name = "representante_tecnico_nombre")
	private String representanteTecnicoNombre;
	
	@Column(name = "representante_tecnico_matricula")
	private String representanteTecnicoMatricula;
		
	@Column(name = "presupuesto_adjudicacion")
	private double presupuestoAdjudicacion;
	
	@Column(name = "presupuesto_final")
	private double presupuestoFinal;
		
	@Column(name = "fecha_estimada_inicio")
	@DateTimeFormat(pattern = "dd-MM-yyyy")
	private Date fechaEstimadaInicio;	
	
	@Column(name = "fecha_estimada_fin")
	@DateTimeFormat(pattern = "dd-MM-yyyy")
	private Date fechaEstimadaFin;
	
	@Column(name = "fecha_real_inicio")
	@DateTimeFormat(pattern = "dd-MM-yyyy")
	private Date fechaRealInicio;
	
	@Column(name = "fecha_real_fin")
	@DateTimeFormat(pattern = "dd-MM-yyyy")
	private Date fechaRealFin;
	
	@Column(name = "estado_obra")
	private String estadoObra;
	
	@Column(name = "observaciones")
	private String observaciones;
	
  	   	
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

	public String getObra() {
		return obra;
	}

	public void setObra(String obra) {
		this.obra = obra;
	}

	public int getPlazo() {
		return plazo;
	}

	public void setPlazo(int plazo) {
		this.plazo = plazo;
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

	public String getContratistaNombre() {
		return contratistaNombre;
	}

	public void setContratistaNombre(String contratistaNombre) {
		this.contratistaNombre = contratistaNombre;
	}

	public String getContratistaCuit() {
		return contratistaCuit;
	}

	public void setContratistaCuit(String contratistaCuit) {
		this.contratistaCuit = contratistaCuit;
	}

	public String getRepresentanteTecnicoNombre() {
		return representanteTecnicoNombre;
	}

	public void setRepresentanteTecnicoNombre(String representanteTecnicoNombre) {
		this.representanteTecnicoNombre = representanteTecnicoNombre;
	}

	public String getRepresentanteTecnicoMatricula() {
		return representanteTecnicoMatricula;
	}

	public void setRepresentanteTecnicoMatricula(
			String representanteTecnicoMatricula) {
		this.representanteTecnicoMatricula = representanteTecnicoMatricula;
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