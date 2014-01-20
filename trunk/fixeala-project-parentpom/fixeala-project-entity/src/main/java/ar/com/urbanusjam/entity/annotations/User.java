package ar.com.urbanusjam.entity.annotations;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.GrantedAuthorityImpl;
import org.springframework.security.core.userdetails.UserDetails;


@Entity
@Table(name="USER")
public class User implements UserDetails {
	
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name="ID_USER")
    private Long id;
  
    @Column(name="USERNAME", unique=true)
    private String username;
    
    @Column(name="PASSWORD")
    private String password;
    
    @Column(name="EMAIL")
    private String email;
    
    @Column(name="NAME")
    private String nombre;
    
    @Column(name="LAST_NAME")
    private String apellido;
    
    @OneToOne
	@JoinColumn(name = "ID_AREA")
    private Area area;
    
    @Column(name="GOV_POSITION")
    private String cargo;
    
    @Column(name="GOV_SUB_AREA")
    private String subArea;
    
    @Column(name="GOV_SUB_AREA_ACRONYM")
    private String siglaSubArea;
    
    @Column(name="NEIGHBORHOOD")
    private String neighborhood;  
    
    @Column(name="IS_AREA")
    private boolean isArea;
    
    @Column(name="VERIFIED_OFFICIAL")
    private boolean verifiedOfficial;
       
    @Column(name="ENABLED")
    private boolean enabled;
    
    @Column(name="REGISTRATION_DATE")
    private Date registrationDate;
    
    @Column(name="LAST_LOGIN_DATE")
    private Date lastLoginDate;
    
    @Column(name="CLOSED_ACCOUNT_DATE")
    private Date closedAccountDate;
    
    @Transient
    private boolean accountNonExpired;

    @Transient
    private boolean accountNonLocked;

    @Transient
    private boolean credentialsNonExpired;

//	@Transient
//	private Collection<GrantedAuthority> grantedAuthorities;
    
    @ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@JoinTable(name = "USER_ROLE",
	         joinColumns = @JoinColumn(name = "ID_USER"),
	         inverseJoinColumns = @JoinColumn(name = "ID_ROLE"))
    private Collection<Authority> roles;  
    
  

	//Constructors
	public User() { }
    
    public User(String username) {
    	this.username = username;
    }

    public User(String username, String password, String email, boolean enabled, Collection<Authority> roles) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.enabled = enabled;
        this.roles =  roles;
    }

    public User(String username, String password, boolean enabled, boolean accountNonExpired, boolean accountNonLocked, 
    		boolean credentialsNonExpired, Collection<Authority> authorities) {
    	
        if (((username == null) || "".equals(username)) || (password == null)) {
            throw new IllegalArgumentException("Cannot pass null or empty values to constructor");
        }
        
        this.username = username;
        this.password = password;
        this.enabled = enabled;
        this.accountNonExpired = accountNonExpired;
        this.accountNonLocked = accountNonLocked;
        this.credentialsNonExpired = credentialsNonExpired;
        this.roles =  roles;
    }
    
    
      
    public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	
    public String getUsername() {
        return this.username;
    }
    
    public void setUsername(String username) {
        this.username = username;
    }
    
    public String getPassword() {
        return this.password;
    }
    
    public void setPassword(String password) {
        this.password = password;
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
	
	public Area getArea() {
		return area;
	}

	public void setArea(Area area) {
		this.area = area;
	}

	public String getCargo() {
		return cargo;
	}

	public void setCargo(String cargo) {
		this.cargo = cargo;
	}

	public String getSubArea() {
		return subArea;
	}

	public void setSubArea(String subArea) {
		this.subArea = subArea;
	}

	public String getSiglaSubArea() {
		return siglaSubArea;
	}

	public void setSiglaSubArea(String siglaSubArea) {
		this.siglaSubArea = siglaSubArea;
	}

	public String getNeighborhood() {
		return neighborhood;
	}

	public void setNeighborhood(String neighborhood) {
		this.neighborhood = neighborhood;
	}
	
	public boolean isArea() {
		return isArea;
	}

	public void setArea(boolean isArea) {
		this.isArea = isArea;
	}

	public boolean isEnabled() {
        return this.enabled;
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
	
	public void setRoles(Collection<Authority> roles) {
		this.roles = roles;
	}	

	public Date getRegistrationDate() {
		return registrationDate;
	}

	public void setRegistrationDate(Date registrationDate) {
		this.registrationDate = registrationDate;
	}

	public Date getLastLoginDate() {
		return lastLoginDate;
	}

	public void setLastLoginDate(Date lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}

	public Date getClosedAccountDate() {
		return closedAccountDate;
	}

	public void setClosedAccountDate(Date closedAccountDate) {
		this.closedAccountDate = closedAccountDate;
	}

	public boolean isAccountNonExpired() { 
    	return this.accountNonExpired;
    }
    
    public void setAccountNonExpired(boolean accountNonExpired) { 
    	this.accountNonExpired = accountNonExpired;
    }

    public boolean isAccountNonLocked() { 
    	return this.accountNonLocked;
    }
    
    public void setAccountNonLocked(boolean accountNonLocked) { 
    	this.accountNonLocked = accountNonLocked; 
    }

    public boolean isCredentialsNonExpired() {
    	return this.credentialsNonExpired;
    }
    
    public void setCredentialsNonExpired(boolean credentialsNonExpired) {
    	this.credentialsNonExpired = credentialsNonExpired; 
    }

	public boolean hasRole(String role, Collection<GrantedAuthority> authorities) {
       boolean hasRole = false;
       
       for (GrantedAuthority grantedAuthority : authorities) {
    	   hasRole = grantedAuthority.getAuthority().equals(role);
           break;
       }       
     
        return hasRole;
    }
    
    public boolean hasSingleRole(String role, Collection<GrantedAuthority> authorities) {
        boolean hasRole = false;        
        if(authorities.size() == 1){
        	for (GrantedAuthority grantedAuthority : authorities) {
          	     hasRole = grantedAuthority.getAuthority().equals(role);              
             }  
        }               
        return hasRole;        
     }
    
    
    public void setGrantedAuthorities(List<Authority> roles) {
        List<Authority> listOfAuthorities = new ArrayList<Authority>();
        for (Authority role : roles) {
            listOfAuthorities.add(new Authority(role.getAuthority()));
        }
        this.roles = (Collection<Authority>) listOfAuthorities;
    }
    
    

	public Collection<Authority> getRoles() {
		return roles;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return null;
	}

	
   
}