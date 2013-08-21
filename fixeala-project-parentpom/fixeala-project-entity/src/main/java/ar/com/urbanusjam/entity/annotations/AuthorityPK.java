package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class AuthorityPK implements Serializable {

	private static final long serialVersionUID = 1L;

	@Column(name="USERNAME", unique=true)
    private String username;
    
    @Column(name="AUTHORITY", unique=true)
    private String authority;
    
    public AuthorityPK(){
      
    }    

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}
    
	@Override
	public boolean equals(Object obj) {
        if (this == obj) return true;
        if ( !(obj instanceof AuthorityPK) ) return false;

        final AuthorityPK pk = (AuthorityPK) obj;

        if ( !pk.getAuthority().equals( getAuthority() ) ) return false;
        if ( !pk.getUsername().equals( getUsername() ) ) return false;

        return true;              
    }
	
	@Override
    public int hashCode() {     
        return getUsername().hashCode() + getAuthority().hashCode();
    }

}
