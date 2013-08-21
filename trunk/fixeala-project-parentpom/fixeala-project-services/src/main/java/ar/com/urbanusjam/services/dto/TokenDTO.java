package ar.com.urbanusjam.services.dto;

import java.io.Serializable;
import java.util.Date;


public class TokenDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String token;
	private String username;
	private Date creation;
	private Date expiration;
	
	public TokenDTO(){}
	
	
	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Date getCreation() {
		return creation;
	}

	public void setCreation(Date creation) {
		this.creation = creation;
	}

	public Date getExpiration() {
		return expiration;
	}

	public void setExpiration(Date expiration) {
		this.expiration = expiration;
	}

	
	
}
