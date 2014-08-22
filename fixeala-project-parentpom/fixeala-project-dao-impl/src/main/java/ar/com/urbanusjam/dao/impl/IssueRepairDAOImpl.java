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
	public void deleteReparacion(Long issueID) {
		List<IssueRepair> licitaciones = this.findWhere(" id = ?", issueID);
		this.delete(licitaciones.get(0));
	}
	
}
