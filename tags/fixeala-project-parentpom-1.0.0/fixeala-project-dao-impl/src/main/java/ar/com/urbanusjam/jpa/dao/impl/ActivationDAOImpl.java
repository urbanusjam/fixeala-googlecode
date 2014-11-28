package ar.com.urbanusjam.jpa.dao.impl;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import ar.com.urbanusjam.dao.ActivationDAO;
import ar.com.urbanusjam.entity.annotations.ActivationToken;

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
	public String findUsernameByActivationToken(String token) throws NoResultException {		
		try{
			ActivationToken activeToken = (ActivationToken) entityManager.createQuery(		
			    						"SELECT a FROM ActivationToken a WHERE CURRENT_DATE < a.expiration AND token = :token")
			    						.setParameter("token", token)	
			    						.getSingleResult();
			return activeToken.getUsername();
		}catch(NoResultException e){
			return null;
		}
		
	}

	@Override
	public void deleteToken(String token) {		
		ActivationToken expiredToken = (ActivationToken) entityManager.createQuery(
				"SELECT a FROM ActivationToken a WHERE CURRENT_DATE >= a.expiration AND token = :token")
				.setParameter("token", token)	
				.getSingleResult();		
		entityManager.remove(expiredToken);			
	}

	@Override
	public void deleteTokenByUsername(String username) throws NoResultException {		
		try{
			ActivationToken activeToken = entityManager.createQuery("SELECT a FROM ActivationToken a WHERE a.username = :username", ActivationToken.class)		
				  								   .setParameter("username", username)			
				  							       .getSingleResult();		
			entityManager.remove(activeToken);	
		}catch(NoResultException e){
			throw new NoResultException();
		}
			
	}

}
