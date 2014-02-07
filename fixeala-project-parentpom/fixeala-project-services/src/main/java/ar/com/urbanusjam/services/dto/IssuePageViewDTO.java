package ar.com.urbanusjam.services.dto;

import java.io.Serializable;
import java.util.Date;

public class IssuePageViewDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String issueID;
	private String username;
	private String ipAddress;
	private Date date;
	

	public String getIssueID() {
		return issueID;
	}

	public void setIssueID(String issueID) {
		this.issueID = issueID;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getIpAddress() {
		return ipAddress;
	}

	public void setIpAddress(String ipAddress) {
		this.ipAddress = ipAddress;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	

	

}
