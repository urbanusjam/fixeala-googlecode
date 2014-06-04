package ar.com.urbanusjam.jpa.dao.impl;

import java.util.Collection;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.AuthorityDAO;
import ar.com.urbanusjam.entity.annotations.Authority;
import ar.com.urbanusjam.entity.annotations.AuthorityPK;

@Repository
public class AuthorityDAOImpl implements AuthorityDAO  {
	
	@PersistenceContext(unitName = "fixealaPU")
	private EntityManager entityManager;   
	
	public AuthorityDAOImpl() {}
	
	@Override
	public Authority getRoleById(Long id){
		Authority rol = entityManager.createNamedQuery("Authority.findByRoleId", Authority.class)
				  					 .setParameter("id", id)			
				  					 .getSingleResult();	
		return rol;
	}
	
	@Override
	public Authority getRoleByName(String rolename){
		Authority rol = entityManager.createNamedQuery("Authority.findByRoleName", Authority.class)
					 .setParameter("rolename", rolename)			
					 .getSingleResult();	
		return rol;
	}	
	
	@Override
	@Transactional
	public void saveAuthorities(String username, Collection<GrantedAuthority> authorities) {
		for(GrantedAuthority auth : authorities){
			AuthorityPK id = new AuthorityPK();			
			id.setUsername(username);
			id.setAuthority(auth.getAuthority());
			Authority a = new Authority();			
			entityManager.persist(a);
		}
	}


}
