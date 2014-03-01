package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;
import java.util.GregorianCalendar;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="issue_update_history")
public class IssueHistorialRevision implements Serializable {

	private static final long serialVersionUID = -3016074901901662598L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id_issue_update_history")
	private Long id;
	
	@ManyToOne
	@JoinColumn(name = "id_issue")	
	private Issue issue;
	
	@OneToOne
	@JoinColumn(name = "id_user")
	private User usuario;
	
	@Column(name = "update_date")
	private GregorianCalendar fecha;
	
	@Column(name = "status")
	private String estado;
	
	@Column(name = "motive")
	private String motivo;
	
	@Column(name = "operation_type")
	private String operacion;
	
	@Column(name = "observations")
	private String observaciones;
	
	@Column(name = "modified_fields") 
	private String[] camposModificados;

	
	public IssueHistorialRevision(){ }
	
	
	public IssueHistorialRevision(Issue issue, User usuario,
			GregorianCalendar fecha, String estado, String motivo,
			String operacion, String observaciones) {
		super();
		this.issue = issue;
		this.usuario = usuario;
		this.fecha = fecha;
		this.estado = estado;
		this.motivo = motivo;
		this.operacion = operacion;
		this.observaciones = observaciones;
	}

	public Long getId() {
		return id;
	}	

	public void setId(Long id) {
		this.id = id;
	}
	
	public Issue getIssue() {
		return issue;
	}	

	public void setIssue(Issue issue) {
		this.issue = issue;
	}	

	public User getUsuario() {
		return usuario;
	}	

	public void setUsuario(User usuario) {
		this.usuario = usuario;
	}	

	public GregorianCalendar getFecha() {
		return fecha;
	}
	
	public void setFecha(GregorianCalendar fecha) {
		this.fecha = fecha;
	}
	
	public String getEstado() {
		return estado;
	}
	
	public void setEstado(String estado) {
		this.estado = estado;
	}

	public String getMotivo() {
		return motivo;
	}

	public void setMotivo(String motivo) {
		this.motivo = motivo;
	}

	public String getOperacion() {
		return operacion;
	}

	public void setOperacion(String operacion) {
		this.operacion = operacion;
	}

	public String getObservaciones() {
		return observaciones;
	}

	public void setObservaciones(String observaciones) {
		this.observaciones = observaciones;
	}

	public String[] getCamposModificados() {
		return camposModificados;
	}

	public void setCamposModificados(String[] camposModificados) {
		this.camposModificados = camposModificados;
	}
	
	
	
	
}
