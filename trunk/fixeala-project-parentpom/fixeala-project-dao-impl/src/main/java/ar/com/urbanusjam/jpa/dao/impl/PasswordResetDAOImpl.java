package ar.com.urbanusjam.jpa.dao.impl;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.PasswordResetDAO;
import ar.com.urbanusjam.entity.annotations.PasswordResetToken;

@Repository
@Transactional(propagation= Propagation.REQUIRED, readOnly=false)
public class PasswordResetDAOImpl implements PasswordResetDAO {

	@PersistenceContext(unitName = "fixealaPU")
	private EntityManager entityManager;   
	
	public PasswordResetDAOImpl() {}

	@Override
	public void saveToken(PasswordResetToken token) {		
		entityManager.persist(token);		
	}

	@Override
	public String findUsernameByPasswordToken(String token) throws NoResultException {		
		try{
			PasswordResetToken pwdToken = (PasswordResetToken) entityManager.createQuery(		
				"SELECT t FROM PasswordResetToken t WHERE CURRENT_DATE < t.expiration AND token = :token")
				.setParameter("token", token)	
				.getSingleResult();		
			return pwdToken.getUsername();
		}catch(NoResultException e){
			return null;
		}		
	}

	@Override
	public void deleteToken(String token) throws NoResultException {
		try{
			PasswordResetToken pwdToken = (PasswordResetToken) entityManager.createQuery(
				"SELECT t FROM PasswordResetToken t WHERE t.token = :token")
				.setParameter("token", token)	
				.getSingleResult();		
			entityManager.remove(pwdToken);	
		}catch(NoResultException e){
			throw new NoResultException();
		}	
	}

}
