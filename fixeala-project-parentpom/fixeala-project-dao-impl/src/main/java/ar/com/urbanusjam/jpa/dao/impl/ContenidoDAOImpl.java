package ar.com.urbanusjam.jpa.dao.impl;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.ContenidoDAO;
import ar.com.urbanusjam.entity.annotations.MediaContent;

@Repository
@Transactional(propagation= Propagation.REQUIRED, readOnly=false)
public class ContenidoDAOImpl implements ContenidoDAO  {
	
	@PersistenceContext(unitName = "fixealaPU")
	private EntityManager entityManager; 

	public ContenidoDAOImpl() {}

	@Override
	public MediaContent findContenidoById(Long idContenido) {
		List<MediaContent> contenidos = this.findWhere( " id = ? ", new Object[]{idContenido});    	
    	return contenidos.size() > 0 ? contenidos.get(0) : null; 
	}

	@Override
	public List<MediaContent> findContenidosByIssue(Long idIssue) {
//		List<Contenido> contenidos = this.findWhere(" issue.id = ? ", new Object[]{idIssue});    	
		
		
		List<MediaContent> contenidos =  null;/**getSessionFactory().getCurrentSession().createCriteria(MediaContent.class)  	
			
				.createAlias("issue", "i")
				.add(Restrictions.eq("i.id", idIssue))
		        .addOrder(Order.asc("orden") )
		        .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
		        .list();**/
		
    	return contenidos; 
	}	
	
	@Override
	public void deleteContenidosByIssue(Collection<MediaContent> contenidos, Long idIssue) {
		
		/**Session session = getSessionFactory().getCurrentSession();
		Transaction tx = session.beginTransaction();
		
		try{				
			
			Long[] contenidosID = new Long[contenidos.size()];
			int index = 0;
			
			for (MediaContent c : contenidos) {
				contenidosID[index] = c.getId();	
				index++;
			}
					
			String hql = "DELETE FROM Contenido c WHERE c.id IN (:contenidosID)";
			session.createQuery(hql).setParameterList("contenidosID", contenidosID).executeUpdate();
			
			
			tx.commit();
					
		} catch (Exception e) {
		
			  tx.rollback();		 
			  session.close();
		  
		} finally {
			
			 session.flush();
			 session.clear();
			 session.close();
			 
		}	**/	
	     
	}
	
	@Override
	public boolean existe(Long idContenido) {
		if ( idContenido == null )
    		return false;
    	List<MediaContent> contenidos = this.findWhere("id = ?", new Object[]{idContenido});
    	return contenidos.size() > 0 ? true : false; 
	}

	@Override
	public MediaContent findContenidoByContenidoAndIssue(Long idContenido, Long idIssue) {
		List<MediaContent> contenidos = this.findWhere( " id = ? AND issue.id = ? AND profilePic = false ", new Object[]{idContenido, idIssue});    	
    	return contenidos.size() > 0 ? contenidos.get(0) : null; 
	}

	@Override
	public MediaContent findUserProfilePic(Long idUser) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void deleteContenido(MediaContent contenido) {
		this.delete(contenido);
	}

	@Override
	public Serializable save(MediaContent persitentObject) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void saveAll(Collection<MediaContent> col) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(MediaContent persitentObject) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(MediaContent persitentObject) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void saveOrUpdate(MediaContent persitentObject) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public String getPersistentClazzName() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MediaContent> findAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MediaContent> findWhere(String where, Object... params) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<MediaContent> findByQuery(String query, Object... params) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public MediaContent get(Serializable id) {
		// TODO Auto-generated method stub
		return null;
	}

		
}
