package ar.com.urbanusjam.dao.impl;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import ar.com.urbanusjam.dao.PasswordResetDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.entity.annotations.PasswordResetToken;

public class PasswordResetDAOImpl extends GenericDAOImpl<PasswordResetToken, Serializable> implements PasswordResetDAO {

	public PasswordResetDAOImpl() {
		super(PasswordResetToken.class);
	}

	@Override
	public void saveToken(PasswordResetToken token) {		
		this.save(token);		
	}

	@Override
	public String findUsernameByPasswordToken(String token) {
		List<PasswordResetToken> passTokens = this.findWhere("token = ? and creation_date < expiration_date", 
				new Object[]{token});		
		return passTokens.size() > 0 ? passTokens.get(0).getUsername() : null;
	}

	@Override
	public void deleteToken(String token) {
		List<PasswordResetToken> passTokens = this.findWhere("token = ? and creation_date < expiration_date", 
				new Object[]{token});
		if(passTokens.size() > 0){
			PasswordResetToken passToken = passTokens.get(0);
			this.delete(passToken);
		}				
	}

}
