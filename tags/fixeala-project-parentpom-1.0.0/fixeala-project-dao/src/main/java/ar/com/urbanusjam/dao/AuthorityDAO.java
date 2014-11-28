package ar.com.urbanusjam.dao;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;

import ar.com.urbanusjam.entity.annotations.Authority;

public interface AuthorityDAO {
	
	public Authority getRoleById(Long id);
	public Authority getRoleByName(String rolename);
	public void saveAuthorities(String username, Collection<GrantedAuthority> authorities);

}
