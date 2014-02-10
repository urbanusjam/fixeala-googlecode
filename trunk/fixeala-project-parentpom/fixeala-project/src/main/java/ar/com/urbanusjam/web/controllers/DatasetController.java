package ar.com.urbanusjam.web.controllers;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

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

import ar.com.urbanusjam.services.IssueService;
import ar.com.urbanusjam.services.dto.IssueCriteriaSearch;
import ar.com.urbanusjam.web.domain.AlertStatus;

@Controller
public class DatasetController {
	
	@Autowired
	private IssueService issueService;
	
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
	public AlertStatus exportDataset(@ModelAttribute("datasetForm") IssueCriteriaSearch search, HttpServletRequest request) { 	
		issueService.generateDataset(search);	
		return new AlertStatus(true, "Todo ok.");	 
	}
	

}
