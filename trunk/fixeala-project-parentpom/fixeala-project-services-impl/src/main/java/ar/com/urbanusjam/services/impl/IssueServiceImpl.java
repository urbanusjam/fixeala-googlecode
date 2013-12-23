package ar.com.urbanusjam.services.impl;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.SortedMap;
import java.util.TreeMap;
import java.util.TreeSet;

import org.hibernate.Hibernate;

import ar.com.urbanusjam.dao.AreaDAO;
import ar.com.urbanusjam.dao.CommentDAO;
import ar.com.urbanusjam.dao.IssueDAO;
import ar.com.urbanusjam.dao.IssueHistorialRevisionDAO;
import ar.com.urbanusjam.dao.IssueLicitacionDAO;
import ar.com.urbanusjam.dao.TagDAO;
import ar.com.urbanusjam.dao.UserDAO;
import ar.com.urbanusjam.entity.annotations.Area;
import ar.com.urbanusjam.entity.annotations.Comment;
import ar.com.urbanusjam.entity.annotations.Contenido;
import ar.com.urbanusjam.entity.annotations.Issue;
import ar.com.urbanusjam.entity.annotations.IssueHistorialRevision;
import ar.com.urbanusjam.entity.annotations.IssueLicitacion;
import ar.com.urbanusjam.entity.annotations.Tag;
import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.ContenidoService;
import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.dto.AreaDTO;
import ar.com.urbanusjam.services.dto.CommentDTO;
import ar.com.urbanusjam.services.dto.ContenidoDTO;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.IssueHistorialRevisionDTO;
import ar.com.urbanusjam.services.dto.IssueLicitacionDTO;
import ar.com.urbanusjam.services.dto.UserDTO;
import ar.com.urbanusjam.services.mock.MapUtil;
import ar.com.urbanusjam.services.utils.IssueStatus;
import ar.com.urbanusjam.services.utils.Operation;

public class IssueServiceImpl implements IssueService {
	
	private ContenidoService contenidoService;
	private IssueDAO issueDAO;
	private UserDAO userDAO;
	private AreaDAO areaDAO;
	private TagDAO tagDAO;
	private CommentDAO commentDAO;
	
	
	public void setContenidoService(ContenidoService contenidoService) {
		this.contenidoService = contenidoService;
	}

	public void setIssueDAO(IssueDAO issueDAO) {
		this.issueDAO = issueDAO;
	}

	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}

	public void setAreaDAO(AreaDAO areaDAO) {
		this.areaDAO = areaDAO;
	}

	public void setTagDAO(TagDAO tagDAO) {
		this.tagDAO = tagDAO;
	}
	
	public void setCommentDAO(CommentDAO commentDAO) {
		this.commentDAO = commentDAO;
	}

	@Override
	public void reportIssue(IssueDTO issueDTO) {
		Area area = areaDAO.getAreaById("1"); //cambiar!!!!
		Issue issue = new Issue();
		issue = this.convertTo(issueDTO);
		User u = userDAO.loadUserByUsername(issueDTO.getUser().getUsername());
		issue.setReporter(u);
		issue.setAssignedArea(area);
		asignarUsuarioDefault(issue);
		issueDAO.saveIssue(issue);		
	}
	
	@Override
	public void updateIssue(IssueDTO issueDTO) {
		Issue issue = new Issue();
		issue = this.convertTo(issueDTO);
		issueDAO.updateIssue(issue);
	}
	
	@Override
	public void updateIssueStatus(String issueID, String newStatus) {
	
		Issue issue = new Issue();
		issue = issueDAO.findIssueById(issueID);
		issue.setStatus(newStatus);
		
		IssueHistorialRevisionDTO revision = new IssueHistorialRevisionDTO();
		revision.setFecha(new Date());
		revision.setUsername(issue.getReporter().getUsername());			
		revision.setNroReclamo(issue.getId());			
		revision.setOperacion(Operation.UPDATE);			
		revision.setMotivo("MODIFICACION");			
		revision.setEstado(issue.getStatus());
		revision.setObservaciones("El reclamo ha sido " + newStatus + ".");
		issue.getRevisiones().add(convertTo(revision));
		
		issueDAO.updateIssue(issue);
	}
	
	
	@Override
	public void assignUserToIssue(String issueID, String username) {

		Issue issue = new Issue();
		issue = issueDAO.findIssueById(issueID);
		User user = userDAO.loadUserByUsername(username);
		issue.setAssignedOfficial(user);
		
		IssueHistorialRevisionDTO revision = new IssueHistorialRevisionDTO();
		revision.setFecha(new Date());
		revision.setUsername(issue.getReporter().getUsername());			
		revision.setNroReclamo(issue.getId());			
		revision.setOperacion(Operation.UPDATE);			
		revision.setMotivo("MODIFICACION");			
		revision.setEstado(issue.getStatus());
		revision.setObservaciones("El reclamo ha sido asignado a " + user.getUsername().toUpperCase() + ".");
		issue.getRevisiones().add(convertTo(revision));
		
		issueDAO.updateIssue(issue);
	}
	
	
	private void asignarUsuarioDefault(Issue issue) {
		
		//asignar USUARIO (ADMIN o MANAGER) seg�n AREA
		//obtener usuarios del area
		List<User> users = new ArrayList<User>();
		users = userDAO.findUsersByArea(String.valueOf(issue.getAssignedArea().getId()));
				
			for(User u : users){
									
					List<Issue> assignedIssues = new ArrayList<Issue>();
					assignedIssues = issueDAO.getAssignedIssuesByVerifiedOfficial(u.getUsername());
					
					//asignar si el usuario: 
					
						//- no tiene reclamos asignados
						if(assignedIssues.size() == 0){
							//- lista de reclamos == 0
							issue.setAssignedOfficial(u);
							break;
						}						
						
						//- tiene reclamos asignados
						else{
							boolean hasPendingIssues = false;
							for(Issue i : assignedIssues){
								//- todos resueltos, cerrados o archivados
								if( i.getStatus().equals(IssueStatus.SOLVED) 
										|| i.getStatus().equals(IssueStatus.CLOSED)
										|| i.getStatus().equals(IssueStatus.ARCHIVED) ){
									hasPendingIssues = false;
								}
								else
									hasPendingIssues = true;
							}
							
							if(!hasPendingIssues){
								issue.setAssignedOfficial(u);
								break;
							}
							
							else{
								//- tiene la menor cantidad de reclamos asignados
//								if(hasLessAssignedIssues(users, u)){
//									issue.setAssignedOfficial(u);
//									break;
//								}
								//- random
								//else{
									Random random = new Random();
									int randomUser = 0 + random.nextInt(users.size()-1);
									issue.setAssignedOfficial(users.get(randomUser));
									break;
								//}
							}
							
						}
					
				}
				
		
	}
	
	private boolean hasLessAssignedIssues(List<User> users, User user){
		HashMap<String, Integer> unSorted = new HashMap<String, Integer>();
		
		for(User u : users){
			unSorted.put(u.getUsername(), (issueDAO.getAssignedIssuesByVerifiedOfficial(u.getUsername()).size()));
		}
		
		Map<String, Integer> sorted = (SortedMap<String, Integer>) MapUtil.sortByComparator(unSorted);
		
		if(sorted.entrySet().iterator().next().getKey().equals(user.getUsername()))
			return true;
		
		return false;
		
	}
	
	
	@Override
	public List<IssueDTO> getIssuesAsignados(String username){
		List<Issue> issues = new ArrayList<Issue>();
		issues = issueDAO.getAssignedIssuesByVerifiedOfficial(username);
		List<IssueDTO> issuesDTO = new ArrayList<IssueDTO>();
		for(Issue issue : issues){		
			issuesDTO.add(convertToDTO(issue));
		}
		return issuesDTO;	
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
	public List<IssueDTO> loadIssuesByArea(String areaName) {
		List<Issue> issues = new ArrayList<Issue>();
		issues = issueDAO.getIssuesByArea(areaName);
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

	@Override
	public void postComment(CommentDTO commentDTO) {
		Issue issue = issueDAO.findIssueById(commentDTO.getNroReclamo());
		User user = userDAO.loadUserByUsername(commentDTO.getUsuario());
		Comment comment = new Comment(issue, user, getCurrentCalendar(commentDTO.getFecha()), commentDTO.getMensaje(), false);
		commentDAO.saveComment(comment);		
	}

	@Override
	public List<CommentDTO> getCommentsByIssue(String issueID) {
		List<Comment> comentarios = new ArrayList<Comment>();
		List<CommentDTO> comentariosDTO = new ArrayList<CommentDTO>();
		comentarios = commentDAO.findCommentsByIssueId(Long.valueOf(issueID));
		for(Comment c : comentarios){
			comentariosDTO.add(convertTo(c));
		}		
		return comentariosDTO;
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
		Issue issue = new Issue();		
		issue.setId(Long.valueOf(historialDTO.getNroReclamo()));
		
		historial.setFecha(this.getCurrentCalendar(historialDTO.getFecha()));	
		historial.setUsuario(userDAO.loadUserByUsername(historialDTO.getUsername()));
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
		user = userDAO.loadUserByUsername(issueDTO.getUsername());
		
		Issue issue = new Issue();
		issue.setId(Long.valueOf(issueDTO.getId()));
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
		
		//contenidos
		for(ContenidoDTO contenido : issueDTO.getContenidos()){
			issue.getContenidos().add(contenidoService.convertirAContenido(contenido));
		}
		
		//tags
		List<String> tagList = issueDTO.getTags();
		
		if(tagList.size() > 0){
			for(String t : tagList){
				
				Tag tag = new Tag();
				
				if(tagDAO.tagExists(t))
					tag = tagDAO.findTagByName(t);
				else				
					tag.setTagname(t);			
				
				issue.addTag(tag);	
			}
		}
	
		issue.setDate(this.getCurrentCalendar(issueDTO.getDate()));		
		issue.setLatitude(Float.parseFloat(issueDTO.getLatitude()));
		issue.setLongitude(Float.parseFloat(issueDTO.getLongitude()));
		issue.setStatus(issueDTO.getStatus());
		
		return issue;
	}
	
	public Issue convertForUpdate(IssueDTO issueDTO){
		
		Issue issue = new Issue();	
		issue.setId(Long.valueOf(issueDTO.getId()));	
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
		issueDTO.setId(String.valueOf(issue.getId()));
		issueDTO.setUser(userDTO);
		issueDTO.setAddress(issue.getAddress());
		issueDTO.setNeighborhood(issue.getNeighborhood());
		issueDTO.setCity(issue.getCity());	
		issueDTO.setProvince(issue.getProvince());	
		issueDTO.setTitle(issue.getTitle());
		issueDTO.setDescription(issue.getDescription());	
		issueDTO.setDate(issue.getDate().getTime());		
		issueDTO.setLatitude(String.valueOf(issue.getLatitude()));
		issueDTO.setLongitude(String.valueOf(issue.getLongitude()));
		issueDTO.setStatus(issue.getStatus());
		issueDTO.setUsername(userDTO.getUsername());
		
		//tags		
		Set<Tag> tagList = issue.getTagsList();
		List<String> tagNames = new ArrayList<String>();
		
		if(tagList.size() > 0){
			for(Tag t :  issue.getTagsList()){				
				tagNames.add(t.getTagname());
			}
		}
		
		issueDTO.setTags(tagNames);
		
		//area asignada
		if(issue.getAssignedArea() != null){
			issueDTO.setAssignedArea(convertTo(issue.getAssignedArea()));
			issueDTO.setArea(issue.getAssignedArea().getNombre());
		}
		else{
			issueDTO.setAssignedArea(null);
			issueDTO.setArea("Comuna 1");
		}
		
		if(issue.getAssignedOfficial() != null){
			UserDTO official = new UserDTO();
			official.setUsername(issue.getAssignedArea().getNombre());
			issueDTO.setAssignedOfficial(official);		
		}
		else
			issueDTO.setAssignedOfficial(null);
		
		//licitacion
		if(issue.getLicitacion() != null)
			issueDTO.setLicitacion(convertTo(issue.getLicitacion()));
		else
			issueDTO.setLicitacion(null);
		
		//historial
		List<IssueHistorialRevisionDTO> historialDTO = new ArrayList<IssueHistorialRevisionDTO>();
		
		for(IssueHistorialRevision revision : issue.getRevisiones()){
			historialDTO.add(convertTo(revision));
		}
		
		issueDTO.setHistorial(historialDTO);
		
		//contenidos
		List<ContenidoDTO> contenidosDTO = new ArrayList<ContenidoDTO>();
		
		for(Contenido contenido : issue.getContenidos()){
			contenidosDTO.add(contenidoService.convertirAContenidoDTO(contenido));
		}
		
		issueDTO.setContenidos(contenidosDTO);
		
		//comentarios
		List<CommentDTO> comentariosDTO = new ArrayList<CommentDTO>();
		
		for(Comment comentario : issue.getComentarios()){
			comentariosDTO.add(convertTo(comentario));
		}
		
		issueDTO.setComentarios(comentariosDTO);
		
		return issueDTO;
	}
	
	public CommentDTO convertTo(Comment comment){
		CommentDTO commentDTO = new CommentDTO();
		commentDTO.setUsuario(comment.getUsuario().getUsername());
		commentDTO.setNroReclamo(String.valueOf(comment.getIssue().getId()));
		commentDTO.setFecha(comment.getFecha().getTime());
		commentDTO.setMensaje(comment.getMensaje());
		return commentDTO;
	}
	
	
	private GregorianCalendar getCurrentCalendar(Date date){		
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(date);
		return (GregorianCalendar) calendar;	
	} 
	
}
