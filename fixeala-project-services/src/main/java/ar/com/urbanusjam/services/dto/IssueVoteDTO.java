package ar.com.urbanusjam.services.dto;

import java.io.Serializable;

public class IssueVoteDTO extends IssueMainActionDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;

	private int vote;
	private boolean isCurrentlyVoteByUser;
	
	public IssueVoteDTO(){
		this.isCurrentlyVoteByUser = false;
	}
	
	public int getVote() {
		return vote;
	}
	
	public void setVote(int vote) {
		this.vote = vote;
	}
	
	public boolean isCurrentlyVoteByUser() {
		return isCurrentlyVoteByUser;
	}

	public void setCurrentlyVoteByUser(boolean isCurrentlyVoteByUser) {
		this.isCurrentlyVoteByUser = isCurrentlyVoteByUser;
	}
		
}