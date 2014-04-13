package ar.com.urbanusjam.dao;

import ar.com.urbanusjam.entity.annotations.IssueRepair;

public interface IssueLicitacionDAO {
	
	public void saveLicitacion(IssueRepair licitacion);
	
	public void updateLicitacion(IssueRepair licitacion);
	
	public void deleteLicitacion(Long idIssue);
	
	public IssueRepair getLicitacionByIssue(Long issueID);

}
