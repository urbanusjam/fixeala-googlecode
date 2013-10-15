package ar.com.urbanusjam.services.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;

import ar.com.urbanusjam.dao.IssueDAO;
import ar.com.urbanusjam.dao.IssueHistorialRevisionDAO;
import ar.com.urbanusjam.dao.IssueLicitacionDAO;
import ar.com.urbanusjam.dao.TagDAO;
import ar.com.urbanusjam.entity.annotations.Issue;
import ar.com.urbanusjam.entity.annotations.IssueHistorialRevision;
import ar.com.urbanusjam.entity.annotations.IssueLicitacion;
import ar.com.urbanusjam.entity.annotations.Tag;
import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.IssueHistorialRevisionDTO;
import ar.com.urbanusjam.services.dto.IssueLicitacionDTO;
import ar.com.urbanusjam.services.dto.UserDTO;
import ar.com.urbanusjam.services.utils.Operation;

public class IssueServiceImpl implements IssueService{
	
	private IssueDAO issueDAO;
	private IssueHistorialRevisionDAO historialDAO;
	private TagDAO tagDAO;
	
	public void setIssueDAO(IssueDAO issueDAO) {
		this.issueDAO = issueDAO;
	}
		
	public void setHistorialDAO(IssueHistorialRevisionDAO historialDAO) {
		this.historialDAO = historialDAO;
	}

	public void setTagDAO(TagDAO tagDAO) {
		this.tagDAO = tagDAO;
	}


	@Override
	public void reportIssue(IssueDTO issueDTO, IssueHistorialRevisionDTO historialDTO) {		
		Issue issue = new Issue();
		issue = this.convertTo(issueDTO);
		issueDAO.saveIssue(issue);		
		historialDAO.saveHistorial(convertTo(historialDTO));
	}
	
	@Override
	public void updateIssue(IssueDTO issueDTO, IssueHistorialRevisionDTO historialDTO) {
		Issue issue = new Issue();
		issue = this.convertTo(issueDTO);
		issue.getRevisiones().add(convertTo(historialDTO));
		issueDAO.updateIssue(issue);
	}

	@Override
	public List<IssueDTO> loadAllIssues() {
		List<Issue> issues = new ArrayList<Issue>();
		issues = issueDAO.getAllIssues();
		List<IssueDTO> issuesDTO = new ArrayList<IssueDTO>();
		for(Issue issue : issues){		
			issuesDTO.add(convertToDTO(issue));
		}
		return issuesDTO;	
	}
	
	@Override
	public List<IssueDTO> loadIssuesByStatus(String[] status) {
		List<Issue> issues = new ArrayList<Issue>();
		issues = issueDAO.getIssuesByStatus(status);
		List<IssueDTO> issuesDTO = new ArrayList<IssueDTO>();
		for(Issue issue : issues){			
			issuesDTO.add(convertToDTO(issue));
		}
		return issuesDTO;	
	}
	
	@Override
	public IssueDTO getIssueById(String issueID){
		Issue issue = issueDAO.findIssueById(issueID);
		return convertToDTO(issue);		
	}
	
	/********************************************************************************/
	
	public IssueLicitacion convertTo(IssueLicitacionDTO licitacionDTO){
		IssueLicitacion licitacion = new IssueLicitacion();
		licitacion.setId(Long.valueOf(licitacionDTO.getNroReclamo()));
		licitacion.setNroLicitacion(licitacionDTO.getNroLicitacion());
		licitacion.setNroExpediente(licitacionDTO.getNroExpediente());
		licitacion.setObjeto(licitacionDTO.getObra());
		licitacion.setTipo(licitacionDTO.getTipoObra());
		licitacion.setEstadoObra(licitacionDTO.getEstadoObra());
		licitacion.setUnidadEjecutora(licitacionDTO.getUnidadEjecutora());
		licitacion.setUnidadFinanciamiento(licitacionDTO.getUnidadFinanciamiento());
		licitacion.setEmpresaConstructoraNombre(licitacionDTO.getEmpresaNombre());
		licitacion.setEmpresaConstructoraCuit(licitacionDTO.getEmpresaCuit());
		licitacion.setEmpresaConstructoraEmail(licitacionDTO.getEmpresaEmail());
		licitacion.setRepresentanteTecnicoNombre(licitacionDTO.getRepresentanteNombre());
		licitacion.setRepresentanteTecnicoDni(licitacionDTO.getRepresentanteDni());
		licitacion.setRepresentanteTecnicoEmail(licitacionDTO.getRepresentanteEmail());
		licitacion.setValorPliego(licitacionDTO.getValorPliego());
		licitacion.setPresupuestoAdjudicado(licitacionDTO.getPresupuestoAdjudicado());
		licitacion.setPresupuestoFinal(licitacionDTO.getPresupuestoFinal());
		licitacion.setFechaEstimadaInicio(licitacionDTO.getFechaEstimadaInicio());
		licitacion.setFechaEstimadaFin(licitacionDTO.getFechaEstimadaFin());
		licitacion.setFechaRealInicio(licitacionDTO.getFechaRealInicio());
		licitacion.setFechaRealFin(licitacionDTO.getFechaRealFin());
		return licitacion;
	}
	
	public IssueLicitacionDTO convertTo(IssueLicitacion licitacion){
		
		IssueLicitacionDTO licitacionDTO = new IssueLicitacionDTO();
		licitacionDTO.setNroLicitacion(licitacion.getNroLicitacion());
		licitacionDTO.setNroExpediente(licitacion.getNroExpediente());
		licitacionDTO.setObra(licitacion.getObjeto());
		licitacionDTO.setTipoObra(licitacion.getTipo());
		licitacionDTO.setEstadoObra(licitacion.getEstadoObra());
		licitacionDTO.setUnidadEjecutora(licitacion.getUnidadEjecutora());
		licitacionDTO.setUnidadFinanciamiento(licitacion.getUnidadFinanciamiento());
		licitacionDTO.setEmpresaNombre(licitacion.getEmpresaConstructoraNombre());
		licitacionDTO.setEmpresaCuit(licitacion.getEmpresaConstructoraCuit());
		licitacionDTO.setEmpresaEmail(licitacion.getEmpresaConstructoraEmail());
		licitacionDTO.setRepresentanteNombre(licitacion.getRepresentanteTecnicoNombre());
		licitacionDTO.setRepresentanteDni(licitacion.getRepresentanteTecnicoDni());
		licitacionDTO.setRepresentanteEmail(licitacion.getRepresentanteTecnicoEmail());
		licitacionDTO.setValorPliego(licitacion.getValorPliego());
		licitacionDTO.setPresupuestoAdjudicado(licitacion.getPresupuestoAdjudicado());
		licitacionDTO.setPresupuestoFinal(licitacion.getPresupuestoFinal());
		licitacionDTO.setFechaEstimadaInicio(licitacion.getFechaEstimadaInicio());
		licitacionDTO.setFechaEstimadaFin(licitacion.getFechaEstimadaFin());
		licitacionDTO.setFechaRealInicio(licitacion.getFechaRealInicio());
		licitacionDTO.setFechaRealFin(licitacion.getFechaRealFin());
		return licitacionDTO;
	}
	
	
	public IssueHistorialRevision convertTo(IssueHistorialRevisionDTO historialDTO){
		
		IssueHistorialRevision historial = new IssueHistorialRevision();
		
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(historialDTO.getFecha());		
		User user = new User();
		user.setUsername(historialDTO.getUsername());		
		Issue issue = new Issue();
		issue.setId(Long.valueOf(historialDTO.getNroReclamo()));
		
		historial.setFecha((GregorianCalendar) calendar);	
		historial.setUsuario(user);
		historial.setIssue(issue);
		historial.setOperacion(Operation.UPDATE);
		historial.setMotivo(historialDTO.getMotivo());
		historial.setEstado(historialDTO.getEstado());		
		historial.setObservaciones(historialDTO.getObservaciones());		
		
		return historial;
		
	}
	
	public IssueHistorialRevisionDTO convertTo(IssueHistorialRevision historial){
		
		IssueHistorialRevisionDTO historialDTO = new IssueHistorialRevisionDTO();
		
		historialDTO.setFecha(historial.getFecha().getTime());	
		historialDTO.setUsername(historial.getUsuario().getUsername());
		historialDTO.setNroReclamo(Long.valueOf(historial.getIssue().getId()));
		historialDTO.setOperacion(Operation.UPDATE);
		historialDTO.setMotivo(historial.getMotivo());
		historialDTO.setEstado(historial.getEstado());		
		historialDTO.setObservaciones(historial.getObservaciones());		
		
		return historialDTO;
		
	}
	
	
	public Issue convertTo(IssueDTO issueDTO){
				
		User user = new User();
		user.setUsername(issueDTO.getUser().getUsername());
		
		Issue issue = new Issue();
		issue.setId(issueDTO.getId());
		issue.setReporter(user);
		issue.setAddress(issueDTO.getAddress());
		issue.setNeighborhood(issueDTO.getNeighborhood());
		issue.setCity(issueDTO.getCity());	
		issue.setProvince(issueDTO.getProvince());	
		issue.setTitle(issueDTO.getTitle());
		issue.setDescription(issueDTO.getDescription());
		
		//licitacion
		if(issueDTO.getLicitacion() != null)
			issue.setLicitacion(convertTo(issueDTO.getLicitacion()));
		else
			issue.setLicitacion(null);
	
		//historial de reviciones
		
		
		//tags
		List<String> tagList = issueDTO.getTags();
		
		for(String t : tagList){
			Tag newTag = new Tag();
			newTag.setTagname(t);				
			issue.addTag(newTag);	
		}
		
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(issueDTO.getDate());
		issue.setDate((GregorianCalendar) calendar);		
//		issue.setDate(issueDTO.getDate());		
		issue.setLatitude(Float.parseFloat(issueDTO.getLatitude()));
		issue.setLongitude(Float.parseFloat(issueDTO.getLongitude()));
		issue.setStatus(issueDTO.getStatus());
		
		return issue;
	}
	
	public Issue convertForUpdate(IssueDTO issueDTO){
		
		Issue issue = new Issue();
	
		issue.setId(issueDTO.getId());	
		issue.setTitle(issueDTO.getTitle());
		issue.setDescription(issueDTO.getDescription());

		List<String> tagList = issueDTO.getTags();
	
		for(String t : tagList){
			Tag newTag = new Tag();
			newTag.setTagname(t);				
			issue.addTag(newTag);	
		}						
				
		return issue;
	}
	
	public IssueDTO convertToDTO(Issue issue){
		
		UserDTO userDTO = new UserDTO();
		userDTO.setUsername(issue.getReporter().getUsername());
		
		IssueDTO issueDTO = new IssueDTO();
		issueDTO.setId(issue.getId());
		issueDTO.setUser(userDTO);
		issueDTO.setAddress(issue.getAddress());
		issueDTO.setNeighborhood(issue.getNeighborhood());
		issueDTO.setCity(issue.getCity());	
		issueDTO.setProvince(issue.getProvince());	
		issueDTO.setTitle(issue.getTitle());
		issueDTO.setDescription(issue.getDescription());	
//		issueDTO.setDate(issue.getDate());
		issueDTO.setDate(issue.getDate().getTime());		
		issueDTO.setLatitude(String.valueOf(issue.getLatitude()));
		issueDTO.setLongitude(String.valueOf(issue.getLongitude()));
		issueDTO.setStatus(issue.getStatus());
		
		if(issue.getLicitacion() != null)
			issueDTO.setLicitacion(convertTo(issue.getLicitacion()));
		
		List<IssueHistorialRevisionDTO> historialDTO = new ArrayList<IssueHistorialRevisionDTO>();
		
		for(IssueHistorialRevision revision : issue.getRevisiones()){
			historialDTO.add(convertTo(revision));
		}
		
		issueDTO.setHistorial(historialDTO);
		
		return issueDTO;
	}
	
	

	@Override
	public List<String> getTagList() {
		List<Tag> tagList = new ArrayList<Tag>();
		List<String> list = new ArrayList<String>();
		tagList = tagDAO.getTags();	
		
		for(Tag t : tagList){			
			list.add(t.getTagname());
		}
		
		return list;
				
	}

	

	

	
}
