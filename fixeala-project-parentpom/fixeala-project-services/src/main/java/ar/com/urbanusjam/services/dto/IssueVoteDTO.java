package ar.com.urbanusjam.services.dto;

import java.io.Serializable;
import java.util.Date;

public class IssueVoteDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String idIssue;
	private String username;
	private int vote;
	private Date date;
	private boolean isCurrentlyVoteByUser;
	
	public IssueVoteDTO(){
		this.isCurrentlyVoteByUser = false;
	}
	
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
	public int getVote() {
		return vote;
	}
	public void setVote(int vote) {
		this.vote = vote;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}

	public boolean isCurrentlyVoteByUser() {
		return isCurrentlyVoteByUser;
	}

	public void setCurrentlyVoteByUser(boolean isCurrentlyVoteByUser) {
		this.isCurrentlyVoteByUser = isCurrentlyVoteByUser;
	}
	
	
}