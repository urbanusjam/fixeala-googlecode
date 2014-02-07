package ar.com.urbanusjam.dao;

import java.util.List;

import ar.com.urbanusjam.entity.annotations.IssueVote;

public interface IssueVoteDAO {
	
	public void saveIssueVote(IssueVote vote);
	
	public IssueVote getVoteByUser(Long idIssue, Long userID);
	
	public List<IssueVote> getVotesByIssue(Long issueID);
	
	public Long getTotalVotesCount(Long issueID);

}
