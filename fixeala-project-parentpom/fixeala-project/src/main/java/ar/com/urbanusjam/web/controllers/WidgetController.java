package ar.com.urbanusjam.web.controllers;

import java.util.ArrayList;
import java.util.List;

import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.UserService;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.services.utils.IssueStatus;
import ar.com.urbanusjam.services.utils.IssueStatusColorCode;
import ar.com.urbanusjam.web.domain.AlertStatus;

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
	
		try{
			model = loadWidgetModel(model);		
			return new AlertStatus(true, "OK");
		} catch(Exception e){			
			return new AlertStatus(false, "Ha ocurrido un error al intentar actualizar la lista de reclamos.");
		}	
	}
	
	@RequestMapping(value="/widget-web", method = RequestMethod.GET)
	public String showWidgetComponent(Model model) throws Exception { 
		model = loadWidgetModel(model);		
		return "widget-web";	 
	}
	
	@RequestMapping(value="/widget-web?province={province}&city={city}", method = RequestMethod.GET)
	public String showWidgetComponent(Model model, @PathVariable ("province") String province, 
			@PathVariable ("city") String city) throws Exception { 			
		
		model = loadWidgetModel(model);		
		return "widget-web";	 
	}
	
	
	private Model loadWidgetModel(Model model){
		
		List<IssueDTO> issues = new ArrayList<IssueDTO>();		
		List<IssueDTO> totalIssues = new ArrayList<IssueDTO>();
		
		int totalOpen = 0;
		int totalReopened = 0;
		int totalResolved = 0;
		int totalClosed = 0;	
		int totalUsers = 0;
		
		try{
			
			issues = issueService.loadIssues(MAX_RESULTS);				
			totalIssues = issueService.loadAllIssues();
			totalUsers = userService.loadAllActiveUsers().size();

			for(IssueDTO issue : totalIssues){
				
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
				
			}
							
			model.addAttribute("totalIssues", issues.size());	
			model.addAttribute("totalOpen", totalOpen);	
			model.addAttribute("totalReopened", totalReopened);	
			model.addAttribute("totalResolved", totalResolved);	
			model.addAttribute("totalClosed", totalClosed);	
			model.addAttribute("totalUsers", totalUsers);	
			
			if(issues.size() > 0)			{
				model.addAttribute("issueList", issues);	
				}
			else
				model.addAttribute("errorMessage", "No es encontraron resultados.");		
			
		} catch(Exception e){
			model.addAttribute("errorMessage", "No se pudo establecer la conexión con el servidor.");
		}	
		
		return model;
		
	}

}
