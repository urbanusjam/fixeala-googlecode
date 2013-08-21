package ar.com.urbanusjam.entity;

import java.io.Serializable;
import java.util.Date;

public class Revision implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private Long id;
	private UserOriginal user;
	private Issue issue;
	private Date date;
	private String previousStatus;
	private String newStatus;
	private String observations;
	
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public UserOriginal getUser() {
		return user;
	}
	
	public void setUser(UserOriginal user) {
		this.user = user;
	}
	
	public Issue getIssue() {
		return issue;
	}
	
	public void setIssue(Issue issue) {
		this.issue = issue;
	}
		
	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getPreviousStatus() {
		return previousStatus;
	}
	
	public void setPreviousStatus(String previousStatus) {
		this.previousStatus = previousStatus;
	}
	
	public String getNewStatus() {
		return newStatus;
	}
	
	public void setNewStatus(String newStatus) {
		this.newStatus = newStatus;
	}
	
	public String getObservations() {
		return observations;
	}
	
	public void setObservations(String observations) {
		this.observations = observations;
	}
	
	
	

}
