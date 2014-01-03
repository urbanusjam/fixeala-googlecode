package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


@Entity
@Table(name="CONTENIDO")
@Inheritance(strategy=InheritanceType.JOINED)
public class Contenido implements Serializable {
    
    private static final long serialVersionUID = 1L;

    @Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "ID_CONTENIDO")
    private Long id;   
    
    @Column(name = "TIPO")
    private String tipo;    
    
    @Column(name = "ALTO")
    private Integer alto;
    
    @Column(name = "ANCHO")
    private Integer ancho;
    
    @Column(name = "PATH_RELATIVO")
    private String pathRelativo;   
    
    @Column(name = "URL")
    private String url;  
    
    @Column(name = "NOMBRE")
    private String nombre;
    
    @Column(name = "NOMBRE_FILE_SYSTEM")
    private String nombreFileSystem;
    
    @ManyToOne
	@JoinColumn(name = "ID_ISSUE", updatable = false)	
	private Issue issue;
    
    
	public Contenido(){
        
    }


	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public String getTipo() {
		return tipo;
	}


	public void setTipo(String tipo) {
		this.tipo = tipo;
	}


	public Integer getAlto() {
		return alto;
	}


	public void setAlto(Integer alto) {
		this.alto = alto;
	}


	public Integer getAncho() {
		return ancho;
	}


	public void setAncho(Integer ancho) {
		this.ancho = ancho;
	}


	public String getPathRelativo() {
		return pathRelativo;
	}


	public void setPathRelativo(String pathRelativo) {
		this.pathRelativo = pathRelativo;
	}


	public String getUrl() {
		return url;
	}


	public void setUrl(String url) {
		this.url = url;
	}


	public String getNombre() {
		return nombre;
	}


	public void setNombre(String nombre) {
		this.nombre = nombre;
	}


	public String getNombreFileSystem() {
		return nombreFileSystem;
	}


	public void setNombreFileSystem(String nombreFileSystem) {
		this.nombreFileSystem = nombreFileSystem;
	}


	public Issue getIssue() {
		return issue;
	}


	public void setIssue(Issue issue) {
		this.issue = issue;
	}

	
	

}
