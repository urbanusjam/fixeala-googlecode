package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import org.springframework.security.core.GrantedAuthority;
/**
 * The persistent class for the AUTHORITIES database table.
 *
 */
@Entity
@Table(name="ROLE")
public class Authority implements GrantedAuthority, Serializable {
    private static final long serialVersionUID = 1L;
    
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Column(name="ID_ROLE")
    private Long id;
    
    @Column(name="NAME")
    private String authority;
    
	@ManyToMany(cascade = CascadeType.ALL, mappedBy="roles")
	private Set<User> users;
	
	public Authority(String authority) {      
        this.authority = authority;
    }
	public Authority() { users = new HashSet<User>(); }
	
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Set<User> getUsers() {
		return users;
	}

	public void setUsers(Set<User> users) {
		this.users = users;
	}

	@Override
	public String getAuthority() {
		return this.authority;
	}
	
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	
	@Override
    public int hashCode() {
        int result;
        result = getId().hashCode();
        result = (int) (29 * result + getId());
        return result;
    }


    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if ( !(obj instanceof Authority) ) return false;

        final Authority a = (Authority) obj;

        return a.getId().equals( this.getId() ) ;
        
    }
    

	
    
}