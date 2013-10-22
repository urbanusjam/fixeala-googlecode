package ar.com.urbanusjam.web.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.util.JSONWrappedObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ar.com.restba.json.JsonArray;
import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.UserService;
import ar.com.urbanusjam.services.dto.AreaDTO;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.UserDTO;
import ar.com.urbanusjam.web.utils.DataTableResultSet;


@Controller
public class HomeController {
	
	@Autowired
	private IssueService issueService;
	
	@Autowired
	private UserService userService;
	
	
	@RequestMapping(value="/usuarios", method = RequestMethod.GET)
	public String showUsersPage() { 	
		return "usuarios";			
	}	
	
	@RequestMapping(value="/usuarios/loadActiveUsers", produces={"application/json; charset=ISO-8859-1"}, method = RequestMethod.GET)
	public @ResponseBody String getActiveUsersJSON(
											
											@RequestParam int iDisplayStart,
								            @RequestParam int iDisplayLength, 
								            @RequestParam int sEcho) throws IOException { 
		DataTableResultSet<UserDTO> dt = new DataTableResultSet<UserDTO>();
		List<UserDTO> users = userService.loadAllActiveUsers();
		
		
	    dt.setAaData(users);  // this is the dataset reponse to client
	    dt.setiTotalDisplayRecords(users.size());  // // the total data in db for datatables to calculate page no. and position
	    dt.setiTotalRecords(users.size());   // the total data in db for datatables to calculate page no.
	    dt.setsEcho(sEcho);		  
		return toJson(dt);		
	}
	
	@RequestMapping(value="/reclamos", method = RequestMethod.GET)
	public String showIssuesPage() { 	
		return "reclamos";			
	}	
	
	@RequestMapping(value="/reclamos/loadIssues", produces={"application/json; charset=ISO-8859-1"}, method = RequestMethod.GET)
	public @ResponseBody String getIssuesJSON(	@RequestParam int iDisplayStart,
								            	@RequestParam int iDisplayLength, 
								            	@RequestParam int sEcho) throws IOException {
		
		DataTableResultSet<IssueDTO> dt = new DataTableResultSet<IssueDTO>();
		List<IssueDTO> issues = issueService.loadAllIssues();		
	    dt.setAaData(issues);  
	    dt.setiTotalDisplayRecords(issues.size()); 
	    dt.setiTotalRecords(issues.size());   
	    dt.setsEcho(sEcho);		  
		return toJson(dt);		
	}
	
	
//	@RequestMapping(value="/users/{userID}/loadUserIssues", produces={"application/json; charset=ISO-8859-1"}, method = RequestMethod.GET)
//	public @ResponseBody String getUserIssuesJSON(	Model model,
//												@PathVariable("userID") String userID,
//												@RequestParam int iDisplayStart,
//								            	@RequestParam int iDisplayLength, 
//								            	@RequestParam int sEcho) throws IOException {
//		
//		DataTableResultSet<IssueDTO> dt = new DataTableResultSet<IssueDTO>();
//		UserDTO user = userService.getUserByUsername(userID); 
//		List<IssueDTO> issues = new ArrayList<IssueDTO>();
//		
//		if(user.hasRole("ROLE_AREA", user.getAuthorities()))
//			issues = issueService.loadIssuesByArea(user.getAreaNombre());
//		
//		if(user.hasRole("ROLE_ADMIN", user.getAuthorities()) 
//				|| user.hasRole("ROLE_MANAGER", user.getAuthorities()))
//			issues = issueService.getIssuesAsignados(userID);
//		
//		else
//			issues = issueService.loadIssuesByUser(userID);		
//		
//	    dt.setAaData(issues);  
//	    dt.setiTotalDisplayRecords(issues.size()); 
//	    dt.setiTotalRecords(issues.size());   
//	    dt.setsEcho(sEcho);		
//	 
//	   
//		return toJson(dt);		
//	}
	
	@RequestMapping(value="/users/{userID}/loadUserIssues",  produces = "application/json", method = RequestMethod.GET)
	public @ResponseBody List<IssueDTO> getUserIssuesJSON(@PathVariable("userID") String userID) throws IOException {
		
		
		UserDTO user = userService.getUserByUsername(userID); 
		List<IssueDTO> issues = new ArrayList<IssueDTO>();
		
		if(user.hasRole("ROLE_AREA", user.getAuthorities()))
			issues = issueService.loadIssuesByArea(user.getAreaNombre());
		
		if(user.hasRole("ROLE_ADMIN", user.getAuthorities()) 
				|| user.hasRole("ROLE_MANAGER", user.getAuthorities()))
			issues = issueService.getIssuesAsignados(userID);
		
		else
			issues = issueService.loadIssuesByUser(userID);		
		
	    return issues;
	}
	
	
	@RequestMapping(value="/users/{userID}", method = RequestMethod.GET)
	public String showUserProfilePage(Model model, @PathVariable("userID") String userID, 
				HttpServletRequest request){
		
		
	
		try{
			
//			if(!loggedUser.equals(userID)){
//				user = userService.getUserByUsername(userID);  
//				
//			}
				Object loggedUser = SecurityContextHolder.getContext().getAuthentication().getPrincipal();	
				UserDTO user = new UserDTO();
				boolean isSameUser = false;
			
				user = userService.getUserByUsername(userID); 
				
//				if(loggedUser.equals("anonymousUser")){
//					
//				}
				
				if(loggedUser instanceof User){
					isSameUser = ((User) loggedUser).getUsername().equals(user.getUsername());
				}
				
				if( user.hasRole("ROLE_ADMIN", user.getAuthorities()) 
						|| user.hasRole("ROLE_MANAGER", user.getAuthorities()) ){
					if(!isSameUser){
						return "redirect:/" + "error.html";
					}					
				}
				
				model.addAttribute("loggedUser", loggedUser);
				model.addAttribute("profileUser", user.getUsername());
				model.addAttribute("profileRole", user.getAuthorities().get(0));
				model.addAttribute("barrio", user.getNeighborhood());
				model.addAttribute("loggedMatchesProfile", isSameUser);
				
								
				if(user.isVerifiedOfficial()){
					model.addAttribute("current_nombre", user.getNombre());
					model.addAttribute("current_apellido", user.getApellido());
					model.addAttribute("current_rol", user.getAuthorities().size() > 0 ? user.getAuthorities().get(0) : "");
					model.addAttribute("current_area", user.getAreaNombre());
					model.addAttribute("current_ciudad", user.getAreaCiudad());
					model.addAttribute("current_provincia", user.getAreaProvinciaSigla());
				}
				
				
		}
		catch(Exception e){
			return "redirect:/" + "error.html";
		}
		
	
		
		return "users";
		
	}
	
	@RequestMapping(value="/error")
	public String showErrorPage(Map<String, Object> model) {
		model.put("error-message-title", "Lo sentimos");
		model.put("error-message", "La p�gina solicitada no existe.");
		
		return "error";			
	}	
	
	private <T> String toJson(DataTableResultSet<T> dt) throws IOException{
		  ObjectMapper mapper = new ObjectMapper();
		  try {
		   return mapper.writeValueAsString(dt);
		  } catch (JsonProcessingException e) {
		   // TODO Auto-generated catch block
		   e.printStackTrace();
		   return null;
		  }
	}
	
	

}
