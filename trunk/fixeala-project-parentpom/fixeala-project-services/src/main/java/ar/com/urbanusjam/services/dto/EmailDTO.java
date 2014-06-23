package ar.com.urbanusjam.services.dto;

import java.io.Serializable;

public class EmailDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private String from;
	private String to;
	private String subject;
	private String username;
	private String issueTitle;
	private String url;
	private String message;
	
	public EmailDTO(){}
	
	public String getFrom() {
		return from;
	}
	
	public void setFrom(String from) {
		this.from = from;
	}
	
	public String getTo() {
		return to;
	}
	
	public void setTo(String to) {
		this.to = to;
	}
	
	public String getSubject() {
		return subject;
	}
	
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getIssueTitle() {
		return issueTitle;
	}
	
	public void setIssueTitle(String issueTitle) {
		this.issueTitle = issueTitle;
	}
	
	public String getUrl() {
		return url;
	}
	
	public void setUrl(String url) {
		this.url = url;
	}
	
	public String getMessage() {
		return message;
	}
	
	public void setMessage(String message) {
		this.message = message;
	}
	
	
	

}
