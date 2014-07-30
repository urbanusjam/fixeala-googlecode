package ar.com.urbanusjam.web.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.codehaus.jackson.JsonProcessingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
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

import ar.com.urbanusjam.entity.annotations.User;
import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.UserService;
import ar.com.urbanusjam.services.dto.CommentDTO;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.dto.UserDTO;
import ar.com.urbanusjam.services.utils.DateUtils;
import ar.com.urbanusjam.services.utils.IssueStatus;
import ar.com.urbanusjam.web.domain.DataTablesParamUtility;
import ar.com.urbanusjam.web.domain.JQueryDataTableParamModel;
import ar.com.urbanusjam.web.utils.DataTableResultSet;
import ar.com.urbanusjam.web.utils.URISchemeUtils;

import com.google.gson.Gson;
import com.google.gson.JsonIOException;
import com.google.gson.JsonObject;


@Controller
public class HomeController {
	
	private static int ITEMS_PER_PAGE = 10;
	
	@Autowired
	private IssueService issueService;
	
	@Autowired
	private UserService userService;
	
	@ModelAttribute("issues")
	public @ResponseBody ArrayList<IssueDTO> getIssuesArray() {    
		return (ArrayList<IssueDTO>) issueService.loadAllIssues();
	} 
	
	@RequestMapping(value="/home", method = RequestMethod.GET)
	public String home(@ModelAttribute ("issues") ArrayList<IssueDTO> issues, Model model ) throws JSONException{		
		
//		List<IssueDTO> issues = issueService.loadAllIssues();
		
		List<String> dbTags = issueService.getTagList();
		JSONArray array = new JSONArray();
		String allTags = StringUtils.EMPTY;
		
		for(String s : dbTags){
			JSONObject obj = new JSONObject();
			obj.put("id", dbTags.indexOf(s));
			obj.put("text", s);
			array.put(obj);
		}
		
		allTags = array.toString();
		model.addAttribute("allTags", allTags.length() == 0 ? "[{}]" : allTags);
		
		//page 1
		JSONArray issuePagesArray = new JSONArray();
		issuePagesArray = paginateToArray(issues, 1, "issue");
		
		JSONArray userPagesArray = new JSONArray();
		userPagesArray = paginateToArray(userService.loadAllActiveUsers(), 1, "user");
		
		model.addAttribute("jsonIssues", issuePagesArray);
		model.addAttribute("jsonUsers", userPagesArray);
		
		return "home";
	}
	
	@RequestMapping(value = "/loadMapMarkers", method = RequestMethod.GET)
	public @ResponseBody List<IssueDTO> loadMapMarkers(@ModelAttribute ("issues") ArrayList<IssueDTO> issues, HttpServletRequest request) throws JSONException {
		
//		List<IssueDTO> issues = issueService.loadAllIssues();

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
	
	@RequestMapping(value="/usuarios", method = RequestMethod.GET)
	public String showUsersPage() { 	
		return "usuarios";			
	}	
	
	@RequestMapping(value="/reclamos", method = RequestMethod.GET)
	public String showIssuesPage() { 	
		return "reclamos";			
	}	
	

	@RequestMapping(value="/loadmore/{type}/{page}", produces={"application/json; charset=UTF-8"}, method = RequestMethod.GET)  
	public @ResponseBody String loadMorePages(@ModelAttribute ("issues") ArrayList<IssueDTO> issues, @PathVariable String type, @PathVariable int page) throws JSONException{  
			
		JSONArray pagesArray = new JSONArray();
		
		if(type.equals("issue"))
			pagesArray = paginateToArray(issues, page, type);
					
		else if (type.equals("user"))
			pagesArray = paginateToArray(userService.loadAllActiveUsers(), page, type);	
		
				
		return pagesArray != null ? pagesArray.toString() :  null;
	}  
	
	@SuppressWarnings("unchecked")
	public <T> JSONArray paginateToArray(List<T> elements, int currentPage, String type) throws JSONException{
		
		int itemsPerPage = ITEMS_PER_PAGE;
		int totalItems = elements.size();
		int totalPages = (int) Math.ceil((double)totalItems / itemsPerPage);	
		
		JSONArray jsonArray = null;
		
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
			if(type.equals("issue")){
				
				jsonArray = new JSONArray();
				
				List<IssueDTO> sub = (List<IssueDTO>) elements.subList(from, to + 1); //sublist toma el item en la posicion anterior al toIndex que se le pasa
				
				for(IssueDTO issue : sub){
					JSONObject obj = new JSONObject();
					obj.put("id", issue.getId());
					obj.put("title", issue.getTitle());
					obj.put("description", issue.getDescription());		
					obj.put("address", issue.getFormattedAddress());	
					obj.put("barrio", issue.getNeighborhood());	
					obj.put("city", issue.getCity());	
					obj.put("province", issue.getProvince());	
					obj.put("date", issue.getFechaFormateadaCompleta());
					obj.put("status", issue.getStatus());
					obj.put("totalVotes", issue.getTotalVotes());	
					obj.put("totalFollowers", issue.getTotalFollowers());	
					obj.put("totalViews", "0");	
					obj.put("css", issue.getStatusCss());		
					obj.put("url", URISchemeUtils.CONN_RELATIVE_URL_ISSUES + "/" + issue.getId());
					jsonArray.put(obj);
				}		
				
			}
			
			else if(type.equals("user")){
			
				jsonArray = new JSONArray();
				
				//user type
				List<UserDTO> sub = (List<UserDTO>) elements.subList(from, to + 1); //sublist toma el item en la posicion anterior al toIndex que se le pasa
				
				for(UserDTO user : sub){
					JSONObject obj = new JSONObject();
					obj.put("username", user.getUsername());
					obj.put("city", user.getCity());	
					obj.put("province", user.getProvince());	
					obj.put("registration", DateUtils.getFechaFormateada(user.getRegistrationDate(), DateUtils.DATE_PATTERN_LONG));
					obj.put("reportedIssues", Math.floor(Math.random() * 50));
					obj.put("postedComments", Math.floor(Math.random() * 99));
					obj.put("fixedIssues", Math.floor(Math.random() * 15));
					obj.put("url", URISchemeUtils.CONN_RELATIVE_URL_USERS + "/" + user.getUsername());
					jsonArray.put(obj);
				}				
			}	
			
			return jsonArray;		   
		}
	}
	
	@RequestMapping(value="/autocomplete", produces={"application/json; charset=UTF-8"}, method = RequestMethod.GET)
	public @ResponseBody String getIssuesAutocomplete(HttpServletRequest request, HttpServletResponse response) throws IOException, JSONException { 
		
		List<IssueDTO> issues = issueService.loadAllIssues();
		JSONArray array = new JSONArray();
		
		for(IssueDTO issue : issues){
			JSONObject obj = new JSONObject();
			obj.put("id", issue.getId());
			obj.put("title", issue.getTitle());
			obj.put("description", issue.getDescription());		
			obj.put("address", issue.getFormattedAddress());	
			obj.put("barrio", issue.getNeighborhood());	
			obj.put("city", issue.getCity());	
			obj.put("province", issue.getProvince());	
			obj.put("date", issue.getFechaFormateada());
			obj.put("status", issue.getStatus());
			obj.put("css", issue.getStatusCss());		
			obj.put("url", URISchemeUtils.CONN_RELATIVE_URL_ISSUES + "/" + issue.getId());
			array.put(obj);
		}		
	
		return array.toString();
		
	}
		
	@RequestMapping(value="/usuarios/loadUsers", produces={"application/json; charset=ISO-8859-1"}, method = RequestMethod.GET)
	public @ResponseBody void getUsersJSON(HttpServletRequest request, HttpServletResponse response) throws IOException, JSONException { 
				   
		JQueryDataTableParamModel param = DataTablesParamUtility.getParam(request);
		           
		String sEcho = param.sEcho;
        int iTotalRecords; // total number of records (unfiltered)
        int iTotalDisplayRecords; //value will be set when code filters companies by keyword
           
        List<UserDTO> dbUsers = userService.loadAllActiveUsers();  
        List<UserDTO> users = new ArrayList<UserDTO>();
        
        iTotalRecords = dbUsers.size();        
        
        for(UserDTO c : dbUsers){
        	if( c.getUsername().toLowerCase().contains(param.sSearch.toLowerCase()) 
               ||
	          ( c.getCity() != null && c.getCity().toLowerCase().contains(param.sSearch.toLowerCase())) )            
              {
        		users.add(c); // add users that matches given search criterion
              }
        }
        
        iTotalDisplayRecords = users.size();// number of companies that match search criterion should be returned
       
        final int sortColumnIndex = param.iSortColumnIndex;
        final int sortDirection = param.sSortDirection.equals("asc") ? -1 : 1;
       
        Collections.sort(users, new Comparator<UserDTO>(){
        	@Override
            public int compare(UserDTO c1, UserDTO c2) {    
        		switch(sortColumnIndex){
                case 0:
                	return c1.getUsername().compareTo(c2.getUsername()) * sortDirection;
                case 1:
            	    if(c1.getCity() != null && c2.getCity() != null)
            		    return c1.getCity().compareTo(c2.getCity()) * sortDirection;		         
                }
                return 0;
           }
        });
       
        if(users.size()< param.iDisplayStart + param.iDisplayLength) {
    	    users = users.subList(param.iDisplayStart, users.size());
        } else {
    	    users = users.subList(param.iDisplayStart, param.iDisplayStart + param.iDisplayLength);
        }
   
        try {   
    	    JsonObject jsonResponse = new JsonObject();     
            jsonResponse.addProperty("sEcho", sEcho);
            jsonResponse.addProperty("iTotalRecords", iTotalRecords);
            jsonResponse.addProperty("iTotalDisplayRecords", iTotalDisplayRecords);           
            Gson gson = new Gson();
            jsonResponse.add("aaData", gson.toJsonTree(users));
           
            response.setContentType("application/Json");
            response.getWriter().print(jsonResponse.toString());
           
        } catch (JsonIOException e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().print(e.getMessage());
       }  	
	}
	
	
	

	
	@RequestMapping(value="/reclamos/loadIssues", produces={"application/json; charset=ISO-8859-1"}, method = RequestMethod.GET)
	public @ResponseBody void getIssuesJSON(HttpServletRequest request, HttpServletResponse response) throws IOException, JSONException { 
				   
		JQueryDataTableParamModel param = DataTablesParamUtility.getParam(request);
		           
		String sEcho = param.sEcho;
        int iTotalRecords; // total number of records (unfiltered)
        int iTotalDisplayRecords; //value will be set when code filters companies by keyword
           
        List<IssueDTO> dbIssues = issueService.loadAllIssues();
        List<IssueDTO> issues = new ArrayList<IssueDTO>();
        
        iTotalRecords = dbIssues.size();        
        
        for(IssueDTO c : dbIssues){
        	if( c.getId().toLowerCase().contains(param.sSearch.toLowerCase()) 
               ||
	           c.getTitle().toLowerCase().contains(param.sSearch.toLowerCase())    
	           ||
	           c.getAddress().toLowerCase().contains(param.sSearch.toLowerCase())     
	           ||
	           ( c.getNeighborhood() != null && c.getNeighborhood().toLowerCase().contains(param.sSearch.toLowerCase()))    
	           ||
	           c.getCity().toLowerCase().contains(param.sSearch.toLowerCase())     
	           ||
	           c.getProvince().toLowerCase().contains(param.sSearch.toLowerCase())     
	           ||
	           c.getUsername().toLowerCase().contains(param.sSearch.toLowerCase())     
	           ||
	           c.getStatus().toLowerCase().contains(param.sSearch.toLowerCase()) )   
              {
        		issues.add(c); 
              }
        }
        
        iTotalDisplayRecords = issues.size();// number of companies that match search criterion should be returned
       
        final int sortColumnIndex = param.iSortColumnIndex;
        final int sortDirection = param.sSortDirection.equals("asc") ? -1 : 1;
       
        Collections.sort(issues, new Comparator<IssueDTO>(){
        	@Override
            public int compare(IssueDTO c1, IssueDTO c2) {    
        		switch(sortColumnIndex){
                case 0:
                	return c1.getId().compareTo(c2.getId()) * sortDirection;
                case 1:
                	return c1.getTitle().compareTo(c2.getTitle()) * sortDirection;
                case 2:
                	return c1.getAddress().compareTo(c2.getAddress()) * sortDirection;
                case 3:
            	    if(c1.getNeighborhood() != null && c2.getNeighborhood() != null)
            		    return c1.getNeighborhood().compareTo(c2.getNeighborhood()) * sortDirection;   
                case 4:
                	return c1.getCity().compareTo(c2.getCity()) * sortDirection;
                case 5:
                	return c1.getProvince().compareTo(c2.getProvince()) * sortDirection;
                case 6:
                	return c1.getUsername().compareTo(c2.getUsername()) * sortDirection;
                case 7:
                	return c1.getStatus().compareTo(c2.getStatus()) * sortDirection;
        		}
                return 0;
           }
        });
       
        if(issues.size()< param.iDisplayStart + param.iDisplayLength) {
        	issues = issues.subList(param.iDisplayStart, issues.size());
        } else {
        	issues = issues.subList(param.iDisplayStart, param.iDisplayStart + param.iDisplayLength);
        }
   
        try {   
    	    JsonObject jsonResponse = new JsonObject();     
            jsonResponse.addProperty("sEcho", sEcho);
            jsonResponse.addProperty("iTotalRecords", iTotalRecords);
            jsonResponse.addProperty("iTotalDisplayRecords", iTotalDisplayRecords);           
            Gson gson = new Gson();
            jsonResponse.add("aaData", gson.toJsonTree(issues));
           
            response.setContentType("application/Json");
            response.getWriter().print(jsonResponse.toString());
           
        } catch (JsonIOException e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().print(e.getMessage());
       }  	
	}
	
	
	@RequestMapping(value="/users/{userID}/loadUserIssues",  produces = "application/json", method = RequestMethod.GET)
	public @ResponseBody void getUserIssuesJSON(Model model, @PathVariable("userID") String userID,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
				
		UserDTO user = userService.getUserByUsername(userID); 
		List<IssueDTO> dbIssues = new ArrayList<IssueDTO>();
		List<IssueDTO> issues = new ArrayList<IssueDTO>();
		
//		if(user.hasRole("ROLE_AREA", user.getAuthorities()))
//			dbIssues = issueService.loadIssuesByArea(user.getAreaNombre());
//		
//		if(user.hasRole("ROLE_ADMIN", user.getAuthorities()) 
//				|| user.hasRole("ROLE_MANAGER", user.getAuthorities()))
//			dbIssues = issueService.getIssuesAsignados(userID);
//		
//		else
			dbIssues = issueService.loadIssuesByUser(userID);		
		
		JQueryDataTableParamModel param = DataTablesParamUtility.getParam(request);
        
		String sEcho = param.sEcho;
        int iTotalRecords; // total number of records (unfiltered)
        int iTotalDisplayRecords; //value will be set when code filters companies by keyword
               
        iTotalRecords = dbIssues.size();        
        
        for(IssueDTO c : dbIssues){
        	if( c.getId().toLowerCase().contains(param.sSearch.toLowerCase()) 
               ||
	           c.getTitle().toLowerCase().contains(param.sSearch.toLowerCase())    
	           ||
	           c.getAddress().toLowerCase().contains(param.sSearch.toLowerCase())     
	           ||
	           ( c.getNeighborhood() != null && c.getNeighborhood().toLowerCase().contains(param.sSearch.toLowerCase()))    
	           ||
	           c.getCity().toLowerCase().contains(param.sSearch.toLowerCase())     
	           ||
	           c.getProvince().toLowerCase().contains(param.sSearch.toLowerCase())     
	           ||
	           c.getUsername().toLowerCase().contains(param.sSearch.toLowerCase())     
	           ||
	           c.getStatus().toLowerCase().contains(param.sSearch.toLowerCase()) )   
              {
        		issues.add(c); 
              }
        }
        
        iTotalDisplayRecords = issues.size();// number of companies that match search criterion should be returned
       
        final int sortColumnIndex = param.iSortColumnIndex;
        final int sortDirection = param.sSortDirection.equals("asc") ? -1 : 1;
       
        Collections.sort(issues, new Comparator<IssueDTO>(){
        	@Override
            public int compare(IssueDTO c1, IssueDTO c2) {    
        		switch(sortColumnIndex){
                case 0:
                	return c1.getId().compareTo(c2.getId()) * sortDirection;
                case 1:
                	return c1.getTitle().compareTo(c2.getTitle()) * sortDirection;
                case 2:
                	return c1.getAddress().compareTo(c2.getAddress()) * sortDirection;
                case 3:
            	    if(c1.getNeighborhood() != null && c2.getNeighborhood() != null)
            		    return c1.getNeighborhood().compareTo(c2.getNeighborhood()) * sortDirection;   
                case 4:
                	return c1.getCity().compareTo(c2.getCity()) * sortDirection;
                case 5:
                	return c1.getProvince().compareTo(c2.getProvince()) * sortDirection;
                case 6:
                	return c1.getUsername().compareTo(c2.getUsername()) * sortDirection;
                case 7:
                	return c1.getStatus().compareTo(c2.getStatus()) * sortDirection;
        		}
                return 0;
           }
        });
       
        if(issues.size()< param.iDisplayStart + param.iDisplayLength) {
        	issues = issues.subList(param.iDisplayStart, issues.size());
        } else {
        	issues = issues.subList(param.iDisplayStart, param.iDisplayStart + param.iDisplayLength);
        }
   
        try {   
    	    JsonObject jsonResponse = new JsonObject();     
            jsonResponse.addProperty("sEcho", sEcho);
            jsonResponse.addProperty("iTotalRecords", iTotalRecords);
            jsonResponse.addProperty("iTotalDisplayRecords", iTotalDisplayRecords);           
            Gson gson = new Gson();
            jsonResponse.add("aaData", gson.toJsonTree(issues));
           
            response.setContentType("application/Json");
            response.getWriter().print(jsonResponse.toString());
           
        } catch (JsonIOException e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().print(e.getMessage());
       }  	
	
	}
	
	
	@RequestMapping(value="/users/{userID}/loadUserComments",  produces = "application/json", method = RequestMethod.GET)
	public @ResponseBody void getUserCommentsJSON(Model model, @PathVariable("userID") String userID,
			HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		List<IssueDTO> userIssues = new ArrayList<IssueDTO>();
		List<CommentDTO> dbComments = new ArrayList<CommentDTO>();
		List<CommentDTO> comments = new ArrayList<CommentDTO>();
		
		userIssues = issueService.loadAllIssues();
		
		for(IssueDTO issue : userIssues){
			for(CommentDTO c : issue.getComentarios())
				if(c.getUsuario().equals(userID))
					dbComments.add(c);
		}
			
		JQueryDataTableParamModel param = DataTablesParamUtility.getParam(request);
        
		String sEcho = param.sEcho;
        int iTotalRecords; // total number of records (unfiltered)
        int iTotalDisplayRecords; //value will be set when code filters companies by keyword
               
        iTotalRecords = dbComments.size();        
        
        for(CommentDTO c : dbComments){
        	if(c.getMensaje().toLowerCase().contains(param.sSearch.toLowerCase())    
	           ||
	           c.getNroReclamo().toLowerCase().contains(param.sSearch.toLowerCase()))   	          
              {
        		comments.add(c); 
              }
        }
        
        iTotalDisplayRecords = comments.size();// number of companies that match search criterion should be returned
       
        final int sortColumnIndex = param.iSortColumnIndex;
        final int sortDirection = param.sSortDirection.equals("asc") ? -1 : 1;
       
        Collections.sort(comments, new Comparator<CommentDTO>(){
        	@Override
            public int compare(CommentDTO c1, CommentDTO c2) {    
        		switch(sortColumnIndex){
                case 0:                	
                	return c1.getMensaje().compareTo(c2.getMensaje()) * sortDirection;   
                case 1:
                	return c1.getNroReclamo().compareTo(c2.getNroReclamo()) * sortDirection;   
              
        		}
                return 0;
           }
        });
       
        if(comments.size()< param.iDisplayStart + param.iDisplayLength) {
        	comments = comments.subList(param.iDisplayStart, comments.size());
        } else {
        	comments = comments.subList(param.iDisplayStart, param.iDisplayStart + param.iDisplayLength);
        }
   
        try {   
    	    JsonObject jsonResponse = new JsonObject();     
            jsonResponse.addProperty("sEcho", sEcho);
            jsonResponse.addProperty("iTotalRecords", iTotalRecords);
            jsonResponse.addProperty("iTotalDisplayRecords", iTotalDisplayRecords);           
            Gson gson = new Gson();
            jsonResponse.add("aaData", gson.toJsonTree(comments));
           
            response.setContentType("application/Json");
            response.getWriter().print(jsonResponse.toString());
           
        } catch (JsonIOException e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().print(e.getMessage());
       }  	
	
	}
	
	
	@RequestMapping(value="/users/{userID}/loadBackendUsers", produces={"application/json; charset=ISO-8859-1"}, method = RequestMethod.POST)
	public @ResponseBody void getBackendUsers(@PathVariable("userID") String userID,  
			@RequestParam("areaID") String areaID, HttpServletRequest request, HttpServletResponse response) throws IOException, JSONException {
		
		JQueryDataTableParamModel param = DataTablesParamUtility.getParam(request);
        
		String sEcho = param.sEcho;
        int iTotalRecords; // total number of records (unfiltered)
        int iTotalDisplayRecords; //value will be set when code filters companies by keyword
           
        List<UserDTO> dbUsers = null; //userService.loadVerifiedUsersByArea(areaID);
        List<UserDTO> users = new ArrayList<UserDTO>();
        
        iTotalRecords = dbUsers.size();        
        
        for(UserDTO c : dbUsers){
        	if( c.getId().toLowerCase().contains(param.sSearch.toLowerCase()) 
               || 
               c.getUsername().toLowerCase().contains(param.sSearch.toLowerCase()) 
               ||
               c.getAuthorities().get(0).toLowerCase().contains(param.sSearch.toLowerCase())     
	           ||
	           c.getNombre().toLowerCase().contains(param.sSearch.toLowerCase())    
	           ||
	           c.getApellido().toLowerCase().contains(param.sSearch.toLowerCase())               	       
	           ||	         
	           c.getRegistrationDate().toString().toLowerCase().contains(param.sSearch.toLowerCase())     
	           ||	        
	           c.getAccountStatus().toLowerCase().contains(param.sSearch.toLowerCase()) )   
              {
        		users.add(c); 
              }
        }
        
        iTotalDisplayRecords = users.size();// number of companies that match search criterion should be returned
       
        final int sortColumnIndex = param.iSortColumnIndex;
        final int sortDirection = param.sSortDirection.equals("asc") ? -1 : 1;
       
        Collections.sort(users, new Comparator<UserDTO>(){
        	@Override
            public int compare(UserDTO c1, UserDTO c2) {    
        		switch(sortColumnIndex){
                case 0:
                	return c1.getUsername().compareTo(c2.getUsername()) * sortDirection;
                case 1:
                	return c1.getRol().compareTo(c2.getRol()) * sortDirection;
                case 2:
                	return c1.getNombre().compareTo(c2.getNombre()) * sortDirection;
                case 3:
            		return c1.getApellido().compareTo(c2.getApellido()) * sortDirection;   
                case 4:
                	return c1.getRegistrationDate().compareTo(c2.getRegistrationDate()) * sortDirection;
                case 5:
                	return c1.getAccountStatus().compareTo(c2.getAccountStatus()) * sortDirection;      
            	case 6:
            		return c1.getId().compareTo(c2.getId()) * sortDirection;
        		}
                return 0;
           }
        });
       
        if(users.size()< param.iDisplayStart + param.iDisplayLength) {
        	users = users.subList(param.iDisplayStart, users.size());
        } else {
        	users = users.subList(param.iDisplayStart, param.iDisplayStart + param.iDisplayLength);
        }
        
        JsonObject jsonResponse = new JsonObject();  
   
        try {   
    	      
            jsonResponse.addProperty("sEcho", sEcho);
            jsonResponse.addProperty("iTotalRecords", iTotalRecords);
            jsonResponse.addProperty("iTotalDisplayRecords", iTotalDisplayRecords);           
            Gson gson = new Gson();
            jsonResponse.add("aaData", gson.toJsonTree(users));
           
            response.setContentType("application/Json");
            response.getWriter().print(jsonResponse.toString());
           
        } catch (JsonIOException e) {
            e.printStackTrace();
            response.setContentType("text/html");
            response.getWriter().print(e.getMessage());
       }  	
        
      

	}
	
	@RequestMapping(value="/users/{userID}/getIssueStatus", method = RequestMethod.GET)
	public @ResponseBody String getIssueStatus(Model model,  
			@PathVariable("userID") String userID, @RequestParam("issueID") String issueID) throws IOException {
		
	
			IssueDTO issue = issueService.getIssueById(issueID);
			model.addAttribute("currentIssueStatus", issue.getStatus());
			model.addAttribute("isAssigned", issue.getAssignedOfficial().getUsername() != null ? true : false);
			
			String currentStatus = issue.getStatus();
			boolean isAssigned = issue.getAssignedOfficial().getUsername() != null ? true : false; 
			
			List<String> statusList = new ArrayList<String>();
			
			if(currentStatus.equals(IssueStatus.OPEN)){
				statusList.add("Admitir");
				statusList.add("Resolver");
				statusList.add("Cerrar");
			}
			
//			if(currentStatus.equals(IssueStatus.ACKNOWLEDGED)){
//				statusList.add("Resolver");
//				statusList.add("Cerrar");
//			}
			
			if(currentStatus.equals(IssueStatus.SOLVED)){
				statusList.add("Reabrir");
				statusList.add("Resolver");
				statusList.add("Cerrar");
			}
			
			if(currentStatus.equals(IssueStatus.REOPENED)){
				statusList.add("Resolver");
				statusList.add("Cerrar");
			}
			
			if(currentStatus.equals(IssueStatus.CLOSED)){
				statusList.add("Reabrir");
			}			
			
		return "users";
		
	}
	
	
	@RequestMapping(value="/users/{userID}", method = RequestMethod.GET)
	public String showUserProfilePage(Model model, @PathVariable("userID") String userID, 
				HttpServletRequest request){
		
		try{
				User loggedUser =  getCurrentUser(SecurityContextHolder.getContext().getAuthentication());
				UserDTO user = new UserDTO();
				boolean isSameUser = false;
			
				user = userService.getUserByUsername(userID); 
				
				if(loggedUser instanceof User){
					isSameUser = ((User) loggedUser).getUsername().equals(user.getUsername());
				}
				
//				if(user.hasRole("ROLE_ADMIN", user.getAuthorities()) 
//						|| user.hasRole("ROLE_MANAGER", user.getAuthorities()) ){
//					if(!isSameUser){
//						return "redirect:/" + "error.html";
//					}					
//				}
				
				model.addAttribute("loggedUser", loggedUser);
				model.addAttribute("loggedMatchesProfile", isSameUser);			
				model.addAttribute("isActiveUser", user.isEnabled());
				model.addAttribute("profileUser", user.getUsername());
				model.addAttribute("profileRole", user.getAuthorities().get(0));				
				model.addAttribute("email", user.getEmail());
				model.addAttribute("city", user.getCity());			
				model.addAttribute("province", user.getProvince());			
				
				List<IssueDTO> userIssues = issueService.loadIssuesByUser(userID);
				List<IssueDTO> allIssues = issueService.loadAllIssues();
				int solvedIssues = 0;
				int commentsCounter = 0;
				
				for(IssueDTO issue : userIssues){
					if(issue.getStatus().equals(IssueStatus.SOLVED))
						solvedIssues++;
				}
				
				for(IssueDTO issue : allIssues){
					for(CommentDTO c : issue.getComentarios())
						if(c.getUsuario().equals(userID))
							commentsCounter++;
				}
													
				model.addAttribute("registrationDate", DateUtils.getFechaFormateada(user.getRegistrationDate(), DateUtils.DATE_TIME_PATTERN_SHORT));
				model.addAttribute("total_issues", userIssues.size());
				model.addAttribute("total_solved", solvedIssues);
				model.addAttribute("total_voted", "0");
				model.addAttribute("total_followings", issueService.getUserFollowings(user.getUsername()).size());
				model.addAttribute("total_flagged", "0");
				model.addAttribute("total_comments", commentsCounter);
				model.addAttribute("total_widgets", "0");				
								
//				if(user.isVerifiedOfficial()){
//					model.addAttribute("current_nombre", user.getNombre());
//					model.addAttribute("current_apellido", user.getApellido());
//					model.addAttribute("current_rol", user.getAuthorities().size() > 0 ? user.getAuthorities().get(0) : "");
//					model.addAttribute("current_area", user.getAreaNombre());
//					model.addAttribute("current_areaID", user.getAreaId());
//					model.addAttribute("current_ciudad", user.getAreaCiudad());
//					model.addAttribute("current_provincia", user.getAreaProvinciaSigla());
//				}				
				
		}catch(Exception e){
			return "redirect:/" + "error.html";
		}
		
		return "users";		
	}
	
	@RequestMapping(value="/error")
	public String showErrorPage(Map<String, Object> model) {		
		return "error";			
	}	
	
	@RequestMapping(value="/closedAccount", method = RequestMethod.GET)
	public String showMessagePage(Map<String, Object> model) {		
		return "closedAccount";			
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
	
	
	private User getCurrentUser(Authentication auth) {
        User currentUser;
        if (auth.getPrincipal() instanceof UserDetails) {
            currentUser = (User) auth.getPrincipal();
        } else if (auth.getDetails() instanceof UserDetails) {
            currentUser = (User) auth.getDetails();
        } else {
        	currentUser = null;
        }
        return currentUser;
    }
	
}
