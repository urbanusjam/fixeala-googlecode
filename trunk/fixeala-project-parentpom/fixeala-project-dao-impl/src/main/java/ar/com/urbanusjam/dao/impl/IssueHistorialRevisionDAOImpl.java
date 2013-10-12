package ar.com.urbanusjam.dao.impl;

import java.io.Serializable;

import ar.com.urbanusjam.dao.IssueDAO;
import ar.com.urbanusjam.dao.IssueHistorialRevisionDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.entity.annotations.Issue;
import ar.com.urbanusjam.entity.annotations.IssueHistorialRevision;

public class IssueHistorialRevisionDAOImpl extends GenericDAOImpl<IssueHistorialRevision, Serializable> 
implements IssueHistorialRevisionDAO {

	public IssueHistorialRevisionDAOImpl() {
		super(IssueHistorialRevision.class);
	}

	@Override
	public void saveHistorial(IssueHistorialRevision historial) {
		this.save(historial);		
	}
	
	

}
