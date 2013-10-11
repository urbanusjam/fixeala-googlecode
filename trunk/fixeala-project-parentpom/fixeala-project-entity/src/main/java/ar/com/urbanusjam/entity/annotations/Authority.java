package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import org.springframework.security.core.GrantedAuthority;
/**
 * The persistent class for the AUTHORITIES database table.
 *
 */
@Entity
@Table(name="AUTHORITY", uniqueConstraints = {@UniqueConstraint(columnNames={"USERNAME", "AUTHORITY"})})
public class Authority implements GrantedAuthority, Serializable {
    private static final long serialVersionUID = 1L;
    
    @Id
    private AuthorityPK id;

	public AuthorityPK getId() {
		return id;
	}

	public void setId(AuthorityPK id) {
		this.id = id;
	}

	@Override
	public String getAuthority() {
		return id.getAuthority();
	}
    
    
}