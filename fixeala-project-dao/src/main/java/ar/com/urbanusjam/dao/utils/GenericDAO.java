package ar.com.urbanusjam.dao.utils;


import java.io.Serializable;
import java.util.Collection;

/**
 * Interface para dao generico
 * 
 * @author 
 *
 */
public interface GenericDAO<T, PK extends Serializable> extends GenericReadableDAO<T, Serializable> {
	
	/**
	 * Persiste un objeto en la DB
	 * @param newInstance
	 * @return
	 */
    PK save(T persitentObject);
    
    /**
     * Persiste una collection de objetos persistentes
     * @param col
     */
    void saveAll(Collection<T> col);
    
    /**
     * Actualiza un objeto persistido
     * @param transientObject
     */
    void update(T persitentObject);

    /**
     * Elimina un objeto
     * @param persistentObject
     */
    void delete(T persitentObject);
    
    
    
    void saveOrUpdate(T persitentObject);
    	
}
