package ar.com.urbanusjam.dao.impl;

import java.io.Serializable;

import ar.com.urbanusjam.dao.IssueLicitacionDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.entity.annotations.IssueRepair;

public class IssueLicitacionDAOImpl extends GenericDAOImpl<IssueRepair, Serializable> 
implements IssueLicitacionDAO {

	public IssueLicitacionDAOImpl() {
		super(IssueRepair.class);
	}

	@Override
	public void saveOrUpdateLicitacion(IssueRepair licitacion) {
		this.saveOrUpdate(licitacion);
	}

}
