package ar.com.urbanusjam.dao.impl;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.AuthorityDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.entity.annotations.Authority;
import ar.com.urbanusjam.entity.annotations.AuthorityPK;

public class AuthorityDAOImpl extends GenericDAOImpl<Authority, Serializable> implements AuthorityDAO  {

	public AuthorityDAOImpl() {
		super(Authority.class);
	}
	
	@Override
	public Authority getRoleById(Long id){
		List<Authority> roles = this.findWhere(" id = ? ", new Object[]{id});
		return roles.size() > 0 ? roles.get(0) : null;
	}
	
	@Override
	public Authority getRoleByName(String rolename){
		List<Authority> roles = this.findWhere(" rolename = ? ", new Object[]{rolename});
		return roles.size() > 0 ? roles.get(0) : null;
	}	
	
	@Override
	@Transactional
	public void saveAuthorities(String username, Collection<GrantedAuthority> authorities) {
		for(GrantedAuthority auth : authorities){
			AuthorityPK id = new AuthorityPK();			
			id.setUsername(username);
			id.setAuthority(auth.getAuthority());
			Authority a = new Authority();			
			this.save(a);
		}
	}


}
