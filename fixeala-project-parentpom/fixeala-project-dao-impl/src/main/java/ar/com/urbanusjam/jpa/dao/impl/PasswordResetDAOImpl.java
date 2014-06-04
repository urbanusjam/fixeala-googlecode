package ar.com.urbanusjam.jpa.dao.impl;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import ar.com.urbanusjam.dao.PasswordResetDAO;
import ar.com.urbanusjam.entity.annotations.PasswordResetToken;

@Repository
public class PasswordResetDAOImpl implements PasswordResetDAO {

	@PersistenceContext(unitName = "fixealaPU")
	private EntityManager entityManager;   
	
	public PasswordResetDAOImpl() {}

	@Override
	public void saveToken(PasswordResetToken token) {		
		entityManager.persist(token);		
	}

	@Override
	public String findUsernameByPasswordToken(String token) {		
		PasswordResetToken pwdToken = (PasswordResetToken) entityManager.createQuery(
				"SELECT t FROM PasswordResetToken t WHERE t.creationDate < t.expirationDate AND token = :token")
				.setParameter("token", token)	
				.getSingleResult();		
		return pwdToken.getUsername();
	}

	@Override
	public void deleteToken(String token) {
		PasswordResetToken pwdToken = (PasswordResetToken) entityManager.createQuery(
				"SELECT t FROM PasswordResetToken t WHERE t.creationDate < t.expirationDate AND token = :token")
				.setParameter("token", token)	
				.getSingleResult();		
		entityManager.remove(pwdToken);	
	}

}
