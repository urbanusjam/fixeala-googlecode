package ar.com.urbanusjam.services.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Set;

import javax.mail.MessagingException;

import org.jfree.util.Log;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import ar.com.urbanusjam.dao.IssueDAO;
import ar.com.urbanusjam.dao.IssueFollowDAO;
import ar.com.urbanusjam.dao.IssuePageViewDAO;
import ar.com.urbanusjam.dao.IssueRepairDAO;
import ar.com.urbanusjam.dao.IssueVerificationDAO;
import ar.com.urbanusjam.dao.IssueVoteDAO;
import ar.com.urbanusjam.dao.ProvinceDAO;
import ar.com.urbanusjam.dao.TagDAO;
import ar.com.urbanusjam.dao.UserDAO;
import ar.com.urbanusjam.dao.utils.IssueCriteriaSearchRaw;
import ar.com.urbanusjam.entity.annotations.Comment;
import ar.com.urbanusjam.entity.annotations.Issue;
import ar.com.urbanusjam.entity.annotations.IssueFollow;
import ar.com.urbanusjam.entity.annotations.IssueHistory;
import ar.com.urbanusjam.entity.annotations.IssueMainAbstractPK;
import ar.com.urbanusjam.entity.annotations.IssueRepair;
import ar.com.urbanusjam.entity.annotations.IssueVerification;
import ar.com.urbanusjam.entity.annotations.IssueVote;
import ar.com.urbanusjam.entity.annotations.MediaContent;
import ar.com.urbanusjam.entity.annotations.Tag;
import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.entity.utils.DateUtils;
import ar.com.urbanusjam.entity.utils.Messages;
import ar.com.urbanusjam.entity.utils.Operation;
import ar.com.urbanusjam.entity.utils.SortingDataUtils;
import ar.com.urbanusjam.entity.utils.StatusList;
import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.MailService;
import ar.com.urbanusjam.services.UserService;
import ar.com.urbanusjam.services.dto.EmailDTO;
import ar.com.urbanusjam.services.dto.IssueCriteriaSearch;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.IssueFollowDTO;
import ar.com.urbanusjam.services.dto.IssueHistoryDTO;
import ar.com.urbanusjam.services.dto.IssueVoteDTO;
import ar.com.urbanusjam.services.dto.UserDTO;


@Service
@Transactional
public class IssueServiceImpl implements IssueService {
		
	private final int MAX_VERIFICATION_REQUESTS = 3;
	private final int MAX_REJECTION_REQUESTS = 3;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private MailService mailService;	
	
	@Autowired
	private IssueDAO issueDAO;
	
	@Autowired
	private UserDAO userDAO;
	
	@Autowired
	private ProvinceDAO provinceDAO;
	
	@Autowired
	private TagDAO tagDAO;
	
	@Autowired
	private IssueFollowDAO issueFollowDAO;
	
	@Autowired
	private IssuePageViewDAO issuePageViewDAO;
	
	@Autowired
	private IssueVoteDAO issueVoteDAO;
	
	@Autowired
	private IssueRepairDAO issueRepairDAO;
	
	@Autowired
	private IssueVerificationDAO issueVerificationDAO;	

	
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void reportIssue(IssueDTO issueDTO) {
		Issue issue = new Issue();
		issue = this.convertTo(issueDTO);
		User u = userDAO.loadUserByUsername(issueDTO.getUser().getUsername());
		issue.setReporter(u);		

		if(issueDTO.getUploadedFile() != null){
			issue.addMediaContent(issueDTO.getUploadedFile());
		}

		issueDAO.saveIssue(issue);	
	}
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED, noRollbackFor={MessagingException.class})
	public void updateIssue(IssueDTO issueDTO) throws MessagingException{
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
		
		try{			
			//email notification
			String link = "<a target='_blank' href='http://localhost:8080/fixeala/issues/" + issue.getId().toString() + ".html' >LINK</a>.";
			String text = "El usuario <i>" + issueDTO.getUsername() + "</i> actualizo la informacion del reclamo <i>#" +issue.getId()+ " \"" + issue.getTitle() + "\"</i>.";
			text += "<br><br>";
			text += "Para acceder al mismo, hac&eacute; clic en el siguiente " + link;
			
			EmailDTO email = new EmailDTO();
			email.setSubject("Nueva actualizaci&oacute;n en el reclamo #" + issue.getId().toString() + " \"" + issue.getTitle() + "\"" );
			email.setTo(issue.getReporter().getEmail());
			email.setUrl(link);
			email.setMessage(text);
			
			Set<IssueFollow> followers = issue.getFollowers();
			String reporterEmail = null;
			
			mailService.sendIssueUpdateEmail(this.getFollowersEmails(followers, reporterEmail), email);
			
		}catch(Exception e){			
			Log.debug("Error en el envio del email a los seguidores del reclamo.");			
		}
		
	}
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED, noRollbackFor={MessagingException.class})
	public void updateIssueStatus(String username, String issueID, String newStatus, String resolution, String obs) throws MessagingException {
	
		Issue issue = issueDAO.findIssueById(issueID);
		User user = userDAO.loadUserByUsername(username);
		
		IssueHistoryDTO revision = new IssueHistoryDTO();
		revision.setFecha(new Date());
		revision.setUsername(username);
		revision.setOperacion(Operation.UPDATE);	
		revision.setEstado(newStatus);					

		if(obs != null)
			revision.setObservaciones(obs);
		
		if(resolution != null)
			issue.setResolution(resolution);
		
		issue.setLastUpdateDate(this.getCurrentCalendar(revision.getFecha()));
			
		if(!newStatus.equals(StatusList.VERIFIED) && !newStatus.equals(StatusList.REJECTED)){
			
			if(newStatus.equals(StatusList.IN_PROGRESS))	
				revision.setMotivo(Messages.ISSUE_UPDATE_STATUS_PROGRESS + " el reclamo");			
			if(newStatus.equals(StatusList.SOLVED))
				revision.setMotivo(Messages.ISSUE_UPDATE_STATUS_RESOLVE + " el reclamo como " + resolution.toUpperCase());			
			if(newStatus.equals(StatusList.CLOSED))
				revision.setMotivo(Messages.ISSUE_UPDATE_STATUS_CLOSE + " el reclamo");	
			if(newStatus.equals(StatusList.REOPENED))	
				revision.setMotivo(Messages.ISSUE_UPDATE_STATUS_REOPEN + " el reclamo porque " + resolution.toUpperCase());		
			
			issue.setStatus(newStatus);
			issue.addRevision(this.convertTo(revision, user));
		}
				
		//si es una solicitud de verificacion		
		if(newStatus.equals(StatusList.VERIFIED) || newStatus.equals(StatusList.REJECTED)){
			
			IssueVerification request = new IssueVerification();
			request.setId(new IssueMainAbstractPK(issue.getId(), user.getId()));
			request.setIssue(issue);
			request.setUser(user);
			request.setDate(this.getCurrentCalendar(new Date()));
			
			//mantengo el reclamo ABIERTO
			issue.setStatus(StatusList.OPEN.getLabel());			
			
			//solicitud verificacion
			if(newStatus.equalsIgnoreCase(StatusList.VERIFIED.getLabel())){
				
				request.setVerified(true);
				revision.setMotivo(Messages.ISSUE_UPDATE_STATUS_VERIFY_REQUEST + " del reclamo");
				
				//si se completan las 5 verificaciones, actualizo el estado a VERIFICADO
				if( issue.getVerificacionesPositivas(issue.getVerificationRequests()).size() == (MAX_VERIFICATION_REQUESTS - 1) ){
					
					IssueHistoryDTO revisionAdicional = new IssueHistoryDTO();
					revisionAdicional.setFecha(revision.getFecha());
					revisionAdicional.setUsername(username);
					revisionAdicional.setOperacion(Operation.UPDATE);	
					revisionAdicional.setEstado(StatusList.VERIFIED.getLabel());						
					revisionAdicional.setMotivo(Messages.ISSUE_UPDATE_STATUS_VERIFIED);
					
					issue.setStatus(StatusList.VERIFIED.getLabel());
					issue.addRevision(this.convertTo(revisionAdicional, user));
				}
			}
			
			//solicitud rechazo
			if(newStatus.equals(StatusList.REJECTED)){
				
				request.setVerified(false);
				revision.setMotivo(Messages.ISSUE_UPDATE_STATUS_REJECT_REQUEST + " del reclamo");
				
				//si se completan los 10 rechazos, actualizo el estado a RECHAZADO
				if(issue.getVerificacionesNegativas(issue.getVerificationRequests()).size() == MAX_REJECTION_REQUESTS - 1){
					
					IssueHistoryDTO revisionAdicional = new IssueHistoryDTO();
					revisionAdicional.setFecha(revision.getFecha());
					revisionAdicional.setUsername(username);
					revisionAdicional.setOperacion(Operation.UPDATE);	
					revisionAdicional.setEstado(StatusList.REJECTED.getLabel());						
					revisionAdicional.setMotivo(Messages.ISSUE_UPDATE_STATUS_REJECTED);
					
					issue.setStatus(StatusList.REJECTED.getLabel());
					issue.addRevision(this.convertTo(revisionAdicional, user));
					
				}
			}	
			issue.addRevision(this.convertTo(revision, user));
			issue.addVerificationRequest(request);
			
		}	
		
		issueDAO.updateIssue(issue);
		
		try{
			
			//email notification
			String link = "<a target='_blank' href='http://localhost:8080/fixeala/issues/" + issue.getId().toString() + ".html' >LINK</a>.";
			String text = "El usuario <u>" + revision.getUsername() + "</u> ha cambiado el estado del reclamo <i>#" + issue.getId().toString() + " \"" + issue.getTitle() + "\"</i> de " + issue.getStatus().toUpperCase() + " a " + newStatus.toUpperCase() + ".";
			text += "<br><br>";
			text += "- Motivo: " + revision.getResolucion();
			text += "<br>";
			text += "- Observaciones: " + revision.getObservaciones();
			text += "<br><br>";
			text += "Para acceder al reclamo actualizado, hac&eacute; clic en el siguiente " + link;
			
			EmailDTO email = new EmailDTO();
			email.setSubject(revision.getUsername() + " " + revision.getMotivo() + " #" + issue.getId().toString() + " \"" + issue.getTitle() + "\"" );
			email.setTo(issue.getReporter().getUsername());
			email.setUrl(link);
			email.setMessage(text);
			
			Set<IssueFollow> followers = issue.getFollowers();
			String reporterEmail = null;
			
			if(!username.equals(issue.getReporter().getUsername()))
				reporterEmail = username;
			
			mailService.sendIssueUpdateEmail(this.getFollowersEmails(followers, reporterEmail), email);
			
		}catch(Exception e){			
			Log.debug("Error en el envio del email a los seguidores del reclamo.");			
		}	
	}
		
	@Override
	public List<IssueDTO> loadAllIssues() {
		List<Issue> issues = new ArrayList<Issue>();
		issues = issueDAO.getAllIssues();
		List<IssueDTO> issuesDTO = new ArrayList<IssueDTO>();
		for(Issue issue : issues){		
			issuesDTO.add(preloadIssues(issue));			
		}
		
		Collections.sort(issuesDTO, new Comparator<IssueDTO>() {
		    public int compare(IssueDTO m1, IssueDTO m2) {
		        return m2.getCreationDate().compareTo(m1.getCreationDate());
		    }
		});
		
		return issuesDTO;	
	}
	
	@Override
	public List<IssueDTO> loadIssues(int numberOfResults) {
		List<Issue> issues = new ArrayList<Issue>();
		issues = issueDAO.getIssues(numberOfResults);
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
		if(issue != null){
			return loadCompleteIssue(issue);		
		}
		else
			return null; 
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
	@Transactional(propagation = Propagation.REQUIRED, noRollbackFor={MessagingException.class, MailException.class})
	public void postComment(Comment comment) throws MessagingException {
		
		Issue issue = issueDAO.findIssueById(String.valueOf(comment.getIssueID()));
		User user = userDAO.loadUserByUsername(comment.getUsername());
		
		//comment
		comment.setIssue(issue);
		comment.setUsuario(user);
		comment.setDenunciado(false);
				
		//revision
		IssueHistoryDTO revision = new IssueHistoryDTO();
		revision.setFecha(new Date());
		revision.setUsername(comment.getUsuario().getUsername());			
		revision.setOperacion(Operation.UPDATE);			
		revision.setMotivo(Messages.ISSUE_UPDATE_COMMENT);			
		revision.setEstado(issue.getStatus());
		revision.setObservaciones(comment.getMensaje());	
			
		issue.setLastUpdateDate(this.getCurrentCalendar(revision.getFecha()));		
		issue.addComment(comment);
		issue.addRevision(convertTo(revision, user));
		
		issueDAO.updateIssue(issue);

		try{				
			//email notification
			String link = "<a target='_blank' href='http://localhost:8080/fixeala/issues/" + issue.getId().toString() + ".html' >LINK</a>.";
			String text = "El usuario <i>" + comment.getUsername() + "</i> ha dejado un comentario en el reclamo <i>#" +issue.getId()+ " \"" + issue.getTitle() + "\"</i>.";
			text += "<br><br>";
			text += "Para acceder al comentario publicado, hac&eacute; clic en el siguiente " + link;
			
			EmailDTO email = new EmailDTO();
			email.setSubject("Nuevo comentario en el reclamo #" + issue.getId().toString() + " \"" + issue.getTitle() + "\"" );
			email.setTo(issue.getReporter().getUsername());
			email.setUrl(link);
			email.setMessage(text);		
			
			Set<IssueFollow> followers = issue.getFollowers();
			String reporterEmail = null;
			
			if(!comment.getUsername().equals(issue.getReporter().getUsername()))
				reporterEmail = issue.getReporter().getEmail();
			
			mailService.sendIssueUpdateEmail(this.getFollowersEmails(followers, reporterEmail), email);
		
		}catch(Exception e){			
			Log.debug("Error en el envio del email a los seguidores del reclamo.");			
		}
		
	}
	
	@Override
	public List<IssueDTO> searchByTagOrStatus(String searchType, String value) {
		List<IssueDTO> issuesDTO = new ArrayList<IssueDTO>();
		List<Issue> issues = new ArrayList<Issue>();
		
		if(searchType.equals("tag")){
			issues = issueDAO.getIssuesByTag(value);
		}
		else{
			issues = issueDAO.getIssuesByStatus(new String[]{value});
		}		
		
		for(Issue i : issues)
			issuesDTO.add(convertToDTO(i));
		
		return issuesDTO;
	}
	
	private IssueDTO preloadIssues(Issue issue){
			
		String[] cssStyle = this.assignCSSbyStatus(issue.getStatus());
		
		IssueDTO issueDTO = new IssueDTO();
		issueDTO.setId(String.valueOf(issue.getId()));
		issueDTO.setUsername(issue.getReporter().getUsername());
		issueDTO.setAddress(issue.getAddress());
		issueDTO.setLatitude(String.valueOf(issue.getLatitude()));
		issueDTO.setLongitude(String.valueOf(issue.getLongitude()));
		issueDTO.setCity(issue.getCity());	
		issueDTO.setProvince(issue.getProvince());	
		issueDTO.setTitle(issue.getTitle());
//		issueDTO.setTitleCss(cssStyle[1]);
		issueDTO.setDescription(issue.getDescription());	
		issueDTO.setCreationDate(issue.getCreationDate().getTime());		
		issueDTO.setStatus(issue.getStatus());
		issueDTO.setStatusCss(cssStyle[1]);	
		issueDTO.setResolution(issue.getResolution());
		issueDTO.setFechaFormateada(issue.getCreationDate().getTime());
		issueDTO.setFechaFormateadaCompleta(issue.getCreationDate().getTime());		
		issueDTO.setTotalVotes(this.countIssueVotes(String.valueOf(issue.getId()))); // llamada al DAO
		issueDTO.setTotalFollowers(issue.getFollowers().size());
		
		//tags		
		Set<Tag> tagList = issue.getTagsList();
		List<String> tagNames = new ArrayList<String>();		
		if(tagList.size() > 0){
			for(Tag t :  issue.getTagsList()){				
				tagNames.add(t.getTagname().trim());
			}
		}		
		issueDTO.setTags(tagNames);
		
		List<MediaContent> imagenes = new ArrayList<MediaContent>();
		for(MediaContent c : issue.getContenidos()){
			//solo imagenes del reclamo
			if(!c.isProfilePic())
				imagenes.add(c);
		}
		issueDTO.setContenidos(imagenes);
		
		return issueDTO;
	}
	
	@Override
	public void followIssue(IssueFollow following) {	
		issueFollowDAO.saveFollowing(following);
	}

	@Override
	public void unFollowIssue(IssueFollow following) {
		issueFollowDAO.deleteFollowing(following);		
	}

	@Override
	public boolean isUserFollowingIssue(IssueFollow following) {
		return issueFollowDAO.findFollowing(following) != null;
	}

	@Override
	public List<String> getIssueFollowers(String issueID) {
		List<IssueFollow> followings = new ArrayList<IssueFollow>();
		List<String> followers = new ArrayList<String>();
		followings = issueFollowDAO.findFollowingsByIssue(Long.valueOf(issueID));
		
		for(IssueFollow f : followings){
			followers.add(f.getUser().getUsername());
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

//	@Override
//	public boolean trackIssuePageView(IssuePageView pageview) {
//		
//		boolean pageviewExists = false;
//		pageviewExists = issuePageViewDAO.existsIssuePageView(pageview.getIssue().getId(), pageview.getUser().getUsername());
//		
//		if(!pageviewExists){
//	
//			Issue issue = new Issue();
//			issue.setId(pageview.getIssue().getId());
//			pageview.setIssue(issue);			
//			pageview.setUser(pageview.getUser());
//			pageview.setDate(pageview.getDate());
//			issuePageViewDAO.saveIssuePageView(pageview);
//			return true;
//		}
//		else{
//			return false;
//		}
//	}

	@Override
	public int getIssuePageViews(String issueID) {
		return issuePageViewDAO.getIssuePageViews(Long.valueOf(issueID));
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void submitVote(IssueVote vote) { //-- cambiar por submitVote()
					
		Issue issue =  issueDAO.findIssueById(String.valueOf(vote.getId().getIssueID()));
//		User user = userDAO.loadUserByUsername(voteDTO.getUsername());
//
//		IssueHistoryDTO revision = new IssueHistoryDTO();
//		revision.setFecha(new Date());
//		revision.setUsername(voteDTO.getUsername());	
//		revision.setOperacion(Operation.UPDATE);			
//		revision.setMotivo("voto por el reclamo." );			
//		revision.setEstado(issue.getStatus());
//		revision.setObservaciones("");
//		
//		issue.addRevision(this.convertTo(revision, user)); 	
		issue.addVote(vote);

		issueDAO.updateIssue(issue);
	}

	@Override
	public IssueVote getCurrentVote(String issueID, String username) {
	
		IssueVote vote = new IssueVote();		
		vote = issueVoteDAO.getVoteByUser(Long.valueOf(issueID), userService.getUserId(username));
		
		if(vote != null){			
			vote.setCurrentlyVoteByUser(true);
			return vote;
		}
		else
			return null;	
		
	}

	@Override
	public Long countIssueVotes(String issueID) {
		return issueVoteDAO.getTotalVotesCount(Long.valueOf(issueID));
	}
	

	@Override
	public List<IssueDTO> findIssuesByCriteria(IssueCriteriaSearch search) {
		
		IssueCriteriaSearchRaw rawSearch =  new IssueCriteriaSearchRaw();
		List<Issue> issues = new ArrayList<Issue>();
		List<IssueDTO> issuesDTO = new ArrayList<IssueDTO>();
		
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
			 				 	
			 	rawSearch.setEstadosArray(search.getEstados().isEmpty() ? null : search.getEstados().split(","));
			 	rawSearch.setTagsArray(search.getTags().isEmpty() ? null : search.getTags().split(","));			 	
			 	rawSearch.setMinFechaFormateada(minDate2);
			 	rawSearch.setMaxFechaFormateada(maxDate2);
			 	
			 	rawSearch.setProvincia(search.getProvincia());
			 	rawSearch.setCiudad(search.getCiudad());
			 	rawSearch.setBarrio(search.getBarrio());
			 	
			 	String orden = search.getOrden();
			 	String sortField = "";
			 	String sortDirection = "";
			 	
			 	if(orden.equals("newest")){
			 		sortField =  "creationDate";
			 		sortDirection = SortingDataUtils.SORT_DESC;
			 		
			 	}
			 	else if(orden.equals("oldest")){
			 		sortField =  "creationDate";
			 		sortDirection = SortingDataUtils.SORT_ASC;
							 		
				}
			 	else if(orden.equals("status")){
			 		sortField =  "status";
			 		sortDirection = SortingDataUtils.SORT_ASC;
						
				}
			 	else if(orden.equals("tag")){
			 		sortField =  "tag";
			 		sortDirection = SortingDataUtils.SORT_ASC;						
				}
			 	
			 	rawSearch.setSortField(sortField);
			 	rawSearch.setSortDirection(sortDirection);			 	
			 	
			 	issues = issueDAO.getIssuesByCriteria(rawSearch);
			 	
			 	for(Issue i : issues)
			 		issuesDTO.add(convertToDTO(i));
			 		
			 				 	
		 } catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		 }
		 
		 return issuesDTO;
	}


	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void addReparacion(IssueRepair repair, String username) {		
		
		Issue issue = issueDAO.findIssueById(String.valueOf(repair.getId()));
		User user = userDAO.loadUserByUsername(username);
		
		IssueHistoryDTO revision = new IssueHistoryDTO();
		revision.setFecha(new Date());
		revision.setUsername(username);
		revision.setNroReclamo(Long.valueOf(repair.getId()));
		revision.setOperacion(Operation.UPDATE);
		revision.setMotivo(Messages.ISSUE_REPAIR_INFO_ADD);		
		revision.setObservaciones(null);	
		revision.setEstado(StatusList.IN_PROGRESS.getLabel());
		
		issue.setStatus(revision.getEstado());
		issue.setLastUpdateDate(this.getCurrentCalendar(revision.getFecha()));
		issue.setReparacion(repair);
		issue.addRevision(this.convertTo(revision, user));
				
		issueDAO.updateIssue(issue);
	}

	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void deleteReparacion(String issueID, String username) {
		
		Issue issue = issueDAO.findIssueById(issueID);
		User user = userDAO.loadUserByUsername(username);
		
		IssueHistoryDTO revision = new IssueHistoryDTO();
		revision.setFecha(new Date());
		revision.setUsername(username);
		revision.setNroReclamo(Long.valueOf(issueID));
		revision.setOperacion(Operation.UPDATE);
		revision.setMotivo(Messages.ISSUE_REPAIR_INFO_DELETE);
		revision.setEstado(StatusList.VERIFIED.getLabel());
		revision.setObservaciones(null);

		issue.setStatus(revision.getEstado());
		issue.setLastUpdateDate(this.getCurrentCalendar(revision.getFecha()));
		issue.addRevision(this.convertTo(revision, user));
		issue.setReparacion(null);
		
		issueRepairDAO.deleteReparacion(Long.valueOf(issueID));
	}

	@Override
	public String[] getFollowersEmails(Set<IssueFollow> followers, String reporterEmail){
		String [] emails;
		if(followers.size() > 0){
			emails = new String[followers.size()+1];
			int index = 0;
			for(IssueFollow follower :  followers){
				emails[index] = follower.getUser().getEmail();
				index++;
			}
			if(reporterEmail != null)
				emails[index++] = reporterEmail;
		}
		else{
			
			if(reporterEmail != null){
				emails = new String[1];
				emails[0] = reporterEmail;
			}
			else
				emails = null;
		}
		
		return emails;
	}

	@Override
	public List<IssueDTO> loadIssuesByLocation(float latitude, float longitude,
			int numberOfResults) {
		List<Issue> reclamos = issueDAO.getIssuesByLocation(latitude, longitude, numberOfResults);
		List<IssueDTO> reclamosDTO = new ArrayList<IssueDTO>();
		for(Issue i : reclamos){
			reclamosDTO.add(convertToDTO(i));
		}
		return reclamosDTO;
	}

	@Override
	public List<String> loadProvinces() {
		return provinceDAO.findAllProvinces();
	}

	@Override
	public List<String> loadLocalityByProvince(String province) {
		return provinceDAO.findLocalitiesByProvince(province);
	}

	@Override
	public IssueVerification isIssueVerifiedByUser(String issueID, String username) {
		return issueVerificationDAO.findVerificationByUser(
				Long.valueOf(issueID), 
				userService.loadUserByUsername(username).getId());
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public GregorianCalendar getCurrentCalendar(Date date){		
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(date);
		return (GregorianCalendar) calendar;	
	} 
	
	private IssueDTO loadCompleteIssue(Issue issue){
		
		String[] cssStyle = this.assignCSSbyStatus(issue.getStatus());
		
		IssueDTO issueDTO = new IssueDTO();
		issueDTO.setId(String.valueOf(issue.getId()));
		issueDTO.setUsername(issue.getReporter().getUsername());
		issueDTO.setAddress(issue.getAddress());
		issueDTO.setLatitude(String.valueOf(issue.getLatitude()));
		issueDTO.setLongitude(String.valueOf(issue.getLongitude()));
		issueDTO.setNeighborhood(issue.getNeighborhood());
		issueDTO.setCity(issue.getCity());	
		issueDTO.setProvince(issue.getProvince());	
		issueDTO.setTitle(issue.getTitle());
//		issueDTO.setTitleCss(cssStyle[1]);
		issueDTO.setDescription(issue.getDescription());	
		issueDTO.setCreationDate(issue.getCreationDate().getTime());		
		issueDTO.setLastUpdateDate(issue.getLastUpdateDate().getTime());		
		issueDTO.setStatus(issue.getStatus());
		issueDTO.setStatusCss(cssStyle[1]);
		issueDTO.setResolution(issue.getResolution());
		issueDTO.setFechaFormateada(issue.getCreationDate().getTime());
		issueDTO.setFechaFormateadaCompleta(issue.getCreationDate().getTime());		
		issueDTO.setTotalVotes(this.countIssueVotes(String.valueOf(issue.getId()))); // llamada al DAO
		issueDTO.setTotalFollowers(issue.getFollowers().size());
		
		//tags		
		Set<Tag> tagList = issue.getTagsList();
		List<String> tagNames = new ArrayList<String>();		
		if(tagList.size() > 0){
			for(Tag t :  issue.getTagsList()){				
				tagNames.add(t.getTagname().trim());
			}
		}		
		issueDTO.setTags(tagNames);
	
		//historial
		List<IssueHistoryDTO> historialDTO = new ArrayList<IssueHistoryDTO>();		
		for(IssueHistory revision : issue.getRevisiones()){
			historialDTO.add(convertTo(revision));
		}		
		issueDTO.setHistorial(historialDTO);
		
		//comentarios
		List<Comment> comentarios = new ArrayList<Comment>(issue.getComentarios());
		//order by date DESC
		Collections.sort(comentarios, new Comparator<Comment>() {
			  public int compare(Comment o1, Comment o2) {
			      return o2.getFecha().compareTo(o1.getFecha());
			  }
		});			
		issueDTO.setComentarios(comentarios);
						
		//contenidos
		List<MediaContent> imagenes = new ArrayList<MediaContent>();
		for(MediaContent c : issue.getContenidos()){
			//solo imagenes del reclamo
			if(!c.isProfilePic())
				imagenes.add(c);
		}
		issueDTO.setContenidos(imagenes);
		
		//reparacion
		if(issue.getReparacion() != null)
			issueDTO.setReparacion(issue.getReparacion());
		else
			issueDTO.setReparacion(null);
		
		//verificaciones		
		issueDTO.setVerificaciones(new ArrayList<IssueVerification>(issue.getVerificationRequests()));
		issueDTO.setPositiveVerifications(issue.getVerificacionesPositivas(issue.getVerificationRequests()).size());
		issueDTO.setNegativeVerifications(issue.getVerificacionesNegativas(issue.getVerificationRequests()).size());
		
		return issueDTO;

	}
	
	//assign CSS
	private String[] assignCSSbyStatus(String status){
		
		String[] css = new String[2];
		
		if(status.equals(StatusList.OPEN)){
			css[0] = "label label-important";
			css[1] = StatusList.OPEN.getColorCode();
		}
		
		if(status.equals(StatusList.REOPENED)){
			css[0] = "label label-important";
			css[1] = StatusList.REOPENED.getColorCode();
		}
		
		if(status.equals(StatusList.VERIFIED)){
			css[0] = "label label-info";
			css[1] = StatusList.VERIFIED.getColorCode();
		}
		
		if(status.equals(StatusList.REJECTED)){
			css[0] = "label label-inverse";
			css[1] = StatusList.REJECTED.getColorCode();			
		}
		
		if(status.equals(StatusList.IN_PROGRESS)){
			css[0] = "label label-warning";
			css[1] = StatusList.IN_PROGRESS.getColorCode();		
		}
		
		if(status.equals(StatusList.SOLVED)){
			css[0] = "label label-success";
			css[1] = StatusList.SOLVED.getColorCode();			
		}
		
		if(status.equals(StatusList.CLOSED)){
			css[0] = "label label-inverse";
			css[1] = StatusList.CLOSED.getColorCode();			
		}
		
		if(status.equals(StatusList.ARCHIVED)){
			css[0] = "label label-default";
			css[1] = StatusList.ARCHIVED.getColorCode();		
		}
		
		return css;
	}
	
//	public void sendMailAfterCommit(final MailManager mail) { 	
//		TransactionSynchronizationManager.registerSynchronization( 			
//				new TransactionSynchronizationAdapter() { 		
//					@Override 		
//					public void afterCommit() { 			
//						mailService.sendMail(mail); 		
//					} 	
//				}); 
//	}
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	public IssueDTO convertToDTO(Issue issue){
		
		UserDTO userDTO = new UserDTO();
		userDTO.setUsername(issue.getReporter().getUsername());
		
		String[] cssStyle = this.assignCSSbyStatus(issue.getStatus());
		
		IssueDTO issueDTO = new IssueDTO();
		issueDTO.setId(String.valueOf(issue.getId()));
		issueDTO.setUser(userDTO);
		issueDTO.setAddress(issue.getAddress());
		issueDTO.setNeighborhood(issue.getNeighborhood());
		issueDTO.setCity(issue.getCity());	
		issueDTO.setProvince(issue.getProvince());	
		issueDTO.setTitle(issue.getTitle());
		issueDTO.setDescription(issue.getDescription());	
		issueDTO.setCreationDate(issue.getCreationDate().getTime());		
		issueDTO.setLastUpdateDate(issue.getLastUpdateDate().getTime());		
		issueDTO.setLatitude(String.valueOf(issue.getLatitude()));
		issueDTO.setLongitude(String.valueOf(issue.getLongitude()));
		issueDTO.setStatus(issue.getStatus());
		issueDTO.setStatusCss(cssStyle[1]);
		issueDTO.setUsername(userDTO.getUsername());
		issueDTO.setFechaFormateada(issue.getCreationDate().getTime());
		issueDTO.setFechaFormateadaCompleta(issue.getCreationDate().getTime());		
		issueDTO.setTotalVotes(this.countIssueVotes(String.valueOf(issue.getId()))); // llamada al DAO
		issueDTO.setTotalFollowers(issue.getFollowers().size());
		issueDTO.setTotalComments(issue.getComentarios().size());	
	
		return issueDTO;
	}
	
	//--revisar
//	public CommentDTO convertToDTO(Comment comment){
//		CommentDTO commentDTO = new CommentDTO();
//		commentDTO.setUsername(comment.getUsuario().getUsername());
//		commentDTO.setNroReclamo(comment.getIssue().getId());
//		commentDTO.setFecha(comment.getFecha().getTime());
//		commentDTO.setFechaFormateada(comment.getFecha().getTime());
//		commentDTO.setMensaje(comment.getMensaje());
//		return commentDTO;
//	}
	
	//--revisar
	public IssueFollow convertTo(IssueFollowDTO followingDTO){
		IssueFollow following = new IssueFollow();
		IssueMainAbstractPK followingId = new IssueMainAbstractPK();		
		followingId.setIssueID(Long.valueOf(followingDTO.getNroReclamo()));
		User u = userDAO.loadUserByUsername(followingDTO.getUsername());
		followingId.setUserID(u.getId());
		following.setId(followingId);
		following.setDate(followingDTO.getFecha() != null ? this.getCurrentCalendar(followingDTO.getFecha()) : null);
		return following;
	}
	
	//--revisar
	public IssueVote convertTo(IssueVoteDTO voteDTO){
		IssueVote vote = new IssueVote();			
		vote.setId(new IssueMainAbstractPK(voteDTO.getNroReclamo(), userService.getUserId(voteDTO.getUsername())));
		vote.setVote(voteDTO.getVote());
		vote.setDate(voteDTO.getFecha() != null ? this.getCurrentCalendar(voteDTO.getFecha()) : null);
		return vote;
	}
	
	public IssueHistory convertTo(IssueHistoryDTO historialDTO, User user){
		
		IssueHistory historial = new IssueHistory();	
		historial.setFecha(this.getCurrentCalendar(historialDTO.getFecha()));	
		historial.setUsuario(user);
		historial.setOperacion(historialDTO.getOperacion());
		historial.setMotivo(historialDTO.getMotivo());		
		historial.setEstado(historialDTO.getEstado());		
		historial.setObservaciones(historialDTO.getObservaciones());		
//		historial.setResolucion(historialDTO.getResolucion());				
		return historial;		
	}
	
	public IssueHistoryDTO convertTo(IssueHistory historial){
		
		IssueHistoryDTO historialDTO = new IssueHistoryDTO();
		
		historialDTO.setFecha(historial.getFecha().getTime());	
		historialDTO.setUsername(historial.getUsuario().getUsername());
		historialDTO.setNroReclamo(Long.valueOf(historial.getIssue().getId()));
		historialDTO.setOperacion(Operation.UPDATE);
		historialDTO.setMotivo(historial.getMotivo());
		historialDTO.setEstado(historial.getEstado());		
		historialDTO.setObservaciones(historial.getObservaciones());	
//		historialDTO.setResolucion(historial.getResolucion());
		
		if(historialDTO.getResolucion() != null && historial.getResolucion() != ""){
			historialDTO.setDetalle(historialDTO.getMotivo() + " como &laquo;" + historialDTO.getResolucion() + "&raquo;" );	
		}
		else{
			historialDTO.setDetalle(historialDTO.getMotivo());
		}		
		
		return historialDTO;		
	}	
	
	public Issue convertTo(IssueDTO issueDTO){
				
		User user = new User();
		user = userDAO.loadUserByUsername(issueDTO.getUsername());
		
		Issue issue = new Issue();	
		if(issueDTO.getId() != null){
			issue.setId(Long.valueOf(issueDTO.getId()));	
		}		
		issue.setReporter(user);
		issue.setAddress(issueDTO.getAddress());
		issue.setNeighborhood(issueDTO.getNeighborhood());
		issue.setCity(issueDTO.getCity());	
		issue.setProvince(issueDTO.getProvince());	
		issue.setTitle(issueDTO.getTitle());
		issue.setDescription(issueDTO.getDescription());
		
		//history
		for(IssueHistoryDTO historial : issueDTO.getHistorial()){
			issue.addRevision(convertTo(historial, user));
		}
		
		//votes
		for(IssueVoteDTO vote : issueDTO.getVotes()){
			issue.addVote(convertTo(vote));
		}
		
		//followers
		for(IssueFollowDTO follower : issueDTO.getFollowers()){
			issue.addFollower(convertTo(follower));
		}
				
		//licitacion
		/*if(issueDTO.getLicitacion() != null)
			issue.setLicitacion(convertTo(issueDTO.getLicitacion()));
		else
			issue.setLicitacion(null);*/
			
		//contenidos
		/*for(MediaContentDTO contenido : issueDTO.getContenidos()){			
			issue.getContenidos().add(contenidoService.convertirAContenido(contenido));
		}*/
		
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
		
		issue.setCreationDate(this.getCurrentCalendar(issueDTO.getCreationDate()));		
		issue.setLastUpdateDate(this.getCurrentCalendar(issueDTO.getLastUpdateDate()));		
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
	
}