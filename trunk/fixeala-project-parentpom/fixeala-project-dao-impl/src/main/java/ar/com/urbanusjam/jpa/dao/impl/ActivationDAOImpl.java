package ar.com.urbanusjam.jpa.dao.impl;

import java.io.Serializable;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import ar.com.urbanusjam.dao.ActivationDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.entity.annotations.ActivationToken;
import ar.com.urbanusjam.entity.annotations.User;

@Repository
public class ActivationDAOImpl implements ActivationDAO {
	
	@PersistenceContext(unitName = "fixealaPU")
	private EntityManager entityManager; 

	public ActivationDAOImpl() {}

	@Override
	public void saveToken(ActivationToken token) {	
		entityManager.persist(token);		
	}

	@Override
	public String findUsernameByActivationToken(String token) {		
		ActivationToken activeToken = (ActivationToken) entityManager.createQuery(
			    						"SELECT a FROM ActivationToken a WHERE a.creationDate < a.expirationDate AND token = :token")
			    						.setParameter("token", token)	
			    						.getSingleResult();
		return activeToken.getUsername();
	}

	@Override
	public void deleteToken(String token) {		
		ActivationToken expiredToken = (ActivationToken) entityManager.createQuery(
				"SELECT a FROM ActivationToken a WHERE a.creationDate < a.expirationDate AND token = :token")
				.setParameter("token", token)	
				.getSingleResult();		
		entityManager.remove(expiredToken);			
	}

	@Override
	public void deleteTokenByUsername(String username) {		
		ActivationToken activeToken = entityManager.createNamedQuery("ActivationToken.deleteByUsername", ActivationToken.class)
				  								   .setParameter("username", username)			
				  							       .getSingleResult();		
		entityManager.remove(activeToken);		
	}

}
