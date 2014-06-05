package ar.com.urbanusjam.jpa.dao.impl;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import ar.com.urbanusjam.dao.IssueHistorialRevisionDAO;
import ar.com.urbanusjam.entity.annotations.IssueUpdateHistory;

@Repository
public class IssueHistorialRevisionDAOImpl implements IssueHistorialRevisionDAO {

	@PersistenceContext(unitName = "fixealaPU")
	private EntityManager entityManager; 
	
	public IssueHistorialRevisionDAOImpl() {}

	@Override
	public void saveHistorial(IssueUpdateHistory historial) {
		entityManager.persist(historial);		
	}
	
	

}
