package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;
import java.util.GregorianCalendar;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;


@Entity
@Table(name="content")
@Inheritance(strategy=InheritanceType.JOINED)
public class MediaContent implements Serializable {
    
    private static final long serialVersionUID = 1L;

    @Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id_content")
    private Long id;   
   
    @Column(name = "height")
    private Integer alto;
    
    @Column(name = "width")
    private Integer ancho;
    
    @Column(name = "relative_path")
    private String pathRelativo;    
    
    @Column(name = "filename")
    private String nombre;
    
    @Column(name = "filename_extension")
    private String tipo;
    
    @Column(name = "filename_with_extension")
    private String nombreConExtension;
    
//    @Column(name = "upload_date")
//    private GregorianCalendar fecha;
    
    @Column(name = "file_order")
    private int orden;
    
    @Column(name = "is_profile_pic")
    private boolean profilePic;
    
    @ManyToOne
	@JoinColumn(name = "id_issue")	
	private Issue issue;
    
    
	public MediaContent(){
        
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

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	
	public String getNombreConExtension() {
		return nombreConExtension;
	}

	public void setNombreConExtension(String nombreConExtension) {
		this.nombreConExtension = nombreConExtension;
	}
		
//	public GregorianCalendar getFecha() {
//		return fecha;
//	}
//
//	public void setFecha(GregorianCalendar fecha) {
//		this.fecha = fecha;
//	}

	public int getOrden() {
		return orden;
	}

	public void setOrden(int orden) {
		this.orden = orden;
	}
	
	public boolean isProfilePic() {
		return profilePic;
	}

	public void setProfilePic(boolean profilePic) {
		this.profilePic = profilePic;
	}

	public Issue getIssue() {
		return issue;
	}

	public void setIssue(Issue issue) {
		this.issue = issue;
	}
	
	

}