package ar.com.urbanusjam.web.controllers;

import java.io.Serializable;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.WordUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ar.com.urbanusjam.entity.annotations.IssueFollow;
import ar.com.urbanusjam.entity.annotations.IssueMainActionPK;
import ar.com.urbanusjam.entity.annotations.IssueRepair;
import ar.com.urbanusjam.entity.annotations.IssueVerification;
import ar.com.urbanusjam.entity.annotations.IssueVote;
import ar.com.urbanusjam.entity.annotations.MediaContent;
import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.ContenidoService;
import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.UserService;
import ar.com.urbanusjam.services.dto.CommentDTO;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.IssueHistoryDTO;
import ar.com.urbanusjam.services.dto.UserDTO;
import ar.com.urbanusjam.services.utils.DateUtils;
import ar.com.urbanusjam.services.utils.Messages;
import ar.com.urbanusjam.services.utils.Operation;
import ar.com.urbanusjam.services.utils.StatusList;
import ar.com.urbanusjam.web.domain.AlertStatus;
import ar.com.urbanusjam.web.domain.ContenidoResponse;

import com.google.gson.Gson;

@Controller
// @RequestMapping(value="/issue")
public class IssueController extends MainController {
	
	private static int ITEMS_PER_PAGE = 10;
	private final int MAX_VERIFICATION_REQUESTS = 3;
	private final int MAX_REJECTION_REQUESTS = 3;

	@Autowired
	private IssueService issueService;

	@Autowired
	private UserService userService;

	@Autowired
	private ContenidoService contenidoService;


	@Autowired
	@Qualifier(value = "fixealaAuthenticationManager")
	protected AuthenticationManager fixealaAuthenticationManager;


	@RequestMapping(value = "/issues/search", method = RequestMethod.GET)
	public String showSearchPage(Model model,
			@RequestParam("type") String searchType,
			@RequestParam("value") String value, HttpServletRequest request)
			throws JSONException {

		List<IssueDTO> issueSearch = issueService.searchByTagOrStatus(
				searchType, value);

		JSONArray array = new JSONArray();
		for (IssueDTO issue : issueSearch) {
			JSONObject obj = new JSONObject();
			obj.put("id", issue.getId());
			obj.put("title", issue.getTitle());
			obj.put("date", DateUtils.getFechaFormateada(issue.getCreationDate(),
					DateUtils.DATE_TIME_PATTERN_SHORT));
			obj.put("user", issue.getUsername());
			obj.put("address", issue.getFullAddress());
			obj.put("description", issue.getDescription());
			obj.put("status", issue.getStatus());
			obj.put("statusCss", issue.getStatusCss());
			array.put(obj);
		}

		model.addAttribute("tag", value);
		model.addAttribute("issuesByTag", array.toString());

		List<String> allTags = issueService.getTagList();
		JSONArray tagArray = new JSONArray();
		for (String tag : allTags) {
			String url = "issues/search.html?type=tag&value=" + tag.trim().trim().toLowerCase();
			JSONObject obj = new JSONObject();
			obj.put("url", url);
			obj.put("label", tag);
			tagArray.put(obj);
		}

		model.addAttribute("allTags", tagArray.toString());

		List<StatusList> statusList = Arrays.asList(StatusList.values());
		JSONArray statusArray = new JSONArray();
		for (StatusList status : statusList) {
			JSONObject obj = new JSONObject();
			String url = "issues/search.html?type=status&value=" + status.getLabel().trim().toLowerCase();
			obj.put("url", url);
			obj.put("text", status.getLabel().toUpperCase());
			obj.put("color", status.getColorCode());
			statusArray.put(obj);
		}

		model.addAttribute("allStatus", statusArray.toString());

		return "search";

	}

	@RequestMapping(value = "/issues/{issueID}", method = RequestMethod.GET)
	public String showIssuePage(Model model,
			@PathVariable("issueID") String issueID,
			HttpServletRequest request) {

		IssueDTO issue = new IssueDTO();
		
		try {
			issue = issueService.getIssueById(issueID);

			JSONObject oldFields = new JSONObject();
			oldFields.put("title", issue.getTitle());
			oldFields.put("desc", issue.getDescription());
			oldFields.put("barrio", issue.getNeighborhood());

			model.addAttribute("oldFields", oldFields.toString());

			model.addAttribute("titulo", issue.getTitle());
			model.addAttribute("estado", issue.getStatus());
			model.addAttribute("estadoCss", issue.getStatusCss());
			model.addAttribute("resolucion", issue.getResolution());
			model.addAttribute("direccion", issue.getFullAddress());
			model.addAttribute("id", issue.getId());
			model.addAttribute("fechaCreacion", DateUtils.getFechaFormateada(
					issue.getCreationDate(), DateUtils.DATE_TIME_PATTERN_SHORT));
			model.addAttribute("fechaUltimaActualizacion", DateUtils.getFechaFormateada(issue.getLastUpdateDate(),
							DateUtils.DATE_TIME_PATTERN_SHORT));
			model.addAttribute("calle", issue.getAddress());
			model.addAttribute("barrio", issue.getNeighborhood());
			model.addAttribute("ciudad", issue.getCity());
			model.addAttribute("provincia", issue.getProvince());
			model.addAttribute("usuario", issue.getUsername());
			model.addAttribute("descripcion", issue.getDescription());
			model.addAttribute("latitud", issue.getLatitude());
			model.addAttribute("longitud", issue.getLongitude());
			model.addAttribute("historial", issue.getHistorial());

			List<String> issueTags = issue.getTags();
			String issueTagsByComma = StringUtils.EMPTY;
			String allTags = StringUtils.EMPTY;

			if (!issueTags.isEmpty()) {
				for (int i = 0; i < issueTags.size(); i++) {
					issueTagsByComma += issueTags.get(i).toLowerCase() + ", ";
				}
				issueTagsByComma = issueTagsByComma.substring(0, issueTagsByComma.length() - 2);
			}

			List<String> dbTags = issueService.getTagList();
			JSONArray array = new JSONArray();
			for (String s : dbTags) {
				JSONObject obj = new JSONObject();
				obj.put("id", dbTags.indexOf(s)+1);
				obj.put("text", s.toLowerCase());
				array.put(obj);
			}

			allTags = array.toString();

			model.addAttribute("tagsByIssue", issueTagsByComma);
			model.addAttribute("allTags", allTags.length() == 0 ? "[{}]"
					: allTags);

			//contenidos
			List<MediaContent> contenidos = new ArrayList<MediaContent>();
			contenidos = issue.getContenidos();

			if (contenidos.size() > 0) {
				model.addAttribute("contenidos", contenidos);
				MediaContent contenido = contenidos.get(0);
				model.addAttribute("imageUrl", contenido.getLink());
			}

			model.addAttribute("cantidadContenidos", contenidos.size());
			model.addAttribute("cantidadRevisiones", issue.getHistorial()
					.size());		
			model.addAttribute("infoReparacion",
					issue.getReparacion() != null ? issue.getReparacion()
							.getEstadoObra() : "Sin datos");
			model.addAttribute("cantidadReclamosSimilares", 0);
			model.addAttribute("cantidadArchivos", 0);
			model.addAttribute("cantidadComentarios", issue.getComentarios()
					.size());

			IssueFollow follow = new IssueFollow();
			IssueVote currentVote = new IssueVote();			
			String loggedUser = "";
			boolean isUserWatching = false;
			
			Authentication auth = (Authentication) SecurityContextHolder
					.getContext().getAuthentication();

			if (!(auth instanceof AnonymousAuthenticationToken)) {
				UserDetails userDB = userService
						.loadUserByUsername(((User) auth.getPrincipal())
								.getUsername());
				if (userDB != null) {
					follow.setId(new IssueMainActionPK(Long.valueOf(issueID), 
							userService.getUserId(userDB.getUsername())));
//					follow.setUsername(userDB.getUsername());
//					follow.setNroReclamo(Long.valueOf(issueID));
					isUserWatching = issueService.isUserFollowingIssue(follow);
					loggedUser = userDB.getUsername();

//					IssuePageViewDTO pageviewDTO = new IssuePageViewDTO();
//					pageviewDTO.setIssueID(issueID);
//					pageviewDTO.setUsername(loggedUser);
//					pageviewDTO.setDate(new Date());
//					issueService.trackIssuePageView(pageviewDTO);
					
					currentVote = issueService.getCurrentVote(issueID, loggedUser);
					
					IssueVerification solicitud = issueService.isIssueVerifiedByUser(issueID, userDB.getUsername());
					model.addAttribute("isVerifiedByUser", solicitud != null ? solicitud.isVerified() : null);
				}

			}
			else{
				model.addAttribute("isVerifiedByUser", false);
			}
			
			//solicitudes de verificacion			
			model.addAttribute("posVerifications", issue.getPositiveVerifications());
			model.addAttribute("negVerifications", issue.getNegativeVerifications());
			model.addAttribute("maxVerificationsAllowed", MAX_VERIFICATION_REQUESTS);
			model.addAttribute("maxRejectionsAllowed", MAX_REJECTION_REQUESTS);
			

			model.addAttribute("loggedUser", loggedUser);
//			model.addAttribute("cantidadVisitas",
//					issueService.getIssuePageViews(issueID));
			model.addAttribute("cantidadObservadores", issueService
					.getIssueFollowers(issueID).size());
			model.addAttribute("isUserWatching", isUserWatching);
			model.addAttribute("cantidadVotos",
					issueService.countIssueVotes(issueID));
			
			if(currentVote != null){
				model.addAttribute("isCurrentlyVoted",
						currentVote.isCurrentlyVoteByUser());
				model.addAttribute("isVoteUp", currentVote.getVote() == 1 ? true
						: false);
			}
			
			
			
			
			IssueRepair repair = issue.getReparacion();
			 
			 if(repair != null){
			 
				 model.addAttribute("obra", repair.getObra());
				 model.addAttribute("nroLicitacion", repair.getNroLicitacion());
				 model.addAttribute("nroExpediente", repair.getNroExpediente());
				 model.addAttribute("estadoObra", repair.getEstadoObra()); 				 
				 model.addAttribute("unidadEjecutora", repair.getUnidadEjecutora());
			     model.addAttribute("unidadFinanciamiento", repair.getUnidadFinanciamiento());			     
			     model.addAttribute("empresaNombre", repair.getContratistaNombre()); 
			     model.addAttribute("empresaCuit", repair.getContratistaCuit());			  
			     model.addAttribute("representanteNombre", repair.getRepresentanteTecnicoNombre());
			     model.addAttribute("representanteMatricula", repair.getRepresentanteTecnicoMatricula()); 			 
			     model.addAttribute("plazo", repair.getPlazo());
			     model.addAttribute("presupuestoAdjudicacion", repair.getPresupuestoAdjudicacion());	
			     model.addAttribute("presupuestoFinal", repair.getPresupuestoFinal());
			     model.addAttribute("fechaEstimadaInicio", DateUtils.getFechaFormateada(repair.getFechaEstimadaInicio(), DateUtils.FORMAT_DATE_DEFAULT));
			     model.addAttribute("fechaEstimadaFin", DateUtils.getFechaFormateada(repair.getFechaEstimadaFin(), DateUtils.FORMAT_DATE_DEFAULT));			     
			     model.addAttribute("fechaRealInicio", DateUtils.getFechaFormateada(repair.getFechaRealInicio(), DateUtils.FORMAT_DATE_DEFAULT));
			     model.addAttribute("fechaRealFin", DateUtils.getFechaFormateada(repair.getFechaRealFin(), DateUtils.FORMAT_DATE_DEFAULT));			     
			     model.addAttribute("observaciones", repair.getObservaciones());
			  
			  }
			 
			//page 1
			JSONArray updatePagesArray = new JSONArray();
			JSONArray commentPagesArray = new JSONArray();
			
			updatePagesArray = paginateToArray(issue.getHistorial(), 1, "update");			
			commentPagesArray = paginateToArray(issue.getComentarios(), 1, "comment");
			
			model.addAttribute("jsonUpdates", updatePagesArray.length() == 0 ? "[]" : updatePagesArray);
			model.addAttribute("jsonComments", commentPagesArray.length() == 0 ? "[]" : commentPagesArray);

		} catch (Exception e) {
			model.addAttribute("messageTitle", "&iexcl;Atenci&oacute;n!");
			model.addAttribute("message", "La página solicitada no existe.");
			return "error";	
		}

		return "issues";
	}
	
	
	@RequestMapping(value="/issues/{issueID}/loadmore/{type}/{page}", produces={"application/json; charset=UTF-8"}, method = RequestMethod.GET)  
	public @ResponseBody String loadMorePagesByIssue(@PathVariable ("issueID") int issueID, @PathVariable ("type") String type, @PathVariable ("page") int page) throws JSONException{  
		
		JSONArray pagesArray = new JSONArray();
		IssueDTO issue = issueService.getIssueById(String.valueOf(issueID));
		
		if(issue == null)
			return null;
		
		else{
			if(type.equals("update"))
				pagesArray = paginateToArray(issue.getHistorial(), page, type);
			
			else if (type.equals("comment")){
				pagesArray = paginateToArray(issue.getComentarios(), page, type);	
			}
		}
			
		return pagesArray != null ? pagesArray.toString() :  null;
	}  
	
	@SuppressWarnings("unchecked")
	private <T> JSONArray paginateToArray(List<T> elements, int currentPage, String type) throws JSONException{
		
		JSONArray jsonArray = null;
		
		if(elements.size() == 0)
			return new JSONArray();
		
		int itemsPerPage = ITEMS_PER_PAGE;
		int totalItems = elements.size();
		int totalPages = (int) Math.ceil((double)totalItems / itemsPerPage);	
		
		if(currentPage > totalPages){ 
			return jsonArray;
		}
		
		else{
		
			int from = ( currentPage - 1 ) * itemsPerPage;
			int to = from + itemsPerPage - 1 ;	
			
			int lastPage = totalPages - currentPage;
			
			//is last page
	    	if(lastPage == 0){
				int itemsLeft = totalItems - ( currentPage - 1 ) * itemsPerPage ; 
			
	    		if( itemsLeft < itemsPerPage )
	    			to = ( currentPage -1 ) * itemsPerPage + itemsLeft-1;
	    	}	
	    	
			//issue type
			if(type.equals("update")){
				
				jsonArray = new JSONArray();
				
				List<IssueHistoryDTO> sub = (List<IssueHistoryDTO>) elements.subList(from, to + 1); //sublist toma el item en la posicion anterior al toIndex que se le pasa
				
				for(IssueHistoryDTO update : sub){
					int index = from + (sub.indexOf(update) + 1);
					
					JSONObject obj = new JSONObject();
					obj.put("id", index);
					obj.put("date", update.getFechaFormateada());
					obj.put("username", update.getUsername());		
					obj.put("motive", update.getMotivo());	
					obj.put("obs", update.getObservaciones());	
					jsonArray.put(obj);
				}		
				
			}
			
			else if(type.equals("comment")){
				
				jsonArray = new JSONArray();
				
				//user type
				List<CommentDTO> sub = (List<CommentDTO>) elements.subList(from, to + 1); //sublist toma el item en la posicion anterior al toIndex que se le pasa
				
				for(CommentDTO comment : sub){
					JSONObject obj = new JSONObject();
					obj.put("username", comment.getUsername());
					obj.put("date", comment.getFechaFormateada());	
					obj.put("message", comment.getMensaje());	
					jsonArray.put(obj);
				}			
			}
			
			return jsonArray;		   
		}
	}
	
	
	@RequestMapping(value = "/users/{userID}/uploadUserPic", method = RequestMethod.POST)
	public @ResponseBody ContenidoResponse doUserFileUpload(
			@PathVariable ("userID") String userPage, 
			@RequestParam ("fileData") String fileData, 
			@RequestParam ("filename") String filename) throws JSONException{
		
		try{
			
			String userID = getCurrentUser(SecurityContextHolder.getContext()
					.getAuthentication()).getUsername();

			if (userPage.equals(userID)) {
			
				MediaContent file = new MediaContent();
				file = this.deserializeFile(fileData);
				file.setFilename(filename);
				file.setUsername(userID);
				file.setProfilePic(true);
				file.setFileOrder(0);
				
				contenidoService.uploadUserPic(file);
			
			}
			
			else{
				return new ContenidoResponse(false, 0);
			}
			
			return new ContenidoResponse(true, 1);
			
			
		}catch(Exception e){
			return new ContenidoResponse(false, 0);
		}
	}


	
	@RequestMapping(value = "/issues/{issueID}/uploadFiles", method = RequestMethod.POST)
	public @ResponseBody ContenidoResponse doFileUpload(@PathVariable ("issueID") String issueID, 
			@RequestParam ("fileList") String fileList, Model model) throws JSONException{
	
		List<MediaContent> files = new ArrayList<MediaContent>();
		ContenidoResponse response = new ContenidoResponse();
		
		try{	
			
			String userID = getCurrentUser(SecurityContextHolder.getContext()
					.getAuthentication()).getUsername();
			
			files = (List<MediaContent>) this.deserializeMultipleFiles(fileList);
			contenidoService.uploadFiles(files, issueID, userID);
			
			List<MediaContent> contenidos = contenidoService.getIssueFiles(issueID);
			model.addAttribute("contenidos", contenidos);
			model.addAttribute("cantidadContenidos", contenidos.size());
			
			JSONArray jsonArray = new JSONArray();
			
			for(MediaContent c : files){				
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("name", shortenFilename(c.getFilename()));
				jsonObject.put("format", c.getFileType());
				jsonObject.put("url", c.getLink());
				jsonObject.put("thumbnailUrl", c.getLink());
				jsonObject.put("size", c.getSize());
				jsonObject.put("error", StringUtils.EMPTY);
				jsonArray.put(jsonObject);
			}
			
			response.setStatus(true);
			response.setTotalUploadedFiles(contenidos.size());
			response.setUploadedFiles(jsonArray.toString());
			return response;
			
		}catch(Exception e){
			return new ContenidoResponse(false, 0);
		}
	}
	
	private String shortenFilename(String filename){
		
		if(filename.length() > 25){
			String [] split =  filename.split(".");
			String type = split[1];
			String newName = split[0].substring(0, 11) + "..." + type;
			return newName;
		}
		else{
			return filename;
		}
	}
	
	@RequestMapping(value = "/issues/{issueID}/deleteFile", method = RequestMethod.POST)
	public @ResponseBody ContenidoResponse doFileDelete(@PathVariable ("issueID") String issueID, 
			@RequestParam ("fileID") String fileID, Model model) throws JSONException{
	
		List<String> files = new ArrayList<String>();
		
		try{			
			
			files.add(fileID);
			contenidoService.deleteFiles(files, issueID);
			
			List<MediaContent> contenidos = contenidoService.getIssueFiles(issueID);
			model.addAttribute("contenidos", contenidos);
			model.addAttribute("cantidadContenidos", contenidos.size());

			
			return new ContenidoResponse(true, contenidos.size());
			
		}catch(Exception e){
			return new ContenidoResponse(false, "No se puedo eliminar el archivo" , 0);
		}
	}
	
	
	private MediaContent deserializeFile(String fileData){
		
		try{
			JSONObject jsonFile = new JSONObject(fileData);
		  
			MediaContent file = new MediaContent();
			file.setFileID(jsonFile.getString("id"));
			file.setFileType(jsonFile.getString("type"));
			file.setWidth(Integer.parseInt(jsonFile.getString("width")));
			file.setHeight(Integer.parseInt(jsonFile.getString("height")));
			file.setSize(Integer.parseInt(jsonFile.getString("size")));
			file.setUploadDate(Integer.parseInt(jsonFile.getString("datetime")));
			file.setDeleteHash(jsonFile.getString("deletehash"));
			file.setLink(jsonFile.getString("link"));
					
			return file;
		}
		catch(JSONException e){
			return null;
		}
	}
	
	private List<MediaContent> deserializeMultipleFiles(String fileData){
		
		List<MediaContent> contenidos = new ArrayList<MediaContent>();
		
		try{
			JSONArray jsonArray = new JSONArray(fileData);
		    
			for(int i = 0; i < jsonArray.length(); i++){
	            JSONObject jsonObject = jsonArray.getJSONObject(i);
	            JSONObject jsonFile = jsonObject.getJSONObject("filedata");
	            
				MediaContent file = new MediaContent();
				file.setFileID(jsonFile.getString("id"));
				file.setFileType(jsonFile.getString("type"));
				file.setWidth(Integer.parseInt(jsonFile.getString("width")));
				file.setHeight(Integer.parseInt(jsonFile.getString("height")));
				file.setSize(Integer.parseInt(jsonFile.getString("size")));
				file.setUploadDate(Integer.parseInt(jsonFile.getString("datetime")));
				file.setDeleteHash(jsonFile.getString("deletehash"));
				file.setLink(jsonFile.getString("link"));				
				file.setFilename(jsonObject.getString("filename"));
				file.setProfilePic(false);			
				contenidos.add(file);
				
		    }
			
		}
		catch(JSONException e){
			return null;
		}
		return contenidos;
		
	}

	@RequestMapping(value = "/reportIssue", method = RequestMethod.POST)
	public @ResponseBody
	AlertStatus doReportIssue(@ModelAttribute("issueForm") IssueDTO issue, 
			@RequestParam("fileData") String fileData, @RequestParam("filename") String filename,
			HttpServletRequest request) {

		try {
			
			String userID = getCurrentUser(SecurityContextHolder.getContext()
					.getAuthentication()).getUsername();			

			String capitalize = WordUtils.capitalizeFully(issue.getTitle(), new char[] { '.' });
			issue.setTitle(capitalize);

			// issue data
			UserDTO userDTO = new UserDTO();
			userDTO.setUsername(userID);
			issue.setUsername(userID);
			issue.setCreationDate(new Date());
			issue.setLastUpdateDate(issue.getCreationDate());
			issue.setStatus(StatusList.OPEN.getLabel());
			issue.setUser(userDTO);

			// history
			IssueHistoryDTO revision = new IssueHistoryDTO();
			revision.setFecha(new Date());
			revision.setUsername(userID);
			revision.setOperacion(Operation.CREATE);
			revision.setMotivo(Messages.ISSUE_CREATION + " el reclamo.");
			revision.setObservaciones("");
			revision.setEstado(issue.getStatus());

			issue.getHistorial().add(revision);
			issue.setReparacion(null);

			//contenido (opcional)
		
			MediaContent file = this.deserializeFile(fileData);
					
			if(file != null){
				file.setFileOrder(1);
				file.setFilename(filename);
				issue.setUploadedFile(file);
			}
			else{
				issue.setUploadedFile(null);
			}
			
			issueService.reportIssue(issue);

			return new AlertStatus(true, "El reclamo ha sido registrado.");
			

		} catch (Exception e) {		
			return new AlertStatus(false,
					"No se pudo publicar el reclamo. Intente m&aacute;s tarde.");
		}
	}

	@RequestMapping(value = "/issues/sendTags", method = RequestMethod.POST)
	public @ResponseBody
	List<String> sendTags(@RequestParam List<String> tags) {
		return tags;
	}

	@RequestMapping(value = "/issues/{issueID}/updateIssue", produces={"application/json; charset=UTF-8"},  method = RequestMethod.POST)
	public @ResponseBody
	AlertStatus doUpdatetIssue(@PathVariable("issueID") String issueID, 
			@ModelAttribute("issue") IssueDTO issue,
			@RequestParam("fields") String fieldChanges,
			HttpServletRequest request) throws Exception {

		try {

			String userID = getCurrentUser(SecurityContextHolder.getContext()
					.getAuthentication()).getUsername();
			
			// tags
			Object[] tagMapValues = (Object[]) issue.getTagsMap().values()
					.toArray();
			
			if(tagMapValues.length == 0){					
				return new AlertStatus(false, "Debe especificar al menos una CATEGOR&Iacute;A.");					
			}
			
			else{
				
				String[] tagsArray = new String[tagMapValues.length];

				if (tagMapValues.length > 0) {
					if (tagMapValues[0] instanceof String) {
						for (int i = 0; i < tagMapValues.length; i++)
							tagsArray[i] = (String) tagMapValues[i];
					} else
						tagsArray = (String[]) tagMapValues[0];
				}

				UpdatedFields updatedFields = new Gson().fromJson(fieldChanges,
						UpdatedFields.class);
				
//					String fields = "";
				String motive = "";
				int fieldCounter = 0;

				/**
				if (updatedFields.getTitle() == 1) {
					fields += "Titulo, ";
					fieldCounter++;
				}
				if (updatedFields.getBarrio() == 1) {
					fields += "Barrio, ";
					fieldCounter++;
				}
				if (updatedFields.getDesc() == 1) {
					fields += "Descripcion, ";
					fieldCounter++;
				}
				**/
				
				//taglist comparison					
				Set<String> currentTags = new HashSet<String>();
				currentTags.addAll(issueService.getIssueById(issueID).getTags());
				
				Set<String> updatedTags = new HashSet<String>();
				updatedTags.addAll(Arrays.asList(tagsArray));
				
				//comparo contenido, sin importar el orden de los items
				boolean areTagsEqual = currentTags.equals(updatedTags);
				
				if(updatedFields.getTitle() == 1
						|| updatedFields.getBarrio() == 1
						|| updatedFields.getDesc() == 1
						|| currentTags.size() != updatedTags.size() 
						|| !areTagsEqual){
//						fields += "Categorias, ";
					fieldCounter++;
				}
									
				//no changes
				if(fieldCounter == 0){
					return new AlertStatus(false, "No hay cambios para guardar.");		
				}
					
				else{
					
//						fields = fields.substring(0, fields.length() - 2 ).trim();

//							if (fieldCounter == 1) {
//								motive = Messages.ISSUE_UPDATE_FIELDS + " el campo "
//										+ fields;
//							}
//							if (fieldCounter > 1) {
//								motive = Messages.ISSUE_UPDATE_FIELDS + " los campos "
//										+ fields;
//							}
					
					motive = "actualizo datos del reclamo.";
					
				}
	
				// history
				IssueHistoryDTO revision = new IssueHistoryDTO();
				revision.setFecha(new Date());
				revision.setUsername(userID);
				revision.setOperacion(Operation.UPDATE);
				revision.setMotivo(motive);
				revision.setEstado(issue.getStatus());
				revision.setObservaciones("");

				issue.setId(issueID);
				issue.setUsername(userID);
				issue.setLastUpdateDate(revision.getFecha());
				issue.setTags(Arrays.asList(tagsArray));
				issue.getHistorial().add(revision);

				issueService.updateIssue(issue);

				return new AlertStatus(true, "El reclamo ha sido actualizado.");

			}
		} catch (Exception e) {			
			return new AlertStatus(false,
					"No ha sido posible actualizar el reclamo. Intente de nuevo.");
		}

	}

	@RequestMapping(value = "/issues/{issueID}/updateIssueStatus", produces={"application/json; charset=UTF-8"}, method = RequestMethod.POST)
	public @ResponseBody
	AlertStatus doUpdatetIssueStatus(@PathVariable("issueID") String issueID,
			@RequestParam("newStatus") String newStatus,
			@RequestParam("resolution") String resolution,
			@RequestParam("obs") String obs, HttpServletRequest request)
			throws Exception {

		try {		
			
			String userID = getCurrentUser(SecurityContextHolder.getContext()
					.getAuthentication()).getUsername();
				
			if(newStatus.equals(StatusList.VERIFIED)){
				issueService.updateIssueStatus(userID, issueID,
						newStatus, null, null);
			}
			else{
				issueService.updateIssueStatus(userID, issueID,
						newStatus, resolution, obs);
			}
							
			return new AlertStatus(true,
					"El estado reclamo ha sido actualizado.");
		

		} catch (Exception e) {		
			return new AlertStatus(false,
					"No ha sido posible actualizar el reclamo. Intente de nuevo.");
		}
	}

	@RequestMapping(value = "/issues/{issueID}/addRepairInfo", method = RequestMethod.POST)
	public @ResponseBody
	AlertStatus addRepairInfo(@PathVariable("issueID") String issueID, @ModelAttribute("repairForm") IssueRepair repair,
			Model model, HttpServletRequest request) throws ParseException {

		try {
			
			String userID = getCurrentUser(SecurityContextHolder.getContext()
				.getAuthentication()).getUsername();		
		
			repair.setId(Long.valueOf(issueID));
			issueService.addReparacion(repair, userID);			
		
			return new AlertStatus(true, "La informacion ha sido actualizada.");
		
		}catch (Exception e) {
			return new AlertStatus(false,
					"No se pudo guardar la informaci&oacute;n. Intente de nuevo.");
		}
	}

	@RequestMapping(value = "/issues/{issueID}/deleteRepairInfo", method = RequestMethod.POST)
	public @ResponseBody AlertStatus deleteRepairInfo(@PathVariable("issueID") String issueID, 
			Model model, HttpServletRequest request) throws ParseException {

		try {
			
			String userID = getCurrentUser(SecurityContextHolder.getContext()
					.getAuthentication()).getUsername();
			
			issueService.deleteReparacion(issueID, userID);			

			return new AlertStatus(true, "La informacion ha sido eliminada.");

		}catch (Exception e) {
			return new AlertStatus(false,
					"No se pudo eliminar la informaci&oacute;n. Intente de nuevo.");
		}
	}

	@RequestMapping(value = "/loadTags", method = RequestMethod.GET)
	public @ResponseBody
	List<String> loadTagList(HttpServletRequest request) {
		return issueService.getTagList();
	}

	@RequestMapping(value = "/loadTags2", method = RequestMethod.GET)
	public @ResponseBody
	String loadTagListJson(HttpServletRequest request) throws JSONException {
		List<String> dbTags = issueService.getTagList();

		JSONArray array = new JSONArray();
		for (String s : dbTags) {
			JSONObject obj = new JSONObject();
			obj.put("id", dbTags.indexOf(s));
			obj.put("text", s);
			array.put(obj);
		}

		return array.toString();

	}

	@RequestMapping(value = "/issues/{issueID}/addComment", method = RequestMethod.POST)
	public @ResponseBody
	AlertStatus doAddComent(@PathVariable("issueID") String issueID,
			@RequestParam("comment") String mensaje,
			HttpServletRequest request, Model model) throws Exception {

		try {
			
			String userID = getCurrentUser(SecurityContextHolder.getContext()
					.getAuthentication()).getUsername();

			if (mensaje.isEmpty()) {
				return new AlertStatus(false, "Agregue un mensaje.");
			}

			else {
				CommentDTO comentario = new CommentDTO();
				comentario.setFecha(new Date());
				comentario.setNroReclamo(Long.valueOf(issueID));
				comentario.setUsername(userID);
				comentario.setMensaje(mensaje);

				issueService.postComment(comentario);

				List<CommentDTO> comments = issueService.getIssueById(issueID).getComentarios();
				model.addAttribute("comentarios", comments);
				model.addAttribute("cantidadComentarios", comments.size());
				
			}

		}catch (Exception e){
			return new AlertStatus(false,
					"No ha sido posible publicar el comentario. Intente de nuevo.");			
		}	
	
		return new AlertStatus(true, "El comentario ha sido publicado.");
	}

	@RequestMapping(value = "/issues/{issueID}/{watchOrUnwatch}", method = RequestMethod.POST)
	public @ResponseBody
	AlertStatus wIssue(@PathVariable String watchOrUnwatch,
			@PathVariable("issueID") String issueID, Model model) {

		IssueFollow follow = new IssueFollow();

		try {

			String userID = getCurrentUser(SecurityContextHolder.getContext()
					.getAuthentication()).getUsername();

			follow.setId(new IssueMainActionPK(Long.valueOf(issueID), userService.getUserId(userID)));
//			follow.setUsername(userID);

			if (watchOrUnwatch.equals("watch")) {
				follow.setDate(DateUtils.toCalendar(new Date()));
				issueService.followIssue(follow);
			}

			else {
				issueService.unFollowIssue(follow);
			}

			List<String> observadores = issueService
					.getIssueFollowers(issueID);
			model.addAttribute("cantidadObservadores", observadores.size());

			return new AlertStatus(true,
					String.valueOf(observadores.size()));		

		}catch (Exception e) {
			return new AlertStatus(false,
					"Ha ocurrido un error al intentar seguir el reclamo.");
		}

	}

	@RequestMapping(value = "/issues/{issueID}/displayIssueFollowers", method = RequestMethod.POST)
	public @ResponseBody
	List<String> displayIssueFollowers(@PathVariable("issueID") String issueID) {
		return issueService.getIssueFollowers(issueID);
	}

	@RequestMapping(value = "/issues/{issueID}/voteIssue", method = RequestMethod.POST)
	public @ResponseBody
	AlertStatus voteIssue(@PathVariable("issueID") String issueID,
			@RequestParam("vote") int voteUpOrDown, Model model) {

		IssueVote vote = new IssueVote();

		try {
			
			String userID = getCurrentUser(SecurityContextHolder.getContext()
					.getAuthentication()).getUsername();
		
			vote.setId(new IssueMainActionPK(Long.valueOf(issueID), userService.getUserId(userID)));
			vote.setVote(voteUpOrDown);
			vote.setDate(DateUtils.toCalendar(new Date()));
			issueService.submitVote(vote);
			
			return new AlertStatus(true, String.valueOf(issueService
					.countIssueVotes(issueID)));

		} catch (Exception e) {
			return new AlertStatus(false,
					"Ha ocurrido un error al intentar votar el reclamo.");
		}

	}

	public static int randomNumber(int min, int max) {

		// Usually this can be a field rather than a method variable
		Random rand = new Random();

		// nextInt is normally exclusive of the top value,
		// so add 1 to make it inclusive
		int randomNum = rand.nextInt((max - min) + 1) + min;

		return randomNum;
	}

	public class UpdatedFields implements Serializable {

		private static final long serialVersionUID = 1L;
		private int title;
		private int desc;
		private int barrio;

		public int getTitle() {
			return title;
		}

		public void setTitle(int title) {
			this.title = title;
		}

		public int getDesc() {
			return desc;
		}

		public void setDesc(int desc) {
			this.desc = desc;
		}

		public int getBarrio() {
			return barrio;
		}

		public void setBarrio(int barrio) {
			this.barrio = barrio;
		}

	}

}
