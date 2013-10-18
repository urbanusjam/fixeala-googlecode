package ar.com.urbanusjam.web.controllers;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.bind.annotation.ResponseBody;

import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.UserService;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.IssueHistorialRevisionDTO;
import ar.com.urbanusjam.services.dto.IssueLicitacionDTO;
import ar.com.urbanusjam.services.dto.UserDTO;
import ar.com.urbanusjam.services.utils.IssueStatus;
import ar.com.urbanusjam.services.utils.Messages;
import ar.com.urbanusjam.services.utils.Operation;
import ar.com.urbanusjam.web.domain.AlertStatus;


@Controller
//@RequestMapping(value="/issue")
public class IssueController {
	
	@Autowired
	private IssueService issueService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	@Qualifier(value = "fixealaAuthenticationManager")
	protected AuthenticationManager fixealaAuthenticationManager;

	
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
				model.addAttribute("descripcion", issue.getDescription());
				model.addAttribute("latitud", issue.getLatitude());
				model.addAttribute("longitud", issue.getLongitude());				
				model.addAttribute("historial", issue.getHistorial());
				
				model.addAttribute("cantidadRevisiones", issue.getHistorial().size());
				model.addAttribute("cantidadLicitacion", issue.getLicitacion() != null ? 1 : 0);
				model.addAttribute("cantidadReclamosSimilares", 0);
				model.addAttribute("cantidadArchivos", 0);
				model.addAttribute("cantidadComentarios", issue.getComentarios().size());				
				
				IssueLicitacionDTO licitacion = new IssueLicitacionDTO();
				licitacion = issue.getLicitacion();
				
				if(licitacion.getNroLicitacion() != null){
					
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
	
		
	@RequestMapping(value="/reportIssue", method = RequestMethod.POST)
	public @ResponseBody AlertStatus doReportIssue(@ModelAttribute("issue") IssueDTO issue, HttpServletRequest request){
		
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
					List<String> authorities = new ArrayList<String>();
					authorities.add("ROLE_USER");		
					userDTO.setAuthorities(authorities);										
//					Calendar calendar = Calendar.getInstance();
//					issue.setDate((GregorianCalendar) calendar);
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
					issue.setId(Long.valueOf(id));
					revision.setNroReclamo(issue.getId());	
					issue.setLicitacion(null);
					issueService.reportIssue(issue, revision);			
					
					return new AlertStatus(true, "Su reclamo ha sido registrado.");			
			}
		}			
		catch(AccessDeniedException e){
			return new AlertStatus(false, "Debe estar logueado para ingresar un nuevo reclamo.");
		}
	
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
					
					if(licitacion.getNroLicitacion() == null)
						licitacion = null;
					
					else{
						licitacion.setNroReclamo(String.valueOf(issue.getId()));
					}
					
					issue.setLicitacion(licitacion);
					
					IssueHistorialRevisionDTO revision = new IssueHistorialRevisionDTO();
					revision.setFecha(new Date());
					revision.setUsername(userDTO.getUsername());			
					revision.setNroReclamo(issue.getId());			
					revision.setOperacion(Operation.UPDATE);			
					revision.setMotivo("MODIFICACION");			
					revision.setEstado(issue.getStatus());
					revision.setObservaciones(Messages.ISSUE_UPDATE_OBS);
					issue.getHistorial().add(revision);
					
					issueService.updateIssue(issue, revision);	
					
					return new AlertStatus(true, "El reclamo ha sido actualizado.");			
			}
		}			
		catch(AccessDeniedException e){
			return new AlertStatus(false, "Debe estar logueado para ingresar un nuevo reclamo.");
		}
	
	}
	
		
		
	@RequestMapping(value="/loadTags", method = RequestMethod.GET)
	public @ResponseBody List<String> loadTagList(HttpServletRequest request){
		return issueService.getTagList();
		
	}

	
	@RequestMapping(value="/loadMapMarkers", method = RequestMethod.GET)
	public @ResponseBody List<IssueDTO> loadMapMarkers(@ModelAttribute("issue") IssueDTO issue, HttpServletRequest request){			
		return issueService.loadAllIssues();		
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
	
}
