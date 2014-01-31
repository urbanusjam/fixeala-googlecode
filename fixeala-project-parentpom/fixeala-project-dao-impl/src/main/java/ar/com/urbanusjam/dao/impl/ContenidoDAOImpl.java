package ar.com.urbanusjam.dao.impl;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.ContenidoDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.entity.annotations.Contenido;
import ar.com.urbanusjam.entity.annotations.Issue;

@Transactional(propagation= Propagation.REQUIRED, readOnly=false)
public class ContenidoDAOImpl extends GenericDAOImpl<Contenido, Serializable> implements ContenidoDAO  {

	public ContenidoDAOImpl() {
		super(Contenido.class);
	}

	@Override
	public Contenido findContenidoById(Long idContenido) {
		List<Contenido> contenidos = this.findWhere( " id = ? ", new Object[]{idContenido});    	
    	return contenidos.size() > 0 ? contenidos.get(0) : null; 
	}

	@Override
	public List<Contenido> findContenidosByIssue(Long idIssue) {
//		List<Contenido> contenidos = this.findWhere(" issue.id = ? ", new Object[]{idIssue});    	
		
		
		List<Contenido> contenidos = getSessionFactory().getCurrentSession().createCriteria(Contenido.class)  	
			
				.createAlias("issue", "i")
				.add(Restrictions.eq("i.id", idIssue))
		        .addOrder(Order.asc("orden") )
		        .setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY)
		        .list();
		
    	return contenidos; 
	}	
	
	@Override
	public void deleteContenidosByIssue(Collection<Contenido> contenidos, Long idIssue) {
		
		Session session = getSessionFactory().getCurrentSession();
		Transaction tx = session.beginTransaction();
		
		try{				
			
			Long[] contenidosID = new Long[contenidos.size()];
			int index = 0;
			
			for (Contenido c : contenidos) {
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
			 
		}		
	     
	}
	
	@Override
	public boolean existe(Long idContenido) {
		if ( idContenido == null )
    		return false;
    	List<Contenido> contenidos = this.findWhere("id = ?", new Object[]{idContenido});
    	return contenidos.size() > 0 ? true : false; 
	}

	@Override
	public Contenido findContenidoByContenidoAndIssue(Long idContenido, Long idIssue) {
		List<Contenido> contenidos = this.findWhere( " id = ? AND issue.id = ? AND profilePic = false ", new Object[]{idContenido, idIssue});    	
    	return contenidos.size() > 0 ? contenidos.get(0) : null; 
	}

	@Override
	public Contenido findUserProfilePic(Long idUser) {
		// TODO Auto-generated method stub
		return null;
	}

		
}
