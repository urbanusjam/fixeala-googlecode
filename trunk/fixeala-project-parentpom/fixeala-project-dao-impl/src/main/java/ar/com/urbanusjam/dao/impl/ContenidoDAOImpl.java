package ar.com.urbanusjam.dao.impl;

import java.io.Serializable;
import java.util.List;

import ar.com.urbanusjam.dao.ContenidoDAO;
import ar.com.urbanusjam.dao.impl.utils.GenericDAOImpl;
import ar.com.urbanusjam.entity.annotations.Contenido;

public class ContenidoDAOImpl extends GenericDAOImpl<Contenido, Serializable> implements ContenidoDAO  {

	public ContenidoDAOImpl() {
		super(Contenido.class);
	}

	@Override
	public Contenido findContenidoById(Long idContenido) {
		List<Contenido> contenidos = this.findWhere( " id = ? ", new Object[]{idContenido});    	
    	return contenidos.size() > 0 ? contenidos.get(0) : null; 
	}

	@Override
	public List<Contenido> findContenidosByIssue(Long idIssue) {
		List<Contenido> contenidos = this.findWhere(" issue.id = ? ", new Object[]{idIssue});    	
    	return contenidos; 
	}

	@Override
	public boolean existe(Long idContenido) {
		if ( idContenido == null )
    		return false;
    	List<Contenido> contenidos = this.findWhere("id = ?", new Object[]{idContenido});
    	return contenidos.size() > 0 ? true : false; 
	}
	
	
}
