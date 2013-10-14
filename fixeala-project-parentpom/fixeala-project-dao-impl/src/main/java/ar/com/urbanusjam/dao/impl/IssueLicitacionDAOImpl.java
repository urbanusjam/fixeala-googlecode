package ar.com.urbanusjam.dao.impl;

import java.io.Serializable;

import ar.com.urbanusjam.dao.IssueLicitacionDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.entity.annotations.IssueLicitacion;

public class IssueLicitacionDAOImpl extends GenericDAOImpl<IssueLicitacion, Serializable> 
implements IssueLicitacionDAO {

	public IssueLicitacionDAOImpl() {
		super(IssueLicitacion.class);
	}

	@Override
	public void saveOrUpdateLicitacion(IssueLicitacion licitacion) {
		this.saveOrUpdate(licitacion);
	}

}
