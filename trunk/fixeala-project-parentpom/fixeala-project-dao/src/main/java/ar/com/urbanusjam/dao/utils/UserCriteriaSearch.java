package ar.com.urbanusjam.dao.utils;

public class UserCriteriaSearch {
	
	private String[] usernames;
	private String[] roles;
	private boolean enabled;
	
	public String[] getUsernames() {
		return usernames;
	}
	
	public void setUsernames(String[] usernames) {
		this.usernames = usernames;
	}
	
	public String[] getRoles() {
		return roles;
	}
	
	public void setRoles(String[] roles) {
		this.roles = roles;
	}
	
	public boolean isEnabled() {
		return enabled;
	}
	
	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	
	

}
