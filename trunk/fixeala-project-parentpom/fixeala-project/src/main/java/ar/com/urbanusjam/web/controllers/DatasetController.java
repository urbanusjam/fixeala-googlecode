package ar.com.urbanusjam.web.controllers;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.jasperreports.engine.JRException;

import org.apache.commons.lang.StringUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import ar.com.urbanusjam.services.ExportService;
import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.dto.IssueCriteriaSearch;
import ar.com.urbanusjam.services.dto.IssueDTO;
import ar.com.urbanusjam.web.domain.AlertStatus;

@Controller
public class DatasetController {
	
	@Autowired
	private IssueService issueService;
	
	@Autowired
	private ExportService exportService;
	
	@RequestMapping(value="/dataset", method = RequestMethod.GET)
	public String showDatasetPage(Model model, HttpServletRequest request) { 	
				
		try {				
				String allTags = StringUtils.EMPTY;				
				JSONArray array = new JSONArray();
				
				List<String> dbTags = issueService.getTagList();
				
				for(String s : dbTags){
					JSONObject obj = new JSONObject();					
					obj.put("id", dbTags.indexOf(s));
					obj.put("text", s);
					array.put(obj);
				}
		
				allTags = array.toString();						
				model.addAttribute("allTags", allTags.length() == 0 ? "[{}]" : allTags);
		
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "dataset";	 
	}
	
	@RequestMapping(value="/exportDataset", method = RequestMethod.POST)
	public @ResponseBody AlertStatus exportDataset(@ModelAttribute("datasetForm") IssueCriteriaSearch search, HttpServletRequest request) throws IOException, JRException { 	
		List<IssueDTO> issues = new ArrayList<IssueDTO>();		
		issues = issueService.findIssuesByCriteria(search);	
		
//		if(issues.isEmpty())
//			return new AlertStatus(false, "No se encontraron resultados.");
//
//		
//		else{
			boolean result = exportService.generateDataset(issues, search.getFormatoArchivo());
			return new AlertStatus(result, "Se encontraron " + issues.size() + " resultados.");
		//}
			
	}
	

}