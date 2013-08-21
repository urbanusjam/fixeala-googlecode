package ar.com.urbanusjam.web.forms;

import java.io.Serializable;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;



public class RegistrationForm implements Serializable {

	private static final long serialVersionUID = 1L;

	@NotEmpty
	private String username;  
	
	@NotEmpty
    @Email
    private String email;
	
	@NotEmpty
    private String password;   

	private String confirmPassword;    
    

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
    public void setEmail(String email) {
            this.email = email;
    }

    public String getEmail() {
            return email;
    }

	public void setPassword(String password) {
            this.password = password;
    }

    public String getPassword() {
            return password;
    }

    public void setConfirmPassword(String confirmPassword) {
            this.confirmPassword = confirmPassword;
    }

    public String getConfirmPassword() {
            return confirmPassword;
    }


}
