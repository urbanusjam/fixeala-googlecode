package ar.com.urbanusjam.jpa.dao.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Repository;

import ar.com.urbanusjam.dao.CommentDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.entity.annotations.Comment;

@Repository
public class CommentDAOImpl  extends GenericDAOImpl<Comment, Serializable> implements CommentDAO  {

	public CommentDAOImpl() {
		super(Comment.class);
	}

	@Override
	public List<Comment> findCommentsByIssueId(
			Long issueID) {
		return findWhere(" issue.id = ? ", issueID);
	}

	@Override
	public void saveComment(Comment comment) {
		this.save(comment);
	}
	
}
