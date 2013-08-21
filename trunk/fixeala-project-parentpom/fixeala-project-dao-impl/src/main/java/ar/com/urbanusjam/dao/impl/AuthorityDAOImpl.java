package ar.com.urbanusjam.dao.impl;

import java.io.Serializable;
import java.util.ArrayList;
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
    public List<String> getAuthoritiesByUserName(String username) {
		List<Authority> authorities = this.findWhere(" username = ? ",  new Object[]{username});		
        List<String> l = new ArrayList<String>();        
        for(Authority a : authorities){
        	 l.add(a.getAuthority());
        }
       
        return l;
    }
	
	@Override
    public List<Authority> getAuthorities(String username) {
		List<Authority> authorities = this.findWhere(" username = ? ",  new Object[]{username});      
        return authorities;
    }

	
	
	@Override
	@Transactional
	public void saveAuthorities(String username, Collection<GrantedAuthority> authorities) {
		for(GrantedAuthority auth : authorities){
			AuthorityPK id = new AuthorityPK();			
			id.setUsername(username);
			id.setAuthority(auth.getAuthority());
			Authority a = new Authority();			
			a.setId(id);
			this.save(a);
		}
	}



	
	
	
	

}
