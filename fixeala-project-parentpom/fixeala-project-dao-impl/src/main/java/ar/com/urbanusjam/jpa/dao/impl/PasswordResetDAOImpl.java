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
				" SELECT t1 FROM PasswordResetToken t1 " +
				" WHERE t1.token = :token AND CURRENT_DATE < t1.expiration " +
				" AND t1.creation = (SELECT MAX(t2.creation) FROM PasswordResetToken t2) ")
				.setParameter("token", token)	
				.getSingleResult();		
			return pwdToken.getUsername();
		}catch(NoResultException e){
			return null;
		}		
	}
	/*
	SELECT t1.*
	FROM password_change_request t1
	WHERE t1.username = 'helloworld' 
	AND t1.creation_date < t1.expiration_date 
	AND t1.creation_date = (SELECT MAX(t2.creation_date)
	                 FROM  password_change_request t2
	                 WHERE t2.username = t1.username)
	                 */

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
