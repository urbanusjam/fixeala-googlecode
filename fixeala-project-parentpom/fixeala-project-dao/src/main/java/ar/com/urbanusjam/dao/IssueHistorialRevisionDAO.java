package ar.com.urbanusjam.dao;

import ar.com.urbanusjam.entity.annotations.IssueUpdateHistory;

public interface IssueHistorialRevisionDAO {
	
	public void saveHistorial(IssueUpdateHistory historial);

}
