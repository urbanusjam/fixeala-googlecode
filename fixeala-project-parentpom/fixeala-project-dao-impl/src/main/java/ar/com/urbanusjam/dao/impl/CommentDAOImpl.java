package ar.com.urbanusjam.dao.impl;

import java.io.Serializable;
import java.util.List;

import ar.com.urbanusjam.dao.CommentDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.entity.annotations.Comment;

public class CommentDAOImpl  extends GenericDAOImpl<Comment, Serializable> implements CommentDAO  {

	public CommentDAOImpl() {
		super(Comment.class);
	}

	@Override
	public List<Comment> findCommentsByIssueId(
			Long issueID) {
//		return findWhere(" issue.id = ? ORDER BY fecha desc ", issueID);
		return findWhere(" issue.id = ? ORDER BY DATE(fecha) desc, TIME(fecha) desc ", issueID);
	}

	@Override
	public void saveComment(Comment comment) {
		this.save(comment);
	}
	
}
