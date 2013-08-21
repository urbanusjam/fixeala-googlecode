package ar.com.urbanusjam.dao;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;

import ar.com.urbanusjam.entity.annotations.Authority;

public interface AuthorityDAO {
	
	public List<String> getAuthoritiesByUserName(String userName) ;
	
	public List<Authority> getAuthorities(String username);
	
	public void saveAuthorities(String username, Collection<GrantedAuthority> authorities);

}
