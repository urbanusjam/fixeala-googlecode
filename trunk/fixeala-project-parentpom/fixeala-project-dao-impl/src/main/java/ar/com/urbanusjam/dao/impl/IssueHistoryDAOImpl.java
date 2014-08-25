package ar.com.urbanusjam.dao.impl;

import java.io.Serializable;

import ar.com.urbanusjam.dao.IssueHistoryDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.entity.annotations.IssueUpdateHistory;

public class IssueHistoryDAOImpl extends GenericDAOImpl<IssueUpdateHistory, Serializable> 
implements IssueHistoryDAO {

	public IssueHistoryDAOImpl() {
		super(IssueUpdateHistory.class);
	}

	@Override
	public void saveHistorial(IssueUpdateHistory historial) {
		this.save(historial);		
	}
	
	

}
