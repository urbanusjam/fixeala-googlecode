package ar.com.urbanusjam.web.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.UserService;
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
