package ar.com.urbanusjam.jpa.dao.impl;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import ar.com.urbanusjam.dao.IssueHistoryDAO;
import ar.com.urbanusjam.entity.annotations.IssueHistory;

@Repository
public class IssueHistoryDAOImpl implements IssueHistoryDAO {

	@PersistenceContext(unitName = "fixealaPU")
	private EntityManager entityManager; 
	
	public IssueHistoryDAOImpl() {}

	@Override
	public void saveHistorial(IssueHistory historial) {
		entityManager.persist(historial);		
	}
	
	

}
