package ar.com.urbanusjam.web.controllers;

import java.io.IOException;
import java.io.InputStream;
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
import org.springframework.web.multipart.MultipartFile;

import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.ContenidoService;
import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.UserService;
import ar.com.urbanusjam.services.dto.CommentDTO;
import ar.com.urbanusjam.services.dto.ContenidoDTO;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.IssueFollowDTO;
import ar.com.urbanusjam.services.dto.IssueHistorialRevisionDTO;
import ar.com.urbanusjam.services.dto.IssueLicitacionDTO;
import ar.com.urbanusjam.services.dto.IssuePageViewDTO;
import ar.com.urbanusjam.services.dto.IssueVoteDTO;
import ar.com.urbanusjam.services.dto.UserDTO;
import ar.com.urbanusjam.services.utils.FileUploadUtils;
import ar.com.urbanusjam.services.utils.IssueStatus;
import ar.com.urbanusjam.services.utils.Messages;
import ar.com.urbanusjam.services.utils.Operation;
import ar.com.urbanusjam.web.domain.AlertStatus;
import ar.com.urbanusjam.web.domain.ContenidoResponse;


@Controller
//@RequestMapping(value="/issue")
public class IssueController {
	
	@Autowired
	private IssueService issueService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ContenidoService contenidoService;
	
	private static final String UPLOAD_DIRECTORY = "C:\\temp\\fixeala\\uploads\\";
	private ContenidoDTO uploadedFile = null;
	
	@Autowired
	@Qualifier(value = "fixealaAuthenticationManager")
	protected AuthenticationManager fixealaAuthenticationManager;
	
	public ContenidoDTO getUploadedFile() {
		return uploadedFile;
	}

	public void setUploadedFile(ContenidoDTO uploadedFile) {
		this.uploadedFile = uploadedFile;
	}


	@RequestMapping(value="/issues/{issueToken}", method = RequestMethod.GET)
	public String showIssuePage(Model model, @PathVariable("issueToken") String issueToken, 
				HttpServletRequest request){
		
		IssueDTO issue = new IssueDTO();
		
		String[] parts = issueToken.split("-");
		String issueID = parts[0];
		
		try{
			 	issue = issueService.getIssueById(issueID);	
			 	
			 	model.addAttribute("titulo", issue.getTitle());
				model.addAttribute("estado", issue.getStatus());
				model.addAttribute("estadoCss", issue.getStatusCss());
				model.addAttribute("direccion", issue.getFormattedAddress());					
				model.addAttribute("id", issue.getId());
				model.addAttribute("fecha", issue.getFormattedDate(issue.getDate()));
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
				
				if(!issueTags.isEmpty()){
					for(int i = 0; i < issueTags.size(); i++){
						issueTagsByComma += issueTags.get(i) + ", ";
					}				
					issueTagsByComma = issueTagsByComma.substring(0, issueTagsByComma.length() -2);
				}
				
				List<String> dbTags = issueService.getTagList();
				JSONArray array = new JSONArray();
				for(String s : dbTags){
					JSONObject obj = new JSONObject();
					obj.put("id", dbTags.indexOf(s));
					obj.put("text", s);
					array.put(obj);
				}
				
				allTags = array.toString();
				
				
				model.addAttribute("tagsByIssue", issueTagsByComma);
				model.addAttribute("allTags", allTags.length() == 0 ? "[{}]" : allTags);
				model.addAttribute("comentarios", issue.getComentarios());
				
				List<ContenidoDTO> contenidos = new ArrayList<ContenidoDTO>();
				contenidos = issue.getContenidos();
				
				if(contenidos.size() > 0){
					model.addAttribute("contenidos", contenidos);
					ContenidoDTO contenido = contenidos.get(0);						
					model.addAttribute("image", contenido);
					model.addAttribute("imageUrl", contenido.getPathRelativo());
					model.addAttribute("imageName", contenido.getNombre());
				}
				
				model.addAttribute("cantidadContenidos", contenidos.size());
				model.addAttribute("cantidadRevisiones", issue.getHistorial().size());
				model.addAttribute("cantidadLicitacion", issue.getLicitacion() != null ? 1 : 0);
				model.addAttribute("cantidadReclamosSimilares", 0);
				model.addAttribute("cantidadArchivos", 0);
				model.addAttribute("cantidadComentarios", issue.getComentarios().size());	
				
				IssueFollowDTO follow = new IssueFollowDTO();
				IssueVoteDTO currentVote = new IssueVoteDTO();
				boolean isUserWatching = false;			
				String loggedUser = ""; 
			
				Authentication auth = (Authentication) SecurityContextHolder.getContext().getAuthentication();		
				
				if(!(auth instanceof AnonymousAuthenticationToken)){
					UserDetails userDB = userService.loadUserByUsername(((User)auth.getPrincipal()).getUsername());
					if(userDB != null){
						follow.setUsername(userDB.getUsername());
						follow.setIdIssue(issueID);
						isUserWatching = issueService.isUserFollowingIssue(follow);
						loggedUser = userDB.getUsername();
						
						IssuePageViewDTO pageviewDTO = new IssuePageViewDTO();
						pageviewDTO.setIssueID(issueID);
						pageviewDTO.setUsername(loggedUser);
						pageviewDTO.setDate(new Date());
						issueService.trackIssuePageView(pageviewDTO);
						currentVote = issueService.getCurrentVote(issueID, loggedUser);						
					}
					
				}
						
				model.addAttribute("loggedUser", loggedUser);	
				model.addAttribute("cantidadVisitas", issueService.getIssuePageViews(issueID));
				model.addAttribute("cantidadObservadores", issueService.getIssueFollowers(issueID).size());				
				model.addAttribute("isUserWatching", isUserWatching);					
				model.addAttribute("cantidadVotos", issueService.countIssueVotes(issueID));
				model.addAttribute("isCurrentlyVoted", currentVote.isCurrentlyVoteByUser());	
				model.addAttribute("isVoteUp", currentVote.getVote() == 1 ? true : false);	
				
				IssueLicitacionDTO licitacion = new IssueLicitacionDTO();
				
				if(issue.getLicitacion() != null){
					
					licitacion = issue.getLicitacion();
					
					model.addAttribute("obra", licitacion.getObra());
					model.addAttribute("nroLicitacion", licitacion.getNroLicitacion());
					model.addAttribute("nroExpediente", licitacion.getNroExpediente());
					model.addAttribute("estadoObra", licitacion.getEstadoObra());
					model.addAttribute("tipoObra", licitacion.getTipoObra());
					model.addAttribute("valorPliego", licitacion.getValorPliego());
					model.addAttribute("unidadEjecutora", licitacion.getEmpresaConstructora());
					model.addAttribute("unidadFinanciamiento", licitacion.getUnidadFinanciamiento());
					model.addAttribute("empresaNombre", licitacion.getEmpresaNombre());
					model.addAttribute("empresaCuit", licitacion.getEmpresaCuit());
					model.addAttribute("empresaEmail", licitacion.getEmpresaEmail());
					model.addAttribute("representanteNombre", licitacion.getRepresentanteNombre());
					model.addAttribute("representanteDni", licitacion.getRepresentanteDni());
					model.addAttribute("representanteEmail", licitacion.getRepresentanteEmail());
//					model.addAttribute("lic-plazo", licitacion.getPlazoEjecucionEnDias());
					model.addAttribute("presupuestoAdjudicado", licitacion.getPresupuestoAdjudicado());
					model.addAttribute("presupuestoFinal", licitacion.getPresupuestoFinal());
					model.addAttribute("fechaEstimadaInicio", parseDate(licitacion.getFechaEstimadaInicio()));
					model.addAttribute("fechaEstimadaFinal", parseDate(licitacion.getFechaEstimadaFin()));
					model.addAttribute("fechaRealInicio", parseDate(licitacion.getFechaRealInicio()));
					model.addAttribute("fechaRealFinal", parseDate(licitacion.getFechaRealFin()));
					
//					String string = licitacion.getFechaEstimadaInicio();
//					SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy"); 
//				    Date convertedDate = dateFormat.parse(string); 
					
				}
			
			 
		} catch(Exception e){
			 
			return "redirect:/" + "error.html";
		}
		
		
		return "issues";
	 }
	
	@RequestMapping(value="/issues/handleMultipleFileUpload", method = RequestMethod.POST)
	public @ResponseBody ContenidoResponse processMultipleUpload(@RequestParam("issueID") String issueID, 
			@RequestParam("files[]") List<MultipartFile> files, HttpServletRequest request, Model model) throws JSONException{
		
		InputStream inputStream = null;
		String fileName = StringUtils.EMPTY;
		String extensionArchivo = StringUtils.EMPTY;	
		ContenidoDTO newContenido = new ContenidoDTO();
		List<ContenidoDTO> uploadedFiles = new ArrayList<ContenidoDTO>();
		ContenidoResponse response = new ContenidoResponse();
		
		JSONArray jsonArray = new JSONArray();
	    
		try {		
	    	
	    	if(issueID.isEmpty()){
	    		return new ContenidoResponse(false, "No se pudo cargar el archivo.");
	    	}
	
			if(files.size() > 0){				
			
				for(MultipartFile file : files){
					fileName = file.getOriginalFilename();			
					inputStream = file.getInputStream();
					extensionArchivo =  FileUploadUtils.getExtensionArchivo(fileName);		
					newContenido.setInputStream(inputStream);
					newContenido.setExtension(extensionArchivo);	
					newContenido.setNroReclamo(issueID);		
					
					newContenido.setOrden(String.valueOf(0));
					
//					int orden = contenidoService.obtenerUltimoOrden(issueID);
//					int nuevoOrden = files.indexOf(file);
//					
//					if(orden == 0)
//						contenido.setOrden(String.valueOf(nuevoOrden));
//					else
//						contenido.setOrden(String.valueOf(nuevoOrden++));
					
					newContenido = contenidoService.subirContenido(newContenido);							
					uploadedFiles.add(newContenido);
					
					JSONObject jsonObject = new JSONObject();
					jsonObject.put("id", newContenido.getId().toString());
					jsonObject.put("name", newContenido.getNombreConExtension());
					jsonObject.put("format", newContenido.getExtension());
					jsonObject.put("url", UPLOAD_DIRECTORY);
					jsonObject.put("thumbnailUrl", "UPLOAD_DIRECTORY");
					jsonObject.put("size", Double.valueOf(newContenido.getFile().length()));
					jsonObject.put("error", StringUtils.EMPTY);
					
					jsonArray.put(jsonObject);
				}

				List<ContenidoDTO> contenidos = contenidoService.listarContenidos(Long.valueOf(issueID));
				model.addAttribute("contenidos", contenidos);
				model.addAttribute("cantidadContenidos", contenidos.size());

				response.setStatus(true);
				response.setTotalUploadedFiles(contenidos.size());
				response.setUploadedFiles(jsonArray.toString());
				return response;
				
			}
			
			else{
				return new ContenidoResponse(false, "No se pudo cargar el archivo.");
			}
			
	    
	    } catch (IOException e) {
	    	return new ContenidoResponse(false, "No se pudo cargar el archivo.");
	    }
				
	}
	

	@RequestMapping(value="/handleFileUpload", method = RequestMethod.POST)
	public @ResponseBody ContenidoResponse doFileUpload(@RequestParam("file") MultipartFile file, 
			@RequestParam("isProfilePic") boolean isProfilePic, HttpServletRequest request){		
		
		InputStream inputStream = null;
		String fileName = StringUtils.EMPTY;
		String extensionArchivo = StringUtils.EMPTY;
		ContenidoDTO nuevoContenido = new ContenidoDTO();	
		
	    try {		
	
			if(file != null){				 
				fileName = file.getOriginalFilename();			
				inputStream = file.getInputStream();
				extensionArchivo =  FileUploadUtils.getExtensionArchivo(fileName);				
				nuevoContenido.setInputStream(inputStream);
				nuevoContenido.setExtension(extensionArchivo);	
				nuevoContenido.setOrden("0");	
				nuevoContenido.setProfilePic(isProfilePic);
				nuevoContenido = contenidoService.uploadFile2(inputStream, nuevoContenido);	
				this.setUploadedFile(nuevoContenido);
			}
			
			return new ContenidoResponse(true, "La foto se cargo exitosamente.");
	    
	    } catch (IOException e) {
	    	return new ContenidoResponse(false, "No se pudo cargar el archivo.");
	    }
	}
	
	
	
	@RequestMapping(value="/issues/deleteFile", method = RequestMethod.POST)
	public @ResponseBody ContenidoResponse doDeleteFile(@RequestParam("issueID") String issueID, 
			@RequestParam("fileID") String fileID, Model model, HttpServletRequest request) throws ParseException {
		
		try {	
			ContenidoDTO contenidoABorrar = contenidoService.obtenerContenido(fileID, issueID);				
			contenidoService.borrarContenido(contenidoABorrar);	
			
			IssueDTO issue = issueService.getIssueById(issueID);
			List<ContenidoDTO> contenidos = new ArrayList<ContenidoDTO>();
			contenidos = issue.getContenidos();
			
			model.addAttribute("contenidos", contenidos);
			model.addAttribute("cantidadContenidos", contenidos.size());
			
			return new ContenidoResponse(true, "El archivo ha sido eliminado.", contenidos.size());		
			
		}catch(Exception e){
			return new ContenidoResponse(false, "Ha ocurrido un error al intentar eliminar el archivo.");		
		}				
		
	}
	
	/**private String getNombreArchivoSinExtension(String nombreArchivo) {
		String nombreArchivoSinExtension = "";
		if (nombreArchivo.lastIndexOf(".") == -1)
			nombreArchivoSinExtension = nombreArchivo;
		else
			nombreArchivoSinExtension = nombreArchivo.substring(0, nombreArchivo.lastIndexOf("."));
		return nombreArchivoSinExtension;
	}
	
	private String getExtensionArchivo(String fileName) {
		String extension = "";

		int i = fileName.lastIndexOf('.');
		if (i > 0) {
		    extension = fileName.substring(i+1);
		}
		return extension;
	}**/
	
		
	@RequestMapping(value="/reportIssue", method = RequestMethod.POST)
	public @ResponseBody AlertStatus doReportIssue(@ModelAttribute("issueForm") IssueDTO issue, HttpServletRequest request){
		
		try {			
				User user =  getCurrentUser(SecurityContextHolder.getContext().getAuthentication());
				UserDetails userDB = userService.loadUserByUsername(user.getUsername());		
				
				if(userDB == null){
					return new AlertStatus(false, "Debe estar logueado para ingresar un nuevo reclamo.");
				}						
			
				//user is logged-in
				else{
					
					Random generator = new Random(); 
					int idIssue = generator.nextInt(100000) + 1000;
									
					UserDTO userDTO = new UserDTO();
					userDTO.setUsername(userDB.getUsername());					
					issue.setDate(new Date());
					issue.setStatus(IssueStatus.OPEN);		
					issue.setUser(userDTO);			
					issue.setId(String.valueOf(idIssue));	
					
					
					if(issue.getProvince().equals("Ciudad Autónoma de Buenos Aires")){
						issue.setCity("Ciudad Autónoma de Buenos Aires");
						issue.setProvince("Buenos Aires");
					}
										
					IssueHistorialRevisionDTO revision = new IssueHistorialRevisionDTO();
					revision.setFecha(new Date());
					revision.setUsername(userDTO.getUsername());	
					revision.setOperacion(Operation.CREATE);			
					revision.setMotivo("ALTA");
					revision.setObservaciones(Messages.ISSUE_CREATE_OBS);
					revision.setEstado(issue.getStatus());
					
					//random id
					issue.setId(String.valueOf(issue.getId()));
					revision.setNroReclamo(Long.valueOf(issue.getId()));	
					issue.setLicitacion(null);
					issue.getHistorial().add(revision);
										
				    //contenido
					ContenidoDTO contenido = this.getUploadedFile();
					
					if(contenido != null){
						contenido.setNroReclamo(String.valueOf(issue.getId()));
					    issue.getContenidos().add(contenido);
					}					
					
					issueService.reportIssue(issue);	
					
					this.setUploadedFile(null);
					
					return new AlertStatus(true, "Su reclamo ha sido registrado.");			
			}				
		
		}catch(AccessDeniedException e){
			return new AlertStatus(false, "Debe estar logueado para ingresar un nuevo reclamo.");
		}
	
	}
	
	@RequestMapping(value="/issues/sendTags", method = RequestMethod.POST)
	public @ResponseBody List<String> sendTags(@RequestParam List<String> tags){
		int i = tags.size();
		return tags;
	}
	
	@RequestMapping(value="/issues/updateIssue", method = RequestMethod.POST)
	public @ResponseBody AlertStatus doUpdatetIssue(@ModelAttribute("issue") IssueDTO issue, 
			@ModelAttribute("licitacion") IssueLicitacionDTO licitacion, HttpServletRequest request) throws ParseException{
		
		try {			
				User user =  getCurrentUser(SecurityContextHolder.getContext().getAuthentication());
				UserDetails userDB = userService.loadUserByUsername(user.getUsername());		
				
				if(userDB == null){
					return new AlertStatus(false, "Debe estar logueado para ingresar un nuevo reclamo.");
				}						
			
				//user is logged-in
				else{
									
					//se actualizan los datos del reclamo
					
					//se actualizan los datos de la licitacion
					
					//se actualiza el historial de revisiones
			
					UserDTO userDTO = new UserDTO();
					userDTO.setUsername(userDB.getUsername());					
					List<String> authorities = new ArrayList<String>();
					authorities.add("ROLE_USER");		
					userDTO.setAuthorities(authorities);	
					issue.setUser(userDTO);	
					
					Object[] tagMapValues = (Object[]) issue.getTagsMap().values().toArray();
					String[] tagsArray = new String[tagMapValues.length];
					
					if(tagMapValues.length > 0){
						
						if(tagMapValues[0] instanceof String){
							for(int i = 0 ; i < tagMapValues.length ; i++)
								tagsArray[i] = (String)tagMapValues[i];
						}
						else					
							tagsArray = (String[]) tagMapValues[0];
						
					}
				
					
					issue.setTags(Arrays.asList(tagsArray)); 
					
					if(licitacion.getNroLicitacion() == null || licitacion.getNroLicitacion() == "")
						licitacion = null;
					
					else{
						licitacion.setNroReclamo(String.valueOf(issue.getId()));
					}
					
					issue.setLicitacion(licitacion);
					
					IssueHistorialRevisionDTO revision = new IssueHistorialRevisionDTO();
					revision.setFecha(new Date());
					revision.setUsername(userDTO.getUsername());			
					revision.setNroReclamo(Long.valueOf(issue.getId()));			
					revision.setOperacion(Operation.UPDATE);			
					revision.setMotivo("MODIFICACION");			
					revision.setEstado(issue.getStatus());
					revision.setObservaciones(Messages.ISSUE_UPDATE_OBS);
					issue.getHistorial().add(revision);
					issue.setAssignedArea(issueService.getAreaByName("Comuna 1"));
					
					issueService.updateIssue(issue);	
					
					return new AlertStatus(true, "El reclamo ha sido actualizado.");			
			}
		}			
		catch(AccessDeniedException e){
			return new AlertStatus(false, "Debe estar logueado para ingresar un nuevo reclamo.");
		}
	
	}
	
	
	@RequestMapping(value="/issues/updateIssueStatus", method = RequestMethod.POST)
	public @ResponseBody AlertStatus doUpdatetIssueStatus(@RequestParam("issueID") String issueID, 
			@RequestParam("newStatus") String newStatus, HttpServletRequest request) throws ParseException {
		
		try {			
			User user =  getCurrentUser(SecurityContextHolder.getContext().getAuthentication());
			UserDetails userDB = userService.loadUserByUsername(user.getUsername());		
			
			if(userDB == null){
				return new AlertStatus(false, "Debe estar logueado para ingresar un nuevo reclamo.");
			}						
		
			else{
				issueService.updateIssueStatus(issueID, newStatus);					
				return new AlertStatus(true, "El reclamo ha sido actualizado.");			
			}
			
		}catch(AccessDeniedException e){
			return new AlertStatus(false, "Debe estar logueado para ingresar un nuevo reclamo.");
		}		
	}
	
	@RequestMapping(value="/issues/assignUser", method = RequestMethod.POST)
	public @ResponseBody AlertStatus doAssignUser(@RequestParam("issueID") String issueID, 
			@RequestParam("selectedUser") String selectedUser, HttpServletRequest request) throws ParseException {
		
		try {			
			User user =  getCurrentUser(SecurityContextHolder.getContext().getAuthentication());
			UserDetails userDB = userService.loadUserByUsername(user.getUsername());		
			
			if(userDB == null){
				return new AlertStatus(false, "Debe estar logueado para ingresar un nuevo reclamo.");
			}						
		
			else{
				issueService.assignUserToIssue(issueID, selectedUser);					
				return new AlertStatus(true, "El reclamo ha sido actualizado.");			
			}
			
		}catch(AccessDeniedException e){
			return new AlertStatus(false, "Debe estar logueado para ingresar un nuevo reclamo.");
		}		
	}
	
	@RequestMapping(value="/issues/getAvailableUsers/{areaID}", produces = "application/json", method = RequestMethod.GET)
	public @ResponseBody List<UserDTO> loadAvailableUsers(@PathVariable("areaID") String areaID, HttpServletRequest request){		
		List<UserDTO> u = userService.loadVerifiedUsersByArea(areaID);	
		return u;		
	}
	
		
	@RequestMapping(value="/loadTags", method = RequestMethod.GET)
	public @ResponseBody List<String> loadTagList(HttpServletRequest request){
		return issueService.getTagList();
		
	}
	
	@RequestMapping(value="/loadTags2", method = RequestMethod.GET)
	public @ResponseBody String loadTagListJson(HttpServletRequest request) throws JSONException{
		List<String> dbTags = issueService.getTagList();
		
		JSONArray array = new JSONArray();
		for(String s : dbTags){
			JSONObject obj = new JSONObject();
			obj.put("id", dbTags.indexOf(s));
			obj.put("text", s);
			array.put(obj);
		}
		
		return array.toString();
		
	}

	
	@RequestMapping(value="/loadMapMarkers", method = RequestMethod.GET)
	public @ResponseBody List<IssueDTO> loadMapMarkers(@ModelAttribute("issue") IssueDTO issue, HttpServletRequest request) throws JSONException{		
		List<IssueDTO> issues = issueService.loadAllIssues();	
		
		
		JSONObject obj = new JSONObject();
		JSONArray array = new JSONArray();
		
		obj.put("type", "FeatureCollection");
		
		
		for(IssueDTO s : issues){
			JSONObject feature = new JSONObject();
			
			feature.put("type", "Feature");
				
			JSONObject geometry = new JSONObject();
			geometry.put("type", "Point");
			geometry.put("coordinates", new float[]{ 
//					Float.parseFloat(s.getLatitude()), Float.parseFloat(s.getLongitude()) });
					Float.parseFloat(s.getLongitude()), Float.parseFloat(s.getLatitude()) });
			
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
	

	
	@RequestMapping(value="/issues/addComment", method = RequestMethod.POST)
	public @ResponseBody AlertStatus doAddComent(@RequestParam("issueID") String issueID, 
			@RequestParam("comment") String mensaje, HttpServletRequest request, Model model) throws ParseException {
		
		try {			
			User user =  getCurrentUser(SecurityContextHolder.getContext().getAuthentication());
			UserDetails userDB = userService.loadUserByUsername(user.getUsername());		
			
			if(userDB == null){
				return new AlertStatus(false, "Debe estar logueado para publicar un comentario.");
			}	
			
			if(mensaje.isEmpty()){
				return new AlertStatus(false, "Agregue un mensaje.");
			}
		
			else{
				CommentDTO comentario = new CommentDTO();
				comentario.setFecha(new Date());
				comentario.setNroReclamo(issueID);
				comentario.setUsuario(userDB.getUsername());
				comentario.setMensaje(mensaje);
				issueService.postComment(comentario);
				List<CommentDTO> comments = issueService.getCommentsByIssue(issueID);
				model.addAttribute("comentarios", issueService.getCommentsByIssue(issueID));
				model.addAttribute("cantidadComentarios", comments.size());			
				return new AlertStatus(true, "El comentario ha sido publicado.");			
			}
			
		}catch(AccessDeniedException e){
			return new AlertStatus(false, "Debe estar logueado para ingresar un nuevo reclamo.");
		}		
	}
	
	
	@RequestMapping(value="/issues/watchIssue", method = RequestMethod.POST)
	public @ResponseBody AlertStatus watchIssue(@RequestParam("issueID") String issueID, Model model){
		
		IssueFollowDTO follow = new IssueFollowDTO();
		
		try {			
			User user =  getCurrentUser(SecurityContextHolder.getContext().getAuthentication());
			UserDetails userDB = userService.loadUserByUsername(user.getUsername());		
			
			if(userDB == null){
				return new AlertStatus(false, "Debe estar logueado para observar el reclamo.");
			}	
			
			follow.setIdIssue(issueID);
			follow.setUsername(userDB.getUsername());
			follow.setDate(new Date());
			
			issueService.followIssue(follow);
			List<String> observadores = issueService.getIssueFollowers(issueID);
			model.addAttribute("cantidadObservadores", observadores.size());		
			
			return new AlertStatus(true, String.valueOf(observadores.size()));
			
		}catch(AccessDeniedException e){
			return new AlertStatus(false, "Debe estar logueado para observar el reclamo.");
		
		}catch(Exception e){
			return new AlertStatus(false, "Ha ocurrido un error al intentar observar el reclamo.");
		}					
		
	}
	
	@RequestMapping(value="/issues/unwatchIssue", method = RequestMethod.POST)
	public @ResponseBody AlertStatus unWatchIssue(@RequestParam("issueID") String issueID, Model model){
		
		IssueFollowDTO follow = new IssueFollowDTO();
		
		try {			
			User user =  getCurrentUser(SecurityContextHolder.getContext().getAuthentication());
			UserDetails userDB = userService.loadUserByUsername(user.getUsername());		
			
			if(userDB == null){
				return new AlertStatus(false, "Debe estar logueado para observar el reclamo.");
			}	
			
			follow.setIdIssue(issueID);
			follow.setUsername(userDB.getUsername());
			
			issueService.unFollowIssue(follow);
			List<String> observadores = issueService.getIssueFollowers(issueID);
			model.addAttribute("cantidadObservadores", observadores.size());	
			
			return new AlertStatus(true, String.valueOf(observadores.size()));
			
		}catch(AccessDeniedException e){
			return new AlertStatus(false, "Debe estar logueado para observar el reclamo.");
			
		}catch(Exception e){
			return new AlertStatus(false, "Ha ocurrido un error al intentar observar el reclamo.");
		}	
		
	}
	
	@RequestMapping(value="/issues/displayIssueFollowers", method = RequestMethod.POST)
	public @ResponseBody List<String> displayIssueFollowers(@RequestParam("issueID") String issueID){
		return issueService.getIssueFollowers(issueID);		
	}

	
	@RequestMapping(value="/issues/voteIssue", method = RequestMethod.POST)
	public @ResponseBody AlertStatus voteIssue(@RequestParam("issueID") String issueID, 
			@RequestParam("vote") int voteUpOrDown, Model model){
		
		IssueVoteDTO vote = new IssueVoteDTO();
		
		try {			
			User user =  getCurrentUser(SecurityContextHolder.getContext().getAuthentication());
			UserDetails userDB = userService.loadUserByUsername(user.getUsername());		
			
			if(userDB == null){
				return new AlertStatus(false, "Debe estar logueado para observar el reclamo.");
			}	
			
			if( (issueService.getCurrentVote(issueID, userDB.getUsername()).isCurrentlyVoteByUser()) )
				return new AlertStatus(false, "Ya ha votado por este reclamo.");
			
			vote.setIdIssue(issueID);		
			vote.setUsername(userDB.getUsername());
			vote.setVote(voteUpOrDown);
			vote.setDate(new Date());
			
			issueService.voteIssue(vote);
					
			return new AlertStatus(true, String.valueOf(issueService.countIssueVotes(issueID)));
			
		}catch(AccessDeniedException e){
			return new AlertStatus(false, "Debe estar logueado para observar el reclamo.");
		
		}catch(Exception e){
			return new AlertStatus(false, "Ha ocurrido un error al intentar votar el reclamo.");
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
	
	private String parseDate(Date date){
		if(date != null){
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
	
	
}
