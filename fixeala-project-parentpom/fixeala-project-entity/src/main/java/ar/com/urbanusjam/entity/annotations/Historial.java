package ar.com.urbanusjam.entity.annotations;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name="HISTORIAL_REVISIONES")
public class Historial {
	
	private Date fecha;
	private String username;
	private String estado;
	private String motivo;
	private String observaciones;
	private Issue issue;

}
