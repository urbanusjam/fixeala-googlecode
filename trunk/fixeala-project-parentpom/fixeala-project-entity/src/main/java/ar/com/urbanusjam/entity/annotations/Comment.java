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
@Table(name="COMMENT")
public class Comment implements Serializable {

	private static final long serialVersionUID = 5843368000713199365L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "ID_COMMENT")
	private Long id;
	
	@ManyToOne
	@JoinColumn(name = "ID_ISSUE")
	private Issue issue;
	
	@OneToOne
	@JoinColumn(name = "ID_USER")
	private User usuario;
	
	@Column(name = "COMMENT_DATE")
	private GregorianCalendar fecha;
	
	@Column(name = "COMMENT_MESSAGE")
	private String mensaje;
	
	@Column(name = "FLAG")
	private boolean denunciado;
		
	public Comment() { } 

	public Comment(Issue issue, User usuario, GregorianCalendar fecha,
			String mensaje, boolean denunciado) {
		super();
		this.issue = issue;
		this.usuario = usuario;
		this.fecha = fecha;
		this.mensaje = mensaje;
		this.denunciado = denunciado;
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

	public String getMensaje() {
		return mensaje;
	}

	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}

	public boolean isDenunciado() {
		return denunciado;
	}

	public void setDenunciado(boolean denunciado) {
		this.denunciado = denunciado;
	}
	
	
	
		
	

}