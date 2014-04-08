package ar.com.urbanusjam.dao.impl;

import java.io.Serializable;

import ar.com.urbanusjam.dao.IssueHistorialRevisionDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.entity.annotations.IssueUpdateHistory;

public class IssueHistorialRevisionDAOImpl extends GenericDAOImpl<IssueUpdateHistory, Serializable> 
implements IssueHistorialRevisionDAO {

	public IssueHistorialRevisionDAOImpl() {
		super(IssueUpdateHistory.class);
	}

	@Override
	public void saveHistorial(IssueUpdateHistory historial) {
		this.save(historial);		
	}
	
	

}
