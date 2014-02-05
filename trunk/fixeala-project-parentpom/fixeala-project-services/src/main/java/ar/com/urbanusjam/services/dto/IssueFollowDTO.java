package ar.com.urbanusjam.services.dto;

import java.io.Serializable;
import java.util.Date;

public class IssueFollowDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String idIssue;
	private String username;
	private Date date;
	
	public IssueFollowDTO(){}
	
	public String getIdIssue() {
		return idIssue;
	}
	
	public void setIdIssue(String idIssue) {
		this.idIssue = idIssue;
	}
	
	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public Date getDate() {
		return date;
	}
	
	public void setDate(Date date) {
		this.date = date;
	}
	
	

}
