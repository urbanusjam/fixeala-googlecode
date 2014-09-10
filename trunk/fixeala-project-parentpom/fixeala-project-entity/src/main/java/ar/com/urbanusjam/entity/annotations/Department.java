package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name = "departamentos")
public class Department implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name = "id")
	private int id;
	
	@OneToOne
	@JoinColumn(name = "provincia_id")
	private Province provincia;
	
	@Column(name = "nombre")
	private String nombre;
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public Province getProvincia() {
		return provincia;
	}
	
	public void setProvincia(Province provincia) {
		this.provincia = provincia;
	}
	
	public String getNombre() {
		return nombre;
	}
	
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

}
