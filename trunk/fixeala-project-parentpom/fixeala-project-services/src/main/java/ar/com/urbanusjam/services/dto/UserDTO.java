package ar.com.urbanusjam.services.dto;

import java.io.Serializable;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

public class UserDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String id;
	private String username;	
	private String password;	
	private String newPassword;	
	private String email;
	private String nombre;
	private String apellido;
	private String cargo;
	private String areaId;
	private String areaNombre;
	private String areaCiudad;
	private String areaProvinciaSigla;
	private String subarea;
	private String neighborhood;
	private Date registrationDate;
	private List<String> authorities;	
	private boolean verifiedOfficial;
	private String accountStatus;
	private boolean enabled;
	private String rol;
	
	private int cantidadIssues; 
	
	public UserDTO(){}
	
	
	
	public String getId() {
		return id;
	}



	public void setId(String id) {
		this.id = id;
	}



	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getApellido() {
		return apellido;
	}

	public void setApellido(String apellido) {
		this.apellido = apellido;
	}

	public String getCargo() {
		return cargo;
	}

	public void setCargo(String cargo) {
		this.cargo = cargo;
	}
	
	public String getAreaId() {
		return areaId;
	}

	public void setAreaId(String areaId) {
		this.areaId = areaId;
	}

	public String getAreaNombre() {
		return areaNombre;
	}

	public void setAreaNombre(String areaNombre) {
		this.areaNombre = areaNombre;
	}

	public String getAreaCiudad() {
		return areaCiudad;
	}

	public void setAreaCiudad(String areaCiudad) {
		this.areaCiudad = areaCiudad;
	}

	public String getAreaProvinciaSigla() {
		return areaProvinciaSigla;
	}

	public void setAreaProvinciaSigla(String areaProvinciaSigla) {
		this.areaProvinciaSigla = areaProvinciaSigla;
	}
	
	public String getSubarea() {
		return subarea;
	}

	public void setSubarea(String subarea) {
		this.subarea = subarea;
	}

	public List<String> getAuthorities() {
		return authorities;
	}

	public void setAuthorities(List<String> authorities) {
		this.authorities = authorities;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	
	public boolean isVerifiedOfficial() {
		return verifiedOfficial;
	}

	public void setVerifiedOfficial(boolean verifiedOfficial) {
		this.verifiedOfficial = verifiedOfficial;
	}

	public String getNeighborhood() {
		return neighborhood;
	}

	public void setNeighborhood(String neighborhood) {
		this.neighborhood = neighborhood;
	}

	public Date getRegistrationDate() {
		return registrationDate;
	}

	public void setRegistrationDate(Date registrationDate) {
		this.registrationDate = registrationDate;
	}
	
	public int getCantidadIssues() {
		return cantidadIssues;
	}

	public void setCantidadIssues(int cantidadIssues) {
		this.cantidadIssues = cantidadIssues;
	}
	
	public String getRol() {
		return rol;
	}

	public void setRol(String rol) {
		this.rol = rol;
	}

	public String getAccountStatus() {
		return accountStatus;
	}

	public void setAccountStatus(String accountStatus) {
		this.accountStatus = accountStatus;
	}

	public boolean hasRole(String role, List<String> authorities) {
	       
		boolean hasRole = false;
	       
		for (String auth : authorities) {
    	   hasRole = auth.equals(role);
           break;
		}       
     
        return hasRole;
	}



}
