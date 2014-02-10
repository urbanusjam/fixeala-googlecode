package ar.com.urbanusjam.services.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.Set;
import java.util.SortedMap;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import ar.com.urbanusjam.dao.AreaDAO;
import ar.com.urbanusjam.dao.CommentDAO;
import ar.com.urbanusjam.dao.IssueDAO;
import ar.com.urbanusjam.dao.IssueFollowDAO;
import ar.com.urbanusjam.dao.IssuePageViewDAO;
import ar.com.urbanusjam.dao.IssueVoteDAO;
import ar.com.urbanusjam.dao.TagDAO;
import ar.com.urbanusjam.dao.UserDAO;
import ar.com.urbanusjam.dao.utils.IssueCriteriaSearchRaw;
import ar.com.urbanusjam.entity.annotations.Area;
import ar.com.urbanusjam.entity.annotations.Comment;
import ar.com.urbanusjam.entity.annotations.Contenido;
import ar.com.urbanusjam.entity.annotations.Issue;
import ar.com.urbanusjam.entity.annotations.IssueFollow;
import ar.com.urbanusjam.entity.annotations.IssueFollowPK;
import ar.com.urbanusjam.entity.annotations.IssueHistorialRevision;
import ar.com.urbanusjam.entity.annotations.IssueLicitacion;
import ar.com.urbanusjam.entity.annotations.IssuePageView;
import ar.com.urbanusjam.entity.annotations.IssueVote;
import ar.com.urbanusjam.entity.annotations.IssueVotePK;
import ar.com.urbanusjam.entity.annotations.Tag;
import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.ContenidoService;
import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.UserService;
import ar.com.urbanusjam.services.dto.AreaDTO;
import ar.com.urbanusjam.services.dto.CommentDTO;
import ar.com.urbanusjam.services.dto.ContenidoDTO;
import ar.com.urbanusjam.services.dto.IssueCriteriaSearch;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.IssueFollowDTO;
import ar.com.urbanusjam.services.dto.IssueHistorialRevisionDTO;
import ar.com.urbanusjam.services.dto.IssueLicitacionDTO;
import ar.com.urbanusjam.services.dto.IssuePageViewDTO;
import ar.com.urbanusjam.services.dto.IssueVoteDTO;
import ar.com.urbanusjam.services.dto.UserDTO;
import ar.com.urbanusjam.services.mock.MapUtil;
import ar.com.urbanusjam.services.utils.DateUtils;
import ar.com.urbanusjam.services.utils.IssueStatus;
import ar.com.urbanusjam.services.utils.Operation;
import ar.com.urbanusjam.services.utils.SortingDataUtils;


@Service("issueService")
public class IssueServiceImpl implements IssueService {
	
	private UserService userService;
	private ContenidoService contenidoService;
	private IssueDAO issueDAO;
	private UserDAO userDAO;
	private AreaDAO areaDAO;
	private TagDAO tagDAO;
	private CommentDAO commentDAO;
	private IssueFollowDAO issueFollowDAO;
	private IssuePageViewDAO issuePageViewDAO;
	private IssueVoteDAO issueVoteDAO;
	
	
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

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
	
	public void setIssueFollowDAO(IssueFollowDAO issueFollowDAO) {
		this.issueFollowDAO = issueFollowDAO;
	}

	public void setIssueVoteDAO(IssueVoteDAO issueVoteDAO) {
		this.issueVoteDAO = issueVoteDAO;
	}

	public void setIssuePageViewDAO(IssuePageViewDAO issuePageViewDAO) {
		this.issuePageViewDAO = issuePageViewDAO;
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
				
		Collection<Tag> newTags = new ArrayList<Tag>(); 
		Collection<Tag> currentTags = new ArrayList<Tag>();
		Collection<Tag> removeTags = new ArrayList<Tag>();

		newTags = issue.getTagsList();
		currentTags = issueDAO.findIssueTagsById(issueDTO.getId());
		currentTags.removeAll(newTags);	
		removeTags = currentTags;
		
		if(removeTags.size() < currentTags.size()){
			for(Tag tag : removeTags){	
				issue.getTagsList().removeAll(removeTags);	
				tag.getIssueList().remove(issue);
			}
		}			
		
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
		issueDTO.setStatusCss(this.assignCSSbyStatus(issue.getStatus()));
		issueDTO.setUsername(userDTO.getUsername());
		issueDTO.setFechaFormateada(issue.getDate().getTime());
		
		//tags		
		Set<Tag> tagList = issue.getTagsList();
		List<String> tagNames = new ArrayList<String>();
		
		if(tagList.size() > 0){
			for(Tag t :  issue.getTagsList()){				
				tagNames.add(t.getTagname().trim());
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
			ContenidoDTO contenidoDTO = contenidoService.convertirAContenidoDTO(contenido);
			contenidoDTO.setFile(contenidoService.abrirContenidoFile(contenidoDTO));
			contenidosDTO.add(contenidoDTO);
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
		commentDTO.setFechaFormateada(comment.getFecha().getTime());
		commentDTO.setMensaje(comment.getMensaje());
		return commentDTO;
	}
	
	public IssueFollow convertTo(IssueFollowDTO followingDTO){
		IssueFollow following = new IssueFollow();
		IssueFollowPK followingId = new IssueFollowPK();		
		followingId.setIssueID(Long.valueOf(followingDTO.getIdIssue()));
		User u = userDAO.loadUserByUsername(followingDTO.getUsername());
		followingId.setFollowerID(u.getId());
		following.setId(followingId);
		following.setDate(followingDTO.getDate() != null ? this.getCurrentCalendar(followingDTO.getDate()) : null);
		return following;
	}
	
	
	private GregorianCalendar getCurrentCalendar(Date date){		
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(date);
		return (GregorianCalendar) calendar;	
	} 
	
	private String assignCSSbyStatus(String status){
		
		String css = StringUtils.EMPTY;
		
		if(status.equals(IssueStatus.OPEN)){
			css = "label label-important";
		}
		
		if(status.equals(IssueStatus.ACKNOWLEDGED)){
			css = "label label-info";
		}
		
		if(status.equals(IssueStatus.IN_PROGRESS)){
			css = "label label-warning";
		}
		
		if(status.equals(IssueStatus.SOLVED)){
			css = "label label-success";
		}
		
		if(status.equals(IssueStatus.REOPENED)){
			css = "label label-important";
		}
		
		if(status.equals(IssueStatus.CLOSED)){
			css = "label label-inverse";
		}
		
		if(status.equals(IssueStatus.ARCHIVED)){
			css = "label";
		}
		
		return css;
	}

	@Override
	public void followIssue(IssueFollowDTO followingDTO) {	
		issueFollowDAO.saveFollowing(convertTo(followingDTO));
	}

	@Override
	public void unFollowIssue(IssueFollowDTO followingDTO) {
		issueFollowDAO.deleteFollowing(convertTo(followingDTO));		
	}

	@Override
	public boolean isUserFollowingIssue(IssueFollowDTO followingDTO) {
		IssueFollow following = issueFollowDAO.findFollowing(convertTo(followingDTO));
		return following != null;
	}

	@Override
	public List<String> getIssueFollowers(String issueID) {
		List<IssueFollow> followings = new ArrayList<IssueFollow>();
		List<String> followers = new ArrayList<String>();
		followings = issueFollowDAO.findFollowingsByIssue(Long.valueOf(issueID));
		
		for(IssueFollow f : followings){
			followers.add(f.getFollower().getUsername());
		}
		
		return followers;			
	}

	@Override
	public List<String> getUserFollowings(String username) {
		List<IssueFollow> followings = new ArrayList<IssueFollow>();
		List<String> issuesFollowed = new ArrayList<String>();		
		User follower = userService.loadUserByUsername(username);
		
		followings = issueFollowDAO.findFollowingsByUser(follower.getId());
		for(IssueFollow f : followings){
			issuesFollowed.add(String.valueOf(f.getIssue().getId()));
		}
		
		return issuesFollowed;
	}

	@Override
	public boolean trackIssuePageView(IssuePageViewDTO pageviewDTO) {
		
		boolean pageviewExists = false;
		pageviewExists = issuePageViewDAO.existsIssuePageView(Long.valueOf(pageviewDTO.getIssueID()), pageviewDTO.getUsername());
		
		if(!pageviewExists){
			IssuePageView pageview = new IssuePageView();
			Issue issue = new Issue();
			issue.setId(Long.valueOf(pageviewDTO.getIssueID()));
			pageview.setIssue(issue);
			User user = userDAO.loadUserByUsername(pageviewDTO.getUsername());
			pageview.setUser(user);
			pageview.setDate(this.getCurrentCalendar(pageviewDTO.getDate()));
			issuePageViewDAO.saveIssuePageView(pageview);
			return true;
		}
		else{
			return false;
		}
	}

	@Override
	public int getIssuePageViews(String issueID) {
		return issuePageViewDAO.getIssuePageViews(Long.valueOf(issueID));
	}

	@Override
	public void voteIssue(IssueVoteDTO voteDTO) {
		IssueVote vote = new IssueVote();		
		IssueVotePK voteId = new IssueVotePK();		
		voteId.setIssueID(Long.valueOf(voteDTO.getIdIssue()));	
		voteId.setVoterID(userService.getUserId(voteDTO.getUsername()));
		vote.setId(voteId);
		vote.setVote(voteDTO.getVote());
		vote.setDate(voteDTO.getDate() != null ? this.getCurrentCalendar(voteDTO.getDate()) : null);				
		issueVoteDAO.saveIssueVote(vote);
	}

	@Override
	public IssueVoteDTO getCurrentVote(String issueID, String username) {
		IssueVoteDTO voteDTO = new IssueVoteDTO();
		User user = new User();		
		user.setId(userService.getUserId(username));
		IssueVote vote = issueVoteDAO.getVoteByUser(Long.valueOf(issueID), user.getId());
		
		if(vote != null){
			voteDTO.setIdIssue(String.valueOf(vote.getId().getIssueID()));
			voteDTO.setUsername(user.getUsername());
			voteDTO.setVote(vote.getVote());
			voteDTO.setDate(vote.getDate().getTime());
			voteDTO.setCurrentlyVoteByUser(true);
		}
		else
			voteDTO.setCurrentlyVoteByUser(false);
			
		return voteDTO;				
	}

	@Override
	public Long countIssueVotes(String issueID) {
		return issueVoteDAO.getTotalVotesCount(Long.valueOf(issueID));
	}

	@Override
	public void generateDataset(IssueCriteriaSearch search) {
		
		IssueCriteriaSearchRaw rawSearch =  new IssueCriteriaSearchRaw();
		
		SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		SimpleDateFormat reFormat = new SimpleDateFormat("yyyy-MM-dd");
		 
		 try {
//			 	Calendar minDate = DateUtils.toCalendar(dateFormat.parse(search.getMinFecha()));
//			 	Calendar maxDate = DateUtils.toCalendar(dateFormat.parse(search.getMaxFecha()));	
			 
			 	Date minDate = format.parse(search.getMinFecha());
			 	Date maxDate = format.parse(search.getMaxFecha());	
			 				 	
			 	String aux1 = reFormat.format(minDate.getTime());
			 	String aux2 = reFormat.format(maxDate.getTime());
			 	
			 	Calendar minDate2 = DateUtils.toCalendar(reFormat.parse(aux1));
				Calendar maxDate2 = DateUtils.toCalendar(reFormat.parse(aux2));	
			 	
			 	
			 	rawSearch.setEstadosArray(search.getEstados().split(","));
			 	rawSearch.setTagsArray(search.getTags().split(","));			 	
			 	rawSearch.setMinFechaFormateada(minDate2);
			 	rawSearch.setMaxFechaFormateada(maxDate2);
			 	
			 	rawSearch.setProvincia(search.getProvincia());
			 	rawSearch.setCiudad(search.getCiudad());
			 	rawSearch.setBarrio(search.getBarrio());
			 	
			 	String orden = search.getOrden();
			 	String sortField = "";
			 	String sortDirection = "";
			 	
			 	if(orden.equals("newest")){
			 		sortField =  "date";
			 		sortDirection = SortingDataUtils.SORT_DESC;
			 		
			 	}
			 	else if(orden.equals("oldest")){
			 		sortField =  "date";
			 		sortDirection = SortingDataUtils.SORT_ASC;
							 		
				}
			 	else if(orden.equals("status")){
			 		sortField =  "status";
			 		sortDirection = SortingDataUtils.SORT_DESC;
						
				}
			 	else if(orden.equals("tag")){
			 		sortField =  "tag";
			 		sortDirection = SortingDataUtils.SORT_DESC;						
				}
			 	
			 	rawSearch.setSortField(sortField);
			 	rawSearch.setSortDirection(sortDirection);			 	
			 	rawSearch.setFormatoArchivo(search.getFormatoArchivo());
			 	
			 	List<Issue> issues = issueDAO.getIssuesByCriteria(rawSearch);
			
			 	
		 } catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		 }
		
		
	}
	
}