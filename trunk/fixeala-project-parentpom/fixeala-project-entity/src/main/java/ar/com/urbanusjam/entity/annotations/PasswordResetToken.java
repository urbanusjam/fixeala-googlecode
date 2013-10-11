package ar.com.urbanusjam.entity.annotations;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="PASSWORD_CHANGE_REQUEST")
public class PasswordResetToken implements Serializable {
	
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "TOKEN")
	private String token;

	@Column(name="USERNAME")
	private String username;
	
	@Column(name="CREATION_DATE")
	private Date creation;
	
	@Column(name="EXPIRATION_DATE")
	private Date expiration;
	
	public PasswordResetToken(){}
	
	public PasswordResetToken(String token, String username, Date creation, Date expiration){
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
