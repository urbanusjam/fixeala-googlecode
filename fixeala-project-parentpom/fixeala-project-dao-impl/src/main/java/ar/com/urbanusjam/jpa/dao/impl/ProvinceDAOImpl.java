package ar.com.urbanusjam.jpa.dao.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.PersistenceException;

import org.springframework.stereotype.Repository;

import ar.com.urbanusjam.dao.ProvinceDAO;

@Repository
public class ProvinceDAOImpl implements ProvinceDAO {
	
	@PersistenceContext(unitName = "fixealaPU")
	private EntityManager entityManager; 
	
	public ProvinceDAOImpl(){}

	@Override
	public List<String> findAllProvinces() {
		try{
			return entityManager.createQuery("SELECT p.nombre FROM Province p").getResultList();
			
		}catch(NoResultException e){
			return null;
		}catch(PersistenceException e){
			return null;
		}	
	}

	@Override
	public List<String> findLocalitiesByProvince(String province) {
		try{
			List<String> localidades = entityManager.createQuery(" SELECT DISTINCT loc.nombre FROM Locality loc " +														   		
															    " JOIN loc.departamento dep "         +
														   " WHERE dep.provincia.nombre  = :province "                  +
														   " ORDER BY loc.nombre ASC ")
					.setParameter("province", province)
					.getResultList(); 
			return localidades;
		}catch(NoResultException e){
			return null;
		}catch(PersistenceException e){
			return null;
		}	
	}
	
}
