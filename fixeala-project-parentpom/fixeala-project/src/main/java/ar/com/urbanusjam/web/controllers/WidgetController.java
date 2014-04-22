package ar.com.urbanusjam.web.controllers;

import java.util.List;

import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.web.domain.AlertStatus;

@Controller
public class WidgetController {
	
	@Autowired
	private IssueService issueService;
	
	@RequestMapping(value="/widget", method = RequestMethod.GET)
	public String showWidgetPage(Model model) { 	
		
		int maxResultados = 3;
		List<IssueDTO> issues = issueService.loadIssues(maxResultados);		
		model.addAttribute("widgetIssues", issues);
		
		return "widget";	 
	}
	
	@RequestMapping(value="/refreshWidget", method = RequestMethod.GET)
	public @ResponseBody AlertStatus refreshWidget(Model model) throws JSONException { 			
		int maxResultados = 3;
		List<IssueDTO> issues = issueService.loadIssues(maxResultados);		
		model.addAttribute("widgetIssues", issues);		
		return new AlertStatus(true, "Todo bien");
	}
	
	

}
