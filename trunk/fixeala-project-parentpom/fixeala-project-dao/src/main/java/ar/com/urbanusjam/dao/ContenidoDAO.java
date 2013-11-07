package ar.com.urbanusjam.dao;

import java.io.Serializable;
import java.util.List;

import ar.com.urbanusjam.dao.utils.GenericDAO;
import ar.com.urbanusjam.entity.annotations.Contenido;

public interface ContenidoDAO extends GenericDAO<Contenido, Serializable> {
	
	public Contenido findContenidoById(Long idContenido);   
	public List<Contenido> findContenidosByIssue(Long idIssue);	
	public boolean existe(Long idContenido);

}
