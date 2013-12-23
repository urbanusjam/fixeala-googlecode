package ar.com.urbanusjam.web.controllers;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.omg.CORBA.portable.ValueOutputStream;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.access.AccessDeniedException;
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
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.ContenidoService;
import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.UserService;
import ar.com.urbanusjam.services.dto.CommentDTO;
import ar.com.urbanusjam.services.dto.ContenidoDTO;
import ar.com.urbanusjam.services.dto.FileWrapperDTO;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.IssueHistorialRevisionDTO;
import ar.com.urbanusjam.services.dto.IssueLicitacionDTO;
import ar.com.urbanusjam.services.dto.UserDTO;
import ar.com.urbanusjam.services.utils.IssueStatus;
import ar.com.urbanusjam.services.utils.Messages;
import ar.com.urbanusjam.services.utils.Operation;
import ar.com.urbanusjam.web.domain.AlertStatus;
import ar.com.urbanusjam.web.utils.UploadFile;


@Controller
//@RequestMapping(value="/issue")
public class IssueController {
	
	@Autowired
	private IssueService issueService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ContenidoService contenidoService;
	
	private static final String UPLOAD_DIRECTORY = "C:\\temp\\fixeala\\uploads\\tmp";
	private static final long MAX_SIZE = 1024*1024*3;
	private static final long MAX_WIDTH = 1080;
	private static final long MAX_HEIGHT = 720;
	private static final long MIN_WIDTH = 640;
	private static final long MIN_HEIGHT = 480;
	private FileWrapperDTO uploadedFile = null;
	
	@Autowired
	@Qualifier(value = "fixealaAuthenticationManager")
	protected AuthenticationManager fixealaAuthenticationManager;
	
	public FileWrapperDTO getUploadedFile() {
		return uploadedFile;
	}

	public void setUploadedFile(FileWrapperDTO uploadedFile) {
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
				model.addAttribute("direccion", issue.getFormattedAddress());					
				model.addAttribute("id", issue.getId());
				model.addAttribute("fecha", issue.getFormattedDate());
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
				
				List<String> tag = new ArrayList<String>();
				for(int i = 0; i < issue.getTags().size(); i++){
					tag.add("'" + issue.getTags().get(i) + "'"); 
				}
				model.addAttribute("tags", tag);
				model.addAttribute("comentarios", issue.getComentarios());
				
				if(issue.getContenidos().size() > 0){
					ContenidoDTO contenido = issue.getContenidos().get(0);						
					model.addAttribute("image", contenido);
					model.addAttribute("imageUrl", contenido.getPathRelativo());
					model.addAttribute("imageName", contenido.getNombre());
				}
				
				model.addAttribute("cantidadRevisiones", issue.getHistorial().size());
				model.addAttribute("cantidadLicitacion", issue.getLicitacion() != null ? 1 : 0);
				model.addAttribute("cantidadReclamosSimilares", 0);
				model.addAttribute("cantidadArchivos", 0);
				model.addAttribute("cantidadComentarios", issue.getComentarios().size());				
				
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
	
//	private Image getImage(InputStream inputStream) throws IOException
//	{
//		BufferedImage bufferedImage;
//		bufferedImage = ImageIO.read(inputStream);
//		Image image = new Image();
//		image.setHeight(bufferedImage.getHeight());
//		image.setWidth(bufferedImage.getWidth());
//		
//		return image;
//	}
	
	
	@RequestMapping(value="/handleFileUpload", method = RequestMethod.POST)
	public @ResponseBody AlertStatus doFileUpload(@RequestParam("fileUpload") MultipartFile file, 
			HttpServletRequest request){
		
		InputStream inputStream = null;
		  
	    try {		
	
			if(file != null){
				 
				String fileName = file.getOriginalFilename();			
				inputStream = file.getInputStream();
				
				FileWrapperDTO fileDTO = contenidoService.subirContenido(inputStream, fileName);				
				int width = fileDTO.getAncho();
				int height = fileDTO.getAlto();
				String extension = fileName;
				
				boolean valid = false;
				String message = StringUtils.EMPTY;				
			
				if( file.getSize() > MAX_SIZE ){
					valid = false;
					message = "El archivo seleccionado supera el peso m&aacute;ximo (3 MB).";
//					return new AlertStatus(false, "El archivo seleccionado supera el peso m&aacute;ximo (3 MB).");
				}
				
				if(! ( extension.equals("jpg") || extension.equals("jpeg") || extension.equals("png") ) ){
					valid = false;
					message = "Los formatos de archivo permitidos son JPEG y PNG.";
					//return new AlertStatus(false, "Los formatos de archivo permitidos son JPEG y PNG.");
				}
					
							
			
				if( (width < MIN_WIDTH)
						|| (height < MIN_HEIGHT)
						|| (width < MIN_WIDTH && height < MIN_HEIGHT) ){
					valid = false;
					message = "La foto debe tener una resoluci�n m�nima de 640 x 480 p�xeles.";
					//return new AlertStatus(false, "La foto debe tener una resoluci�n m�nima de 640 x 480 p�xeles.");					
				}
					
			
				if( (width > MAX_WIDTH)
						|| (height > MAX_HEIGHT)
						|| (width > MAX_WIDTH && height > MAX_HEIGHT) ){
					valid = false;
					message = "La foto debe tener una resoluci�n m�xima de 1080 x 720 p�xeles.";
					//return new AlertStatus(false, "La foto debe tener una resoluci�n m�xima de 1080 x 720 p�xeles.");
				}
					
			    if(!valid){
			    	fileDTO.getFile().delete();
			    	return new AlertStatus(false, message);
			    }				
				
			    else{
			    	this.setUploadedFile(fileDTO);
			    }
				
			}
			
			return new AlertStatus(true, "La foto se carg� exitosamente.");
	    
	    } catch (IOException e) {
	    	return new AlertStatus(false, "No se pudo cargar el archivo.");
	    }
	  
	
	}
	
	private String getNombreArchivoSinExtension(String nombreArchivo) {
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
	}
	
		
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
									
					UserDTO userDTO = new UserDTO();
					userDTO.setUsername(userDB.getUsername());					
					issue.setDate(new Date());
					issue.setStatus(IssueStatus.OPEN);		
					issue.setUser(userDTO);					
					
					Random generator = new Random(); 
					int id = generator.nextInt(100000) + 1000;
					
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
					
					
				    //ContenidoDTO
					FileWrapperDTO file = this.getUploadedFile();
					
					if(file != null){
						String fileName = file.getFile().getName();						
						ContenidoDTO contenido = new ContenidoDTO();
					    contenido.setNombre(this.getNombreArchivoSinExtension(fileName));
					    contenido.setNombreFileSystem(fileName);	
					    contenido.setPathRelativo("/"+ fileName);
					    contenido.setAncho(file.getAncho());
					    contenido.setAlto(file.getAlto());
					    contenido.setTipo(this.getExtensionArchivo(fileName));
					    contenido.setNroReclamo(String.valueOf(issue.getId()));
					    issue.getContenidos().add(contenido);
					}					
					
					issueService.reportIssue(issue);		
					
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
//			@RequestParam("tags") List<String> tags,
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

	
	@RequestMapping(value="/loadMapMarkers", method = RequestMethod.GET)
	public @ResponseBody List<IssueDTO> loadMapMarkers(@ModelAttribute("issue") IssueDTO issue, HttpServletRequest request){			
		return issueService.loadAllIssues();		
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