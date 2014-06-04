package ar.com.urbanusjam.jpa.dao.impl;

import java.io.Serializable;
import java.util.List;

import org.springframework.stereotype.Repository;

import ar.com.urbanusjam.dao.IssueLicitacionDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.entity.annotations.IssueRepair;

@Repository
public class IssueLicitacionDAOImpl extends GenericDAOImpl<IssueRepair, Serializable> 
	implements IssueLicitacionDAO {

	public IssueLicitacionDAOImpl() {
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
