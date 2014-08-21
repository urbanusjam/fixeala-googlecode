package ar.com.urbanusjam.dao.impl;

import java.io.Serializable;
import java.util.List;

import ar.com.urbanusjam.dao.IssueRepairDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.entity.annotations.IssueRepair;

public class IssueRepairDAOImpl extends GenericDAOImpl<IssueRepair, Serializable> 
implements IssueRepairDAO {

	public IssueRepairDAOImpl() {
		super(IssueRepair.class);
	}

	@Override
	public void saveLicitacion(IssueRepair licitacion) {
		this.save(licitacion);
	}

	@Override
	public void updateLicitacion(IssueRepair licitacion) {
		this.update(licitacion);
	}
	
	@Override
	public void deleteLicitacion(Long issueID) {
		List<IssueRepair> licitaciones = this.findWhere(" id = ?", issueID);
		this.delete(licitaciones.get(0));
	}
	
	@Override
	public IssueRepair getLicitacionByIssue(Long issueID) {
		List<IssueRepair> licitaciones = this.findWhere(" id = ?", issueID);
		return licitaciones.get(0);
	}
}
