package ar.com.urbanusjam.jpa.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.TagDAO;
import ar.com.urbanusjam.entity.annotations.Tag;

@Repository
@Transactional(propagation= Propagation.REQUIRED, readOnly=false)
public class TagDAOImpl implements TagDAO {
	
	@PersistenceContext(unitName = "fixealaPU")
	private EntityManager entityManager; 

	public TagDAOImpl() {}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Tag> getTags() {
		return (List<Tag>)entityManager.createQuery("SELECT t FROM Tag t").getResultList();
	}

	@Override
	public boolean tagExists(String tagname) {
		Tag tag = entityManager.createQuery("SELECT t FROM Tag t WHERE t.tagname = :tagname", Tag.class)
				   .setParameter("tagname", tagname)			
			       .getSingleResult();	
		return tag != null ? true : false;
	}

	@Override
	public Tag findTagByName(String tagname) {
		Tag tag = entityManager.createNamedQuery("SELECT t FROM Tag t WHERE t.tagname = :tagname", Tag.class)
				   .setParameter("tagname", tagname)			
			       .getSingleResult();	
		return tag;
	}

	@Override
	public void deleteTag(Tag tag) {
		entityManager.remove(tag);		
	}
	
	


}
