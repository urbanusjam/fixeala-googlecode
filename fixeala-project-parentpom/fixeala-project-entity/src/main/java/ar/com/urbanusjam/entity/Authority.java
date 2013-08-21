package ar.com.urbanusjam.entity;

import org.springframework.security.core.GrantedAuthority;

public class Authority implements GrantedAuthority {

	private static final long serialVersionUID = 1L;
	
	private String username;

    private String authority;  //Spring Security demands them to start with "ROLE_"
    //bi-directional one-to-one association to User
   
    private User user;
    
    public Authority() {
    }
    
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public String getAuthority() {
        return this.authority;
    }
    public void setAuthority(String authority) {
        this.authority = authority;
    }
    public User getUser() {
        return this.user;
    }
    public void setUser(User user) {
        this.user = user;
    }

}
