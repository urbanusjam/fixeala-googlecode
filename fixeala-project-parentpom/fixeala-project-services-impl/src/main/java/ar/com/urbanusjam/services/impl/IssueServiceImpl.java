package ar.com.urbanusjam.services.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import org.hibernate.Hibernate;

import ar.com.urbanusjam.dao.AreaDAO;
import ar.com.urbanusjam.dao.IssueDAO;
import ar.com.urbanusjam.dao.IssueHistorialRevisionDAO;
import ar.com.urbanusjam.dao.IssueLicitacionDAO;
import ar.com.urbanusjam.dao.TagDAO;
import ar.com.urbanusjam.entity.annotations.Area;
import ar.com.urbanusjam.entity.annotations.Issue;
import ar.com.urbanusjam.entity.annotations.IssueHistorialRevision;
import ar.com.urbanusjam.entity.annotations.IssueLicitacion;
import ar.com.urbanusjam.entity.annotations.Tag;
import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.dto.AreaDTO;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.IssueHistorialRevisionDTO;
import ar.com.urbanusjam.services.dto.IssueLicitacionDTO;
import ar.com.urbanusjam.services.dto.UserDTO;
import ar.com.urbanusjam.services.utils.Operation;

public class IssueServiceImpl implements IssueService{
	
	private IssueDAO issueDAO;
	private AreaDAO areaDAO;
	private TagDAO tagDAO;

	
	public void setIssueDAO(IssueDAO issueDAO) {
		this.issueDAO = issueDAO;
	}

	public void setAreaDAO(AreaDAO areaDAO) {
		this.areaDAO = areaDAO;
	}

	public void setTagDAO(TagDAO tagDAO) {
		this.tagDAO = tagDAO;
	}


	@Override
	public void reportIssue(IssueDTO issueDTO) {
		Area area = areaDAO.getAreaByName("Comuna 1");
		int i = area.getIssues().size();
		Issue issue = new Issue();
		issue = this.convertTo(issueDTO);
		issue.setAssignedArea(area);
		issueDAO.saveIssue(issue);		
	}
	
	@Override
	public void updateIssue(IssueDTO issueDTO) {
		int i = 1;
		Issue issue = new Issue();
		issue = this.convertTo(issueDTO);
		issueDAO.updateIssue(issue);
		
		System.out.println("****************************************************** UPDATE ISSUE >>>> " + i);
		i++;
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
	public List<IssueDTO> loadIssuesByUser(String username) {
		List<Issue> issues = new ArrayList<Issue>();
		issues = issueDAO.getIssuesByUser(username);
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
	
	@Override
	public AreaDTO getAreaByName(String areaName) {
		return convertTo(areaDAO.getAreaByName(areaName));
	}
	
	/********************************************************************************/
	
	public Area convertTo(AreaDTO areaDTO){
		Area area = new Area();
		area.setNombre(areaDTO.getAreaName());
		area.setSigla(areaDTO.getAreaAcronym());
		area.setCiudad(areaDTO.getCityName());
		area.setCiudadSigla(areaDTO.getCityAcronym());
		area.setProvincia(areaDTO.getProvinceName());
		area.setProvinciaSigla(areaDTO.getProvinceAcronym());
		return area;
	}
	
	public AreaDTO convertTo(Area area){
		AreaDTO areaDTO = new AreaDTO();
		areaDTO.setAreaName(area.getNombre());
		areaDTO.setAreaAcronym(area.getSigla());
		areaDTO.setCityName(area.getCiudad());
		areaDTO.setCityAcronym(area.getCiudadSigla());
		areaDTO.setProvinceName(area.getProvincia());
		areaDTO.setProvinceAcronym(area.getProvinciaSigla());
		return areaDTO;
	}
	
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
		licitacion.setFechaEstimadaInicio(licitacionDTO.getFechaEstimadaInicio() != null ? licitacionDTO.getFechaEstimadaInicio() : null );
		licitacion.setFechaEstimadaFin(licitacionDTO.getFechaEstimadaFin() != null ? licitacionDTO.getFechaEstimadaFin() : null);
		licitacion.setFechaRealInicio(licitacionDTO.getFechaRealInicio() != null ? licitacionDTO.getFechaRealInicio() : null);
		licitacion.setFechaRealFin(licitacionDTO.getFechaRealFin() != null ? licitacionDTO.getFechaRealFin() : null);
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
	
		//historial de revisiones
		for(IssueHistorialRevisionDTO historial : issueDTO.getHistorial()){
			issue.getRevisiones().add(convertTo(historial));
		}
		
		
		//tags
		List<String> tagList = issueDTO.getTags();
		
		if(tagList.size() > 0){
			for(String t : tagList){
				Tag newTag = new Tag();
				newTag.setTagname(t);				
				issue.addTag(newTag);	
			}
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
		
		if(issue.getAssignedArea() != null){
			issueDTO.setAssignedArea(convertTo(issue.getAssignedArea()));
			issueDTO.setArea(issue.getAssignedArea().getNombre());
		}
		else{
			issueDTO.setAssignedArea(null);
			issueDTO.setArea("Comuna 1");
		}
		
		if(issue.getLicitacion() != null)
			issueDTO.setLicitacion(convertTo(issue.getLicitacion()));
		else
			issueDTO.setLicitacion(null);
		
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
