package ar.com.urbanusjam.jpa.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import ar.com.urbanusjam.dao.CommentDAO;
import ar.com.urbanusjam.entity.annotations.Comment;

@Repository
public class CommentDAOImpl implements CommentDAO  {
	
	@PersistenceContext(unitName = "fixealaPU")
	private EntityManager entityManager; 

	public CommentDAOImpl() {}

	@Override
	public List<Comment> findCommentsByIssueId(Long issueID) {
		List<Comment> comments = entityManager.createNamedQuery("Comment.findByIssueId", Comment.class)
				   					    .setParameter("id", issueID)
				   					    .getResultList();
		return comments;
	}

	@Override
	public void saveComment(Comment comment) {
		entityManager.persist(comment);
	}
	
}
