package ar.com.urbanusjam.entity.annotations;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
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
    @Column(name="USERNAME")
    private String username;
    
    @Column(name="PASSWORD")
    private String password;
    
    @Column(name="EMAIL")
    private String email;
    
    @Column(name="NEIGHBORHOOD")
    private String neighborhood;    
       
    @Column(name="ENABLED")
    private boolean enabled;
    
    @Column(name="CLOSED_ACCOUNT_DATE")
    private Date closedAccountDate;
    
    @Transient
    private boolean accountNonExpired;

    @Transient
    private boolean accountNonLocked;

    @Transient
    private boolean credentialsNonExpired;
//
//    @OneToMany(
//            fetch = FetchType.EAGER, cascade = CascadeType.ALL,
//            mappedBy = "user"
//    ) 
    @Transient
    private Collection<GrantedAuthority> authorities;
    
  

	//Constructors
    public User() {
    }
    
    public User(String username) {
    	this.username = username;
    }

    public User(String username, String password, String email, boolean enabled, Collection<GrantedAuthority> authorities) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.enabled = enabled;
        this.authorities =  authorities;
    }

    public User(String username, String password, boolean enabled, boolean accountNonExpired, boolean accountNonLocked, 
    		boolean credentialsNonExpired, Collection<GrantedAuthority> authorities) {
    	
        if (((username == null) || "".equals(username)) || (password == null)) {
            throw new IllegalArgumentException("Cannot pass null or empty values to constructor");
        }
        
        this.username = username;
        this.password = password;
        this.enabled = enabled;
        this.accountNonExpired = accountNonExpired;
        this.accountNonLocked = accountNonLocked;
        this.credentialsNonExpired = credentialsNonExpired;
        this.authorities =  authorities;
    }
    
    
      
    // Getters & Setters for original props
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
		
	public String getNeighborhood() {
		return neighborhood;
	}

	public void setNeighborhood(String neighborhood) {
		this.neighborhood = neighborhood;
	}

	public boolean isEnabled() {
        return this.enabled;
    }
    
    public void setEnabled(boolean enabled) {
        this.enabled = enabled;
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
    
    @Override
	public Collection<GrantedAuthority> getAuthorities() {
		return this.authorities;
	}

//	public void setAuthorities(Collection<GrantedAuthority> authorities) {
//		this.authorities = authorities;
//	}
    
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
    
    
    public void setAuthorities(List<String> roles) {
        List<GrantedAuthority> listOfAuthorities = new ArrayList<GrantedAuthority>();
        for (String role : roles) {
            listOfAuthorities.add(new GrantedAuthorityImpl(role));
        }
        this.authorities = (Collection<GrantedAuthority>) listOfAuthorities;
    }

	
   
}