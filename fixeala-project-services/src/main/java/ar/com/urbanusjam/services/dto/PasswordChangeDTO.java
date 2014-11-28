package ar.com.urbanusjam.services.dto;

import java.io.Serializable;

public class PasswordChangeDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String operation;
	private String token;
	private String username;
	private String currentPassword;
	private String newPassword;
	
		
	public PasswordChangeDTO() {
		super();
	}

	public PasswordChangeDTO(String operation, String token, String username,
			String currentPassword, String newPassword) {
		super();
		this.operation = operation;
		this.token = token;
		this.username = username;
		this.currentPassword = currentPassword;
		this.newPassword = newPassword;
	}

	public String getOperation() {
		return operation;
	}
	
	public void setOperation(String operation) {
		this.operation = operation;
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
	
	public String getCurrentPassword() {
		return currentPassword;
	}
	
	public void setCurrentPassword(String currentPassword) {
		this.currentPassword = currentPassword;
	}
	
	public String getNewPassword() {
		return newPassword;
	}
	
	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}
	
	
	

}
