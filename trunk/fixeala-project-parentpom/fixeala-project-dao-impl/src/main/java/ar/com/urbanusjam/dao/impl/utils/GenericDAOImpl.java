package ar.com.urbanusjam.dao.impl.utils;


import java.io.Serializable;
import java.util.Collection;

import ar.com.urbanusjam.dao.utils.GenericDAO;





/**
 * Implementacion de dao generico
 * @author 
 *
 * @param <T>
 * @param <PK>
 */
public class GenericDAOImpl<T, PK extends Serializable> 
	extends GenericReadableDAOImpl<T, Serializable>
	implements GenericDAO<T, Serializable>
{

	/**
	 * Constructor.
	 * @param persistentClazz: clase persistente que manejara el dao.
	 */
	public GenericDAOImpl(Class<T> persistentClazz){
		super(persistentClazz);
	}
	
	public void delete(T persitentObject) {
		getHibernateTemplate().delete(persitentObject);
	}
	
	
	@SuppressWarnings("unchecked")
	public PK save(T persitentObject) {
        return (PK) getHibernateTemplate().save(persitentObject);
	}
	
//	@SuppressWarnings("unchecked")
//	public PK save(Class<T> token) {
//        return (PK) getHibernateTemplate().save(token);
//	}
	
	public void saveAll(Collection<T> col) {
		for (T t : col) {
			getHibernateTemplate().save(t);
		}
	}

	public void update(T persitentObject) {
		getHibernateTemplate().update(persitentObject);
	}
	
	public void saveOrUpdate(T persitentObject) {
		getHibernateTemplate().saveOrUpdate(persitentObject);
	}

}