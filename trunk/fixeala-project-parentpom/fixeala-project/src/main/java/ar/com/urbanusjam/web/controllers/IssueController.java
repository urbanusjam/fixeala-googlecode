package ar.com.urbanusjam.web.controllers;

import java.io.Serializable;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.WordUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.access.AccessDeniedException;
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

import ar.com.urbanusjam.entity.annotations.IssueRepair;
import ar.com.urbanusjam.entity.annotations.MediaContent;
import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.ContenidoService;
import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.UserService;
import ar.com.urbanusjam.services.dto.CommentDTO;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.IssueFollowDTO;
import ar.com.urbanusjam.services.dto.IssuePageViewDTO;
import ar.com.urbanusjam.services.dto.IssueHistoryDTO;
import ar.com.urbanusjam.services.dto.IssueVoteDTO;
import ar.com.urbanusjam.services.dto.UserDTO;
import ar.com.urbanusjam.services.utils.DateUtils;
import ar.com.urbanusjam.services.utils.IssueStatus;
import ar.com.urbanusjam.services.utils.Messages;
import ar.com.urbanusjam.services.utils.Operation;
import ar.com.urbanusjam.web.domain.AlertStatus;
import ar.com.urbanusjam.web.domain.ContenidoResponse;
import ar.com.urbanusjam.web.utils.StatusList;

import com.google.gson.Gson;

@Controller
// @RequestMapping(value="/issue")
public class IssueController {
	
	private static int ITEMS_PER_PAGE = 10;

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
			obj.put("date", issue.getFormattedDate(issue.getCreationDate(),
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
			String url = "./search.html?type=tag&value=" + tag.trim().trim().toLowerCase();
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
			String url = "./search.html?type=status&value=" + status.getLabel().trim().toLowerCase();
			obj.put("url", url);
			obj.put("text", status.getLabel().toUpperCase());
			obj.put("css", status.getCssClass());
			obj.put("color", status.getColorCode());
			statusArray.put(obj);
		}

		model.addAttribute("allStatus", statusArray.toString());

		return "search";

	}

	@RequestMapping(value = "/issues/{issueToken}", method = RequestMethod.GET)
	public String showIssuePage(Model model,
			@PathVariable("issueToken") String issueToken,
			HttpServletRequest request) {

		IssueDTO issue = new IssueDTO();
		String issueID = issueToken;

		try {
			request.getSession().setAttribute("issueID", issueID);
			issue = issueService.getIssueById(issueID);

			JSONObject oldFields = new JSONObject();
			oldFields.put("title", issue.getTitle());
			oldFields.put("desc", issue.getDescription());
			oldFields.put("barrio", issue.getNeighborhood());

			model.addAttribute("oldFields", oldFields.toString());

			model.addAttribute("titulo", issue.getTitle());
			model.addAttribute("tituloCss", issue.getTitleCss());
			model.addAttribute("estado", issue.getStatus());
			model.addAttribute("estadoCss", issue.getStatusCss());
			model.addAttribute("resolucion", issue.getResolution());
			model.addAttribute("direccion", issue.getFullAddress());
			model.addAttribute("id", issue.getId());
			model.addAttribute("fechaCreacion", issue.getFormattedDate(
					issue.getCreationDate(), DateUtils.DATE_TIME_PATTERN_SHORT));
			model.addAttribute("fechaUltimaActualizacion", issue
					.getFormattedDate(issue.getLastUpdateDate(),
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

			IssueFollowDTO follow = new IssueFollowDTO();
			IssueVoteDTO currentVote = new IssueVoteDTO();			
			String loggedUser = "";
			boolean isUserWatching = false;
			
			Authentication auth = (Authentication) SecurityContextHolder
					.getContext().getAuthentication();

			if (!(auth instanceof AnonymousAuthenticationToken)) {
				UserDetails userDB = userService
						.loadUserByUsername(((User) auth.getPrincipal())
								.getUsername());
				if (userDB != null) {
					follow.setUsername(userDB.getUsername());
					follow.setIdIssue(issueID);
					isUserWatching = issueService.isUserFollowingIssue(follow);
					loggedUser = userDB.getUsername();

					IssuePageViewDTO pageviewDTO = new IssuePageViewDTO();
					pageviewDTO.setIssueID(issueID);
					pageviewDTO.setUsername(loggedUser);
					pageviewDTO.setDate(new Date());
					issueService.trackIssuePageView(pageviewDTO);
					currentVote = issueService.getCurrentVote(issueID,
							loggedUser);
				}

			}

			model.addAttribute("loggedUser", loggedUser);
			model.addAttribute("cantidadVisitas",
					issueService.getIssuePageViews(issueID));
			model.addAttribute("cantidadObservadores", issueService
					.getIssueFollowers(issueID).size());
			model.addAttribute("isUserWatching", isUserWatching);
			model.addAttribute("cantidadVotos",
					issueService.countIssueVotes(issueID));
			model.addAttribute("isCurrentlyVoted",
					currentVote.isCurrentlyVoteByUser());
			model.addAttribute("isVoteUp", currentVote.getVote() == 1 ? true
					: false);

			
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
			     model.addAttribute("fechaEstimadaInicio", parseDate(repair.getFechaEstimadaInicio()));
			     model.addAttribute("fechaEstimadaFin", parseDate(repair.getFechaEstimadaFin()));			     
			     model.addAttribute("fechaRealInicio", parseDate(repair.getFechaRealInicio()));
			     model.addAttribute("fechaRealFin", parseDate(repair.getFechaRealFin()));			     
			     model.addAttribute("observaciones", repair.getObservaciones());
			  
			  }
			 
			//page 1
			JSONArray updatePagesArray = new JSONArray();
			updatePagesArray = paginateToArray(issue.getHistorial(), 1, "update");
			
			JSONArray commentPagesArray = new JSONArray();
			commentPagesArray = paginateToArray(issue.getComentarios(), 1, "comment");
			
			model.addAttribute("jsonUpdates", updatePagesArray);
			model.addAttribute("jsonComments", commentPagesArray);

		} catch (Exception e) {

			return "redirect:/" + "error.html";
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
					obj.put("username", comment.getUsuario());
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
			User user = getCurrentUser(SecurityContextHolder.getContext()
					.getAuthentication());
			UserDetails loggedUser = userService.loadUserByUsername(user
					.getUsername());

			if (userPage.equals(loggedUser.getUsername())) {
			
				MediaContent file = new MediaContent();
				file = this.deserializeFile(fileData);
				file.setFilename(filename);
				file.setUsername(loggedUser.getUsername());
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
			
			User user = getCurrentUser(SecurityContextHolder.getContext()
					.getAuthentication());
			UserDetails userDB = userService.loadUserByUsername(user
					.getUsername());

			if (userDB == null) {
				return new ContenidoResponse(false, 0);
			}
			
			files = (List<MediaContent>) this.deserializeMultipleFiles(fileList);
			contenidoService.uploadFiles(files, issueID, userDB.getUsername());
			
			List<MediaContent> contenidos = contenidoService.getIssueFiles(issueID);
			model.addAttribute("contenidos", contenidos);
			model.addAttribute("cantidadContenidos", contenidos.size());
			
			JSONArray jsonArray = new JSONArray();
			
			for(MediaContent c : files){				
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("name",shortenFilename(c.getFilename()));
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
			User user = getCurrentUser(SecurityContextHolder.getContext()
					.getAuthentication());
			UserDetails userDB = userService.loadUserByUsername(user
					.getUsername());

			if (userDB == null) {
				return new AlertStatus(false,
						"Debe estar logueado para ingresar un nuevo reclamo.");
			}

			// user is logged-in
			else {

				String capitalize = WordUtils.capitalizeFully(issue.getTitle(), new char[] { '.' });
				issue.setTitle(capitalize);

				Random generator = new Random();
				int idIssue = generator.nextInt(100000) + 1000;

				// issue data
				UserDTO userDTO = new UserDTO();
				userDTO.setUsername(userDB.getUsername());
				issue.setUsername(userDB.getUsername());
				issue.setCreationDate(new Date());
				issue.setLastUpdateDate(issue.getCreationDate());
				issue.setStatus(IssueStatus.OPEN);
				issue.setUser(userDTO);
				issue.setId(String.valueOf(idIssue));

				// history
				IssueHistoryDTO revision = new IssueHistoryDTO();
				revision.setFecha(new Date());
				revision.setUsername(userDTO.getUsername());
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
					issue.setUploadedFile(file);
				}
				else{
					issue.setUploadedFile(null);
				}
				
				
					
				issueService.reportIssue(issue);

				return new AlertStatus(true, "Su reclamo ha sido registrado.");
			}

		} catch (Exception e) {
			if (e instanceof AccessDeniedException)
				return new AlertStatus(false,
						"Debe estar logueado para ingresar un nuevo reclamo.");
			else
				return new AlertStatus(false,
						"No se pudo publicar el reclamo. Intente m&aacute;s tarde.");
		}
	}

	@RequestMapping(value = "/issues/sendTags", method = RequestMethod.POST)
	public @ResponseBody
	List<String> sendTags(@RequestParam List<String> tags) {
		return tags;
	}

	@RequestMapping(value = "/issues/updateIssue", produces={"application/json; charset=UTF-8"},  method = RequestMethod.POST)
	public @ResponseBody
	AlertStatus doUpdatetIssue(@ModelAttribute("issue") IssueDTO issue,
			@RequestParam("fields") String fieldChanges,
			HttpServletRequest request) throws Exception {

		try {

			User user = getCurrentUser(SecurityContextHolder.getContext()
					.getAuthentication());
			UserDetails userDB = userService.loadUserByUsername(user
					.getUsername());

			if (userDB == null) {
				return new AlertStatus(false,
						"Debe estar logueado para ingresar un nuevo reclamo.");
			}

			// user is logged-in
			else {

				// tags
				Object[] tagMapValues = (Object[]) issue.getTagsMap().values()
						.toArray();
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
				String fields = "";
				String motive = "";
				int fieldCounter = 0;
				
				if(fieldCounter > 0){
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
					
					fields = fields.substring(0, fields.length() - 2 ).trim();

					if (fieldCounter == 1) {
						motive = Messages.ISSUE_UPDATE_FIELDS + " el campo "
								+ fields;
					}
					if (fieldCounter > 1) {
						motive = Messages.ISSUE_UPDATE_FIELDS + " los campos "
								+ fields;
					}
				}
				
				else{
					motive = "actualizo las Categorias del reclamo.";
				}

				// history
				IssueHistoryDTO revision = new IssueHistoryDTO();
				revision.setFecha(new Date());
				revision.setUsername(userDB.getUsername());
				revision.setOperacion(Operation.UPDATE);
				revision.setMotivo(motive);
				revision.setEstado(issue.getStatus());
				revision.setObservaciones("");

				issue.setUsername(userDB.getUsername());
				issue.setLastUpdateDate(revision.getFecha());
				issue.setTags(Arrays.asList(tagsArray));
				issue.getHistorial().add(revision);

				issueService.updateIssue(issue);

				return new AlertStatus(true, "El reclamo ha sido actualizado.");

			}
		} catch (Exception e) {
			if (e instanceof AccessDeniedException)
				return new AlertStatus(false,
						"Debe estar logueado para ingresar un nuevo reclamo.");
			else
				return new AlertStatus(false,
						"No ha sido posible actualizar el reclamo. Intente de nuevo.");
		}

	}

	@RequestMapping(value = "/issues/updateIssueStatus", produces={"application/json; charset=UTF-8"}, method = RequestMethod.POST)
	public @ResponseBody
	AlertStatus doUpdatetIssueStatus(@RequestParam("issueID") String issueID,
			@RequestParam("newStatus") String newStatus,
			@RequestParam("resolution") String resolution,
			@RequestParam("obs") String obs, HttpServletRequest request)
			throws Exception {

		try {
			User user = getCurrentUser(SecurityContextHolder.getContext()
					.getAuthentication());
			UserDetails userDB = userService.loadUserByUsername(user
					.getUsername());

			if (userDB == null) {
				return new AlertStatus(false,
						"Debe estar logueado para ingresar un nuevo reclamo.");
			}

			else {
				issueService.updateIssueStatus(userDB.getUsername(), issueID,
						newStatus, resolution, obs);
				return new AlertStatus(true,
						"El estado reclamo ha sido actualizado.");
			}

		} catch (Exception e) {
			if (e instanceof AccessDeniedException)
				return new AlertStatus(false,
						"Debe estar logueado para ingresar un nuevo reclamo.");
			else
				return new AlertStatus(false,
						"No ha sido posible actualizar el reclamo. Intente de nuevo.");
		}
	}

	@RequestMapping(value = "/issues/addRepairInfo", method = RequestMethod.POST)
	public @ResponseBody
	AlertStatus addRepairInfo(@ModelAttribute("repairForm") IssueRepair repair,
			Model model, HttpServletRequest request) throws ParseException {

		try {
			
			User user = getCurrentUser(SecurityContextHolder.getContext()
					.getAuthentication());
			UserDetails userDB = userService.loadUserByUsername(user
					.getUsername());

			if (userDB == null) {
				return new AlertStatus(false,
						"Debe estar logueado para agregar informaci&oacute;n al reclamo.");
			}
			
			else{
				String issueID = (String) request.getSession().getAttribute(
						"issueID");

				repair.setId(Long.valueOf(issueID));
				issueService.addReparacion(repair, userDB.getUsername());
			}
		
			return new AlertStatus(true, "La informacion ha sido actualizada.");

		} catch (AccessDeniedException e) {
			return new AlertStatus(false,
					"Debe estar logueado para actualizar el reclamo.");
		} catch (Exception e) {
			return new AlertStatus(false,
					"No se pudo guardar la informaci&oacute;n. Intente de nuevo.");
		}
	}

	@RequestMapping(value = "/issues/deleteRepairInfo", method = RequestMethod.POST)
	public @ResponseBody AlertStatus deleteRepairInfo(Model model, HttpServletRequest request) throws ParseException {

		try {
			
			User user = getCurrentUser(SecurityContextHolder.getContext()
					.getAuthentication());
			UserDetails userDB = userService.loadUserByUsername(user
					.getUsername());

			if (userDB == null) {
				return new AlertStatus(false,
						"Debe estar logueado para actualizar el reclamo.");
			}
			
			else{
				String issueID = (String) request.getSession().getAttribute("issueID");
				issueService.deleteReparacion(issueID, userDB.getUsername());
			}

			return new AlertStatus(true, "La informacion ha sido eliminada.");

		} catch (AccessDeniedException e) {
			return new AlertStatus(false,
					"Debe estar logueado para actualizar el reclamo.");
		} catch (Exception e) {
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

	@RequestMapping(value = "/issues/addComment", method = RequestMethod.POST)
	public @ResponseBody
	AlertStatus doAddComent(@RequestParam("issueID") String issueID,
			@RequestParam("comment") String mensaje,
			HttpServletRequest request, Model model) throws Exception {

		try {
			User user = getCurrentUser(SecurityContextHolder.getContext()
					.getAuthentication());
			UserDetails userDB = userService.loadUserByUsername(user
					.getUsername());

			if (userDB == null) {
				return new AlertStatus(false,
						"Debe estar logueado para publicar un comentario.");
			}

			if (mensaje.isEmpty()) {
				return new AlertStatus(false, "Agregue un mensaje.");
			}

			else {
				CommentDTO comentario = new CommentDTO();
				comentario.setFecha(new Date());
				comentario.setNroReclamo(issueID);
				comentario.setUsuario(userDB.getUsername());
				comentario.setMensaje(mensaje);

				issueService.postComment(comentario);

//				List<CommentDTO> comments = issueService
//						.getCommentsByIssue(issueID);
				List<CommentDTO> comments = issueService.getIssueById(issueID).getComentarios();
				model.addAttribute("comentarios", comments);
				model.addAttribute("cantidadComentarios", comments.size());
				
			}

		}catch (Exception e) {
			if(e instanceof AccessDeniedException){
				return new AlertStatus(false,
						"Debe estar logueado para publicar un nuevo comentario.");	
			}
			else{
				return new AlertStatus(false,
						"No ha sido posible publicar el comentario. Intente de nuevo.");
			} 
			
		}	
	
		return new AlertStatus(true, "El comentario ha sido publicado.");
	}

	@RequestMapping(value = "/issues/{issueID}/{watchOrUnwatch}", method = RequestMethod.POST)
	public @ResponseBody
	AlertStatus wIssue(@PathVariable String watchOrUnwatch,
			@PathVariable("issueID") String issueID, Model model) {

		IssueFollowDTO follow = new IssueFollowDTO();

		try {

			User user = getCurrentUser(SecurityContextHolder.getContext()
					.getAuthentication());
			UserDetails loggedUser = userService.loadUserByUsername(user
					.getUsername());

			if (loggedUser == null) {
				return new AlertStatus(false,
						"Debe estar logueado para seguir el reclamo.");
			}

			else {

				follow.setIdIssue(issueID);
				follow.setUsername(loggedUser.getUsername());

				if (watchOrUnwatch.equals("watch")) {
					follow.setDate(new Date());
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
			}

		} catch (AccessDeniedException e) {
			return new AlertStatus(false,
					"Debe estar logueado para seguir el reclamo.");

		} catch (Exception e) {
			return new AlertStatus(false,
					"Ha ocurrido un error al intentar seguir el reclamo.");
		}

	}

	@RequestMapping(value = "/issues/displayIssueFollowers", method = RequestMethod.POST)
	public @ResponseBody
	List<String> displayIssueFollowers(@RequestParam("issueID") String issueID) {
		return issueService.getIssueFollowers(issueID);
	}

	@RequestMapping(value = "/issues/voteIssue", method = RequestMethod.POST)
	public @ResponseBody
	AlertStatus voteIssue(@RequestParam("issueID") String issueID,
			@RequestParam("vote") int voteUpOrDown, Model model) {

		IssueVoteDTO vote = new IssueVoteDTO();

		try {
			User user = getCurrentUser(SecurityContextHolder.getContext()
					.getAuthentication());
			UserDetails loggedUser = userService.loadUserByUsername(user
					.getUsername());

			if (loggedUser == null) {
				return new AlertStatus(false,
						"Debe estar logueado para votar el reclamo.");
			}

			else {

				IssueDTO issueDTO = issueService.getIssueById(issueID);
				IssueVoteDTO currentVote = issueService.getCurrentVote(issueID,
						loggedUser.getUsername());

				if (issueDTO.getUsername().equals(loggedUser.getUsername())
						&& currentVote != null) {
					return new AlertStatus(false,
							"No puede votar su propio reclamo.");
				}

				else {
					if ((currentVote.isCurrentlyVoteByUser()))
						return new AlertStatus(false,
								"Ya ha votado por este reclamo.");
				}

			}

			vote.setIdIssue(issueID);
			vote.setUsername(loggedUser.getUsername());
			vote.setVote(voteUpOrDown);
			vote.setDate(new Date());

			issueService.voteIssue(vote);
			return new AlertStatus(true, String.valueOf(issueService
					.countIssueVotes(issueID)));

		} catch (AccessDeniedException e) {
			return new AlertStatus(false,
					"Debe estar logueado para votar el reclamo.");

		} catch (Exception e) {
			return new AlertStatus(false,
					"Ha ocurrido un error al intentar votar el reclamo.");
		}

	}

	private User getCurrentUser(Authentication auth) {
		User currentUser;
		if (auth.getPrincipal() instanceof UserDetails) {
			currentUser = (User) auth.getPrincipal();
		} else if (auth.getDetails() instanceof UserDetails) {
			currentUser = (User) auth.getDetails();
		} else {
			throw new AccessDeniedException("User not properly authenticated.");
		}
		return currentUser;
	}

	private String parseDate(Date date) {
		if (date != null) {
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
			String parsedDate = df.format(date);
			return parsedDate;
		}

		return "";
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
