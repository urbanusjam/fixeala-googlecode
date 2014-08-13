package ar.com.urbanusjam.jpa.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.TagDAO;
import ar.com.urbanusjam.entity.annotations.Tag;

@Repository
//@Transactional(propagation= Propagation.REQUIRED, readOnly=false)
public class TagDAOImpl implements TagDAO {
	
	@PersistenceContext(unitName = "fixealaPU")
	private EntityManager entityManager; 

	public TagDAOImpl() {}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Tag> getTags() throws PersistenceException {
		try{
			return (List<Tag>)entityManager.createQuery("SELECT t FROM Tag t").getResultList();
		}catch(PersistenceException e){
			return null;
		}
	}

	@Override
	public boolean tagExists(String tagname) {
		try{
			entityManager.createQuery("SELECT t FROM Tag t WHERE t.tagname = :tagname", Tag.class)
					   .setParameter("tagname", tagname)			
				       .getSingleResult();	
			return true;
		}catch(NoResultException e){
			return false;
		}		
	}

	@Override
	public Tag findTagByName(String tagname) {
		try{
			Tag tag = entityManager.createQuery("SELECT t FROM Tag t WHERE t.tagname = :tagname", Tag.class)
					   .setParameter("tagname", tagname)			
				       .getSingleResult();	
			return tag;
		}catch(NoResultException e){
			return null;
		}		
	}

	@Override
	public void deleteTag(Tag tag) {
		entityManager.remove(tag);		
	}
	
	
	public void saveTags(String[] tags){
		for(String tagname : tags){
			entityManager.persist(new Tag(tagname));
		}		
	}
	
	


}
