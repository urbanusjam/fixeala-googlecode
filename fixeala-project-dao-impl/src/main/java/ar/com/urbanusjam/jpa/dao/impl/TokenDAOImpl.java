package ar.com.urbanusjam.jpa.dao.impl;
/**package ar.com.urbanusjam.dao.impl;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import ar.com.urbanusjam.dao.ActivationDAO;
import ar.com.urbanusjam.dao.PasswordResetDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.entity.annotations.PasswordResetToken;

@SuppressWarnings("rawtypes")
public abstract class TokenDAOImpl<T> extends GenericDAOImpl<T, Serializable> implements ActivationDAO {


	public TokenDAOImpl(Class<T> persistentClazz) {
		super(persistentClazz);
		// TODO Auto-generated constructor stub
	}

	@Override
	public String findUsernameByToken(String token) {
		List<T> tokens = this.findWhere("token = ? and creation_date < expiration_date", 
				new Object[]{token});		
		return tokens.size() > 0 ? tokens.get(0).getUsername() : null;
	}

	@Override
	public void deleteToken(String token) {
		List<T> tokens = this.findWhere("token = ? and creation_date < expiration_date", 
				new Object[]{token});
		if(tokens.size() > 0){
			T t = tokens.get(0);
			this.delete(t);
		}				
	}

}**/
