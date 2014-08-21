package ar.com.urbanusjam.jpa.dao.impl;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Repository;

import ar.com.urbanusjam.dao.IssueRepairDAO;
import ar.com.urbanusjam.entity.annotations.IssueRepair;

@Repository
public class IssueRepairDAOImpl implements IssueRepairDAO {
	
	@PersistenceContext(unitName = "fixealaPU")
	private EntityManager entityManager; 

	public IssueRepairDAOImpl() {}

	@Override
	public void saveLicitacion(IssueRepair licitacion) {
		entityManager.persist(licitacion);
	}

	@Override
	public void updateLicitacion(IssueRepair licitacion) {
		entityManager.merge(licitacion);
		entityManager.flush();
	}
	
	@Override
	public void deleteLicitacion(Long issueID) {
		IssueRepair licitacion = entityManager.createNamedQuery("IssueRepair.findById", IssueRepair.class)
				   .setParameter("id", issueID)
			       .getSingleResult();	
		entityManager.remove(licitacion);
	}
	
	@Override
	public IssueRepair getLicitacionByIssue(Long issueID) {
		IssueRepair licitacion = entityManager.createNamedQuery("IssueRepair.findById", IssueRepair.class)
											  .setParameter("id", issueID)
											  .getSingleResult();
		return licitacion;
	}
}
