package ar.com.urbanusjam.dao.impl.utils;

import java.io.Serializable;
import java.util.List;

import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.util.ClassUtils;

import ar.com.urbanusjam.dao.utils.GenericReadableDAO;





/**
 * Implementacion predeterminada de {@link GenericReadableDAO}
 * utilizando {@link HibernateDaoSupport}.
 * 
 * @author
 */
public class GenericReadableDAOImpl<T, PK extends Serializable> 
	extends HibernateDaoSupport 
	implements GenericReadableDAO<T, PK> 
{

	protected final Class<T> persistentClazz;
	private final String persistentClazzName;
	
	/**
	 * Constructor.
	 * @param persistentClazz: clase persistente que manejara el dao.
	 */
	public GenericReadableDAOImpl(Class<T> persistentClazz){
		super();
		this.persistentClazz = persistentClazz;
		this.persistentClazzName = ClassUtils.getShortName(persistentClazz);
	}

	public String getPersistentClazzName() {
		return this.persistentClazzName;
	}

	@SuppressWarnings("unchecked")
	public List<T> findAll() {
		return getHibernateTemplate().find("from " + getPersistentClazzName());
	}

	@SuppressWarnings("unchecked")
	public List<T> findWhere(String where, Object... params) {
		String query = "from " + getPersistentClazzName() + " where " + where;
		HibernateTemplate ht = this.getHibernateTemplate(); 

		final List<T> result = ht.find(query, params); 
		
		return result;
	}

	public T get(Serializable id) {
		final Object instance = this.getHibernateTemplate().get(persistentClazz, id);
		return this.persistentClazz.cast(instance);
	}

	@SuppressWarnings("unchecked")
	public List<T> findByQuery(String query, Object... params) {
		final List<T> result = this.getHibernateTemplate().find(query, params);
		return result;
	}
	
    
//    @SuppressWarnings("unchecked")
//    @Override
//    public PaginatedResult findByCriteria(ParametrosBusqueda parametrosBusqueda, PaginationParameters parametrosPaginacion) {
//        LinkDetachedCriteria criteria = new LinkDetachedCriteria(this.persistentClazz.getName());
//        criteria.addParameters(parametrosBusqueda);
//        List<T>  fullResult = this.getHibernateTemplate().findByCriteria(criteria);
//        List<T>  result = this.getHibernateTemplate().findByCriteria(criteria, parametrosPaginacion.getPaginatedFirstResult(), parametrosPaginacion.getLinesPerPage());
//        
//        return new PaginatedResult(result, 
//                parametrosPaginacion.getLinesPerPage(), 
//                parametrosPaginacion.getPageNumber(), 
//                fullResult.size() );        
//    }   
    /*
    @Override
    public T findUnique(ParametrosBusqueda parametrosBusqueda) {
        List<T> matches = this.findByCriteria(parametrosBusqueda);
        return (matches.size() > 0) ? matches.get(0) : null;
    }
*/
//    @SuppressWarnings("unchecked")
//    @Override
//    public PaginatedResult findByHQL(String hql, final String sqlTotalCount, final Map<String,Object> nameParameters, PaginationParameters paginationParameters) {
//        BigDecimal TotalRowCount =((BigDecimal)getHibernateTemplate().execute(new HibernateCallback(){
//               @Override
//               public Object doInHibernate(Session session) throws HibernateException, SQLException {
//                   SQLQuery query = session.createSQLQuery(sqlTotalCount);
//                   Iterator<String> it = nameParameters.keySet().iterator();
//                   for (; it.hasNext();) {
//                       String param = (String) it.next();
//                       query.setParameter(param, nameParameters.get(param));
//                   }
//                   query.addScalar("count_rows", Hibernate.BIG_DECIMAL);
//                   return query.uniqueResult();
//              }
//        }));
//        
//        List<T> resultados = (List<T>) getHibernateTemplate().execute(new GenericReadeablePaginatedDAOCallback(hql, nameParameters, paginationParameters));
//        PaginatedResult paginatedResult = new PaginatedResult(resultados, paginationParameters.getLinesPerPage(), paginationParameters.getPageNumber(), resultados.size());
//        
//        paginatedResult.setTotalRowCount(TotalRowCount.intValue());
//        return paginatedResult;
//    }
//
//    @SuppressWarnings("unchecked")
//    @Override
//    public List<T> findByHQL(String hql, Map<String, Object> nameParameters) {
//        List<T> resultados = (List<T>)getHibernateTemplate().execute( new GenericReadeableDAOCallback(hql, nameParameters));
//        return resultados;
//    }
//
//    private class GenericReadeableDAOCallback implements HibernateCallback {
//        String hql;
//        Map<String, Object> nameParameters;
//
//        GenericReadeableDAOCallback(String hql,
//                Map<String, Object> nameParameters) {
//            this.hql = hql;
//            this.nameParameters = nameParameters;
//        }
//
//        @Override
//        public Object doInHibernate(Session session) throws HibernateException,
//                SQLException {
//            Query query = session.createQuery(hql);
//            for (String name : nameParameters.keySet()) {
//                query.setParameter(name, nameParameters.get(name));
//            }
//
//            return query.list();
//        }
//
//    }
//    
//    private class GenericReadeablePaginatedDAOCallback implements HibernateCallback {
//        String hql;
//        Map<String, Object> nameParameters;
//        PaginationParameters paginationParameters;
//        
//        GenericReadeablePaginatedDAOCallback(String hql, Map<String,Object> nameParameters, PaginationParameters paginationParameters) {
//            this.hql = hql;
//            this.nameParameters = nameParameters;
//            this.paginationParameters = paginationParameters;
//        }
//
//        @Override
//        public Object doInHibernate(Session session) throws HibernateException,
//                SQLException {
//            Query query = session.createQuery(hql);
//            query.setFirstResult(paginationParameters.getPaginatedFirstResult());
//            query.setMaxResults(paginationParameters.getLinesPerPage());
//            for (String name : nameParameters.keySet()) {
//                query.setParameter(name, nameParameters.get(name));
//            }
//
//            return query.list();
//        }
//    }
}