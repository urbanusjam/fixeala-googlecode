package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public abstract class Token implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name = "token")
	private String token;

	@Column(name="username")
	private String username;
	
	@Column(name="creation_date")
	private Date creation;
	
	@Column(name="expiration_date")
	private Date expiration;
	
	public Token(){}
	
	public Token(String token, String username, Date creation, Date expiration){
		this.token = token;
		this.username = username;
		this.creation = creation;
		this.expiration = expiration;
	}	
	
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
