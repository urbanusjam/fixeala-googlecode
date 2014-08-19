package ar.com.urbanusjam.web.controllers;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.UserService;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.utils.IssueStatus;
import ar.com.urbanusjam.services.utils.IssueStatusColorCode;
import ar.com.urbanusjam.web.domain.AlertStatus;
import ar.com.urbanusjam.web.utils.StatusResponse;

@Controller
public class WidgetController {
	
	@Autowired
	private IssueService issueService;
	
	@Autowired
	private UserService userService;
	
	private final static int MAX_RESULTS = 4;
	
	@RequestMapping(value="/widget", method = RequestMethod.GET)
	public String showWidgetPage(Model model) { 				
		return "widget";	 
	}
	
	////// COMPONENTE WIDGET ////////
	
	@RequestMapping(value="/refreshWidget", method = RequestMethod.GET)
	public @ResponseBody AlertStatus refreshWidget(Model model) throws JSONException { 			
		List<IssueDTO> issues = new ArrayList<IssueDTO>();
		try{
			issues = issueService.loadIssues(MAX_RESULTS);
			model.addAttribute("totalIssues", issues.size());
			model.addAttribute("widget-body", issues);	
			return new AlertStatus(true, "OK");
		} catch(Exception e){
			model.addAttribute("totalIssues", 0);
			return new AlertStatus(false, "Ha ocurrido un error al intentar actualizar la lista de reclamos.");
		}	
	}
	
	@RequestMapping(value="/widget-web", method = RequestMethod.GET)
	public String showWidgeComponent(Model model) throws Exception { 			
		
		List<IssueDTO> issues = new ArrayList<IssueDTO>();		
		
		int totalOpen = 0;
		int totalReopened = 0;
		int totalResolved = 0;
		int totalClosed = 0;
		int totalComments = 0;
		int totalUsers = 0;
		
		try{
			
			issues = issueService.loadIssues(MAX_RESULTS);	
			totalUsers = userService.loadAllActiveUsers().size();
			
			for(IssueDTO issue : issues){
				
				if(issue.getStatus().equals(IssueStatus.OPEN)){
					issue.setStatusCss(IssueStatusColorCode.CSS_OPEN);
					totalOpen++;
				}
									
				if(issue.getStatus().equals(IssueStatus.REOPENED)){
					issue.setStatusCss(IssueStatusColorCode.CSS_REOPENED);
					totalReopened++;					
				}

				if(issue.getStatus().equals(IssueStatus.IN_PROGRESS)){
					issue.setStatusCss(IssueStatusColorCode.CSS_IN_PROGRESS);
				}
									
				if(issue.getStatus().equals(IssueStatus.SOLVED)){
					issue.setStatusCss(IssueStatusColorCode.CSS_SOLVED);
					totalResolved++;
				}					
				
				if(issue.getStatus().equals(IssueStatus.CLOSED)){
					issue.setStatusCss(IssueStatusColorCode.CSS_CLOSED);
					totalClosed++;
				}
				
				totalComments += issue.getComentarios().size();
					
			}
							
			model.addAttribute("totalIssues", issues.size());	
			model.addAttribute("totalOpen", totalOpen);	
			model.addAttribute("totalReopened", totalReopened);	
			model.addAttribute("totalResolved", totalResolved);	
			model.addAttribute("totalClosed", totalClosed);	
			model.addAttribute("totalComments", totalComments);	
			model.addAttribute("totalUsers", totalUsers);	
			
			if(issues.size() > 0)			
				model.addAttribute("issueList", issues);			
			else
				model.addAttribute("errorMessage", "No es encontraron resultados.");		
			
		} catch(Exception e){
			model.addAttribute("errorMessage", "No se pudo establecer la conexión con el servidor.");
		}		
		return "widget-web";	 
	}
	
	

}
