package ar.com.urbanusjam.dao.utils;

import java.io.Serializable;
import java.util.List;




//import ar.com.link.dao.pagination.PaginatedResult;
//import ar.com.link.dao.pagination.PaginationParameters;
//import ar.com.link.domain.ParametrosBusqueda;

/**
 * DAO Generico, que solo permite buscar instancias
 * de un determinado tipo.
 * 
 * @author 
 *
 */
public interface GenericReadableDAO<T, PK extends Serializable> {

	/**
	 * Regresa el nombre de la clase persistente
	 * @return
	 */
	public String getPersistentClazzName();

	/**
     * Regresa todos los objetos persistidos
     * @return
     */
    public List<T> findAll();

    /**
     * Hace consultas ingresando la clausula where y una lista de parametros
     * @param where
     * @return
     */
	public List<T> findWhere(String where, Object... params);
	
	/**
	 * Hace consultas tomando como parametro la consulta completa
	 * y una lista de parametros
	 * @param query
	 * @return
	 */
	public List<T> findByQuery(String query, Object... params);
    
    
	/**
     * Regresa un objeto por su ID
     * @param id
     * @return
     */
    public T get(PK id);
    
	
//	/* Evaluar utilidad **********************************************************************************************************/
//    
//    /**
//     * Hace consultas hql tomando como parametro la consulta completa y una lista de parametros
//     * @param query hql
//     * @return
//     */
//    public List<T> findByHQL(String hql, Map<String,Object> nameParameters);
//
//	/**
//	 * Busca una entidad por determinados par�metros de b�squeda
//	 * @param parametrosBusqueda par�metros de b�squeda para filtrar
//	 * @return
//	 */
//	public List<T> findByCriteria(ParametrosBusqueda parametrosBusqueda);
//	
//	/**
//	 * Busca una entidad por determinados par�metros de b�squeda y paginacion
//	 * @param parametrosBusqueda par�metros de b�squeda para filtrar
//	 * @return
//	 */
//	public PaginatedResult findByCriteria(ParametrosBusqueda parametrosBusqueda, PaginationParameters parametrosPaginacion);	
//
	/**
	 * Busca una entidad individual que corresponde con los par�metros de b�squeda 
	 * @param parametrosBusqueda par�metros de b�squeda para filtrar
	 * @return
	 */
	//public T findUnique(ParametrosBusqueda parametrosBusqueda);
//
//
//
//    /**
//     * Hace consultas hql paginadas tomando como parametro la consulta completa, count de consulta completa los parametros de paginacion y una lista de parametros
//     * @param query hql
//     * @return
//     */
//	public PaginatedResult findByHQL(String hql, final String sqlTotalCount, final Map<String, Object> nameParameters, PaginationParameters paginationParameters);
//	
//	/**********************************************************************************************************************/
//	
}
