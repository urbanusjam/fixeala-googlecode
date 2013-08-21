package ar.com.urbanusjam.dao.impl;

import java.io.Serializable;
import java.util.List;

import ar.com.urbanusjam.dao.ActivationDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.entity.annotations.ActivationToken;

public class ActivationDAOImpl extends GenericDAOImpl<ActivationToken, Serializable> implements ActivationDAO {

	public ActivationDAOImpl() {
		super(ActivationToken.class);
	}

	@Override
	public void saveToken(ActivationToken token) {	
		this.save(token);		
	}

	@Override
	public String findUsernameByActivationToken(String token) {
		List<ActivationToken> activTokens = this.findWhere("token = ? and creation_date < expiration_date", 
				new Object[]{token});		
		return activTokens.size() > 0 ? activTokens.get(0).getUsername() : null;
	}

	@Override
	public void deleteToken(String token) {
		List<ActivationToken> activTokens = this.findWhere("token = ? and creation_date < expiration_date", 
				new Object[]{token});
		if(activTokens.size() > 0){
			ActivationToken passToken = activTokens.get(0);
			this.delete(passToken);
		}				
	}

}
