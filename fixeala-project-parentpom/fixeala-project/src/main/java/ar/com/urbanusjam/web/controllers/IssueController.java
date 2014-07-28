package ar.com.urbanusjam.web.controllers;

import java.io.IOException;
import java.io.InputStream;
import java.io.Serializable;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.WordUtils;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;

import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.ContenidoService;
import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.UserService;
import ar.com.urbanusjam.services.dto.CommentDTO;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.IssueFollowDTO;
import ar.com.urbanusjam.services.dto.IssuePageViewDTO;
import ar.com.urbanusjam.services.dto.IssueRepairDTO;
import ar.com.urbanusjam.services.dto.IssueUpdateHistoryDTO;
import ar.com.urbanusjam.services.dto.IssueVoteDTO;
import ar.com.urbanusjam.services.dto.MediaContentDTO;
import ar.com.urbanusjam.services.dto.UserDTO;
import ar.com.urbanusjam.services.utils.DateUtils;
import ar.com.urbanusjam.services.utils.FileUploadUtils;
import ar.com.urbanusjam.services.utils.IssueStatus;
import ar.com.urbanusjam.services.utils.Messages;
import ar.com.urbanusjam.services.utils.Operation;
import ar.com.urbanusjam.services.utils.Resolution;
import ar.com.urbanusjam.web.domain.AlertStatus;
import ar.com.urbanusjam.web.domain.ContenidoResponse;
import ar.com.urbanusjam.web.utils.StatusList;
import ar.com.urbanusjam.web.utils.URISchemeUtils;

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

	private static final String UPLOAD_DIRECTORY_WIN = "C:\\temp\\fixeala\\uploads\\";
	// private static final String UPLOAD_DIRECTORY_MAC =
	// "file:///Users/cora/Documents/dev/temp/fixeala/uploads/";

	private MediaContentDTO uploadedFile = null;

	@Autowired
	@Qualifier(value = "fixealaAuthenticationManager")
	protected AuthenticationManager fixealaAuthenticationManager;

	public MediaContentDTO getUploadedFile() {
		return uploadedFile;
	}

	public void setUploadedFile(MediaContentDTO uploadedFile) {
		this.uploadedFile = uploadedFile;
	}

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
			obj.put("address", issue.getFormattedAddress());
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
			String url = "./search.html?type=tag&value=" + tag.trim();
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
			String url = "./search.html?type=status&value=" + status.getLabel();
			obj.put("url", url);
			obj.put("text", status.getLabel());
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
		// String[] parts = issueToken.split("-");
		// String issueID = parts[0];

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
			model.addAttribute("direccion", issue.getFormattedAddress());
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
			model.addAttribute("usuario", issue.getUser().getUsername());
			model.addAttribute("area", issue.getArea());
			model.addAttribute("descripcion", issue.getDescription());
			model.addAttribute("latitud", issue.getLatitude());
			model.addAttribute("longitud", issue.getLongitude());
			model.addAttribute("historial", issue.getHistorial());

			List<String> issueTags = issue.getTags();
			String issueTagsByComma = StringUtils.EMPTY;
			String allTags = StringUtils.EMPTY;

			if (!issueTags.isEmpty()) {
				for (int i = 0; i < issueTags.size(); i++) {

					issueTagsByComma += issueTags.get(i) + ", ";
					// String url =
					// "./search.html?type=tag&value="+issueTags.get(i);
					// issueTagsByComma += "<a class=\"taglink\" href=\"" + url
					// + "\"><span class=\"label label-default\">" +
					// issueTags.get(i) + "</span></a>";

				}
				issueTagsByComma = issueTagsByComma.substring(0,
						issueTagsByComma.length() - 2);
			}

			List<String> dbTags = issueService.getTagList();
			JSONArray array = new JSONArray();
			for (String s : dbTags) {
				JSONObject obj = new JSONObject();
				obj.put("id", dbTags.indexOf(s));
				obj.put("text", s);
				array.put(obj);
			}

			allTags = array.toString();

			model.addAttribute("tagsByIssue", issueTagsByComma);
			model.addAttribute("allTags", allTags.length() == 0 ? "[{}]"
					: allTags);

			JSONArray jsonArray = new JSONArray();

			for (CommentDTO c : issue.getComentarios()) {
				JSONObject obj = new JSONObject();
				obj.put("fecha", c.getFechaFormateada());
				obj.put("usuario", c.getUsuario());
				obj.put("mensaje", c.getMensaje());
				jsonArray.put(obj);
			}
			model.addAttribute("comentariosJson", jsonArray);
			model.addAttribute("comentarios", issue.getComentarios());
			
			List<MediaContentDTO> contenidos = new ArrayList<MediaContentDTO>();
			contenidos = issue.getContenidos();

			if (contenidos.size() > 0) {
				model.addAttribute("contenidos", contenidos);
				MediaContentDTO contenido = contenidos.get(0);
				model.addAttribute("image", contenido);
				model.addAttribute("imageUrl", contenido.getPathRelativo());
				model.addAttribute("imageName", contenido.getNombre());
			}

			model.addAttribute("cantidadContenidos", contenidos.size());
			model.addAttribute("cantidadRevisiones", issue.getHistorial()
					.size());
			model.addAttribute("cantidadLicitacion",
					issue.getLicitacion() != null ? 1 : 0);
			model.addAttribute("estadoLicitacion",
					issue.getLicitacion() != null ? issue.getLicitacion()
							.getEstadoObra() : "Sin datos");
			model.addAttribute("cantidadReclamosSimilares", 0);
			model.addAttribute("cantidadArchivos", 0);
			model.addAttribute("cantidadComentarios", issue.getComentarios()
					.size());

			IssueFollowDTO follow = new IssueFollowDTO();
			IssueVoteDTO currentVote = new IssueVoteDTO();
			boolean isUserWatching = false;
			String loggedUser = "";

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

			/**
			 * IssueRepairDTO licitacion = new IssueRepairDTO();
			 * 
			 * if(issue.getLicitacion() != null){
			 * 
			 * licitacion = issue.getLicitacion();
			 * 
			 * model.addAttribute("obra", licitacion.getObra());
			 * model.addAttribute("nroLicitacion",
			 * licitacion.getNroLicitacion());
			 * model.addAttribute("nroExpediente",
			 * licitacion.getNroExpediente()); model.addAttribute("estadoObra",
			 * licitacion.getEstadoObra()); model.addAttribute("tipoObra",
			 * licitacion.getTipoObra()); model.addAttribute("valorPliego",
			 * licitacion.getValorPliego());
			 * model.addAttribute("unidadEjecutora",
			 * licitacion.getEmpresaConstructora());
			 * model.addAttribute("unidadFinanciamiento",
			 * licitacion.getUnidadFinanciamiento());
			 * model.addAttribute("empresaNombre",
			 * licitacion.getEmpresaNombre()); model.addAttribute("empresaCuit",
			 * licitacion.getEmpresaCuit());
			 * model.addAttribute("representanteNombre",
			 * licitacion.getRepresentanteNombre());
			 * model.addAttribute("representanteDni",
			 * licitacion.getRepresentanteDni()); //
			 * model.addAttribute("lic-plazo",
			 * licitacion.getPlazoEjecucionEnDias());
			 * model.addAttribute("presupuestoAdjudicado",
			 * licitacion.getPresupuestoAdjudicado());
			 * model.addAttribute("presupuestoFinal",
			 * licitacion.getPresupuestoFinal());
			 * model.addAttribute("fechaEstimadaInicio",
			 * parseDate(licitacion.getFechaEstimadaInicio()));
			 * model.addAttribute("fechaEstimadaFinal",
			 * parseDate(licitacion.getFechaEstimadaFin()));
			 * model.addAttribute("fechaRealInicio",
			 * parseDate(licitacion.getFechaRealInicio()));
			 * model.addAttribute("fechaRealFinal",
			 * parseDate(licitacion.getFechaRealFin()));
			 * 
			 * }
			 **/
			
			
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
	
	
	@RequestMapping(value="/issues/loadmoreByIssue/{issueID}/{type}/{page}", produces={"application/json; charset=UTF-8"}, method = RequestMethod.GET)  
	public @ResponseBody String loadMorePagesByIssue(@PathVariable ("issueID") int issueID, @PathVariable ("type") String  type, @PathVariable ("page") int page) throws JSONException{  
		
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
				
				List<IssueUpdateHistoryDTO> sub = (List<IssueUpdateHistoryDTO>) elements.subList(from, to + 1); //sublist toma el item en la posicion anterior al toIndex que se le pasa
				
				for(IssueUpdateHistoryDTO update : sub){
					JSONObject obj = new JSONObject();
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

	@RequestMapping(value = "/issues/handleMultipleFileUpload", method = RequestMethod.POST)
	public @ResponseBody
	ContenidoResponse processMultipleUpload(
			@RequestParam("issueID") String issueID,
			@RequestParam("userID") String userID,
			@RequestParam("files[]") List<MultipartFile> files,
			HttpServletRequest request, Model model) throws JSONException {

		InputStream inputStream = null;
		String fileName = StringUtils.EMPTY;
		String extensionArchivo = StringUtils.EMPTY;
		MediaContentDTO newContenido = new MediaContentDTO();
		List<MediaContentDTO> uploadedFiles = new ArrayList<MediaContentDTO>();
		ContenidoResponse response = new ContenidoResponse();

		JSONArray jsonArray = new JSONArray();

		try {

			IssueDTO issue = issueService.getIssueById(issueID);

			if (issueID.isEmpty()) {
				return new ContenidoResponse(false,
						"No se pudo cargar el archivo.");
			}

			if (files.size() > 0) {

				for (MultipartFile file : files) {
					fileName = file.getOriginalFilename();
					inputStream = file.getInputStream();
					extensionArchivo = FileUploadUtils
							.getExtensionArchivo(fileName);
					newContenido.setInputStream(inputStream);
					newContenido.setExtension(extensionArchivo);
					newContenido.setNroReclamo(issueID);
					newContenido.setOrden(String.valueOf(0));

					MediaContentDTO uploadedContenido = contenidoService
							.subirContenido(newContenido);
					uploadedFiles.add(uploadedContenido);

					JSONObject jsonObject = new JSONObject();
					// jsonObject.put("id",
					// uploadedContenido.getId().toString());
					jsonObject.put("name",
							uploadedContenido.getNombreConExtension());
					jsonObject.put("format", uploadedContenido.getExtension());
					jsonObject.put("url", UPLOAD_DIRECTORY_WIN);
					jsonObject.put("thumbnailUrl", "UPLOAD_DIRECTORY_MAC");
					jsonObject.put("size", Double.valueOf(uploadedContenido
							.getFile().length()));
					jsonObject.put("error", StringUtils.EMPTY);

					jsonArray.put(jsonObject);

					issue.getContenidos().add(uploadedContenido);
				}

				List<MediaContentDTO> contenidos = contenidoService
						.listarContenidos(Long.valueOf(issueID));
				model.addAttribute("contenidos", contenidos);
				model.addAttribute("cantidadContenidos", contenidos.size());

				response.setStatus(true);
				response.setTotalUploadedFiles(contenidos.size());
				response.setUploadedFiles(jsonArray.toString());

				IssueUpdateHistoryDTO revision = new IssueUpdateHistoryDTO();
				revision.setNroReclamo(Long.valueOf(issueID));
				revision.setFecha(new Date());
				revision.setUsername(userID);
				revision.setOperacion(Operation.CREATE);
				revision.setMotivo(Messages.ISSUE_UPDATE_ATTACH_FILES + " "
						+ files.size() + " archivo(s).");
				revision.setObservaciones(Messages.ISSUE_CREATE_OBS);
				revision.setEstado(issue.getStatus());

				issue.getHistorial().add(revision);

				issueService.updateIssue(issue); // NO ANDA BIEN > duplica los
													// registros del historial

				return response;

			}

			else {
				return new ContenidoResponse(false,
						"No se pudo cargar el archivo.");
			}

		} catch (IOException e) {
			return new ContenidoResponse(false, "No se pudo cargar el archivo.");
		}

	}

	@RequestMapping(value = "/handleFileUpload", method = RequestMethod.POST)
	public @ResponseBody
	ContenidoResponse doFileUpload(
			@RequestParam("file") MultipartFile file,
			/* @RequestParam("isProfilePic") boolean isProfilePic, */HttpServletRequest request) {

		InputStream inputStream = null;
		String fileName = StringUtils.EMPTY;
		String extensionArchivo = StringUtils.EMPTY;
		MediaContentDTO nuevoContenido = new MediaContentDTO();

		try {

			if (file != null) {
				fileName = file.getOriginalFilename();
				inputStream = file.getInputStream();
				extensionArchivo = FileUploadUtils
						.getExtensionArchivo(fileName);
				nuevoContenido.setInputStream(inputStream);
				nuevoContenido.setExtension(extensionArchivo);
				nuevoContenido.setOrden("0");
				// nuevoContenido.setProfilePic(isProfilePic);
				nuevoContenido = contenidoService.uploadFile(inputStream,
						nuevoContenido);
				this.setUploadedFile(nuevoContenido);
			}

			return new ContenidoResponse(true,
					"La foto se carg&oacute; exitosamente.");

		} catch (IOException e) {
			return new ContenidoResponse(false, "No se pudo cargar el archivo.");
		}
	}

	@RequestMapping(value = "/issues/deleteFile", method = RequestMethod.POST)
	public @ResponseBody
	ContenidoResponse doDeleteFile(@RequestParam("issueID") String issueID,
			@RequestParam("userID") String userID,
			@RequestParam("fileID") String fileID, Model model,
			HttpServletRequest request) throws ParseException {

		try {
			MediaContentDTO contenidoABorrar = contenidoService
					.obtenerContenido(fileID, issueID);
			contenidoService.borrarContenido(contenidoABorrar);

			IssueDTO issue = issueService.getIssueById(issueID);

			IssueUpdateHistoryDTO revision = new IssueUpdateHistoryDTO();
			revision.setNroReclamo(Long.valueOf(issueID));
			revision.setFecha(new Date());
			revision.setUsername(userID);
			revision.setOperacion(Operation.CREATE);
			revision.setMotivo(Messages.ISSUE_UPDATE_REMOVE_FILES
					+ " 1 archivo.");
			revision.setObservaciones(Messages.ISSUE_CREATE_OBS);
			revision.setEstado(issue.getStatus());

			issueService.addHistoryUpdate(revision);

			List<MediaContentDTO> contenidos = new ArrayList<MediaContentDTO>();
			contenidos = issue.getContenidos();

			model.addAttribute("contenidos", contenidos);
			model.addAttribute("cantidadContenidos", contenidos.size());

			return new ContenidoResponse(true, "El archivo ha sido eliminado.",
					contenidos.size());

		} catch (Exception e) {
			return new ContenidoResponse(false,
					"Ha ocurrido un error al intentar eliminar el archivo.");
		}

	}

	/**
	 * private String getNombreArchivoSinExtension(String nombreArchivo) {
	 * String nombreArchivoSinExtension = ""; if (nombreArchivo.lastIndexOf(".")
	 * == -1) nombreArchivoSinExtension = nombreArchivo; else
	 * nombreArchivoSinExtension = nombreArchivo.substring(0,
	 * nombreArchivo.lastIndexOf(".")); return nombreArchivoSinExtension; }
	 * 
	 * private String getExtensionArchivo(String fileName) { String extension =
	 * "";
	 * 
	 * int i = fileName.lastIndexOf('.'); if (i > 0) { extension =
	 * fileName.substring(i+1); } return extension; }
	 **/

	@RequestMapping(value = "/reportIssue", method = RequestMethod.POST)
	public @ResponseBody
	AlertStatus doReportIssue(@ModelAttribute("issueForm") IssueDTO issue,
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
				issue.setCreationDate(new Date());
				issue.setLastUpdateDate(issue.getCreationDate());
				issue.setStatus(IssueStatus.OPEN);
				issue.setUser(userDTO);
				issue.setId(String.valueOf(idIssue));

				// history
				IssueUpdateHistoryDTO revision = new IssueUpdateHistoryDTO();
				revision.setFecha(new Date());
				revision.setUsername(userDTO.getUsername());
				revision.setOperacion(Operation.CREATE);
				revision.setMotivo(Messages.ISSUE_CREATION + " el reclamo.");
				revision.setObservaciones("");
				revision.setEstado(issue.getStatus());

				issue.getHistorial().add(revision);
				issue.setLicitacion(null);

				// random id
				// issue.setId(String.valueOf(issue.getId()));
				// revision.setNroReclamo(Long.valueOf(issue.getId()));

				// contenido
				MediaContentDTO contenido = this.getUploadedFile();
				if (contenido != null) {
					// contenido.setNroReclamo(String.valueOf(issue.getId()));
					issue.setUploadedFile(contenido);
				}
				this.setUploadedFile(null);

				issueService.reportIssue(issue);

				return new AlertStatus(true, "Su reclamo ha sido registrado.");
			}

		} catch (AccessDeniedException e) {
			return new AlertStatus(false,
					"Debe estar logueado para ingresar un nuevo reclamo.");
		}

	}

	@RequestMapping(value = "/issues/sendTags", method = RequestMethod.POST)
	public @ResponseBody
	List<String> sendTags(@RequestParam List<String> tags) {
		return tags;
	}

	@RequestMapping(value = "/issues/updateIssue", method = RequestMethod.POST)
	public @ResponseBody
	AlertStatus doUpdatetIssue(@ModelAttribute("issue") IssueDTO issue,
			@RequestParam("fields") String fieldChanges,
			HttpServletRequest request) throws ParseException,
			JsonParseException, JsonMappingException, IOException {

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

				if (updatedFields.getTitle() == 1) {
					fields += " «TITULO» ";
					fieldCounter++;
				}
				if (updatedFields.getBarrio() == 1) {
					fields += " «BARRIO» ";
					fieldCounter++;
				}
				if (updatedFields.getDesc() == 1) {
					fields += " «DESCRIPCION» ";
					fieldCounter++;
				}

				if (fieldCounter == 1) {
					motive = Messages.ISSUE_UPDATE_FIELDS + " el campo "
							+ fields;
				}
				if (fieldCounter > 1) {
					motive = Messages.ISSUE_UPDATE_FIELDS + " los campos "
							+ fields;
				}
				if (fieldCounter == 0) {
					motive = "actualizo las CATEGORIAS del reclamo.";
				}

				// history
				IssueUpdateHistoryDTO revision = new IssueUpdateHistoryDTO();
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
		} catch (AccessDeniedException e) {
			return new AlertStatus(false,
					"Debe estar logueado para ingresar un nuevo reclamo.");
		}

	}

	@RequestMapping(value = "/issues/updateIssueStatus", method = RequestMethod.POST)
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

	@RequestMapping(value = "/issues/saveRepairInfo", method = RequestMethod.POST)
	public @ResponseBody
	AlertStatus saveRepairInfo(@RequestParam("issueID") String issueID,
			@RequestParam("userID") String userID,
			@ModelAttribute("repairForm") IssueRepairDTO licitacionDTO,
			Model model, HttpServletRequest request) throws ParseException {

		try {

			licitacionDTO.setNroReclamo(String.valueOf(issueID));

			IssueDTO issue = issueService.getIssueById(issueID);
			issue.setLicitacion(licitacionDTO);

			IssueUpdateHistoryDTO revision = new IssueUpdateHistoryDTO();
			revision.setFecha(new Date());
			revision.setUsername(userID);
			revision.setNroReclamo(Long.valueOf(issueID));
			revision.setOperacion(Operation.UPDATE);
			revision.setMotivo(Messages.ISSUE_REPAIR_INFO_ADD);
			revision.setEstado(issue.getStatus());
			revision.setObservaciones(Messages.ISSUE_UPDATE_OBS);

			issue.setLastUpdateDate(revision.getFecha());

			issueService.addRepairInfo(licitacionDTO);
			issueService.addHistoryUpdate(revision);

			return new AlertStatus(true, "La informacion ha sido guardada.");

		} catch (AccessDeniedException e) {
			return new AlertStatus(false,
					"Debe estar logueado para ingresar un nuevo reclamo.");
		} catch (Exception e) {
			return new AlertStatus(false,
					"No se pudo guardar la informacion. Intente de nuevo.");
		}
	}

	@RequestMapping(value = "/issues/updateRepairInfo", method = RequestMethod.POST)
	public @ResponseBody
	AlertStatus updateRepairInfo(
			@ModelAttribute("licitacion") IssueRepairDTO licitacionDTO,
			Model model, HttpServletRequest request) throws ParseException {

		try {
			String issueID = (String) request.getSession().getAttribute(
					"issueID");
			licitacionDTO.setNroReclamo(issueID);
			IssueUpdateHistoryDTO revision = new IssueUpdateHistoryDTO();
			revision.setFecha(new Date());
			revision.setUsername("coripel");
			revision.setNroReclamo(Long.valueOf(issueID));
			revision.setOperacion(Operation.UPDATE);
			revision.setMotivo(Messages.ISSUE_REPAIR_INFO_UPDATE);
			revision.setEstado("ESTADO");
			revision.setObservaciones(Messages.ISSUE_UPDATE_OBS);

			issueService.updateRepairInfo(licitacionDTO);
			issueService.addHistoryUpdate(revision);

			return new AlertStatus(true, "La informacion ha sido actualizada.");

		} catch (AccessDeniedException e) {
			return new AlertStatus(false,
					"Debe estar logueado para ingresar un nuevo reclamo.");
		} catch (Exception e) {
			return new AlertStatus(false,
					"No se pudo actualizar la informacion. Intente de nuevo.");
		}
	}

	@RequestMapping(value = "/issues/deleteRepairInfo", method = RequestMethod.POST)
	public @ResponseBody
	AlertStatus deleteRepairInfo(@RequestParam("issueID") String issueID,
			@RequestParam("userID") String userID, Model model,
			HttpServletRequest request) throws ParseException {

		try {

			IssueDTO issue = issueService.getIssueById(issueID);

			IssueUpdateHistoryDTO revision = new IssueUpdateHistoryDTO();
			revision.setFecha(new Date());
			revision.setUsername(userID);
			revision.setNroReclamo(Long.valueOf(issueID));
			revision.setOperacion(Operation.UPDATE);
			revision.setMotivo(Messages.ISSUE_REPAIR_INFO_DELETE);
			revision.setEstado(issue.getStatus());
			revision.setObservaciones(Messages.ISSUE_UPDATE_OBS);

			issue.setLastUpdateDate(revision.getFecha());

			issueService.deleteRepairInfo(issueID);
			issueService.addHistoryUpdate(revision);

			return new AlertStatus(true, "La informacion ha sido eliminada.");

		} catch (AccessDeniedException e) {
			return new AlertStatus(false,
					"Debe estar logueado para ingresar un nuevo reclamo.");
		} catch (Exception e) {
			return new AlertStatus(false,
					"No se pudo eliminar la informacion. Intente de nuevo.");
		}
	}

	@RequestMapping(value = "/issues/assignUser", method = RequestMethod.POST)
	public @ResponseBody
	AlertStatus doAssignUser(@RequestParam("issueID") String issueID,
			@RequestParam("selectedUser") String selectedUser,
			HttpServletRequest request) throws ParseException {

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
				issueService.assignUserToIssue(issueID, selectedUser);
				return new AlertStatus(true, "El reclamo ha sido actualizado.");
			}

		} catch (AccessDeniedException e) {
			return new AlertStatus(false,
					"Debe estar logueado para ingresar un nuevo reclamo.");
		}
	}

	@RequestMapping(value = "/issues/getAvailableUsers/{areaID}", produces = "application/json", method = RequestMethod.GET)
	public @ResponseBody
	List<UserDTO> loadAvailableUsers(@PathVariable("areaID") String areaID,
			HttpServletRequest request) {
		List<UserDTO> u = null; // userService.loadVerifiedUsersByArea(areaID);
		return u;
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

	@RequestMapping(value = "/loadMapMarkers", method = RequestMethod.GET)
	public @ResponseBody List<IssueDTO> loadMapMarkers(HttpServletRequest request) throws JSONException {
		
		List<IssueDTO> issues = issueService.loadAllIssues();

		JSONObject obj = new JSONObject();
		JSONArray array = new JSONArray();

		obj.put("type", "FeatureCollection");

		for (IssueDTO s : issues) {
			JSONObject feature = new JSONObject();

			feature.put("type", "Feature");

			JSONObject geometry = new JSONObject();
			geometry.put("type", "Point");
			geometry.put(
					"coordinates",
					new float[] {
							// Float.parseFloat(s.getLatitude()),
							// Float.parseFloat(s.getLongitude()) });
							Float.parseFloat(s.getLongitude()),
							Float.parseFloat(s.getLatitude()) });

			feature.put("geometry", geometry);

			JSONObject properties = new JSONObject();
			properties.put("id", s.getId());
			properties.put("address", s.getFormattedAddress());
			properties.put("title", s.getTitle());
			properties.put("status", s.getStatus());
			properties.put("statusCss", s.getStatusCss());
			properties.put("date", s.getFechaFormateada());
			properties.put("description", s.getDescription());
			properties.put("user", s.getUsername());

			feature.put("properties", properties);
			array.put(feature);
		}

		obj.put("features", array);

		System.out.println(obj.toString());

		return issues;
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

				List<CommentDTO> comments = issueService
						.getCommentsByIssue(issueID);
				model.addAttribute("comentarios",
						issueService.getCommentsByIssue(issueID));
				model.addAttribute("cantidadComentarios", comments.size());
				return new AlertStatus(true, "El comentario ha sido publicado.");
			}

		} catch (Exception e) {
			if (e instanceof AccessDeniedException)
				return new AlertStatus(false,
						"Debe estar logueado para publicar un nuevo comentario.");
			else
				return new AlertStatus(false,
						"No ha sido posible publicar el comentario. Intente de nuevo.");
		}
	}

	@RequestMapping(value = "/issues/{watchOrUnwatch}", method = RequestMethod.POST)
	public @ResponseBody
	AlertStatus wIssue(@PathVariable String watchOrUnwatch,
			@RequestParam("issueID") String issueID, Model model) {

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
