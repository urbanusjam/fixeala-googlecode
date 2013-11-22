package ar.com.urbanusjam.dao;

import java.util.List;

import ar.com.urbanusjam.entity.annotations.Comment;

public interface CommentDAO {
	
	public List<Comment> findCommentsByIssueId(Long issueID);
	
	public void saveComment(Comment comment);

}
